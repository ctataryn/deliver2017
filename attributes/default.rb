# Java settings
default['java_se']['uri'] = "file:///D:/jdk-8u131-windows-x64.exe"
default['java_se']['sha256']['exe']['x64'] = "8226ff89769ec3bd212305dbc83a678ad42560e65a430819917bb7965a2b89bb"
default['java_se']['java_home'] = "C:\\jdk\\jdk1.8.0_131"
default['java_se']['win_jre_home'] = "C:\\jdk\\jdk1.8.0_131\\jre"
default['java_se']['win_adlocal'] = "ToolsFeature"

# Tomcat settings
default['tomcat']['url'] = 'file:///D:/apache-tomcat-8.5.23-windows-x64.zip'
default['tomcat']['folder'] = 'C:\apache-tomcat-8.5.23'
default['tomcat']['instance']['baseFolder'] = 'C:\tc-instances'
default['tomcat']['instance']['memory']['min'] = '512'
default['tomcat']['instance']['memory']['max'] = '4096'

default['tomcat']['admin']['uid'] = 'admin'
default['tomcat']['admin']['pwd'] = 'adminpwd'
default['tomcat']['build']['uid'] = 'build'
default['tomcat']['build']['pwd'] = 'buildpwd'

#Added service related memory contraints
default['tomcat']['memory']['min'] = '512'
default['tomcat']['memory']['max'] = '1024'
