require_relative "test_helper"

class TvAppTest < Test::Unit::TestCase

  TOKEN_TEST = "Your token account here"

  SUB_TOKEN_TEST = "your sub_token account here"

  PHONE_NUMBERS = %W(TODO puts your array of test phone numbers)

  TEXT_MESSAGE = "Message for tests sms"

  SUCCESS_TV_MESSAGE = "exitosa"

  SUCCESS_SEND_MESSAGE = "MENSAJE_ENVIADO"


  def test_config
    TextVeloper::ApiSelector.api.setup do |config|
      config.token_account = TOKEN_TEST
      config.sub_token = SUB_TOKEN_TEST
    end
    assert_equal TOKEN_TEST, TextVeloper::ApiSelector.api.token_account
    assert_equal SUB_TOKEN_TEST, TextVeloper::ApiSelector.api.sub_token
    assert_equal TOKEN_TEST, TextVeloper::ApiSelector.account_manager.token
  end


  def test_single_message_send
    text_veloper = TextVeloper::ApiSelector.api
    text_veloper.config_tokens_account TOKEN_TEST, SUB_TOKEN_TEST
    response = text_veloper.send_message(TEXT_MESSAGE, PHONE_NUMBERS.first)
    response = JSON.parse(response)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
    assert_equal SUCCESS_SEND_MESSAGE, response["mensaje_transaccion"]
  end

  def test_multiple_message_send
    text_veloper = TextVeloper::ApiSelector.api
    text_veloper.config_tokens_account TOKEN_TEST, SUB_TOKEN_TEST
    response = text_veloper.send_message(TEXT_MESSAGE, PHONE_NUMBERS)
    response = JSON.parse(response)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
    assert_equal SUCCESS_SEND_MESSAGE, response["mensaje_transaccion"]
  end

  def test_points_query
    text_veloper = TextVeloper::ApiSelector.api
    text_veloper.config_tokens_account TOKEN_TEST, SUB_TOKEN_TEST
    response = JSON.parse(text_veloper.points_query)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
  end

  def test_messages_records
    text_veloper = TextVeloper::ApiSelector.api
    text_veloper.config_tokens_account TOKEN_TEST, SUB_TOKEN_TEST
    response = JSON.parse(text_veloper.messages_records)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
  end

  def test_account_points_query
    account_manager = TextVeloper::ApiSelector.account_manager
    account_manager.config_token_account TOKEN_TEST
    response = JSON.parse(account_manager.balance)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
  end

  def test_api_sub_account
    account_manager = TextVeloper::ApiSelector.account_manager
    account_manager.config_token_account TOKEN_TEST
    response = JSON.parse(account_manager.purchase_history)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
  end

  def test_official_usage
    account_manager = TextVeloper::ApiSelector.account_manager
    account_manager.config_token_account TOKEN_TEST
    sub_account = account_manager.sub_account_api SUB_TOKEN_TEST
    response = sub_account.send_message TEXT_MESSAGE, PHONE_NUMBERS.first
    response = JSON.parse(response)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
    assert_equal SUCCESS_SEND_MESSAGE, response["mensaje_transaccion"]
    response = sub_account.send_message TEXT_MESSAGE, PHONE_NUMBERS
    response = JSON.parse(response)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
    assert_equal SUCCESS_SEND_MESSAGE, response["mensaje_transaccion"]
    response = JSON.parse(sub_account.points_query)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
    response = JSON.parse(sub_account.messages_records)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
    response = JSON.parse(account_manager.balance)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
    response = JSON.parse(account_manager.purchase_history)
    assert_equal SUCCESS_TV_MESSAGE, response["transaccion"]
  end

end