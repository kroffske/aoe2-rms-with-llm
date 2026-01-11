# SOLID Principles

Python examples for each SOLID principle with before/after comparisons.

---

## Single Responsibility Principle (SRP)

> A class should have only one reason to change.

**Violation Signs:**
- Class name includes "And" or "Manager"
- Multiple unrelated methods
- Changes for different reasons affect same class

```python
# BEFORE: Multiple responsibilities
class UserManager:
    def create_user(self, data):
        # Validate data
        if not data.get('email'):
            raise ValueError("Email required")

        # Save to database
        conn = mysql.connector.connect(...)
        cursor = conn.cursor()
        cursor.execute("INSERT INTO users...")

        # Send welcome email
        smtp = smtplib.SMTP('smtp.gmail.com')
        smtp.sendmail(...)

        # Log activity
        with open('/var/log/users.log', 'a') as f:
            f.write(f"User created: {data}")


# AFTER: Single responsibility per class
class UserValidator:
    def validate(self, data: dict) -> None:
        if not data.get('email'):
            raise ValueError("Email required")


class UserRepository:
    def __init__(self, connection_pool):
        self.pool = connection_pool

    def save(self, user_data: dict) -> int:
        with self.pool.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("INSERT INTO users...", user_data)
            return cursor.lastrowid


class WelcomeEmailService:
    def __init__(self, smtp_config):
        self.config = smtp_config

    def send(self, user_email: str) -> None:
        # Email sending logic
        pass


class UserService:
    """Orchestrates user creation - single responsibility: coordination."""

    def __init__(
        self,
        validator: UserValidator,
        repository: UserRepository,
        email_service: WelcomeEmailService,
    ):
        self.validator = validator
        self.repository = repository
        self.email_service = email_service

    def create_user(self, data: dict) -> int:
        self.validator.validate(data)
        user_id = self.repository.save(data)
        self.email_service.send(data['email'])
        return user_id
```

---

## Open/Closed Principle (OCP)

> Open for extension, closed for modification.

**Violation Signs:**
- if/elif chains for type handling
- Switch statements on type strings
- Modification required to add new behavior

```python
# BEFORE: Modification required for new discount types
class DiscountCalculator:
    def calculate(self, order, discount_type: str):
        if discount_type == "percentage":
            return order.total * 0.1
        elif discount_type == "fixed":
            return 10
        elif discount_type == "tiered":
            if order.total > 1000:
                return order.total * 0.15
            return order.total * 0.05
        # Adding new type requires modifying this class!


# AFTER: Open for extension via abstractions
from abc import ABC, abstractmethod
from decimal import Decimal


class DiscountStrategy(ABC):
    @abstractmethod
    def calculate(self, order) -> Decimal:
        pass


class PercentageDiscount(DiscountStrategy):
    def __init__(self, percentage: Decimal):
        self.percentage = percentage

    def calculate(self, order) -> Decimal:
        return order.total * self.percentage


class FixedDiscount(DiscountStrategy):
    def __init__(self, amount: Decimal):
        self.amount = amount

    def calculate(self, order) -> Decimal:
        return min(self.amount, order.total)


class TieredDiscount(DiscountStrategy):
    def calculate(self, order) -> Decimal:
        if order.total > 1000:
            return order.total * Decimal("0.15")
        if order.total > 500:
            return order.total * Decimal("0.10")
        return order.total * Decimal("0.05")


# New discount types: just add new class, no modification needed
class SeasonalDiscount(DiscountStrategy):
    def calculate(self, order) -> Decimal:
        # Holiday logic
        return order.total * Decimal("0.20")


class DiscountCalculator:
    def calculate(self, order, strategy: DiscountStrategy) -> Decimal:
        return strategy.calculate(order)
```

---

## Liskov Substitution Principle (LSP)

> Subtypes must be substitutable for their base types.

**Violation Signs:**
- Subclass overrides method with different behavior
- Subclass throws exceptions base class doesn't
- Client code checks type before calling method

```python
# BEFORE: Violates LSP - Square changes Rectangle behavior
class Rectangle:
    def __init__(self, width: float, height: float):
        self._width = width
        self._height = height

    def set_width(self, width: float) -> None:
        self._width = width

    def set_height(self, height: float) -> None:
        self._height = height

    def area(self) -> float:
        return self._width * self._height


class Square(Rectangle):
    def set_width(self, width: float) -> None:
        self._width = width
        self._height = width  # Breaks LSP: changes height too!

    def set_height(self, height: float) -> None:
        self._width = height  # Breaks LSP: changes width too!
        self._height = height


# This code breaks with Square:
def resize_rectangle(rect: Rectangle):
    rect.set_width(10)
    rect.set_height(5)
    assert rect.area() == 50  # Fails for Square!


# AFTER: Proper abstraction respects LSP
from abc import ABC, abstractmethod


class Shape(ABC):
    @abstractmethod
    def area(self) -> float:
        pass


class Rectangle(Shape):
    def __init__(self, width: float, height: float):
        self.width = width
        self.height = height

    def area(self) -> float:
        return self.width * self.height


class Square(Shape):
    def __init__(self, side: float):
        self.side = side

    def area(self) -> float:
        return self.side * self.side


# Now works correctly:
def print_area(shape: Shape):
    print(f"Area: {shape.area()}")  # Works for any Shape
```

---

## Interface Segregation Principle (ISP)

> Clients should not depend on interfaces they don't use.

**Violation Signs:**
- Interface with many methods
- Implementations with empty/pass methods
- Clients only use subset of interface

```python
# BEFORE: Fat interface forces unnecessary implementations
from abc import ABC, abstractmethod


class Worker(ABC):
    @abstractmethod
    def work(self) -> None:
        pass

    @abstractmethod
    def eat(self) -> None:
        pass

    @abstractmethod
    def sleep(self) -> None:
        pass


class Robot(Worker):
    def work(self) -> None:
        print("Working...")

    def eat(self) -> None:
        pass  # Robots don't eat - forced to implement!

    def sleep(self) -> None:
        pass  # Robots don't sleep - forced to implement!


# AFTER: Segregated interfaces
class Workable(ABC):
    @abstractmethod
    def work(self) -> None:
        pass


class Eatable(ABC):
    @abstractmethod
    def eat(self) -> None:
        pass


class Sleepable(ABC):
    @abstractmethod
    def sleep(self) -> None:
        pass


class Human(Workable, Eatable, Sleepable):
    def work(self) -> None:
        print("Working...")

    def eat(self) -> None:
        print("Eating...")

    def sleep(self) -> None:
        print("Sleeping...")


class Robot(Workable):
    def work(self) -> None:
        print("Working...")
    # No need to implement eat() or sleep()
```

---

## Dependency Inversion Principle (DIP)

> Depend on abstractions, not concretions.

**Violation Signs:**
- Direct instantiation in constructor
- Import of concrete implementations
- Hard to test without real dependencies

```python
# BEFORE: High-level depends on low-level
class MySQLDatabase:
    def save(self, data: str) -> None:
        print(f"Saving to MySQL: {data}")


class UserService:
    def __init__(self):
        self.db = MySQLDatabase()  # Tight coupling!

    def create_user(self, name: str) -> None:
        self.db.save(name)


# Problems:
# 1. Can't test without MySQL
# 2. Can't switch to PostgreSQL
# 3. UserService knows about MySQL


# AFTER: Both depend on abstraction
from abc import ABC, abstractmethod


class Database(ABC):
    @abstractmethod
    def save(self, data: str) -> None:
        pass


class MySQLDatabase(Database):
    def save(self, data: str) -> None:
        print(f"Saving to MySQL: {data}")


class PostgresDatabase(Database):
    def save(self, data: str) -> None:
        print(f"Saving to PostgreSQL: {data}")


class InMemoryDatabase(Database):
    """For testing."""

    def __init__(self):
        self.data = []

    def save(self, data: str) -> None:
        self.data.append(data)


class UserService:
    def __init__(self, db: Database):  # Depends on abstraction
        self.db = db

    def create_user(self, name: str) -> None:
        self.db.save(name)


# Usage: inject any Database implementation
production_service = UserService(PostgresDatabase())
test_service = UserService(InMemoryDatabase())
```

---

## Quick Reference

| Principle | Violation | Fix |
|-----------|-----------|-----|
| **SRP** | Class does multiple things | Extract classes by responsibility |
| **OCP** | if/elif for types | Strategy pattern, abstractions |
| **LSP** | Subclass changes behavior | Redesign hierarchy, use composition |
| **ISP** | Fat interface, empty methods | Split into focused interfaces |
| **DIP** | Direct instantiation | Constructor injection, abstractions |
