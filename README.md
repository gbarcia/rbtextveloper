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

In Ruby SOLO

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
