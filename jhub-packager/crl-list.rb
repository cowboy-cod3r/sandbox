#
#         __           __  __      __
#        / /___ ______/ / / /_  __/ /_
#   __  / / __ `/ ___/ /_/ / / / / __ \
#  / /_/ / /_/ / /  / __  / /_/ / /_/ /
#  \____/\__,_/_/  /_/ /_/\__,_/_.___/
#
# File:    crl-list.rb
# Author:  Chris Eberle <chris.eberle@issinc.com>
# Created: Mon Jan 20 10:56:53 2014
#
# Package up CRL files

logger.info "CRL :: Starting to package CRL."

unless File.exists?(crlLocation)
  logger.error "crlLocation points to a bogus location"
  raise RuntimeError.new "The CRL path defined doesn't exist"
end

# To avoid any possible collisions, our filenames will have a timestamp
dateAndTimeFormat = java.text.SimpleDateFormat.new("yyyyMMdd_HHmmss")
dateAndTime = dateAndTimeFormat.format(java.util.Date.new)
crlFileName = "crl-list-" + dateAndTime + ".zip"
crlFile = File.join(cwd, crlFileName)

totalRunTime = timeIt do
  logger.info "Compressing package into #{crlFileName}..."

  compressTime = timeIt do
    compress(crlLocation, crlFile) do |file, path|
      keepTheFile = if file.isDirectory
                      true
                    elsif file.isFile and path.match(/\.crl$/)
                      true
                    else
                      false
                    end

      if keepTheFile
        logger.debug "[compress] #{path}"
      end

      keepTheFile
    end
  end

  logger.info "Compression finished in #{compressTime}"
end

logger.info "Packager CRL finished in #{totalRunTime}"
crlFileName
