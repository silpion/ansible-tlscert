# Ansible ssl-certificates Role

Role to create or copy certificates

## Variables

### ssl_certificates_create: []
if variable is set Role will create self-signed certificates for given list elements

#### Options:

```
subj: "/C=DE/ST=Hamburg/L=Hamburg/O=IT/CN={{ansible_fqdn}}"
days: 3650
key:
certificate:
```
  
#### Example:

```
ssl_certificates_create:
  - key: "/etc/ssl/certs/test.crt"
    certificate: "/etc/ssl/private/test.key"
```

### ssl_certificates_copy: []
if variable is set Role will copy given certificates to destination


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
