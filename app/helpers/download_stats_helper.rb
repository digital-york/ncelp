module DownloadStatsHelper
  def self.total_downloads
    if Figaro.env.download_stats_json.nil?
      '668,578' # Last GA download count before switching to GA4 account 21/06/2023
    else
      json_string = File.read(Figaro.env.download_stats_json)
      # Read number and format it with comma every thousend
      JSON.parse(json_string)['total_downloads'].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse
    end
  end
end
