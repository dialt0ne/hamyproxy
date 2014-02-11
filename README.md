hamyproxy Cookbook
=====================
This cookbook configures haproxy for mysql connections.
It also contains a companion script that will reload haproxy when the IP address of a DNS name changes.

![mmmm... hamy](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Schinken.jpg/300px-Schinken.jpg)

Requirements
------------
#### packages
- `haproxy` - hamyproxy needs haproxy to proxy connections
- `cron` - hamyproxy needs cron to schedule tests of IP changes

Attributes
----------

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
    <td><tt>None</tt></td>
  </tr>
  <tr>
    <td><tt>['hamyproxy']['splaytime']</tt></td>
    <td>Int</td>
    <td>Upper boundary of the random number of seconds to sleep before reload</td>
    <td><tt>30</tt></td>
  </tr>
</table>

Usage
-----
Insure that the user `haproxy_check` exists in the mysql master database. To create it:

```
mysql -u root -p -e "INSERT INTO mysql.user (Host,User) values ('%','haproxy_check'); FLUSH PRIVILEGES;"
```

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

Thanks
------
This cookbook is based on the excellent [How To](https://www.digitalocean.com/community/articles/how-to-use-haproxy-to-set-up-mysql-load-balancing--3) provided by Jesin and DigitalOcean

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

   Copyright 2014 Corsis
   http://www.corsis.com/

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

