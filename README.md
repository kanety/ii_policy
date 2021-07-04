# IIPolicy

A base policy to support management of authorization logic.

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
class User < ActiveRecord::Base
end
```

Prepare controller with `current_user` and call `authorize`:

```ruby
class UsersController < ActionController::Base
  def index
    @policy = authorize(UserPolicy)
    @items = User.all
  end

  def show
    @item = User.find(params[:id])
    @policy = authorize(@item)
  end

  def current_user
    User.find(session[:login_user_id])
  end
end
```

Create policy that has methods corresponding with actions of controller:

```ruby
class UserPolicy < IIPolicy::Base
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

# policy class
authorize(UserPolicy)

# object
authorize(@user)

# second argument is extra policy context
authorize(@user, something: 'something')
```

The policy context is automatically set to `{ user: current_user }` in the controller.
You can set any context you want by overriding `policy_context`:

```ruby
class UsersController < ActionController::Base
  def policy_context
    super.merge(something: 'something')
  end
end
```

When current user is not authoized, `IIPolicy::AuthorizationError` is raised.
You can catch the error and render a special page using `rescue_from`:

```ruby
class UsersController < ActionController::Base
  rescue_from IIPolicy::AuthorizationError, with: -> { ... }
end
```

You can also create policy instance by yourself and check authorization using `allowed` method as follows:

```ruby
# policy class
policy(UserPolicy).allowed(:index?)

# object
policy(@user).allowed(:index?)
```

### Policy

Policy has following attributes:

```ruby
class UserPolicy < IIPolicy::Base
  def index?
    puts "user: #{@user}"
    puts "item: #{@item}"
    puts "context: #{@context}"
  end
end

policy = UserPolicy.new(user: User.find(1), item: User.find(2), something: 'something')
policy.allowed(:index?)
#=> user: #<User: id=1...>
#   item: #<User: id=2...>
#   context: #<IIPolicy::Context user=..., item=..., something="something">
```

You can call another policy method in the same context:

```ruby
class UserPolicy < IIPolicy::Base
  def another_show?
    allowed(:show?)
  end
end
```

You can use policy for another object by using `policy`:

```ruby
class UserPolicy < IIPolicy::Base
  def another_show?
    policy(@context.another_user).allowed(:show?)
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
class UserPolicy < IIPolicy::Base
  before_call do
    @something = @context.something
  end

  def index?
    @something == 'something'
  end
end
```

#### Policy chain

You can chain shared policies into specific policy:

```ruby
# shared policy
class SharedPolicy < IIPolicy::Base
  def show?
    @user.admin?
  end
end

# specific policy
class UserPolicy < IIPolicy::Base
  include IIPolicy::Chain

  chain SharedPolicy

  def show?
    @item.status != 'deleted'
  end
end
```

In this example, `UserPolicy#show?` is evaluated by `SharedPolicy#show?` AND `UserPolicy#show?`.

### Lookup for policy

`authorize` and `policy` lookups policy class in case the first argument is not a policy class.
So the name of policy class should be composed of the base name of model or controller.
For example:

```ruby
class UserPolicy < IIPolicy::Base
end

class User
end

class UsersController < ActionController::Base
end

IIPolicy::Base.lookup(User)
#=> UserPolicy

IIPolicy::Base.lookup(UsersController)
#=> UserPolicy
```

```ruby
class Namespaced::UserPolicy < IIPolicy::Base
end

class Namespaced::User
end

class Namespaced::UsersController < ActionController::Base
end

IIPolicy::Base.lookup(Namespaced::User)
#=> Namespaced::UserPolicy

IIPolicy::Base.lookup(Namespaced::UsersController)
#=> Namespaced::UserPolicy
```

Note that superclass of model or controller is also looked up until policy is found.

```ruby
class UserPolicy < IIPolicy::Base
end

class User
end

class Inherited::User < User
end

IIPolicy::Base.lookup(Inherited::User)
#=> UserPolicy
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/ii_policy.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
