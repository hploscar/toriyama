class FetchCsvService
  def initialize(params)
    return "Error" if params[:url].blank?

    @url = URI(params[:url])
  end

  def fetch
    begin
      download_file
    rescue
      "Error"
    end
  end

  private

  attr_reader :url

  def download_file
    time = Time.new
    filename = "#{time.year}-#{time.month}-#{time.day}.csv"
    @req = Net::HTTP::Get.new(url)

    begin
      Net::HTTP.start(url.hostname, url.port) do |http|
        resp = http.request(@req)
      end
    rescue
      "Error"
    end

    begin
      puts resp.body
      open(filename, "wb") do |file|
        file.write(resp.body)
      end
      filename
    rescue
      "Error"
    end

    #(url.eql? "http://www.google.es") ? filename : "Error"
  end

end
