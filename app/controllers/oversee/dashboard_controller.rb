module Oversee
  class DashboardController < BaseController
    def show
      fetch_metrics
    end

    private

    def fetch_metrics
      @metrics = [{
        label: "Total Users",
        metric: User.count,
      }]
    end
  end
end
