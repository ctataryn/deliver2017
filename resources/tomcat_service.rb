
resource_name :tomcat_service

property :service_name, String, required: true
property :jvm_opts, Array, required: false, default: []
property :mem_min, String, required: false, default: ''
property :mem_max, String, required: false, default: ''
property :log_level, String, required: false, default: ''
property :log_stdout, String, required: false
property :log_stderr, String, required: false
property :startup, Symbol, required: false

default_action :create

action :create do
  log enviro
  execute "Create #{service_name} Windows Service" do
    environment enviro
    command "#{tomcat_svc_cmd} install #{service_name}"
    not_if  "sc query #{service_name}"
  end
end

action :remove do
  log enviro
  execute "Removing #{service_name} Windows Service" do
    environment enviro
    command "#{tomcat_cmd} //DS//#{service_name}"
    only_if  "sc query #{service_name}"
  end
end

action :update do
  execute "Update Tomcat Service params" do
    environment env
    command "#{tomcat_cmd} //US//#{service_name} #{get_service_opts}"
  end
end

action :start do
  unless new_resource.startup.nil?
    sup = new_resource.startup == :auto ? 'auto' : 'manual'
    execute "Changing startup of Tomcat Service to #{sup}" do
      command "#{tomcat_cmd} //US//#{service_name} --Startup=#{sup}"
    end
  end

  execute "Start Tomcat Service" do
    command "sc start #{service_name}"
    not_if { (`sc start #{service_name}` =~ /STOPPED/).nil? }
  end
end

action :stop do
  execute "Stop Tomcat Service" do
    command "#{tomcat_cmd} //SS//#{service_name}"
    only_if  "sc query #{service_name}"
  end
end

action_class.class_eval do
  def tomcat_svc_cmd
    "#{node['tomcat']['folder']}\\bin\\service.bat"
  end

  def tomcat_cmd
    "#{node['tomcat']['folder']}\\bin\\tomcat8.exe"
  end

  def enviro
    {"CATALINA_HOME" => node['tomcat']['folder']}
  end

  def get_service_opts
    opts = ''
    unless new_resource.mem_min.empty?
      opts += "--JvmMs=#{new_resource.mem_min} "
    end

    unless new_resource.mem_max.empty?
      opts += "--JvmMx=#{new_resource.mem_max} "
    end

    unless new_resource.log_level.empty?
      opts += "--LogLevel=#{new_resource.log_level} "
    end

    # in the case of log_stdout it's valid to set the value to a blank string
    # so we can't use .empty?
    unless new_resource.log_stdout.nil?
      opts += "--StdOutput=\"#{new_resource.log_stdout}\" "
    end

    # in the case of log_stderr it's valid to set the value to a blank string
    unless new_resource.log_stdout.nil?
      opts += "--StdError=\"#{new_resource.log_stderr}\" "
    end

    new_resource.jvm_opts.each do |jvm_opt|
      opts += "++JvmOptions=\"#{jvm_opt}\" "
    end

    opts

  end
end
