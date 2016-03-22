Pixel Cookbook
===================
This cookbook prepares an Ubuntu 14.04 server for [Pixel](https://github.com/floored1585/pixel) deployment.  It
installs the necessary packages and creates a user (complete with authorized_keys file) to use for deploying and
running the application.  I personally use Capistrano to deploy Pixel, and as soon as I figure out a good place
for it I'll share my `deploy.rb`.

Requirements
------------
- Only tested on Ubuntu 14.04
- You must create your own files/default/authorized_keys until I get around to making it an attribute or template.
- Requires the following cookbooks:  
  - [chef-rvm](https://github.com/martinisoft/chef-rvm)  
  - [apache2](https://github.com/svanzoest-cookbooks/apache2)  
  - [logrotate](https://github.com/stevendanna/logrotate)  

Usage
-----
#### pixel::default

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
