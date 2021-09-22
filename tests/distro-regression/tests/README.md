# Distro-Regression Tests

The tests in this directory are used to regression test new releases of
OpenStack and other closely related applications.

At a basic level, the tests will currently:
 1. deploy the specified bundle using the -proposed pocket
 2. perform any necessary configuration of the deployed cloud
 3. run tempest regression tests against the cloud

In the near future, the tests will:
 1. deploy the specified bundle using the -updates pocket
 2. perform any necessary configuration of the deployed cloud
 3. run tempest regression tests against the cloud
 4. package-upgrade the cloud to -proposed pocket or testing PPA
 5. run tempest regression tests against the upgraded cloud

## Test Matrix

The following table can be used as a quick reference when getting familiar
with the bundles in this repository. Each of the distro-regression bundles
maps directly to a check-marked cell in this table.


|                | swift   | ovs (no-l3ha+no-dvr) | ovs (l3ha+dvr) | ovs (l3ha+dvr-snat) | ovs (sriov) | ovs (dpdk) | ovn (no-sriov+no-dpdk) | ovn (sriov) | ovn (dpdk) |
| -------------- | ------- | -------------------- | -------------- | ------------------- | ----------- | ---------- | ---------------------- | ----------- | ---------- |
| jammy-yoga     | &check; | &check;              | &check;        | &check;             | &check;     | TODO       | &check;                | &check;     | TODO       |
| focal-yoga     | &check; | &check;              | &check;        | &check;             | &check;     | TODO       | &check;                | &check;     | TODO       |
| impish-xena    | &check; | &check;              | &check;        | &check;             | &check;     | TODO       | &check;                | &check;     | TODO       |
| focal-xena     | &check; | &check;              | &check;        | &check;             | &check;     | TODO       | &check;                | &check;     | TODO       |
| focal-wallaby  | &check; | &check;              | &check;        | &check;             | &check;     | TODO       | &check;                | &check;     | TODO       |
| focal-victoria | &check; | &check;              | &check;        | &check;             | &check;     | TODO       | &check;                | &check;     | TODO       |
| focal-ussuri   | &check; | &check;              | &check;        | &check;             | &check;     | TODO       | &check;                | &check;     | TODO       |
| bionic-ussuri  | &check; | &check;              | &check;        | &check;             | &check;     | TODO       | &check;                | &check;     | TODO       |
| bionic-train   | &check; | &check;              | &check;        | &check;             | &check;     | TODO       |                        |             |            |
| bionic-stein   | &check; | &check;              | &check;        | &check;             | &check;     | TODO       |                        |             |            |
| bionic-rocky   | &check; | &check;              | &check;        | &check;             | &check;     | TODO       |                        |             |            |
| bionic-queens  | &check; | &check;              | &check;        | &check;             | &check;     | TODO       |                        |             |            |

## Bundle Layout

There is a bundle that corresponds to each of the above &check marks. These
are located in charmed-openstack-tester/tests/distro-regression/tests/bundles/.
Each bundle that is meant to be deployed is named with a <series>-<release>
prefix. Each of these bundles is just a symlink to a common bundle. The common
bundles are not meant to be deployed directly. For example:
```bash
~/charmed-openstack-tester/tests/distro-regression/tests/bundles$ ls -l focal-ussuri-ovs.yaml
lrwxrwxrwx 1 ubuntu ubuntu 21 Feb  8 15:00 focal-ussuri-ovs.yaml -> ovs-mysql8-focal.yaml
```
Each bundle with a <series>-<release> prefix has an overlay with the same name
and a .j2 suffix. These overlays are where the openstack-origin and source
values are specified. For example:
```bash
~/charmed-openstack-tester/tests/distro-regression/tests/bundles/overlays$ ls -l focal-ussuri-ovs.yaml.j2
-rw-rw-r-- 1 ubuntu ubuntu 1505 Feb  9 20:08 focal-ussuri-ovs.yaml.j2
```

## Running Tests

For more details on how to run tests, see the README in the root directory
of this repository.
