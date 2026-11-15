require 'json'
require 'net/http'
require 'openssl'
require 'rubygems/version'
require 'uri'

module RedmineDarkThemeSwitcher
  class VersionChecker
    class Error < StandardError; end

    TAGS_URI = URI(
      'https://api.github.com/repos/artymarty0/redmine_dark_theme_switcher/tags?per_page=100'
    )

    def latest_version
      response = Net::HTTP.start(
        TAGS_URI.host,
        TAGS_URI.port,
        use_ssl: true,
        open_timeout: 3,
        read_timeout: 5
      ) do |http|
        request = Net::HTTP::Get.new(TAGS_URI)
        request['Accept'] = 'application/vnd.github+json'
        request['User-Agent'] = 'Redmine-Dark-Theme-Switcher'
        http.request(request)
      end

      raise Error, "GitHub API returned HTTP #{response.code}" unless response.is_a?(Net::HTTPSuccess)

      tags = JSON.parse(response.body)
      raise Error, 'GitHub API returned an invalid tags response' unless tags.is_a?(Array)

      versions = tags.filter_map do |tag|
        next unless tag.is_a?(Hash) && tag['name'].is_a?(String)

        version = tag['name'].delete_prefix('v')
        Gem::Version.new(version) if Gem::Version.correct?(version)
      end

      versions.max || raise(Error, 'No version tags were found on GitHub')
    rescue Net::OpenTimeout, Net::ReadTimeout, SocketError, SystemCallError,
           OpenSSL::SSL::SSLError, JSON::ParserError => e
      raise Error, "Unable to check for updates: #{e.message}"
    end
  end
end
