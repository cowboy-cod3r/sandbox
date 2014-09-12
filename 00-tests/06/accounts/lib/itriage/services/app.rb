#!/opt/apps/ruby/ruby/bin/ruby
$:.unshift(File.join(File.dirname(__FILE__),".."))

# Required Libraries
require 'sinatra/base'
require 'accounts'
require 'account'

# == Description
# This class is the initialization point for all endpoints
# pertaining to ivv-monitoring

class App < Sinatra::Base

  attr_accessor :context, :accounts

  # Endpoint Constants
  CONTEXT = 'itriage'

  # ==== Description
  # Constructor
  def initialize()
    # Url Context Path
    @context = 'itriage'

    # Add some dummy accounts to query
    @accounts = Itriage::Accounts.instance()
    @accounts.add(Itriage::Account.new(1, 'sean',   ['admin'],       'secret'))
    @accounts.add(Itriage::Account.new(2, 'lisa',   ['doctor','pa'], 'secret'))
    @accounts.add(Itriage::Account.new(3, 'liam',   ['patient'],     'secret'))
    @accounts.add(Itriage::Account.new(4, 'alyssa', ['patient'],     'secret'))

    # Invoke the parent class
    super()
  end

  # ==== Description
  # Retrieves an account in json format
  #
  # ==== Arguments
  # id - [String] - The ID of the account
  #
  # ==== Returns
  # [String] - Returns a JSON String containing the requested account
  # [Nil]    - Nil if the account cannot be found
  get "/#{CONTEXT}/account/:id" do
    @accounts = Itriage::Accounts.instance()
    account   = @accounts.get(params[:id].to_i)
    return account.to_json
  end

  delete "/#{CONTEXT}/account/:id" do
    begin
      @accounts = Itriage::Accounts.instance()
      @accounts.delete(params[:id].to_i)

      # 204 is the status code for successful but did not return content
      status 204
    rescue Exception => e
      status 500
    end
  end

end