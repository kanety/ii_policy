# IIPolicy

A base policy to support management of authorization logic.

This gem is inspired by [pundit](https://github.com/varvet/pundit) specs.

## Dependencies

* ruby 2.3+
* activesupport 5.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ii_policy'
```

Then execute:

    $ bundle

## Usage

Prepare model:

```ruby
class Item < ActiveRecord::Base
end
```

Prepare controller with `current_user` and call `authorize`:

```ruby
class ItemsController < ActionController::Base
  def index
    @policy = authorize(ItemPolicy)
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @policy = authorize(@item)
  end

  def current_user
    User.find(session[:login_user_id])
  end
end
```

Create policy that has methods corresponding with actions of controller:

```ruby
class ItemPolicy < IIPolicy::Base
  def index?
    @user.admin?
  end

  def show?
    @user.admin? && @item.status != 'deleted'
  end
end
```

### Controller

`authorize` lookups policy and calls it's method corresponding with current action.
`authorize` takes following arguments:

```ruby
# no argument (policy class is looked up using the name of controller class)
authorize

# instance (policy class is looked up using the name of instance's class)
authorize(@item)

# policy class
authorize(ItemPolicy)

# with extra context as second argument
authorize(@item, something: 'something')
```

Context is set to `{ user: current_user }` in the controller by default.
You can set other context you want by overriding `policy_context`:

```ruby
class ItemsController < ActionController::Base
  def policy_context
    super.merge(something: 'something')
  end
end
```

When current user is not authoized, `IIPolicy::AuthorizationError` is raised.
You can catch the error and render a special page using `rescue_from`:

```ruby
class ItemsController < ActionController::Base
  rescue_from IIPolicy::AuthorizationError, with: -> { ... }
end
```

You can also create policy instance by yourself and check authorization using `allowed` method as follows:

```ruby
# policy class
policy(ItemPolicy).allowed(:index?)

# instance
policy(@item).allowed(:index?)
```

### Policy

Policy has following attributes:

```ruby
class ItemPolicy < IIPolicy::Base
  def index?
    puts "user: #{@user}"
    puts "item: #{@item}"
    puts "context: #{@context}"
  end
end

policy = ItemPolicy.new(user: User.find(1), item: Item.find(1), something: 'something')
policy.allowed(:index?)
#=> user: #<User: ...>
#   item: #<Item: ...>
#   context: #<IIPolicy::Context user=..., item=..., something="something">
```

You can call another policy method in the same context:

```ruby
class ItemPolicy < IIPolicy::Base
  def another_show?
    allowed(:show?)
  end
end
```

You can use policy for another instance by using `policy`:

```ruby
class ItemPolicy < IIPolicy::Base
  def another_show?
    policy(@context.another_item).allowed(:show?)
  end
end
```

#### Callbacks

Following callbacks are available:

* `before_call`
* `around_call`
* `after_call`

For example:

```ruby
class ItemPolicy < IIPolicy::Base
  before_call do
    @something = @context.something
  end

  def index?
    @something == 'something'
  end
end
```

#### Policy chain

You can chain shared policies to base policy by including `IIPolicy::Chain` as follows:

```ruby
# shared policy
class SharedPolicy < IIPolicy::Base
  def show?
    @user.admin?
  end
end

# base policy
class ItemPolicy < IIPolicy::Base
  include IIPolicy::Chain

  chain SharedPolicy

  def show?
    @item.status != 'deleted'
  end
end

policy = ItemPolicy.new(user: User.find(1), item: Item.find(1))
policy.allowed(:show?)
#=> true
```

In this example, `policy.allowed(:show?)` is evaluated by `SharedPolicy#show? && ItemPolicy#show?`.

### Lookup for policy

`authorize` and `policy` lookups policy class if the first argument of them is not a policy class.
So the name of policy class should be composed of the base name of model or controller.
For example:

```ruby
class ItemPolicy < IIPolicy::Base
end

class Item
end

class ItemsController < ActionController::Base
end

IIPolicy::Base.lookup(Item)
#=> ItemPolicy

IIPolicy::Base.lookup(Item.new)
#=> ItemPolicy

IIPolicy::Base.lookup(ItemsController)
#=> ItemPolicy
```

Note that superclass of model or controller is also looked up until policy is found.

```ruby
class ItemPolicy < IIPolicy::Base
end

class Item
end

class InheritedItem < Item
end

IIPolicy::Base.lookup(InheritedItem)
#=> ItemPolicy

IIPolicy::Base.lookup(InheritedItem.new)
#=> ItemPolicy
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/ii_policy.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
