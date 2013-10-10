require "text_veloper/version"
require 'text_veloper/util'
require 'rest_client'
require 'singleton'

module TextVeloper

  class Api
    include TextVeloper
    include Singleton

    attr_accessor :token_account, :sub_token

    def initialize
      @base_request_data = {
          cuenta_token: "",
          subcuenta_token: ""
      }
    end

    def config_tokens_account token_account, sub_token
      @base_request_data[:cuenta_token] = token_account
      @base_request_data[:subcuenta_token] = sub_token
      self
    end

    def send_message(message, phones = [])
      response = {}
      phones_arg = phones
      phones = phones_arg.is_a?(Array) ? phones_arg : [phones_arg]
      phones.each do |phone|
        response = RestClient.post url_base_for('enviar'), @base_request_data.merge({telefono: phone, mensaje: message})
      end
    rescue => e
      raise TextVeloperError.new "Problem with send message", e
    ensure
      return response
    end

    def points_query
      response = RestClient.post url_base_for('historial-transferencias'), @base_request_data
    rescue => e
      raise TextVeloperError.new "Problem with points query", e
    ensure
      return response
    end

    def messages_records
      response = RestClient.post url_base_for('historial-envios'), @base_request_data
    rescue => e
      raise TextVeloperError.new "Problem with message records", e
    ensure
      return response
    end

    def setup
      yield self
      @base_request_data = {cuenta_token: @token_account, subcuenta_token: @sub_token}
      TextVeloper::ApiSelector.account_manager.token = @token_account
      TextVeloper::ApiSelector.account_manager.payload = {cuenta_token: @token_account}
    end

  end

  class AccountManager
    include TextVeloper
    include Singleton

    attr_accessor :token, :payload, :memorizing, :sub_accounts

    def initialize
      @payload = {cuenta_token: ""}
      @memorizing = true
      @sub_accounts = {}
    end

    def config_token_account token_account, sub_account_record = true
      @token = token_account
      @payload = {cuenta_token: @token}
      @memorizing = sub_account_record
      @sub_accounts = {}
      self
    end

    def sub_account_api sub_token
      return TextVeloper::Api.instance.config_tokens_account @token, sub_token unless @memorizing
      @sub_accounts[sub_token] = TextVeloper::Api.instance.config_tokens_account @token, sub_token unless  @sub_accounts.keys.include? sub_token
      @sub_accounts[sub_token]
    end

    def balance
      response = RestClient.post url_base_for('saldo-cuenta'), @payload
    rescue => e
      raise TextVeloperError.new "Problem with balance", e
    ensure
      return response
    end

    def purchase_history
      response = RestClient.post url_base_for('historial-compras'), @payload
    rescue => e
      raise TextVeloperError.new "Problem with purchase history", e
    ensure
      return response
    end

  end

end
