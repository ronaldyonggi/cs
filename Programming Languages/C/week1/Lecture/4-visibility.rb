# In ruby, object state is private, can't be accessed 
# by even other instance of the same class.

# To make them available, use "getters" and "setters"
# Instead of get_foo, can just 'foo'
def get_foo
    @foo
end


# Instead of set_foo x, can do foo= x
def set_foo x
    @foo = x
end 

# getters and setters are so common that there is a
# shortand for it.
attr_reader :foo #getter
attr_accessor :foo #setter


class Foo = 
    # If we don't write any method visibility, by default
    # it's public

    protected
    # Now methods below the 'protected above' will all
    # be protected until next visibility keywrod
    ...

    public
    ...
    ...
    private 
    ...
    ...
end