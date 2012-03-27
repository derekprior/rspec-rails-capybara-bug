# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Item keys are normally added to list items as id.
  # This setting turns that off
  navigation.autogenerate_item_ids = false
  navigation.selected_class = 'active'

  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI. Passing :subpath will match all restful actions
    #
    primary.item :schedule, t('navigation.primary.schedule'), current_schedule_path do |schedule|
      schedule.item :schedule_now, t('navigation.schedule.now'), current_schedule_path
      schedule.item :schedule_weekly, t('navigation.schedule.weekly'), weekly_schedule_path, :highlights_on => /schedule\/weekly/
      schedule.item :schedule_personal, t('navigation.schedule.personal'), personal_schedule_path(current_user), :highlights_on => /schedule\/personal/
      schedule.item :edit_schedules, t('navigation.schedule.edit'), shift_schedules_path, :highlights_on => :subpath, :if => Proc.new { can? :edit, :shift_schedules }
      schedule.item :edit_assignments, t('navigation.schedule.assignments'), assignments_index_path, :highlights_on => :subpath, :if => Proc.new { can? :edit, :assignments }
      schedule.dom_id    = 'subnav'
      schedule.dom_class = 'nav nav-tabs'
    end
    primary.item :admin, t('navigation.primary.admin'), admin_root_path, :if => Proc.new { current_user.administrator? } do |admin|
      admin.item :admin_shifts, t('navigation.admin.shifts'), admin_shifts_path, :highlights_on => /admin\/?$|admin\/shifts/
      admin.item :admin_responsibilities, t('navigation.admin.responsibilities'), admin_responsibilities_path, :highlights_on => :subpath
      admin.item :admin_locations, t('navigation.admin.locations'), admin_locations_path, :highlights_on => :subpath
      admin.item :admin_holiday_schedules, t('navigation.admin.holiday_schedules'), admin_holiday_schedules_path, :highlights_on => :subpath
      admin.item :admin_users, t('navigation.admin.users'), admin_users_path, :highlights_on => :subpath
      admin.dom_id    = 'subnav'
      admin.dom_class = 'nav nav-tabs'
    end
    primary.item :help, t('navigation.primary.help'), help_path
    primary.dom_class = 'nav'
  end
end
