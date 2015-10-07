# ansible-ssl

Create self-signed or install existing SSL certificates.

## Requirements

When configuring any owner or group for any of ``cnf``, ``crt`` or ``key`` path variables
it is required to have these user/group accounts available on the managed node. Otherwise
this role will fail the play.

## Role Variables

* ``ssl_create``: Array of SSL certificates to create (array, default: ``[]``)
* ``ssl_install``: Array of existing SSL certificates to install (array, default: ``[]``)

* ``ssl_cnf_path``: Directory name where to store OpenSSL configuration files (string, default: see ``vars/{{ ansible_os_family }}.yml``)
* ``ssl_crt_path``: Directory name where to store SSL certificates (string, default: see ``vars/{{ ansible_os_family }}.yml``)
* ``ssl_key_path``: Directory name where to store SSL private keys (string, default: see ``vars/{{ ansible_os_family }}.yml``)

* ``ssl_cnf_path_owner``: Owner name or UID for OpenSSL configuration files directory (string, default: ``0``)
* ``ssl_cnf_path_group``: Group name of GID for OpenSSL configuration files directory (string, default: ``0``)
* ``ssl_cnf_path_mode``: Mode for OpenSSL configuration files directory (string, default: ``700``)

* ``ssl_crt_path_owner``: Owner name or UID for OpenSSL certificates directory (string, default: ``0``)
* ``ssl_crt_path_group``: Group name or GID for OpenSSL certificates directory (string, default: ``0``)
* ``ssl_crt_path_mode``: Mode for OpenSSL certificates directory (string, default: ``755``)

* ``ssl_key_path_owner``: Owner name or UID for OpenSSL private key directory (string, default: ``0``)
* ``ssl_key_path_group``: Group name or GID for OpenSSL private key directory (string, default: ``0``)
* ``ssl_key_path_mode``: Mode for OpenSSL private key directory (string, default: ``700``)


### Global SSL certificate generation defaults

* ``ssl_openssl_default_days``: Feeds -days argument to openssl req command (default: ``3650``)
* ``ssl_openssl_default_bits``: Feeds -newkey rsa:BITS argument to openssl req command (default: ``1024``)
* ``ssl_openssl_default_C``: OpenSSL countryName (default: ``DE``)
* ``ssl_openssl_default_ST``: OpenSSL stateOrProvince (default: ``Hamburg``)
* ``ssl_openssl_default_L``: OpenSSL localityName (default: ``Hamburg``)
* ``ssl_openssl_default_O``: OpenSSL 0.organizationalUnitName (default: ``Silpion IT Solutions``)
* ``ssl_openssl_default_OU``: OpenSSL organizationalUnitName (default: ``Development SSL``)
* ``ssl_openssl_default_P``: Password for the SSL certificate creation (default: ``SILPION!``)
* ``ssl_openssl_default_email``: Email for the SSL certificate creation (default: ``webmaster@{{ ansible_fqdn }}``)

### ssl_create

Any global variable can be overridden for each certificate from
``ssl_create`` array, e.g:

    vars:
      - ssl_create:
        - name: test-cert
          days: 365
          bits: 2048
          email: foo@bar.org
        - name: another-test-cert
          C: US
          ST: Michigan
          .
          .
          .

Variables not provided in a ``name`` dictionary within ``ssl_create``
array default to the global defaults.

### ssl_install

The role will copy existing certificate/key pairs to a managed node
if ``ssl_install`` variable is set.

    vars:
      - ssl_install:
        - name: foo.domain.tld

This requires two files .crt and .key to be available at files/ directory.

## Dependencies

This role depends on ``groover.util`` role. This is configured
for ``ansible-galaxy install`` in **requirements.yml**.

**NOTE**: Requirements are installed as virtual user ``silpion``
(``silpion.util``).

Be sure to install required roles with

    ansible-galaxy install --role-file requirements.yml

* [groover.util](https://github.com/silpion/ansible-util)

## Example playbook

**NOTE** Be advised to NOT add configuration variables to the playbook.
This is just an example which variables to configure in your inventory!

    - hosts: lbs
      vars:
        - ssl_create:
          - name: www.example.com
      roles:
        - { role: ansible-ssl }

<!-- -->

    - hosts: lbs
      vars:
        - ssl_install:
          - name: www.example.com

## License

Apache Version 2.0

## Integration testing

This role provides integration tests using the Ruby RSpec/serverspec framework
with a few drawbacks at the time of writing this documentation.

- Currently supports ansible_os_family == 'Debian' only.

Running integration tests requires a number of dependencies being
installed. As this role uses Ruby RSpec there is the need to have
Ruby with rake and bundler available.

    # install role specific dependencies with bundler
    bundle install

<!-- -->

    # run the complete test suite with Docker
    rake suite

<!-- -->

    # run the complete test suite with Vagrant
    RAKE_ANSIBLE_USE_VAGRANT=1 rake suite


## Author information

Anja Siek @anja.siek silpion.de
Mark Kusch @mark.kusch silpion.de


<!-- vim: set nofen ts=4 sw=4 et: -->
