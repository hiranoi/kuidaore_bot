require "faraday"
require "faraday_middleware"
require "json"
require "pp"

class ReplAiClient
  URL_HEAD = 'https://api.repl-ai.jp'

  def initialize(api_key, bot_id = 'normal', scenario ='greeting')
    @api_key = api_key
    @bot_id  = bot_id
    @scenario = scenario
  end

  def get_user_id
    res = post('/v1/registration',{
      botId: @bot_id
      })
    res.body
  end

  def get_message(user_id, message)
    res = post('/v1/dialogue',{
        appUserId: user_id,
        botId: @bot_id,
        voiceText: message,
        initTalkingFlag: true,
        initTopicId: @scenario,
        appRecvTime: Time.now.strftime('%Y/%m/%d %H:%M:%S'),
        appSendTime: Time.now.strftime('%Y/%m/%d %H:%M:%S'),
      })
    res.body
  end

  private

  def post(path, data)
    client = Faraday.new(:url => URL_HEAD) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
      # conn.proxy @proxy
    end

    res = client.post do |request|
      request.url path
      request.headers = {
          'Content-type' => 'application/json; charset=UTF-8',
          'x-api-key' => @api_key
      }
      request.body = data
    end
    res
  end
end
