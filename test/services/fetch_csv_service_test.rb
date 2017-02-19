require "test_helper"

class FetchCsvServiceTest < ActiveSupport::TestCase

  test 'it should return an error if url is empty' do
    params = {
      url: ""
    }

    assert_raises ArgumentError do
      FetchCsvService.new(params).fetch
    end
  end

  test 'it should return an error if url does not exists' do
    params = {
      url: 'https://torstatus.blutmagies.den/ip_list_all.php/Tor_ip_list_ALL_ERROR.csv'
    }

    assert_raises URI::Error do
      FetchCsvService.new(params).fetch
    end
  end

  test 'it should return a path if file is succesfully saved' do
    params = {
      url: 'https://torstatus.blutmagie.de/ip_list_all.php/Tor_ip_list_ALL.csv'
    }

    time = Time.new
    filename = "files/#{time.year}-#{time.month}-#{time.day}.csv"

    assert_equal(filename, FetchCsvService.new(params).fetch)
    # assert FetchCsvService.new(params).fetch

  end
end
