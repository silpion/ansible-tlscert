# ansible-ssl

Create self-signed or install existing SSL certificates.

## Description

This roles purpose is to manage SSL/TLS certificates. To do so, it provides
three main functionalities:

* Generate self-signed certificates
* Copy over existing certificates
* Save information about available certificates for other roles

## Requirements

None

## Role Variables

### ssl_install

A list of certificates to copy over to the managed node. This requires
a ``{{ name }}.crt`` and a ``{{ name }}.key`` file to be available at
``files/`` directory.

      ssl_install:
        - foo.domain.tld

### ssl_create

A list of self-signed certificates to create


    ssl_create:
      - CN: test-cert.org         # Required: Common name the certificate is valid for
        C: US                     # Optional: Country
        ST: Michigan              # Optional: State
        OU: Fire_department       # Optional: Organizational unit
        days: 365                 # Optional: Days the cert is valid
        bits: 2048                # Optional: Bits to use for the cert
        email: foo@bar.org        # Optional: Mailaddress of the site admin


#### Global SSL certificate generation defaults

* ``ssl_openssl_default_days``: Feeds -days argument to openssl req command (default: ``3650``)
* ``ssl_openssl_default_bits``: Feeds -newkey rsa:BITS argument to openssl req command (default: ``1024``)
* ``ssl_openssl_default_C``: OpenSSL countryName (default: ``DE``)
* ``ssl_openssl_default_ST``: OpenSSL stateOrProvince (default: ``Hamburg``)
* ``ssl_openssl_default_L``: OpenSSL localityName (default: ``Hamburg``)
* ``ssl_openssl_default_O``: OpenSSL 0.organizationalUnitName (default: ``Silpion IT Solutions``)
* ``ssl_openssl_default_OU``: OpenSSL organizationalUnitName (default: ``Development SSL``)
* ``ssl_openssl_default_P``: Password for the SSL certificate creation (default: ``SILPION!``)
* ``ssl_openssl_default_email``: Email for the SSL certificate creation (default: ``webmaster@{{ ansible_fqdn }}``)

### Global role defaults

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
