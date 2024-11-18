class Oversee::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def add_routes
    route 'mount Oversee::Engine => "/oversee"'
  end
end
