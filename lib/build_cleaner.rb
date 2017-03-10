# For solving Middleman 4 deploy issues
# See https://github.com/middleman-contrib/middleman-deploy/issues/114

class BuildCleaner < Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super
    FileUtils.rm_rf app.config[:build_dir]
  end

end

::Middleman::Extensions.register(:build_cleaner, BuildCleaner)
