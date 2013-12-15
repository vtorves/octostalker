module Octokit
  class Client
    module Organizations

      def organization_members_size(org, options = {})
        organization_members(org, per_page: 1, auto_paginate: false)
        @last_response.rels[:last].href_template.expand({}).query_values["page"].to_i
      end
    end
  end
end
