module Oversee
  class DashboardController < BaseController
    def index
      render Oversee::Views::Dashboard::Index.new, layout: false
    end

    def show
      fetch_metrics

      root = Rails.root.join("app/oversee/cards/")
      files = Dir.glob(root.join("**/*.rb"))
      @class_strings = files.sort!.map! { |f| f.split(root.to_s).last.delete_suffix(".rb").classify }
    end

    private

    def fetch_metrics
      # @metrics = [{
      #   label: "Total Users",
      #   value: User.count,
      # }]
      @metrics = []
    end
  end
end
