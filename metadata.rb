name 'deliver2017'
maintainer 'Craig Tataryn'
maintainer_email 'craiger@tataryn.net'
license 'Copyright Craig Tataryn All Rights Reserved'
description 'Installs/Configures demo recipes for PrDC Deliver 2017'
long_description 'Cookbooks for configuring the Java-based applications'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'java_se', '~> 8.131.0'
depends 'windows', '~> 3.1.1'
supports 'windows'

