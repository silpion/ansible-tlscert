# ssl-certificates

Create self-signed or install existing SSL certificates.

## Requirements

None.

## Role Variables

* ``ssl_certificates_create``: Array of SSL certificates to create (default: ``[]``)
* ``ssl_certificates_copy``: Array of existing SSL certificates to install (default: ``[]``)

### Global SSL certificate generation defaults

* ``ssl_certificates_openssl_default_days``: Feeds -days argument to openssl req command (default: ``3650``)
* ``ssl_certificates_openssl_default_bits``: Feeds -newkey rsa:BITS argument to openssl req command (default: ``1024``)
* ``ssl_certificates_openssl_default_C``: OpenSSL countryName (default: ``DE``)
* ``ssl_certificates_openssl_default_ST``: OpenSSL stateOrProvince (default: ``Hamburg``)
* ``ssl_certificates_openssl_default_L``: OpenSSL localityName (default: ``Hamburg``)
* ``ssl_certificates_openssl_default_O``: OpenSSL 0.organizationalUnitName (default: ``Silpion IT Solutions``)
* ``ssl_certificates_openssl_default_OU``: OpenSSL organizationalUnitName (default: ``Development SSL``)
* ``ssl_certificates_openssl_default_P``: Password for the SSL certificate creation (default: ``SILPION!``)
* ``ssl_certificates_openssl_default_email``: Email for the SSL certificate creation (default: ``webmaster@{{ ansible_fqdn }}``)

### ssl_certificates_create

Any global variable can be overridden for each certificate from
``ssl_certificates_create`` array, e.g:

    vars:
      - ssl_certificates_create:
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

Variables not provided in a ``name`` dictionary within ``ssl_certificates_create``
array default to the global defaults.

### ssl_certificates_copy

The role will copy existing certificate/key pairs to a managed node
if ``ssl_certificates_copy`` variable is set.

    vars:
      - ssl_certificates_copy:
        - src: "files/certs/foo.crt"
          dest: "/etc/ssl/certs/foo.crt"

## Dependencies

None.

## Example playbook

**NOTE** Be advised to NOT add configuration variables to the playbook.
This is just an example which variables to configure in your inventory!

    - hosts: lbs
      vars:
        - ssl_certificates_create:
          - name: www.example.com
      roles:
        - { role: ssl-certificates }

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
