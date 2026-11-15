require_relative 'lib/redmine_dark_theme_switcher/hooks'
require_relative 'lib/redmine_dark_theme_switcher/version_checker'

Redmine::Plugin.register :redmine_dark_theme_switcher do
  name 'Redmine Theme Switcher'
  author 'artymarty'
  description 'Light and dark mode switch'
  version '1.0.0'
  url 'https://github.com/artymarty0/redmine_dark_theme_switcher'
  requires_redmine version_or_higher: '6.0.0'

  menu :admin_menu, :theme_switcher_updates,
       { controller: 'redmine_dark_theme_switcher/version_checks', action: 'show' },
       caption: :label_theme_switcher_updates,
       icon: 'moon',
       plugin: 'redmine_dark_theme_switcher',
       html: { class: 'icon' }

  menu :account_menu, :theme_toggle, '#',
       caption: '',
       html: { id: 'theme-toggle-btn', title: 'Switch theme' },
       first: true
end
