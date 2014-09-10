$:.unshift(File.join(File.dirname(__FILE__),".."))

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Required Libraries
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
require 'optparse'
require 'yaml'
require 'singleton'
require 'psi/logger'

class PSI
  class Args
  
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Modules
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    include Singleton
  
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Setters/Getters
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    attr_reader :options, :optparse
  
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Constructor
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    def initialize()
      @logger            = PSI::Logger.instance()
      @options           = {}
      @required_switches = {}
      @optparse          = nil
      @subcommand        = nil
      define_options()
      required_switches()
    end
    
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Parse the command line options
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    private
      def define_options()
        @optparse = OptionParser.new do | opts |
          opts.program_name = $0
          opts.banner = "\nUsage: ruby #{$0} [options]"
      
          @options[:project] = nil
          opts.on('-o', '--project PROJECT', 'Required - Specifies the KEY (not name) of the project that you want to act on in stash.') do | project |
            @options[:project] = project
          end

          @options[:workspace] = nil
          opts.on('-w', '--workspace WORKSPACE', 'Required - The full path to the directory in which a git action will be performed.') do | workspace |
            @options[:workspace] = workspace
          end
          
          @options[:authentication] = "SSH"
          opts.on('-a', '--auth AUTHENTICATION', 'Optional - Specify the authentication scheme, either SSH, or BASIC.  Defaults to SSH.') do | authentication |
            @options[:authentication] = authentication
          end          
  
          @options[:repo] = []
          opts.on('-r', '--repo a,b,c', Array, 'Optional - The repos within a project you want to act on. Defaults to all repos in a project if not specified.') do | repo |
            @options[:repo] = repo
          end

          @options[:blacklist] = []
          opts.on('-x', '--blacklist a,b,c', Array, 'Optional - Specifies if you want to perform a checkout.') do | blacklist |
            @options[:blacklist] = blacklist
          end
              
          @options[:clone] = nil
          opts.on('-c', '--clone', 'Optional - Specifies if you want to clone a repo. If no repo is specified, all repos in the project will be cloned.') do | clone |
            @options[:clone] = clone
          end
          
          @options[:pull] = nil
          opts.on('-p', '--pull', 'Optional - Specifies if you want to perform a pull on a repo. If no repo is specified, all repos in the project will be pulled.') do | pull |
            @options[:pull] = pull
          end
          
          @options[:fetch] = nil
          opts.on('-f', '--fetch', 'Optional - Specifies if you want to perform a fetch on a repo. If no repo is specified, all repos in the project will be fetched.') do | fetch |
            @options[:fetch] = fetch
          end
          
          @options[:checkout] = nil
          opts.on('-k', '--checkout BRANCH', 'Optional - Specifies if you want to perform a checkout. If no repo is specified, all repos in the project will be checked out.') do | checkout |
            @options[:checkout] = checkout
          end
                    
          @options[:status] = nil
          opts.on('-s', '--status', 'Optional - Provides a git status of the given repo. If no repository is specified, all repos in the project will be statused.') do | status |
            @options[:status] = status
          end

          @options[:stash_project_list] = nil
          opts.on('-j', '--stash-project-list', 'Optional - Provides a list of the project keys in stash.') do | project_list |
            @options[:stash_project_list] = project_list
          end

          @options[:setup_creds] = nil
          opts.on('-t', '--setup-creds', 'Optional - Allows the user to configure their credentials.') do | setup_creds |
            @options[:setup_creds] = setup_creds
          end

          # Help Option
          opts.on('-h','--help','Optional - Display this screen') do 
            puts opts
            Kernel.abort
          end
        end

        # Parse the options
        begin
          @optparse.parse!
        rescue Exception => e
          puts
          @optparse.help()
          Kernel.abort
        end

        # Return early before running checks in the next section
        return if @options[:setup_creds]
        return if @options[:stash_project_list]

        # Ensure that required switches were provided
        @required_switches['project']   = @options[:project]
        @required_switches['workspace'] = @options[:workspace]
      end
    
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Ensures that required switches are passed in
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    private
      def required_switches()
        status = 0
        @required_switches.each do | key,value |
          if value.nil?
            status = 1
            @logger.error("'#{key}' switch must be provided when executing the command")
          end
        end
        
        if status == 1
          puts @optparse.help()
          Kernel.abort
        end
      end
  end
end
