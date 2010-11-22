module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /^(.*)'s edit interests page$/
      "/users/#{User.find_by_username($1).id}/interests/edit"#edit_path(User.find_by_username($1))
    when /^(.*)'s add interest page$/
      "/users/#{User.find_by_username($1).id}/interests/new"#add_interest_user_path(User.find_by_username($1))
    when /^(.*)'s show interests page$/
      "/users/#{User.find_by_username($1).id}/interests"#show_interests_user_path(User.find_by_username($1))
    when /^the signup page$/
      signup_path
    when /^the nearby users list$/
      nearby_list_path
    when /^the nearby users map$/
      nearby_map_path
    when /^the login page$/
      login_path
    when /^(.*)'s update_location page$/
      "/users/#{User.find_by_username($1).id}/update_location"#edit_path(User.find_by_username($1))
    when /^my profile$/
      user_path(current_user)
    when /^the show user page for ([^ ]+)$/
      user_path(User.find_by_username($1))
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
