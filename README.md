# Infrastructure as Code - Introduction to Chef

Presented at the [PrDC Deliver 2017](http://prdcdeliver.com) conference, this session gives an overview of teh primary tenants of Chef and provides a demo recipe and set of supporting resources for installing Apache Tomcat on a Windows machine.

A PDF of the Slide deck can be found in the `slides` folder

The recipe will perform the following:
1. Install a Java JDK
1. Install Apache Tomcat
1. Create a Windows Service

The setup shown at the presentation was as follows:
* [ChefDK](https://downloads.chef.io/chefdk) was installed on the presenter's Mac Book Pro
* [chef-server](https://downloads.chef.io/chef-server) was installed on an Oracle Virtual Box Ubuntu 16.04 VM [downloaded from osboxes.org](http://www.osboxes.org/ubuntu/)
* chef-client was bootstrapped onto the Windows VM from the ChefDK machine using `knife bootstrap winrm...`. The Windows VirtualBox VM was a [free 90day Windows 10 download](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/) from Microsoft.

If you would like an onsite presentation, or Chef-related training, please email me at craig@grindsoftware.com

**Note:** The recipe is instrumented by manipulating values in `attributes/default.rb`.  Because this recipe was designed for a presentation where Internet access wasn't guaranteed, binary installers for Java and Tomcat are assumed to exist on the local filesystem. Thus, if you'd like to use this on your system it is safe to remove `default['java_se']['uri']` and `default['java_se']['sha256']['exe']['x64']` attributes and have the `java_se` recipe download Java from Oracle.  For Tomcat you will have to find the right download URL (i.e. [http://mirror.its.dal.ca/apache/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23-windows-x64.zip](http://mirror.its.dal.ca/apache/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23-windows-x64.zip))
