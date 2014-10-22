# Required Libraries
require 'json'
require 'rest-client'
require 'benchmark'

# namespace
class Itriage

  # == Description
  # The Heroes class
  class Heroes
    attr_accessor :context_path, :heroes_path, :host, :port
    attr_accessor :heroes_api

    # ==== Description
    # Constructor
    def initialize(ssl = false, host = "localhost" , port = 80)
      # Construct url
      @host         = host
      @port         = port
      @scheme       = ssl ? 'https' : 'http'
      @base_url     = "%s://%s:%d" % [@scheme, @host, @port]

      # paths and urls
      @context_path  = "api"
      @heroes_path   = @context_path + "/heroes"
      @heroes_api    = @base_url + "/" + @heroes_path

      # Other Useful members
      @valid_fields = ['id', 'name', 'realName', 'owner', 'gender']
    end

    # ==== Description
    # Get a list of heroes
    #
    # ==== Returns
    # [Array]
    public
      def get_heroes()
        # Create the resource and execute
        resource = RestClient::Resource.new(@heroes_api)
        heroes_ary = JSON.parse(resource.get(:accept => :json, :content_type => :json))
        return heroes_ary
      end

    # ==== Description
    # Get a list of heroes
    #
    # ==== Returns
    # [Array]
    public
      def get_hero(id)
        # Error Checking
        arg_error = "You must provide the %s argument"
        raise(ArgumentError, arg_error % ["id"]) if !id.kind_of?(Integer)

        # Set the endpoint
        endpoint = @heroes_api + "/" + id.to_s

        # Invoke the endpoint
        resource = RestClient::Resource.new(endpoint)
        hero_ary = JSON.parse(resource.get(:accept => :json, :content_type => :json))
        return hero_ary
      end

    # ==== Description
    # Checks to see if a record Exists
    #
    # ==== Arguments
    # * +name+       - [String] - name of the hero
    # * +real_name+  - [String] - real name of the hero
    #
    # ==== Returns
    # [Boolean] - true if record exists
    # [Booelan] - false if record does not exist
    public
      def hero_exists?(name, real_name)
        # Error Checking
        arg_error = "You must provide the %s argument"
        raise(ArgumentError, arg_error % ['hero'])      if !name.kind_of?(String) || name.strip.empty?
        raise(ArgumentError, arg_error % ['real_name']) if !real_name.kind_of?(String) || real_name.strip.empty?

        # Get Heroes
        heroes = get_heroes

        # Verify if the hero exists
        hero = heroes.select {|h| (h['name'] == name && h['realName']==real_name) }

        # Return value
        exists = hero.empty? ? false : true
        return exists
      end

    # ==== Description
    # Post a Hero
    #
    # ==== Returns
    # [RestClient::Response] - the hash object that was passed in
    # [Hash]                 - If the user already existed, the hash object is returned back
    public
      def post_hero(hero)
        # Error Checking
        arg_error = "You must provide the %s argument"
        raise(ArgumentError, arg_error % ["hero"]) if !hero.kind_of?(Hash) || hero.empty?
        raise(ArgumentError, "Your hash did not contain the correct fields.  They must contain: #{@valid_fields.join(" ")}") if hero.keys.sort != @valid_fields.sort

        # Set the endpoint
        endpoint = @heroes_api

        # Invoke the endpoint
        if hero_exists?(hero['name'], hero['realName'])
          #puts "WARN: Hero already exists..."
          return hero
        else
          resource = RestClient::Resource.new(endpoint)
          response = resource.post(hero.to_json, :accept => :json, :content_type => :json)
          return response
        end
      end

    # ==== Description
    # Delete a Hero
    #
    # ==== Returns
    # [RestClient::Response] - the hash object that was passed in
    # [Hash]                 - If the user already existed, the hash object is returned back
    public
      def delete_hero(hero)
        # Error Checking
        arg_error = "You must provide the %s argument"
        raise(ArgumentError, arg_error % ["hero"]) if !hero.kind_of?(Hash) || hero.empty?
        raise(ArgumentError, "Your hash did not contain the correct fields.  They must contain: #{@valid_fields.join(" ")}") if hero.keys.sort != @valid_fields.sort

        # Set the endpoint
        endpoint = @heroes_api + "/" + hero['id'].to_s

        # Invoke the endpoint
        if hero_exists?(hero['name'], hero['realName'])
          resource = RestClient::Resource.new(endpoint)
          response = resource.delete()
          return response
        else
          #puts "WARN: Hero did not exist..."
          return hero
        end
      end
  end
end
