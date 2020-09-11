# Object Oriented Programming

class Fib():
    """A Fibonacci number.

    >>> start = Fib()
    >>> start
    0
    >>> start.next()
    1
    >>> start.next().next()
    1
    >>> start.next().next().next()
    2
    >>> start.next().next().next().next()
    3
    >>> start.next().next().next().next().next()
    5
    >>> start.next().next().next().next().next().next()
    8
    >>> start.next().next().next().next().next().next() # Ensure start isn't changed
    8
    """

    def __init__(self, value=0):
        self.value = value

    def next(self):
        "*** YOUR CODE HERE ***"
        if self.value == 0:
            result = Fib(1)
        else:
            result = Fib(self.value + self.previous)
        result.previous = self.value
        return result

    def __repr__(self):
        return str(self.value)

class VendingMachine:
    """A vending machine that vends some product for some price.

    >>> v = VendingMachine('candy', 10)
    >>> v.vend()
    'Machine is out of stock.'
    >>> v.deposit(15)
    'Machine is out of stock. Here is your $15.'
    >>> v.restock(2)
    'Current candy stock: 2'
    >>> v.vend()
    'You must deposit $10 more.'
    >>> v.deposit(7)
    'Current balance: $7'
    >>> v.vend()
    'You must deposit $3 more.'
    >>> v.deposit(5)
    'Current balance: $12'
    >>> v.vend()
    'Here is your candy and $2 change.'
    >>> v.deposit(10)
    'Current balance: $10'
    >>> v.vend()
    'Here is your candy.'
    >>> v.deposit(15)
    'Machine is out of stock. Here is your $15.'

    >>> w = VendingMachine('soda', 2)
    >>> w.restock(3)
    'Current soda stock: 3'
    >>> w.restock(3)
    'Current soda stock: 6'
    >>> w.deposit(2)
    'Current balance: $2'
    >>> w.vend()
    'Here is your soda.'
    """
    "*** YOUR CODE HERE ***"
    def __init__(self, product, price, stock = 0, balance = 0):
        self.product = product
        self.price = price
        self.stock = 0
        self.balance = 0

    def vend(self):
        if self.stock <= 0: # If machine is out of stock
            return 'Machine is out of stock.'
        elif self.balance < self.price: # If the current balance is not enough
            difference = self.price - self.balance
            return 'You must deposit ${0} more.'.format(difference)
        elif self.balance == self.price: # If the current balance is exact
            self.balance -= self.price
            self.stock -= 1
            return 'Here is your {0}.'.format(self.product)
        elif self.balance > self.price: # If the current balance is more than the cost
            difference = self.balance - self.price
            self.balance = 0
            self.stock -= 1
            return 'Here is your {0} and ${1} change.'.format(self.product, difference)

    def deposit(self, amount):
        if self.stock <= 0:
            return 'Machine is out of stock. Here is your ${0}.'.format(amount)
        else:
            self.balance += amount
            return 'Current balance: ${0}'.format(self.balance)
    
    def restock(self, x):
        self.stock += x
        return 'Current {0} stock: {1}'.format(self.product, self.stock)
