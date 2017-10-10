resource_name :unzip_to

property :path, String, name_property: true, required: true
property :source, String, required: true
property :tarbomb, [true, false], required: false, default: true
property :extract_folder, String, required: false
property :app_name, String, required: false, default: ''

default_action :unzip


action :unzip do
  windows_zipfile "Download/unzip #{new_resource.app_name}" do
    path      tmp_folder
    source    new_resource.source
    overwrite true
    not_if    { is_installed(new_resource.path) }
    notifies  :create, "directory[Create #{new_resource.app_name} Folder]", :immediately
    notifies  :run, 'ruby_block[Extract folder name from archive]', :immediately
    notifies  :run, "execute[Install #{new_resource.app_name}]", :immediately
    notifies  :delete, "directory[Delete tmp folder]", :immediately
  end

  directory "Create #{new_resource.app_name} Folder" do
    path      new_resource.path
    recursive true
    action    :nothing
  end

  ruby_block "Extract folder name from archive" do
    block do
      dir_name = ''
      if (new_resource.tarbomb)
        dir_name = '.'
      elsif (new_resource.extract_folder.nil?)
        dir_name = Dir.entries(tmp_folder).last
      else
        dir_name = new_resource.extract_folder
      end
      node.run_state['unzip_dir_name'] = dir_name
      Chef::Log.info("UNZIP_DIR_NAME: #{node.run_state['unzip_dir_name']}")
    end
    action :nothing
  end

  execute "Install #{new_resource.app_name}" do
    cwd       lazy { "#{tmp_folder}\\#{node.run_state['unzip_dir_name']}" }
    command   "xcopy /S /E /Q . #{new_resource.path}"
    action    :nothing
  end

  directory "Delete tmp folder" do
    path      tmp_folder
    recursive true
    action    :nothing
  end

end

action_class.class_eval do

  def tmp_folder
    "#{Chef::Config[:file_cache_path]}/unzip_to_tmp"
  end

  def is_installed(the_path)
    ::File.exist?(the_path)
  end

end
