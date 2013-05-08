default["horizon"]["db"]["username"] = "dash"                                               # node_attribute
default["horizon"]["db"]["password"] = "dash"                                               # node_attribute
default["horizon"]["db"]["name"] = "dash"                                                   # node_attribute

default["horizon"]["use_ssl"] = true                                                        # node_attribute
default["horizon"]["ssl"]["cert"] = "horizon.pem"                                           # node_attribute
default["horizon"]["ssl"]["key"] = "horizon.key"                                            # node_attribute

default["horizon"]["services"]["dash"]["scheme"] = "http"                       # node_attribute
default["horizon"]["services"]["dash"]["network"] = "public"                    # node_attribute
default["horizon"]["services"]["dash"]["port"] = 80                           # node_attribute
default["horizon"]["services"]["dash"]["path"] = "/"

default["horizon"]["services"]["dash_ssl"]["scheme"] = "https"                       # node_attribute
default["horizon"]["services"]["dash_ssl"]["network"] = "public"                    # node_attribute
default["horizon"]["services"]["dash_ssl"]["port"] = 443                           # node_attribute
default["horizon"]["services"]["dash_ssl"]["path"] = "/"

default["horizon"]["swift"]["enabled"] = "False"

default["horizon"]["theme"] = "default"

default["horizon"]["rackspace_theme"]["files"] = {
  "PrivateCloud.png" => "15f5c9726009b213dfe6cba2085cd29f373f9cacb6b11e8188ab0cf922f614ad",
  "Rackspace_Cloud_Company.png" => "c790f4067bcec5ddb294979ae7f3b3780ba03ff538de457ba341790f11220a97",
  "Rackspace_Cloud_Company_Small.png" => "08bd42c57c69f7b07ca780ae8c3cfdd8e9f56f10f09d915956c6899a221bcb68",
  "alert_red.png" => "2814a08fb95436f0cfd957d72d2b9edd204fdebbbad04487bb1e5bc3abd0e0d5",
  "body_bkg.gif" => "6c1852a68f30a0e6095cdb58a95523210b959f9be6554fd07cc91ae3b7f1b93c",
  "selected_arrow.png" => "08cf891a8f93df30b7fb07e62e3b49cdce1fab4423f92c619b286448e66740da"
}

case node["platform"]
when "fedora", "centos", "redhat", "amazon", "scientific"
  default["horizon"]["ssl"]["dir"] = "/etc/pki/tls"                                         # node_attribute
  default["horizon"]["local_settings_path"] = "/etc/openstack-dashboard/local_settings"     # node_attribute
  # TODO(shep) - Fedora does not generate self signed certs by default
  default["horizon"]["platform"] = {                                                   # node_attribute
    "horizon_packages" => ["openstack-dashboard", "MySQL-python", "python-netaddr"],
    "package_overrides" => ""
  }
  default["horizon"]["dash_path"] = "/usr/share/openstack-dashboard"      # node_attribute
  default["horizon"]["stylesheet_path"] = "/usr/share/openstack-dashboard/openstack_dashboard/templates/_stylesheets.html"
  default["horizon"]["wsgi_path"] = node["horizon"]["dash_path"] + "/openstack_dashboard/wsgi"                    # node_attribute
when "ubuntu", "debian"
  default["horizon"]["ssl"]["dir"] = "/etc/ssl"                                             # node_attribute
  default["horizon"]["local_settings_path"] = "/etc/openstack-dashboard/local_settings.py"  # node_attribute
  default["horizon"]["platform"] = {                                                   # node_attribute
    "horizon_packages" => ["lessc","openstack-dashboard", "python-mysqldb"],
    "package_overrides" => "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
  default["horizon"]["dash_path"] = "/usr/share/openstack-dashboard/openstack_dashboard"      # node_attribute
  default["horizon"]["stylesheet_path"] = "/usr/share/openstack-dashboard/openstack_dashboard/templates/_stylesheets.html"
  default["horizon"]["wsgi_path"] = node["horizon"]["dash_path"] + "/wsgi"                    # node_attribute
end

