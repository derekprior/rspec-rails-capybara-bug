Rails.application.config.generators do |g|
    g.test_framework     :rspec
    g.form_builder       :simple_form

    # RSpec Defaults
    g.routing_specs      false
    g.view_specs         false
    g.controller_specs   false
    g.request_specs      false
    g.helper_specs       false

    # Generator Defaults
    g.helper             false
end

