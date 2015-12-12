# Wallaby

![Travis CI](https://travis-ci.org/reinteractive-open/wallaby.svg)

Wallaby is a Rails engine to manage your data. You could have a play with the [demo here](https://wallaby-demo.herokuapp.com/admin/)

## Requirements
Rails 4.0 and above

## Support
ActiveRecord

## Yet another Rails admin engine? Why?
Because this engine is built in Rails way! You could customize things like what you normally do developing Rails app. (see the section [Customization](#customization) below).

# Installation

1. Add to `Gemfile`:

    ```ruby
    gem 'bootstrap-sass'
    gem 'jquery-rails'
    gem 'kaminari'
    gem 'wallaby'
    ```

2. Add engine to `routes.rb`:

    ```ruby
    mount Wallaby::Engine => "/the_path_you_like"
    ```

# Customization

> Assume that you have an active model `Post(id: integer, title: string, body: text, publish_time: datetime, creator_id: integer, updator_id: integer, created_at: datetime, updated_at: datetime)`

1. Configuration

    This engine by default uses ActiveRecord adaptor, you could change this to other adaptor (e.g. Mongo / HER adaptor) as below:

    ```ruby
    # config/initializers/wallaby.rb
    Wallaby.config do |config|
      config.adaptor = Wallaby::SomeOtherAdaptor
    end
    ```

    By default, there is no authentication, and you need to do the following config if you need one:

    ```ruby
    # config/initializers/wallaby.rb
    Wallaby.config do |config|
      config.security.authenticate do
        # you could use any controller methods here
        authenticate_or_request_with_http_basic do |username, password|
          username == 'too_simple' && password == 'too_naive'
        end
      end

      config.security.current_user do
        # you could use any controller methods here
        Class.new do
          def email
            'user@example.com'
          end
        end.new
      end
    end
    ```

    You could hide some models using configuration as below:

    ```ruby
    # config/initializers/wallaby.rb
    Wallaby.config do |config|
      config.models.exclude ProductDetail, Order, Order::Item
    end
    ```

2. Controller

    You could modify the logics for Post model by defining a controller as below:

    ```ruby
    class PostsController < Wallaby::ResourceController
      def create
        # do something else
        super
      end
    end

    # OR any controller name you want, but specifying the `model_class`
    class Admin::CustomPostsController < Wallaby::ResourceController
      def self.model_class
        Post
      end

      def create
        # do something else
        super
      end
    end
    ```

3. Decorator

    Similar to the controller above, you could use two ways to define a decorator.
    Having a decorator, you could then modify what fields to use for views index/show/form

    ```ruby
    class PostDecorator < ResourceDecorator
      index_field_names.delete 'body'
      show_fields['body'][:type] = 'markdown'
      form_fields['body'][:label] = 'Content'
    end
    ```

4. View

    You could easily define any field view for any custom type (e.g. markdown) for Post by defining a partial under `app/views/posts/index/_markdown`

    ```erb
    <%# The local variables in the partial are `value` %>
    <%= markdown.render value %>
    ```

    If you want to make it available for other models, you could move it to `app/views/resources/index/_markdown`

# How to test

```
bundle exec rake spec
```

# License
This project rocks and uses MIT-LICENSE.
