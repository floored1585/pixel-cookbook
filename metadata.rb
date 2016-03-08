name 'pixel'
maintainer 'Ian Clark'
maintainer_email 'ian@f85.net'
issues_url 'https://github.com/floored1585/pixel-cookbook/issues' if respond_to?(:issues_url)
source_url 'https://github.com/floored1585/pixel-cookbook/' if respond_to?(:source_url)
license 'MIT'
description 'Prepares a server for Pixel application software'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.7'

depends 'apache2'
depends 'rvm'
depends 'logrotate'
