<#assign
	show_footer = getterUtil.getBoolean(themeDisplay.getThemeSetting("show-footer"))
	show_header = getterUtil.getBoolean(themeDisplay.getThemeSetting("show-header"))
	show_header_search = getterUtil.getBoolean(themeDisplay.getThemeSetting("show-header-search"))
	wrap_widget_page_content = getterUtil.getBoolean(themeDisplay.getThemeSetting("wrap-widget-page-content"))
	site_name = getterUtil.getString(themeDisplay.getThemeSetting("site-name"))
	menu_logo_height = getterUtil.getLong(themeDisplay.getThemeSetting("menu-logo-height"))
	use_menu_logo_urls = getterUtil.getBoolean(themeDisplay.getThemeSetting("use-menu-logo-urls"))
	menu_collapsed_logo_url = getterUtil.getString(themeDisplay.getThemeSetting("menu-collapsed-logo-url"))
	menu_expanded_logo_url = getterUtil.getString(themeDisplay.getThemeSetting("menu-expanded-logo-url"))
	menu_template_id = getterUtil.getLong(themeDisplay.getThemeSetting("menu-template-id"))
	menu_id = getterUtil.getLong(themeDisplay.getThemeSetting("menu-id"))
	show_control_menu = getterUtil.getBoolean(sessionClicks.get(request, "SHOW_CONTROL_MENU", "true"))
	user_menu_position = getterUtil.getString(themeDisplay.getThemeSetting("user-menu-position"))
/>

<#if wrap_widget_page_content && ((layout.isTypeContent() && themeDisplay.isStateMaximized()) || (layout.getType() == "portlet"))>
	<#assign portal_content_css_class = "container" />
<#else>
	<#assign portal_content_css_class = "" />
</#if>

<#function min(a, b)>
  <#return (a < b)?then(a, b)>
</#function>