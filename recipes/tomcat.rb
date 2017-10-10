tomcat_folder = node['tomcat']['folder']
tomcat_installed = ::File.exist?(tomcat_folder)
java_installed = ::File.exists?(node['java_se']['java_home'])
tomcat_installer_url = node['tomcat']['url']
service_name = 'PRDC'

if (!java_installed)
    include_recipe "java_se::default"
end

unzip_to 'unzip tomcat' do
    path      tomcat_folder
    tarbomb   false
    source    tomcat_installer_url
    not_if    { tomcat_installed }
end

template "#{tomcat_folder}/conf/tomcat-users.xml" do
  source "tomcat-users.xml.erb"
  sensitive true
end

tomcat_service "Create #{service_name}'s Tomcat" do
  service_name "#{service_name}"
  action :create
  notifies :update, "tomcat_service[Update #{service_name}]", :immediately
end

tomcat_service "Update #{service_name}" do
  service_name "#{service_name}"
  action :nothing
  mem_min node['tomcat']['memory']['min']
  mem_max node['tomcat']['memory']['max']
  log_level "Warning"
  log_stdout ''
  log_stderr ''
end

tomcat_service "Start #{service_name}" do
  service_name "#{service_name}"
  action :start
  startup :auto
end
