# TextVeloper

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'text_veloper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install text_veloper

## Usage

    require 'text_veloper'

    # get the account mannager
    account_manager = TextVeloper::ApiSelector.account_manager

    #set the token account
    account_manager.config_token_account "TOKEN_ACCOUNT_STRING"

    #get the sub_account(Yo can have many sub_accounts)
    sub_account = account_manager.sub_account_api "SUB_TOKEN_STRING"

    #send a message
    #PHONE_NUMBERS can be a Array with many numbers ["number1", "number2"] or one number "number"
    response = sub_account.send_message TEXT_MESSAGE, PHONE_NUMBERS

    #Points query / Consulta de puntos
    response = sub_account.points_query

    #Messages Records
    response = sub_account.messages_records

    #Account Balance
    response = account_manager.balance

    # Purchase history
    response = account_manager.purchase_history

    #NOTE: Al responses are returned by json. Yo can use JSON.parse(response) for get a Ruby Hash

 In Rails

    rails g text_veloper:initializer

 And config your default token for account and sub_account

    # For configure the tokens for textveloper gem
    TextVeloper::ApiSelector.api.setup do |config|
      config.token_account = ""
      config.sub_token = ""
    end

##Other Languages?
  see this for python: [a link](https://github.com/iferminm/pytextveloper)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
