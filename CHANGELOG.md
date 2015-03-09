# 0.5.0

Mark Kusch (6):

* Do not show ansible output when possibly dealing with passwords
* Maintain role meta data and add dependency to silpion.util role
* Maintain default path information for {{ ansible_os_family }}
* Provide usable defaults based on OS family
* Fix hardcoded key file path in openssl configuration
* Whether to show a neat sheep or ansible_managed

# 0.4.1

Mark Kusch (1):

* Add description to include_vars task for OS specific vars

# 0.4.0

Mark Kusch (6):

* Allow to override ownership and access controls for OpenSSL directories
* Add license
* Allow github to perform integration testing
* Update integration testing to work with Serverspec 2.N
* Ensure tasks define sudo: yes when requiring superuser privileges
* Abstract supported platforms in vars

# 0.3.0

Mark Kusch (8):

* Install existing certificates according to pathes
* Install SSL certificate keys with .pem extension
* Update documentation

# 0.2.3

Mark Kusch (2):

* Update ubuntu-upstart-sshkey container to version 1.0.0
* Ensure custom facts are available to third party roles

# 0.2.2

* Fix local facts destination.

.
.
.

# 0.0.1

* Initial release


<!-- vim: set nofen ts=4 sw=4 et: -->
