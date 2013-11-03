
require 'sass/plugin/rack'

module Emailer
  class App < Sinatra::Base
    helpers Sinatra::JSON
    set :public_folder, File.join(File.dirname(__FILE__), "..", '/public')
    set(:accepted_verbs) { |*verbs| condition { verbs.any?{|v| v == request.request_method }  } }

    use Sass::Plugin::Rack

    use ActiveRecord::ConnectionAdapters::ConnectionManagement

    before "*", accepted_verbs: ["POST", "PATCH", "PUT"] do
      request.body.rewind
      @request_payload = JSON.parse request.body.read
    end

    get '/' do
      haml :index
    end

    get '/campaigns/:campaign_id' do
      json Campaign.find(params[:campaign_id])
    end

    patch '/campaigns/:campaign_id' do
      campaign = Campaign.find(params[:campaign_id])
      attr = params[:changed]
      raise unless ["name", "body"].include?(attr)

      campaign.update_attribute(attr, @request_payload[attr])
      json campaign
    end

    get '/campaigns.?:format?' do
      json Campaign.all
    end

    post '/campaigns' do
      json Campaign.create!(@request_payload)
    end


    get '/users.?:format?' do
      json User.all
    end

    post '/users' do
      json User.create!(@request_payload)
    end

    get '/users/:user_id' do
      haml "views/users/show"
    end

    get '/ngView/:ngController/:ngAction' do
      haml :"ng_view/#{params[:captures].join("/")}"
    end

    #get '/stylesheets/*' do
      #sass :"sass/#{params[:splat].first.to_sym}", style: :expanded
    #end
  end
end
