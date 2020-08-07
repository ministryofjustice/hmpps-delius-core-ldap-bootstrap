hmpps-delius-core-ldap-bootstrap
=========

Ansible role to setup/configure an OpenLDAP instance for use with National Delius.


Role Variables
--------------
See [common.tfvars#default_ldap_config](https://github.com/ministryofjustice/hmpps-env-configs/blob/master/common/common.tfvars) for example configuration.

```yaml
# Connection
ldap_port: Port to expose the ldap on.
bind_user: Distinguished name for the admin user.
bind_password: Desired password for the admin user.
# Structure
base_root: The root context for the directory.
# Logging
log_level: The slapd log-level, as a comma-separated string eg. "stats,acl". See https://www.openldap.org/doc/admin24/slapdconfig.html#loglevel%20%3Clevel%3E
# Backups
s3_backups_bucket: S3 bucket name to be used for LDIF backups.
backup_frequency: How often to backup to S3. Either 'none', 'hourly' or 'daily'.
# Performance/tuning
query_time_limit: LDAP query timout, in seconds.
db_max_size: Max size of the ldap mdb database, in bytes.
```

Tasks
-----
### 1. [openldap.yml](tasks/openldap.yml)
Installs the OpenLDAP packages (server and client), 
configures the [MDB](https://www.openldap.org/pub/hyc/mdb-paper.pdf) back-end,
and installs the required OpenLDAP schemas and overlays.

### 2. [schemas.yml](tasks/schemas.yml)
Pulls the [hmpps-ndelius-rbac](https://github.com/ministryofjustice/hmpps-ndelius-rbac) repository,
and installs any custom schemas.

### 3. [user-expiry.yml](tasks/user-expiry.yml)
Creates a nightly cron job to lock user accounts that are past their end date.

### 4. [monitoring.yml](tasks/monitoring.yml)
Configures logging using rsyslog, 
and publishes LDAP monitoring info (eg. connections, operations) to CloudWatch.

### 5. [replication.yml](tasks/replication.yml)
Enables dynamic [multi-master](https://www.openldap.org/doc/admin24/replication.html#N-Way%20Multi-Master%20replication) replication, 
by continually fetching the details of other servers in the Auto-Scaling Group and updating them in the database config.
See [update_replicas.sh.j2](templates/update_replicas.sh.j2).

Additionally, this sets up a service for electing a primary instance to support automatic failover at the load-balancer.
See [is-primary.py.j2](templates/is-primary.py.j2).
Configuring the LDAP in this way, using OpenLDAP multi-master but directing all reads and writes to a single node, 
reduces the impact of replication latency while still minimizing downtime on failover - because all instances are already prepared to act as the master.

### 6. [backups.yml](tasks/backups.yml)
Schedules regular backups of the directory to an S3 bucket.

Dependencies
------------


License
-------

MIT

Author Information
------------------

HMPPS Digital Studio
