hamyproxy Cookbook
=====================
This cookbook configures haproxy for mysql connections

Requirements
------------
#### packages
- `haproxy` - hamyproxy needs haproxy to proxy connections

Attributes
----------

e.g.
#### hamyproxy::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['hamyproxy']['basedir']</tt></td>
    <td>String</td>
    <td>Location of hamyproxy base directory</td>
    <td><tt>/opt/hamyproxy</tt></td>
  </tr>
  <tr>
    <td><tt>['hamyproxy']['servers']</tt></td>
    <td>Hash</td>
    <td>Key/value pairs of serverid and servername (DNS name)</td>
    <td><tt>{}</tt></td>
  </tr>
</table>

Usage
-----
#### hamyproxy::default

Include `hamyproxy` in your node's `run_list` and set the servers attribute:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hamyproxy]"
  ],
  "hamyproxy": {
    "servers": {
      "alfa": "alfa-db.example.com",
      "bravo": "bravo-db.example.com"
    }
  }
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Anthony Tonns <atonns@corsis.com>
