solo true
file_cache_path "/tmp/chef-solo"
cookbook_path %W(/tmp/chef-solo/cookbooks #{File.expand_path(File.join(File.dirname(__FILE__), "cookbooks"))})
