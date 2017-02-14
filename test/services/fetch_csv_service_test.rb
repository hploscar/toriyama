require "test_helper"

class FetchCsvServiceTest < ActiveSupport::TestCase
  test 'it should return an error if url is empty' do
    params = {
      url: ""
    }

    file = FetchCsvService.new(params).fetch
    assert_equal("Error", file)
  end

  test 'it should return an error if url does not exists' do
    params = {
      url: 'http://asdaweqw.sdaweas.asw'
    }

    file = FetchCsvService.new(params).fetch
    assert_equal("Error", file)
  end

  test 'it should return a path if file is succesfully saved' do
    params = {
      url: 'http://www.google.es'
    }

    time = Time.new
    filename = "#{time.year}-#{time.month}-#{time.day}.csv"

    file = FetchCsvService.new(params).fetch

    assert file
    assert_equal(filename, file)
  end
end
