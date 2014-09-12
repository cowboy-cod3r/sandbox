class Itriage

  # == Descriptions
  # Class for holding account information
  class Account

    # Accessors
    attr_accessor :id, :username, :groups, :password

    # ==== Description
    # Constructor
    def initialize(id, username, groups, password)
      @id       = id
      @username = username
      @groups   = groups
      @password = password
    end

    # ==== Description
    # Convert the object to a JSON string
    public
      def to_json(*a)
        {
          "json_class"           => self.class.name,
          "data"                 =>
          {
            "id"                 => @id,
            "username"           => @username,
            "password"           => @password,
            "groups"             => @groups
          }
        }.to_json(*a)
      end
  end
end
