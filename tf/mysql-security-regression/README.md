# Overview

This terraform plan and helper scripts deploy a minimal OpenStack Service
(Keystone) with MySQL Router and a 3 node MySQL InnoDB Cluster.

The Security Proposed PPA is enabled by default, allowing basic regression
testing of an OpenStack service against proposed security updates for the
MySQL packages in Ubuntu.

A workflow is provided to test supported Ubuntu LTS releases.

# Setup

Install required snaps:

```
./deps
```

# Terraform

Use of the plan requires a previous bootstrapped Juju controller - works fine
with LXD as no special kernel level features required.

To apply the plan:

```
terraform init
terraform apply -var ubuntu-base=ubuntu@24.04
```

and to teardown afterward:

```
terraform destroy
```

# Tempest

Once the applications have deployed and configuration has completed, Tempest
can be used to validate the deployment:

```
./tempest-run
```

This will run a smoke test of the Keystone service.

