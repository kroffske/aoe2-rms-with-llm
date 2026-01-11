# Refactoring Strategies

Practical approaches and design patterns for code improvement.

---

## Method Extraction

**When:** Long methods, duplicate logic, unclear abstraction levels.

### Technique

1. Identify cohesive block of code
2. Extract to new function with clear name
3. Pass only required parameters
4. Return computed values

```python
# BEFORE: 60-line method with mixed concerns
def process_report(data: dict) -> dict:
    # Validation (15 lines)
    if not data.get('date'):
        raise ValueError("Date required")
    if not data.get('metrics'):
        raise ValueError("Metrics required")
    # ... more validation

    # Transformation (25 lines)
    result = {}
    for key, value in data['metrics'].items():
        if isinstance(value, str):
            result[key] = float(value)
        else:
            result[key] = value
    # ... more transformation

    # Aggregation (20 lines)
    total = sum(result.values())
    average = total / len(result)
    # ... more aggregation

    return {'total': total, 'average': average, 'data': result}


# AFTER: Clear, testable functions
def process_report(data: dict) -> dict:
    validate_report_data(data)
    metrics = transform_metrics(data['metrics'])
    return aggregate_metrics(metrics)


def validate_report_data(data: dict) -> None:
    if not data.get('date'):
        raise ValueError("Date required")
    if not data.get('metrics'):
        raise ValueError("Metrics required")


def transform_metrics(raw_metrics: dict) -> dict[str, float]:
    return {
        key: float(value) if isinstance(value, str) else value
        for key, value in raw_metrics.items()
    }


def aggregate_metrics(metrics: dict[str, float]) -> dict:
    total = sum(metrics.values())
    average = total / len(metrics) if metrics else 0
    return {'total': total, 'average': average, 'data': metrics}
```

---

## Class Decomposition

**When:** Large classes, multiple responsibilities, low cohesion.

### Technique

1. Identify distinct responsibilities
2. Group related fields and methods
3. Extract to new classes
4. Use composition to connect

```python
# BEFORE: 400-line class handling everything
class OrderProcessor:
    def __init__(self):
        self.db_connection = ...
        self.email_client = ...
        self.payment_gateway = ...

    def process(self, order):
        self._validate_order(order)
        self._check_inventory(order)
        self._process_payment(order)
        self._update_inventory(order)
        self._save_order(order)
        self._send_confirmation(order)

    # 50 private methods for all concerns...


# AFTER: Focused classes with single responsibility
class OrderValidator:
    def validate(self, order: Order) -> None:
        if not order.items:
            raise OrderValidationError("Order must have items")
        if order.total <= 0:
            raise OrderValidationError("Invalid order total")


class InventoryService:
    def __init__(self, repository: InventoryRepository):
        self.repository = repository

    def check_availability(self, items: list[OrderItem]) -> bool:
        for item in items:
            if not self.repository.is_available(item.sku, item.quantity):
                return False
        return True

    def reserve(self, items: list[OrderItem]) -> None:
        for item in items:
            self.repository.decrement(item.sku, item.quantity)


class PaymentProcessor:
    def __init__(self, gateway: PaymentGateway):
        self.gateway = gateway

    def process(self, order: Order) -> PaymentResult:
        return self.gateway.charge(order.payment_method, order.total)


class OrderProcessor:
    """Orchestrates order processing - only coordination logic."""

    def __init__(
        self,
        validator: OrderValidator,
        inventory: InventoryService,
        payment: PaymentProcessor,
        repository: OrderRepository,
        notifier: OrderNotifier,
    ):
        self.validator = validator
        self.inventory = inventory
        self.payment = payment
        self.repository = repository
        self.notifier = notifier

    def process(self, order: Order) -> OrderResult:
        self.validator.validate(order)

        if not self.inventory.check_availability(order.items):
            raise InsufficientInventoryError()

        payment_result = self.payment.process(order)
        self.inventory.reserve(order.items)

        order_id = self.repository.save(order, payment_result)
        self.notifier.send_confirmation(order)

        return OrderResult(order_id=order_id, status="completed")
```

---

## Design Pattern Application

### Factory Pattern

**When:** Complex object creation, multiple implementations.

```python
from abc import ABC, abstractmethod


class Notifier(ABC):
    @abstractmethod
    def send(self, message: str) -> None:
        pass


class EmailNotifier(Notifier):
    def send(self, message: str) -> None:
        print(f"Email: {message}")


class SMSNotifier(Notifier):
    def send(self, message: str) -> None:
        print(f"SMS: {message}")


class SlackNotifier(Notifier):
    def send(self, message: str) -> None:
        print(f"Slack: {message}")


class NotifierFactory:
    _notifiers: dict[str, type[Notifier]] = {
        "email": EmailNotifier,
        "sms": SMSNotifier,
        "slack": SlackNotifier,
    }

    @classmethod
    def create(cls, notifier_type: str) -> Notifier:
        if notifier_type not in cls._notifiers:
            raise ValueError(f"Unknown notifier: {notifier_type}")
        return cls._notifiers[notifier_type]()

    @classmethod
    def register(cls, name: str, notifier_class: type[Notifier]) -> None:
        cls._notifiers[name] = notifier_class


# Usage
notifier = NotifierFactory.create("email")
notifier.send("Hello!")
```

### Strategy Pattern

**When:** Multiple algorithms for same task, runtime selection.

```python
from abc import ABC, abstractmethod
from typing import Callable


class CompressionStrategy(ABC):
    @abstractmethod
    def compress(self, data: bytes) -> bytes:
        pass


class GzipCompression(CompressionStrategy):
    def compress(self, data: bytes) -> bytes:
        import gzip
        return gzip.compress(data)


class LZ4Compression(CompressionStrategy):
    def compress(self, data: bytes) -> bytes:
        import lz4.frame
        return lz4.frame.compress(data)


class NoCompression(CompressionStrategy):
    def compress(self, data: bytes) -> bytes:
        return data


class FileProcessor:
    def __init__(self, compression: CompressionStrategy):
        self.compression = compression

    def process(self, data: bytes) -> bytes:
        return self.compression.compress(data)


# Usage: swap strategies at runtime
processor = FileProcessor(GzipCompression())
result = processor.process(b"data")

processor = FileProcessor(LZ4Compression())  # Switch strategy
result = processor.process(b"data")
```

### Repository Pattern

**When:** Data access abstraction, testability.

```python
from abc import ABC, abstractmethod
from dataclasses import dataclass


@dataclass
class User:
    id: int | None
    email: str
    name: str


class UserRepository(ABC):
    @abstractmethod
    def find_by_id(self, user_id: int) -> User | None:
        pass

    @abstractmethod
    def find_by_email(self, email: str) -> User | None:
        pass

    @abstractmethod
    def save(self, user: User) -> int:
        pass

    @abstractmethod
    def delete(self, user_id: int) -> bool:
        pass


class PostgresUserRepository(UserRepository):
    def __init__(self, connection_pool):
        self.pool = connection_pool

    def find_by_id(self, user_id: int) -> User | None:
        with self.pool.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))
            row = cursor.fetchone()
            return User(*row) if row else None

    # ... other implementations


class InMemoryUserRepository(UserRepository):
    """For testing - no database needed."""

    def __init__(self):
        self._users: dict[int, User] = {}
        self._next_id = 1

    def find_by_id(self, user_id: int) -> User | None:
        return self._users.get(user_id)

    def save(self, user: User) -> int:
        if user.id is None:
            user.id = self._next_id
            self._next_id += 1
        self._users[user.id] = user
        return user.id

    # ... other implementations
```

### Decorator Pattern

**When:** Add behavior without modifying class, cross-cutting concerns.

```python
from abc import ABC, abstractmethod
import time
import logging


class DataFetcher(ABC):
    @abstractmethod
    def fetch(self, key: str) -> dict:
        pass


class APIDataFetcher(DataFetcher):
    def fetch(self, key: str) -> dict:
        # Actual API call
        return {"key": key, "data": "..."}


class CachingDecorator(DataFetcher):
    def __init__(self, wrapped: DataFetcher, ttl: int = 300):
        self._wrapped = wrapped
        self._cache: dict[str, tuple[float, dict]] = {}
        self._ttl = ttl

    def fetch(self, key: str) -> dict:
        if key in self._cache:
            timestamp, data = self._cache[key]
            if time.time() - timestamp < self._ttl:
                return data

        data = self._wrapped.fetch(key)
        self._cache[key] = (time.time(), data)
        return data


class LoggingDecorator(DataFetcher):
    def __init__(self, wrapped: DataFetcher):
        self._wrapped = wrapped
        self._logger = logging.getLogger(__name__)

    def fetch(self, key: str) -> dict:
        self._logger.info(f"Fetching: {key}")
        start = time.time()
        result = self._wrapped.fetch(key)
        self._logger.info(f"Fetched {key} in {time.time() - start:.2f}s")
        return result


# Usage: compose decorators
fetcher = LoggingDecorator(
    CachingDecorator(
        APIDataFetcher()
    )
)
data = fetcher.fetch("user:123")  # Logged + cached
```

---

## Refactoring Execution Order

### Phase 1: Quick Wins (1-2 hours)

| Action | Impact | Effort |
|--------|--------|--------|
| Extract magic numbers | Medium | 5 min each |
| Rename unclear identifiers | High | 5 min each |
| Remove dead code | Low | 10 min |
| Simplify boolean expressions | Medium | 10 min each |

### Phase 2: Method Extraction (2-4 hours)

| Action | Impact | Effort |
|--------|--------|--------|
| Extract duplicate code | High | 15-30 min |
| Split long methods | High | 20-40 min |
| Add guard clauses | Medium | 10 min each |

### Phase 3: Structure (4-8 hours)

| Action | Impact | Effort |
|--------|--------|--------|
| Extract class | High | 1-2 hours |
| Introduce interface | Medium | 30-60 min |
| Apply design pattern | High | 1-3 hours |

---

## Risk Mitigation

### Before Refactoring

1. **Ensure test coverage** - Can't refactor safely without tests
2. **Commit current state** - Rollback point
3. **Identify dependencies** - What might break?

### During Refactoring

1. **Small steps** - One change at a time
2. **Run tests frequently** - After each change
3. **Keep it working** - Never break existing functionality

### After Refactoring

1. **Compare behavior** - Same inputs, same outputs
2. **Performance check** - No regressions
3. **Code review** - Fresh eyes catch issues
