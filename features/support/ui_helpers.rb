module UiHelpers
  def create_feed username
    visit '/'
    fill_in 'username', with: username
    click_button 'create'
  end
end
