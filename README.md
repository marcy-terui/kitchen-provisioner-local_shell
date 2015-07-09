# Kitchen::Provisioner::LocalShell

A Test-Kitchen Provisioner that execute some command from localhost.

This provisioner is made in reference to Shell-Verifier.  
https://github.com/higanworks/kitchen-verifier-shell

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kitchen-provisioner-local_shell'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kitchen-provisioner-local_shell

## Usage

Pass driver's state via env, such as KITCHEN_HOSTNAME, KITCHEN_PORT, KITCHEN_CONTAINER_ID, etc...

- .kitchen.yml

```yml
----
platforms:
  - name: ubuntu-14.04
provisioner:
  name: local_shell
  command: ./bin/itamae docker recipes/default.rb --container=$KITCHEN_CONTAINER_ID
driver:
  name: docker_cli
transport:
  name: docker_cli
suites:
  - name: example
    run_list:
      - recipes/default.rb
```

## Contributing

1. Fork it ( https://github.com/marcy-terui/kitchen-provisioner-local_shell/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
