openstack-keystone Cookbook
===========================
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwich.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - openstack-keystone needs toaster to brown your bagel.

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### openstack-keystone::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['openstack-keystone']['public_address']</tt></td>
    <td>text</td>
    <td>Public Address</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['openstack-keystone']['admin_address']</tt></td>
    <td>text</td>
    <td>Admin Address</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['openstack-keystone']['internal_address']</tt></td>
    <td>text</td>
    <td>Internal Address</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
</table>

Usage
-----
1. Create data bag `openstack` `secrets` like this.



2. Include `openstack-keystone` in your node's `run_list` like this:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[openstack-keystone]"
  ],
  "openstack": {
    "public_address": "123.123.123.123",
    "admin_address": "192.168.33.5",
    "internal_address": "192.168.33.5"
  }
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author: Koji Tanaka
License: Apache 2.0
