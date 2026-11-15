RedmineApp::Application.routes.draw do
  get 'redmine_dark_theme_switcher/updates',
      to: 'redmine_dark_theme_switcher/version_checks#show',
      as: 'redmine_dark_theme_switcher_updates'
end
