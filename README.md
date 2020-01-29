hmpps-delius-core-ldap-bootstrap
=========

Ansible role to setup/configure an OpenLDAP instance for use with National Delius.


Role Variables
--------------

```yaml
workspace: Workspace location for storing temporary files during bootstrap

# LDAP
ldap_protocol: Protocol to be expose the ldap on - ldap or ldaps 
ldap_port: Port to expose the ldap on
bind_user: Admin user. Default='cn=admin,{{ base_root }}'.
bind_password: Desired password for the admin user.
base_root: The root context for the directory (eg. dc=moj,dc=com)
log_level: The slapd log-level. Default=stats.

# Tuning
time_limit: LDAP query timout, in seconds. Default=30.
db_max_size: Max size of the ldap mdb database, in bytes. Default=50GB.
num_threads: Number of threads to use. Default=2*number of processors, or 16 if there are less than 8 processors.

# Backups
s3_backups_bucket: S3 bucket name to be used for LDIF backups
backup_frequency: How often to backup to S3. Default=hourly.

```

Dependencies
------------


License
-------

MIT

Author Information
------------------

HMPPS Digital Studio
