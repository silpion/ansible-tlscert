# Ansible ssl-certificates Role

Role to create or copy SSL certificates.

## Variables

### ssl_certificates_create: []

If variable is set the role will create self-signed certificates for
given list elements.

#### Options:

```
subj: "/C=DE/ST=Hamburg/L=Hamburg/O=IT/CN={{ ansible_fqdn }}"
days: 3650
key:
certificate:
```

#### Example:

```
ssl_certificates_create:
  - key: "/etc/ssl/certs/test.key"
    certificate: "/etc/ssl/private/test.crt"
```

### ssl_certificates_copy: []

If variable is set the role will copy given certificates to destination.


#### Options:

```
dest:
src:
```

#### Example:

```
ssl_certificates_copy:
  - dest: "/etc/ssl/certs/test.crt"
    src: "files/certificates/test.cert"
  - dest: "/etc/ssl/private/test.key"
    src: "files/certificates/test.key"
```


<!-- vim: set nofen ts=4 sw=4 et: -->
