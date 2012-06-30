module UiHelpers
  def create_feed
    visit '/'
    fill_in 'username', with: 'artemave'
    click_button 'create'
  end
end
