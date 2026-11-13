require_relative 'lib/redmine_theme_switcher/hooks'

Redmine::Plugin.register :redmine_theme_switcher do
  name 'Redmine Theme Switcher'
  author 'artymart'
  description 'Light and dark mode switch'
  version '0.1.0'
  requires_redmine version_or_higher: '6.0.0'

  menu :account_menu, :theme_toggle, '#',
       caption: '',
       html: { id: 'theme-toggle-btn', title: 'Switch theme' },
       first: true
end
