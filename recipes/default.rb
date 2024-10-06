#
# Cookbook:: chef-conda
# Recipe:: default
#
# Copyright:: 2022, Open Source Robotics Foundation.
#

username = node['conda']['user']['name']
user_password = node['conda']['user']['password']

miniforge_installer = "C:\\Users\\#{username}\\miniforge.exe"
miniforge_install = "C:\\Users\\#{username}\\Miniforge3"
miniforge_exe = "#{miniforge_install}\\condabin\conda"

user username do
  password user_password
  manage_home true
end

directory "C:\\Users\#{username}" do
  user username
  password user_password
  owner username
  recursive true
  action :create
end

remote_file miniforge_installer do
  source 'https://github.com/conda-forge/miniforge/releases/download/24.7.1-0/Miniforge3-Windows-x86_64.exe'
  owner username
  retries 5
end

batch 'install_miniforge' do
  user username
  password user_password
  code "start /wait \"\" #{miniforge_installer} /InstallationType=JustMe /RegisterPython=0 /S /D=#{miniforge_install}"
end

batch 'run help' do
  user username
  password user_password
  code "#{miniforge_exe} /help"
end
