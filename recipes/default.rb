#
# Cookbook:: lamp-stack
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
file "/root/myfile" do

	action :create
	content "salut testss"
end


execute "update" do
  command "apt-get update"
  action :run
end

execute	"remove-apache" do
	command "apt-get remove apache2"
	action	:run
end
