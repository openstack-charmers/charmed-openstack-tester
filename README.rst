========================
Charmed OpenStack Tester
========================

Charmed OpenStack Tester deploys OpenStack clouds and runs tempest
(or other tests) against them.

It uses the following to get this done:

* `OpenStack Charms`_
* `zaza`_
* `zaza-openstack-tests`_
* `Juju`_
* `tempest`_

.. _OpenStack Charms: https://docs.openstack.org/charm-guide
.. _zaza: https://github.com/openstack-charmers/zaza
.. _zaza-openstack-tests: https://github.com/openstack-charmers/zaza-openstack-tests
.. _Juju: https://juju.is/docs
.. _tempest: https://github.com/openstack/tempest


Getting Started
===============

Common setup:

.. code-block:: bash

  source ~/novarc
  export TEST_HTTP_PROXY=http://squid.internal:3128
  export TEST_FIP_RANGE=10.5.150.0:10.5.200.254
  export TEST_CIDR_EXT=10.5.0.0/16
  export TEST_GATEWAY=10.5.0.1
  export TEST_NAMESERVER=10.245.168.6
  export TEST_CIDR_PRIV=192.168.21.0/24
  export TEST_SWIFT_IP=10.245.161.162

Deploy and test a specific bundle:

.. code-block:: bash

  tox -e func-target keystone_v3_smoke_focal:jammy-yoga

Deploy and test all smoke bundles:

.. code-block:: bash

  tox -e func-smoke

Re-run a specific zaza phase:

.. code-block:: bash

  source .tox/func-smoke/bin/activate
  cd tests/<scenario>/
  juju deploy -m MODEL BUNDLE
  functest-configure -m MODEL_ALIAS:MODEL
  functest-test -m MODEL_ALIAS:MODEL

Specifying Tests to Run
=======================

Specifying which tests to run can be done with the following keys: smoke, whitelist, blacklist, and regex. For example:

.. code-block:: yaml

  tests_options:
    tempest:
      keystone_v3_smoke:
        smoke: True
      keystone_v3_full:
        whitelist:
           - "tempest.api.compute.servers.test_create_server.ServersTestManualDisk.test_list_servers"
           - "tempest.api.compute.servers.test_create_server.ServersTestManualDisk.test_verify_server_details"
        blacklist:
           - "tempest.api.identity.admin.v3.test_policies.PoliciesTestJSON.test_create_update_delete_policy"
        regex:
           - "tempest.api.network.*"

Debugging Tests
===============

By default, the tempest workspace gets cleaned up after each tempest run. To keep the workspace around for
re-running tests, set keep-workspace to True in tests.yaml:

.. code-block:: yaml

  tests_options:
    tempest:
      keystone_v3_smoke:
        smoke: True
        keep-workspace: True

Then, update tests.yaml with whitelist of failing tests and re-run tests with functest-test.

Client environment auth scripts are located in the scripts directory for manually running OpenStack commands:

.. code-block:: bash

  # For xenial-pike and below
  source scripts/novarc

  # For xenial-queens through bionic-ussuri
  source scripts/novarcv3_domain
  source scripts/novarcv3_domain

  # For focal-ussuri and above
  source scripts/novarcv3_ssl_domain
  source scripts/novarcv3_ssl_domain

Contact
=======
IRC: #openstack-charms on Freenode (irc.freenode.net)
