require 'json'

# -----------------------------------------------------------------------------
# To insert the sponsor tag into a page, use the following code:
# -----------------------------------------------------------------------------
# <div class="sponsored">
#   {% sponsored_link %}
#   <small>Sponsored link</small>
# </div>
# -----------------------------------------------------------------------------

module Jekyll
  class SponsoredLinkTag < Liquid::Tag
    def render(context)
      # Get the latest issue number from the index
      issues_response = curated_api_request("https://api.curated.co/iosdevweekly/api/v1/issues")
      issues_json = JSON.parse(issues_response.body)
      latest_issue_number = issues_json["issues"].first["number"]
      latest_issue_url = "https://api.curated.co/iosdevweekly/api/v1/issues/#{latest_issue_number}"

      # Get the sponsored link information for the latest issue
      latest_issue_response = curated_api_request(latest_issue_url)
      latest_issue_json = JSON.parse(latest_issue_response.body)
      latest_issue_json["categories"].each do |category|
        if category["code"] == "sponsored" then
          sponsored_link = category["items"].first
          sponsored_link_title = sponsored_link["title"]
          sponsored_link_url = sponsored_link["url"]
          sponsored_link_body = sponsored_link["description"]
          return "<h3><a href=\"#{sponsored_link_url}\">#{sponsored_link_title}</a></h3>#{sponsored_link_body}"
        end
      end
    end

    def curated_api_request(url)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      headers = { "Authorization" => "Token token=8e67fac28ede5eeca2f95a8dde1990de" }
      Net::HTTP::Get.new(uri.request_uri, headers)
      request = Net::HTTP::Get.new(uri.request_uri, headers)
      http.request(request)
    end
  end
end

Liquid::Template.register_tag('sponsored_link', Jekyll::SponsoredLinkTag)
