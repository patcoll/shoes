include_recipe "env"

if node.platform == "mac_os_x" and node.platform_version[0,4] == "10.6"
  package "libpng" do
    version "1.4.5"
  end
  
  package "jpeg" do
    version "8c"
  end
  
  package "giflib" do
    version "4.1.6"
  end

  package "gettext" do
    version "0.18.1.1"
  end

  package "libiconv" do
    version "1.13.1"
  end

  package "libxml2" do
    version "2.7.8"
  end

  package "glib2" do
    version "2.28.1"
  end

  package "libpixman" do
    version "0.20.2"
  end

  package "cairo" do
    version "1.10.2"
    options "+no_x11 +quartz"
  end

  package "pango" do
    version "1.28.3"
    options "+no_x11 +quartz"
  end

  package "portaudio" do
    version "19.20071207"
  end

  %w(rake bundler).each do |gempkg|
    gem_package gempkg
  end
  
  execute "bundle-gems" do
    cwd node.base_dir
    command "bundle"
  end
  
  bash "build-shoes" do
    cwd node.base_dir
    # environment({
    #   "PKG_CONFIG_PATH" => "/opt/local/lib/pkgconfig",
    #   "DYLD_LIBRARY_PATH" => "/opt/local/lib",
    #   "LD_LIBRARY_PATH" => "/opt/local/lib",
    #   "SHOES_DEPS_PATH" => "/opt/local",
    #   # "RUBYOPT" => "-I/opt/local/lib/ruby/site_ruby/1.9.1 -I/opt/local/lib/ruby/1.9.1 -I/tmp/dep/lib/ruby/1.9.1/powerpc-darwin9.8.0"
    # })
    code "rake"
    # not_if 
  end
end

