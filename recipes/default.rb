#
# Cookbook:: lamp-stack
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
file "/root/myfile" do

	action :create
	content "salut test"
end
