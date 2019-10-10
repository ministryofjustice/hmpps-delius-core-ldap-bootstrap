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

# Data import
import_users_ldif: LDIF file to import from the s3_backups_bucket. This can be set to LATEST to retrieve the latest backup from S3. Default=None (no users)
import_users_ldif_base_users: The context where users are stored in the imported LDIF (eg. ou=NDProd,cn=Users,dc=moj,dc=com)
sanitize_oid_ldif: Whether to remove Oracle-specific attributes from the LDIF
perf_test_users: Number of users to create to support performance testing. Default=0

```

TODO
----
Changes that were made manually in production to support go-live should be implemented as code:
- [ ] Create cn=admin as proxy admin, instead of root dn
- [ ] Add indexes
- [x] Fix ACL
- [ ] Set timelimit
- [ ] Set number of threads
- [ ] Set cache sizes
- [ ] Update SLAPD_OPTIONS with logging config
- [ ] Setup rsyslog for logging
- [ ] Switch to MDB
- [ ] Update backup script to use root dn
- [ ] Add MIS/BO and FS groups to restore process from S3

The following changes should also be added:
- [ ] Update SLAPD_URLS correctly
- [ ] Push logs to cloudwatch
- [ ] Push monitor db info to cloudwatch
- [ ] Separate ldap restore into it's own job
- [ ] Make backup frequency configurable (currently is daily, hourly would be better)
- [ ] Add replicas/standbys or configure multi-master
- [ ] Add cron job or overlay to implement user start/end dates

Dependencies
------------


License
-------

MIT

Author Information
------------------

HMPPS Digital Studio
