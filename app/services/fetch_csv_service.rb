class FetchCsvService
  require "open-uri"

  def initialize(params)
    raise ArgumentError, "Error" if params[:url].blank?

    @url = params[:url]
  end

  def fetch
    download_file
  end

  private

  attr_reader :url

  def download_file
    time = Time.new
    filename = "files/#{time.year}-#{time.month}-#{time.day}.csv"

    uri = URI.parse(url)
    req = Net::HTTP.new(uri.host, uri.port)
    req.use_ssl = true if uri.scheme == 'https'

    begin
      req.get(uri.path) do |http|
        open(filename, "wb") do |file|
          file.write(http)
        end
      end

      filename

    rescue
      raise URI::Error
    end

  end

end
