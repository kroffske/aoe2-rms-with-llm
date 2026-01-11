# Code Smells

Detection patterns and fixes for common code quality issues.

---

## Long Methods (>20 lines)

**Detection:**
- Scroll needed to read entire method
- Multiple levels of abstraction
- Comments separating "sections"

**Fix: Extract Method**

```python
# BEFORE: 50+ lines doing validation, calculation, notification
def process_order(order):
    # validation (15 lines)
    if not order.customer_id:
        raise ValueError("No customer")
    if not order.items:
        raise ValueError("No items")
    # ... more validation

    # calculation (20 lines)
    total = 0
    for item in order.items:
        total += item.price * item.quantity
    # ... more calculation

    # notification (15 lines)
    smtp = smtplib.SMTP('smtp.example.com')
    smtp.sendmail(...)
    # ... more notification

# AFTER: Clear, testable functions
def process_order(order):
    validate_order(order)
    total = calculate_order_total(order)
    send_order_notification(order, total)

def validate_order(order):
    if not order.customer_id:
        raise ValueError("No customer")
    if not order.items:
        raise ValueError("No items")

def calculate_order_total(order):
    return sum(item.price * item.quantity for item in order.items)

def send_order_notification(order, total):
    # notification logic
    pass
```

---

## Large Classes (>200 lines)

**Detection:**
- Class handles multiple unrelated concerns
- Many private methods
- Fields used by different method groups

**Fix: Extract Class**

```python
# BEFORE: God class with 5 responsibilities
class UserManager:
    def create_user(self, data):
        # validate, save, email, log, cache
        pass

    def validate_user_data(self, data): pass
    def save_to_database(self, user): pass
    def send_welcome_email(self, user): pass
    def log_activity(self, user): pass
    def update_cache(self, user): pass

# AFTER: Single responsibility per class
class UserValidator:
    def validate(self, data): pass

class UserRepository:
    def save(self, user): pass

class EmailService:
    def send_welcome_email(self, user): pass

class UserActivityLogger:
    def log_creation(self, user): pass

class UserService:
    def __init__(
        self,
        validator: UserValidator,
        repository: UserRepository,
        email_service: EmailService,
        logger: UserActivityLogger
    ):
        self.validator = validator
        self.repository = repository
        self.email_service = email_service
        self.logger = logger

    def create_user(self, data):
        self.validator.validate(data)
        user = self.repository.save(data)
        self.email_service.send_welcome_email(user)
        self.logger.log_creation(user)
        return user
```

---

## Duplicate Code

**Detection:**
- Copy-paste patterns
- Similar logic in multiple places
- Same fix needed in multiple locations

**Fix: Extract to Shared Function**

```python
# BEFORE: Duplicate validation in 3 places
def create_order(data):
    if not data.get('customer_id'):
        raise ValueError("No customer")
    # ... rest of creation

def update_order(data):
    if not data.get('customer_id'):
        raise ValueError("No customer")
    # ... rest of update

def delete_order(data):
    if not data.get('customer_id'):
        raise ValueError("No customer")
    # ... rest of delete

# AFTER: Single validation function
def validate_order_data(data):
    if not data.get('customer_id'):
        raise ValueError("No customer")

def create_order(data):
    validate_order_data(data)
    # ... rest of creation

def update_order(data):
    validate_order_data(data)
    # ... rest of update
```

---

## Complex Conditionals

**Detection:**
- Nested if/else > 2 levels
- Long boolean expressions
- Repeated condition checks

**Fix: Guard Clauses + Extract Method**

```python
# BEFORE: Nested conditionals
def get_payment_amount(user, order):
    if user is not None:
        if user.is_active:
            if order is not None:
                if order.total > 0:
                    if user.is_premium:
                        return order.total * 0.9
                    else:
                        return order.total
    return 0

# AFTER: Guard clauses
def get_payment_amount(user, order):
    if user is None:
        return 0
    if not user.is_active:
        return 0
    if order is None:
        return 0
    if order.total <= 0:
        return 0

    discount = 0.9 if user.is_premium else 1.0
    return order.total * discount
```

---

## Magic Numbers

**Detection:**
- Unexplained numeric literals
- Same number in multiple places
- Numbers in business logic

**Fix: Named Constants**

```python
# BEFORE: What does 0.85 mean?
if similarity > 0.85:
    dedupe(doc)

# AFTER: Self-documenting
DEDUP_SIMILARITY_THRESHOLD = 0.85  # Empirically tuned on golden dataset

if similarity > DEDUP_SIMILARITY_THRESHOLD:
    dedupe(doc)
```

---

## Tight Coupling

**Detection:**
- Direct instantiation of dependencies
- Concrete class references
- Hard to test in isolation

**Fix: Dependency Injection**

```python
# BEFORE: Tight coupling
class OrderService:
    def __init__(self):
        self.db = MySQLDatabase()  # Hard-coded dependency!
        self.email = SMTPEmailService()  # Another one!

# AFTER: Dependency injection
from abc import ABC, abstractmethod

class Database(ABC):
    @abstractmethod
    def save(self, data): pass

class EmailService(ABC):
    @abstractmethod
    def send(self, to, subject, body): pass

class OrderService:
    def __init__(self, db: Database, email: EmailService):
        self.db = db
        self.email = email
```

---

## Long Parameter List

**Detection:**
- Function with >3 parameters
- Related parameters often passed together
- Hard to remember parameter order

**Fix: Parameter Object**

```python
# BEFORE: 8 parameters
def create_user(
    first_name: str,
    last_name: str,
    email: str,
    phone: str,
    street: str,
    city: str,
    state: str,
    zip_code: str,
) -> None:
    pass

# AFTER: Parameter objects
from pydantic import BaseModel, EmailStr

class Address(BaseModel):
    street: str
    city: str
    state: str
    zip_code: str

class UserData(BaseModel):
    first_name: str
    last_name: str
    email: EmailStr
    phone: str
    address: Address

def create_user(user_data: UserData) -> None:
    pass
```

---

## Feature Envy

**Detection:**
- Method uses another class's data more than its own
- Multiple calls to same object's getters
- Logic belongs elsewhere

**Fix: Move Method**

```python
# BEFORE: Order envies Customer's data
class Order:
    def calculate_shipping(self, customer: "Customer") -> Decimal:
        if customer.is_premium:
            return Decimal("0") if customer.address.is_international else Decimal("5")
        return Decimal("20") if customer.address.is_international else Decimal("10")

# AFTER: Move to Customer
class Customer:
    is_premium: bool
    address: "Address"

    def calculate_shipping_cost(self) -> Decimal:
        if self.is_premium:
            return Decimal("0") if self.address.is_international else Decimal("5")
        return Decimal("20") if self.address.is_international else Decimal("10")

class Order:
    def calculate_shipping(self, customer: Customer) -> Decimal:
        return customer.calculate_shipping_cost()
```

---

## Detection Checklist

| Smell | Check | Threshold |
|-------|-------|-----------|
| Long method | Line count | >20 lines |
| Large class | Line count | >200 lines |
| Duplicate code | AST similarity | >3 occurrences |
| Complex conditional | Nesting depth | >2 levels |
| Magic number | Unexplained literal | Any |
| Tight coupling | Direct instantiation | Any in constructor |
| Long parameter list | Parameter count | >3 |
| Feature envy | External getters | >2 calls |
