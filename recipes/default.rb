#
# Cookbook Name:: chef-logentries
# Recipe:: default
#
# Copyright 2013, EverTrue, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if platform?("amazon")
  include_recipe 'yum'

  # add the Logentries Agent GPG key
  yum_key "RPM-GPG-KEY-logentries" do
    url "http://rep.logentries.com/RPM-GPG-KEY-logentries"
    action :add
  end

  yum_repository "logentries" do
    description "Logentries Agent for Amazon Linux"
    mirrorlist "http://rep.logentries.com/amazon\$releasever/\$basearch"
    key "RPM-GPG-KEY-logentries"
  end
elsif platform?("ubuntu")
  include_recipe 'apt'

  apt_repository 'logentries' do
    uri 'http://rep.logentries.com/'
    components ['precise', 'main']
    keyserver 'pgp.mit.edu'
    key 'C43C79AD'
  end
end

package 'logentries'
package 'logentries-daemon' do
  action :nothing
end
