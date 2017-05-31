require 'singleton'

module TextVeloper

  URL_BASE = 'https://api.textveloper.com/'

  def url_base_for concat_param
    URL_BASE + concat_param.to_s + "/"
  end

  class TextVeloperError < StandardError

    attr_accessor :exception

    def initialize message, exception
      @exception = exception
      super(message)
    end

  end

  class ApiSelector

    class << self
      undef_method :new

      def api
        TextVeloper::Api.instance
      end

      def account_manager
        TextVeloper::AccountManager.instance
      end

    end

  end

end
