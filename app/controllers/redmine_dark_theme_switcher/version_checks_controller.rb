module RedmineDarkThemeSwitcher
  class VersionChecksController < ApplicationController
    before_action :require_admin

    def show
      @plugin = Redmine::Plugin.find(:redmine_dark_theme_switcher)
      @latest_version = VersionChecker.new.latest_version
      installed_version = @plugin.version.delete_prefix('v')
      @update_available = Gem::Version.new(installed_version) < @latest_version
    rescue VersionChecker::Error => e
      @check_error = e.message
    end
  end
end
