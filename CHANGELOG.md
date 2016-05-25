# 2.0.1


* Use suid bit for facts script
* Use long option for sudo call
* Fix sudo timeout for facts script

Alvaro Aleman (3):
# 2.0.0
Alvaro Aleman (8):

* Use .key as file suffix for generated keys
* Use lib.localfacts
* Use lib.os-specific-vars
* Add silpion.lib to requirements
* Add note about silpion.lib dependency to README
* Re-read tlscerts facts when certificate changes occured
* Dont use subkey in filter args for setup module
* Add simple usage examples

Anja Siek (1):

* fix deprication warnings

# 1.2.0

Alvaro Aleman (1):

* Use host-specific name for local vars file

# 1.2.0

Alvaro Aleman (6):

* Make fact naming consistent
* Recognize certificate keys with different filetypes
* Redirect error output of key modulus detection
* Update docs to reflect obsolete dependency on util
* Use heredoc for factscript
* Use var instead of msg param for fact debugging

# 1.1.0

Alvaro Aleman (1):

* Remove hard dependency on ansible-util

Mark Kusch (1):

* Fixup variable name for checkmode make target

# 1.0.0

Alvaro Aleman (38):

* fixed errors on empty ssl\_certificates\_create
* role renamed
* Refactor variable names to reflect role name
* Rename facts
* Rework README
* Update Vagrant testing
* Remove create facts.d dicetory task
* Add ansible-util assertion
* Refactor default directorys map for readability
* Fix testplaybook
* Refactor testplaybook for readability
* Allow defining ssl\_install as String
* Move ssl\_cert install to beginning
* Add script for gathering ssl cert info
* Add execute tasks for gather cert facts script
* Move ssl\_create to locally templated vars file
* Fix gather\_cert\_facts script
* Update README
* Fix roleinternal\_facts script
* Fix testcert distribution
* Make gather\_facts script output JSON
* Use script for tls\_certificates fact generation
* Remove obsolete variables
* Remove cert.name variable
* Disable host key checking for testing
* Add short form for ssl\_create
* Move defaulting of ssl\_{cnf,crt,key}\_path to roleinternal\_facts template
* Use .key extension for ssl keys
* Make ssl\_install sourcedircetory configurable
* Add ssl\_changed var
* Update README
* Rename role to ansible-tlscert
* Avoid unnecessary re-reading of facts
* Add a makefile for automated testing
* Fix ortography
* Consistently use complex args style
* Fix naming in Vagrant
* Allow syntax testing without executing role

# 0.6.0

Alvaro Aleman (3):

* Updated TDD functionality
* moved template logic for ssl_certificates_create into tasks to make the list reusable
* removed Debian platform specific serverspec tests

Mark Kusch (1):

* Add CN name to test certificate

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
