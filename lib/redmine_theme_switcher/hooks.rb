module RedmineThemeSwitcher
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, partial: 'hooks/theme_head'
    render_on :view_layouts_base_body_bottom, partial: 'hooks/theme_switcher'
  end
end
