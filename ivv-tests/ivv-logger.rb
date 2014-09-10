#!/opt/apps/ruby/ruby/bin/ruby
#
require 'ivv-logger'

log = IVV::Logger::Log.instance()
log.debug("Hope it worked")
log.info("Hope it worked")
log.error("Hope it worked")
log.warn("Hope it worked")
log.fatal("Hope it worked")
