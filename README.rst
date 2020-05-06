========================
OpenStack Charms Tempest
========================

OpenStack Charms Tempest deploys OpenStack clouds and runs tempest tests against them.
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

Run smoke tests:

.. code-block:: bash

  tox -e func-smoke

Rerun a specific zaza phase:

.. code-block:: bash

  source .tox/func-smoke/bin/activate
  functest-deploy -m keystone_v3_smoke:zaza-9f452734f430
  functest-configure -m keystone_v3_smoke:zaza-9f452734f430
  functest-test -m keystone_v3_smoke:zaza-9f452734f430

Specifying Tests to Run
=======================

Specifying the tests to run can be done with the following keys: smoke, whitelist, blacklist, and regex. For example:

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

* Update tests.yaml tests_options with whitelist of failing tests and re-run tests with functest-test.
* Client environment auth scripts are also located in the scripts directory needed for manually running OpenStack commands.

Contact
=======
IRC: #openstack-charms on Freenode (irc.freenode.net)
