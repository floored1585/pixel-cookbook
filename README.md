Pixel Cookbook
===================
This cookbook prepares an Ubuntu 14.04 server for [Pixel](https://github.com/floored1585/pixel) deployment

Requirements
------------
- Only tested on Ubuntu 14.04
- You must create your own files/default/settings.yaml until I get around to making it a template.
- You must create your own files/default/authorized_keys until I get around to making it a template.
- Requires the following cookbooks:  
  - [chef-rvm](https://github.com/martinisoft/chef-rvm)  
  - [apache2](https://github.com/svanzoest-cookbooks/apache2)  
  - [logrotate](https://github.com/stevendanna/logrotate)  

Attributes
----------
TODO: List your cookbook attributes here.

#### pixel::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['pixel']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### pixel::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `pixel` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pixel]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Test your change
5. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Ian Clark  
License: MIT. Be free!
