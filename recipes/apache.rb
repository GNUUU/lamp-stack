#
# Cookbook:: lamp-stack
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
file "/root/myfile" do

		action :create
		content "salut testss"
end

package	"apache2" do
		action	:install
end

service "apache2" do
  	action [:enable, :start]
end

#Virtual Hosts Files

node["lamp-stack"]["sites"].each do |sitename, data|

		document_root = "/var/www/html/#{sitename}"

directory document_root do
		mode "0755"
	 	recursive true
	  end
execute "enable-sites" do
		command "a2ensite #{sitename}"
		action :nothing
		end

template "/etc/apache2/sites-available/#{sitename}.conf" do
	 	source "virtualhosts.erb"
	  mode "0644"
	 	variables(
	      :document_root => document_root,
	      :port => data["port"],
	      :serveradmin => data["serveradmin"],
	      :servername => data["servername"]
	    )
		notifies :restart, "service[apache2]"
		notifies :run, "execute[enable-sites]"

	  end

directory "/var/www/html/#{sitename}/public_html" do
	    action :create
	  end

directory "/var/www/html/#{sitename}/logs" do
	    action :create
	  end
end
