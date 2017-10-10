tomcat_folder = node['tomcat']['folder']
tomcat_installed = ::File.exist?(tomcat_folder)
java_installed = ::File.exists?(node['java_se']['java_home'])
tomcat_installer_url = node['tomcat']['url']

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
