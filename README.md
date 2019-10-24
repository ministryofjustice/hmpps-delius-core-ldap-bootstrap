hmpps-delius-core-ldap-bootstrap
=========

Ansible role to setup/configure an OpenLDAP instance for use with National Delius.


Role Variables
--------------

```yaml
workspace: Workspace location for storing temporary files during bootstrap

# AWS
s3_dependencies_bucket: S3 bucket name containing artefacts
s3_backups_bucket: S3 bucket name to be used for LDIF backups

# LDAP
ldap_protocol: Protocol to be expose the ldap on - ldap or ldaps 
ldap_port: Port to expose the ldap on
bind_user: Admin user to create. Default='cn=admin,{{ base_root }}'.
bind_password: Desired password for the admin user.
base_root: The root context for the directory (eg. dc=moj,dc=com)
base_users: The context where users are stored (eg. ou=Users,dc=moj,dc=com)
log_level: The slapd log-level. Default=stats.

# LDAP tuning
time_limit: LDAP query timout, in seconds. Default=30.
db_max_size: Max size of the ldap mdb database, in bytes. Default=50GB.
num_threads: Number of threads to use. Default=2*number of processors, or 16 if there are less than 8 processors.
backup_frequency: How often to backup to S3. Default=hourly.

# Data import
import_users_ldif: LDIF file to import from the s3_backups_bucket. This can be set to LATEST to retrieve the latest backup from S3. Default=None (no users)
import_users_ldif_base_users: The context where users are stored in the imported LDIF (eg. ou=NDProd,cn=Users,dc=moj,dc=com)
sanitize_oid_ldif: Whether to remove Oracle-specific attributes from the LDIF
perf_test_users: Number of users to create to support performance testing. Default=0

```

Dependencies
------------


License
-------

MIT

Author Information
------------------

HMPPS Digital Studio
