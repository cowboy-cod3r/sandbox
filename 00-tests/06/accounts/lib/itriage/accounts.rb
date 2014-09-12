require 'singleton'
require 'json'

class Itriage

  # == Descriptions
  # Class for holding account information
  class Accounts
    # Modules
    include Singleton

    # Accessors
    attr_accessor :accounts

    # ==== Description
    # Constructor
    def initialize()
      @accounts = Array.new()
    end

    # ==== Description
    # Adds an account to track
    def add(account)
      emsg = "The %s argument cannot be nil, empty, or a zero length string"
      raise(ArgumentError, emsg % ['account']) if !account.kind_of?(Itriage::Account)
      @accounts << account
    end

    # ==== Description
    # Retrieves an account
    #
    # ==== Argument
    # id - [Integer] - ID of the account
    #
    # ==== Returns
    # [Itriage::Account]
    # [nil] - if an account could not be found
    def get(id)
      emsg = "The %s argument cannot be nil, empty, or a zero length string"
      raise(ArgumentError, emsg % ['id']) if !id.kind_of?(Integer)
      account = @accounts.select{|a| a.id == id}
      account = account.nil? || account.empty? ? nil : account[0]
      return account
    end

    # ==== Description
    # Removes an account from tracking
    def delete(id)
      emsg = "The %s argument cannot be nil, empty, or a zero length string"
      raise(ArgumentError, emsg % ['id']) if !id.kind_of?(Integer)

      # remove the account
      @accounts.delete_if{|a| a.id == id}
    end

  end
end
