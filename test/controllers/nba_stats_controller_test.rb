require 'test_helper'

class NbaStatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nba_stats_index_url
    assert_response :success
  end

end
