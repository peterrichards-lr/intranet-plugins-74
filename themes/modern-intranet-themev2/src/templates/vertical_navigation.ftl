<#assign 
    show_secondary = false 
    current_index = 0
/>

<style>
<#if use_menu_logo_urls>
    #mi-menu > a > img, #mi-icon-menu > span > img {
        height: ${menu_logo_height}px;
    }

    #mi-icon-menu > span > img {
        content: url(${menu_collapsed_logo_url}) / "${logo_description}";            
    }

    #mi-menu > a > img {
        content: url(${menu_expanded_logo_url}) / "${logo_description}";
    }
<#else>
    #mi-menu > a > img, #mi-icon-menu > span > img {
        height: ${menu_logo_height}px;
    }

    #mi-icon-menu > span > img {
        content: url(${themeDisplay.getCompanyLogo()}) / "${logo_description}";
    }

    #mi-menu > a > img {
        content: url(${themeDisplay.getCompanyLogo()}) / "${logo_description}";
    }
</#if>
</style>

<#if nav_items?has_content>
    <#list nav_items as nav_item>
        <#if nav_item.isSelected() || nav_item.isChildSelected() >
            <#if nav_item.hasChildren()>
                <#assign
                    show_secondary = true
                    current_index = nav_item?index
                />
            </#if>
            <#break>
        </#if>
    </#list>
</#if>

<div id="vertical-nav-wrapper" class="d-none ${show_secondary?string('has-secondary','')}">
</div>

<div class="mobile-menu container mt-2">	
    
    <button id="mobile-toggler" class="navbar-toggler navbar-toggler-right" type="button">
        <@liferay_ui.icon icon="bars" markupView="lexicon" />
    </button>

    <#assign search_preferences = freeMarkerPortletPreferences.getPreferences({"portletSetupPortletDecoratorId": "barebone", "destination": "/search"}) />

    <div class="mi-mob-search-bar mr-2">
        <@liferay.search_bar default_preferences="${search_preferences}" />
    </div>

    <#if user_menu_position=='left'>
        <@liferay.user_personal_bar />
    </#if>

</div>

<nav id="mi-icon-menu" class="flex-column">
    <span class="navbar-brand mb-5 mt-5">
        <img />
    </span>
    <#if nav_items?has_content>
        <ul id="mi-menu-icons" class="navbar-nav nav-stacked w-100 mb-5">	
            <#list nav_items as nav_item>
                <#assign
                    nav_item_css_class = ""
                    nav_item_layout = nav_item.getLayout()
                />
                <#if nav_item.isSelected() || nav_item.isChildSelected() >
                    <#assign nav_item_css_class = "selected active" />
                    <#if nav_item.hasChildren()>
                        <#assign
                            show_secondary = true
                            current_index = nav_item?index
                        />
                    </#if>
                </#if>
                <#assign layout_icon = " " />
                <#if nav_item_layout.getExpandoBridge().hasAttribute("icon")>
                    <#if nav_item_layout.getExpandoBridge().getAttribute("icon")??>
                        <#assign layout_icon = nav_item_layout.getExpandoBridge().getAttribute("icon") />
                    </#if>
                </#if>
                <li class="item-icon ${nav_item_css_class} d-flex justify-content-center w-100 my-3">
                    <@liferay_ui.icon icon="${layout_icon}" markupView="lexicon" />
                </li>
            </#list>
        </ul>
    </#if>
    <#if user_menu_position=='left'>
        <div class="personal-bar mt-auto mb-4">
            <@liferay.user_personal_bar />
        </div>
    </#if>
</nav>

<nav id="mi-menu" class="navbar flex-column align-items-start monserrat">
    <a class="navbar-brand d-flex align-items-center mb-5 pl-5 mt-5" href="${themeDisplay.getURLHome()}">
        <img />
        <#if !use_menu_logo_urls>
            <#if site_name?has_content>
                <h2 class="m-0 text-dark">${site_name}</h2>
            </#if>
            <#if !site_name?has_content>
                <h2 class="m-0 text-dark">
                    ${htmlUtil.escape(themeDisplay.getLayout().getGroup().getDescriptiveName())}
                </h2>
            </#if>
            <div>
                <img />
            </div>
        </#if>
    </a>
    <#if layout.isPublicLayout()>
        <#assign ddmTemplateLocalService = serviceLocator.findService("com.liferay.dynamic.data.mapping.service.DDMTemplateLocalService")>
        <#assign template = ddmTemplateLocalService.fetchDDMTemplate(menu_template_id)!>
        <#assign siteNavigationMenuLocalService = serviceLocator.findService("com.liferay.site.navigation.service.SiteNavigationMenuLocalService")>
        <#assign navigationMenu = siteNavigationMenuLocalService.fetchSiteNavigationMenu(menu_id)!>

        <#if template?has_content && navigationMenu?has_content>
            <@liferay_site_navigation["navigation-menu"]
                ddmTemplateGroupId=template.groupId
                ddmTemplateKey=template.templateKey
                displayDepth=1
                expandedLevels="auto"
                rootItemType="absolute"
                rootItemLevel=0
                siteNavigationMenuId=navigationMenu.siteNavigationMenuId />
        <#else>
            <div class="d-flex" style="color: var(--danger);">Configure menu Id and menu template Id</div>
        </#if>
    <#else>
        <#if nav_items?has_content>
            <ul id="mi-menu-list" class="navbar-nav nav-stacked w-100 mb-5">
                <#list nav_items as nav_item>
                    <#assign nav_item_css_class = "" />

                    <#if nav_item.isSelected() || nav_item.isChildSelected()>
                        <#assign nav_item_css_class = "selected active" />
                    </#if>

                    <li class="item ${nav_item_css_class} w-100 pl-6 my-3">
                        <a href="${nav_item.getURL()}">
                            ${nav_item.getName()}
                        </a>
                    </li>
                </#list>
            </ul>
        </#if>
    </#if>
    <#if user_menu_position=='left'>
        <div class="personal-bar pl-6 mt-auto mb-4">
            <@liferay.user_personal_bar />
        </div>
    </#if>
</nav>

<#if show_secondary>
    <nav id="mi-secondary-menu">
        <ul class="child-menu navbar-nav nav-stacked mt-5 monserrat">
            <#list nav_items[current_index].getChildren() as nav_child>
                <#assign nav_item_css_class = "" />

                <#if nav_child.isSelected()>
                    <#assign nav_item_css_class = "selected active" />
                </#if>

                <#assign layout_icon = " " />
                <#assign
                    nav_item_child_layout = nav_child.getLayout()
                />
                <#if nav_item_child_layout.getExpandoBridge().hasAttribute("icon")>
                    <#if nav_item_child_layout.getExpandoBridge().getAttribute("icon")??>
                        <#assign layout_icon = nav_item_child_layout.getExpandoBridge().getAttribute("icon") />
                    </#if>
                </#if>

                <li class="item-child ${nav_item_css_class} w-100 my-1" >
                    <a href="${nav_child.getURL()}">
                        <@liferay_ui.icon icon="${layout_icon}" markupView="lexicon" />
                        <span class="ml-1">${nav_child.getName()}</span>
                    </a>
                </li>
            </#list>
        </ul>
    </nav>
</#if>