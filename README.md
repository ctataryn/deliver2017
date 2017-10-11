# Infrastructure as Code - Application Server Management using Chef

Presented at the [PrDC Deliver 2017](http://prdcdeliver.com) conference, this session gives an overview of teh primary tenants of Chef and provides a demo recipe and set of supporting resources for installing Apache Tomcat on a Windows machine.

A PDF of the Slide deck can be found in the `slides` folder

If you would like an onsite presentation, or Chef-related training, please email me at craig@grindsoftware.com

The recipe will perform the following:
1. Install a Java JDK
1. Install Apache Tomcat
1. Create a Windows Service

**Note:** The recipe is instrumented by manipulating values in `attributes/default.rb`.  Because this recipe was designed for a presentation where Internet access wasn't guaranteed, binary installers for Java and Tomcat that are on the local filesystem. Thus, if you'd like to use this on your system it is safe to remove `default['java_se']['uri']` and `default['java_se']['sha256']['exe']['x64']` attributes and have the `java_se` recipe download Java from Oracle.  For Tomcat you will have to find the right download URL (i.e. [http://mirror.its.dal.ca/apache/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23-windows-x64.zip](http://mirror.its.dal.ca/apache/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23-windows-x64.zip))
