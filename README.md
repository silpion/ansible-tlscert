# ansible-tlscert

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

### tlscert_install

A list of certificates to copy over to the managed node. This requires
a ``{{ name }}.crt`` and a ``{{ name }}.key`` file to be available at
``{{ tlscert_install_sourcedirectory|default('files') }}/`` directory.

      tlscert_install:
        - foo.domain.tld

### tlscert_create

A list of self-signed certificates to generate.


    tlscert_create:
      - my.tld.com                # Short form, allows to configure domain only
      - CN: test-cert.org         # Required: Common name the certificate is valid for
        C: US                     # Optional: Country
        ST: Michigan              # Optional: State
        OU: Fire_department       # Optional: Organizational unit
        days: 365                 # Optional: Days the cert is valid
        bits: 2048                # Optional: Bits to use for the cert
        email: foo@bar.org        # Optional: Mailaddress of the site admin


#### Global SSL certificate generation defaults

* ``tlscert_openssl_default_days``: Feeds -days argument to openssl req command (default: ``3650``)
* ``tlscert_openssl_default_bits``: Feeds -newkey rsa:BITS argument to openssl req command (default: ``1024``)
* ``tlscert_openssl_default_C``: OpenSSL countryName (default: ``DE``)
* ``tlscert_openssl_default_ST``: OpenSSL stateOrProvince (default: ``Hamburg``)
* ``tlscert_openssl_default_L``: OpenSSL localityName (default: ``Hamburg``)
* ``tlscert_openssl_default_O``: OpenSSL 0.organizationalUnitName (default: ``Silpion IT Solutions``)
* ``tlscert_openssl_default_OU``: OpenSSL organizationalUnitName (default: ``Development SSL``)
* ``tlscert_openssl_default_P``: Password for the SSL certificate creation (default: ``SILPION!``)
* ``tlscert_openssl_default_email``: Email for the SSL certificate creation (default: ``webmaster@{{ ansible_fqdn }}``)

### Global role defaults

* ``tlscert_cnf_path``: Directory name where to store OpenSSL configuration files (string, default: see ``vars/{{ ansible_os_family }}.yml``)
* ``tlscert_crt_path``: Directory name where to store SSL certificates (string, default: see ``vars/{{ ansible_os_family }}.yml``)
* ``tlscert_key_path``: Directory name where to store SSL private keys (string, default: see ``vars/{{ ansible_os_family }}.yml``)

* ``tlscert_cnf_path_owner``: Owner name or UID for OpenSSL configuration files directory (string, default: ``0``)
* ``tlscert_cnf_path_group``: Group name of GID for OpenSSL configuration files directory (string, default: ``0``)
* ``tlscert_cnf_path_mode``: Mode for OpenSSL configuration files directory (string, default: ``700``)

* ``tlscert_crt_path_owner``: Owner name or UID for OpenSSL certificates directory (string, default: ``0``)
* ``tlscert_crt_path_group``: Group name or GID for OpenSSL certificates directory (string, default: ``0``)
* ``tlscert_crt_path_mode``: Mode for OpenSSL certificates directory (string, default: ``755``)

* ``tlscert_key_path_owner``: Owner name or UID for OpenSSL private key directory (string, default: ``0``)
* ``tlscert_key_path_group``: Group name or GID for OpenSSL private key directory (string, default: ``0``)
* ``tlscert_key_path_mode``: Mode for OpenSSL private key directory (string, default: ``700``)

* ``tlscert_install_sourcedirectory``: Basedir to look into for tlscert\_install certs (string, default: ``files``)

## Dependencies

This role depends on ``groover.util`` role. This is configured
for ``ansible-galaxy install`` in **requirements.yml**.

**NOTE**: Requirements are installed as virtual user ``silpion``
(``silpion.util``).

Be sure to install required roles with

    ansible-galaxy install --role-file requirements.yml

* [groover.util](https://github.com/silpion/ansible-util)

## Facts

This role provides various facts. First off, it deploys a script that tries to find all available certificates.
These facts can be used by other roles to automatically find the right certificate and key:

```yml
dommainname: 'example.com'
ansible_local.tlscert.certs.{{ domainname }}.crt
ansible_local.tlscert.certs.{{ domainname }}.key

```

Also, there is a fact named ``tlscert_changed`` which gets set to ``true`` if changes happen to the deployed certificates.
This is usefull to e.G. handle reloads after a new certificate was deployed for a specific domain.
**Note:** This fact is provided via a handler, this means it can only be accessed in a play that gets executed after the one
that runs this role!

## Example playbook

**NOTE** Be advised to NOT add configuration variables to the playbook.
This is just an example which variables to configure in your inventory!

    - hosts: lbs
      vars:
        - tlscert_create:
          - www.example.com
      roles:
        - role: ansible-tlscert

<!-- -->

    - hosts: lbs
      vars:
        - tlscert_install:
          - www.example.com

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

* Anja Siek @anja.siek silpion.de
* Mark Kusch @mark.kusch silpion.de
* Alvaro Aleman @aleman silpion.de


<!-- vim: set nofen ts=4 sw=4 et: -->
