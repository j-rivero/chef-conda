#
# Cookbook:: chef-conda
# Recipe:: default
#
# Copyright:: 2022, Open Source Robotics Foundation.
#

username = node['conda']['user']['name']
user_password = node['conda']['user']['password']

user_home = "C:\\Users\\#{username}"
miniforge_installer = "#{user_home}\\miniforge.exe"
miniforge_install = "#{user_home}\\Miniforge3"
miniforge_exe = "#{miniforge_install}\\condabin\\conda.bat"

user username do
  password user_password
  comment 'Jenkis agent username'
  manage_home true
end

group 'Administrators' do
  members [username]
  append true
  action :modify
end

directory user_home do
  # user username
  # password user_password
  owner username
  recursive true
  action :create
end

remote_file miniforge_installer do
  source 'https://github.com/conda-forge/miniforge/releases/download/24.7.1-0/Miniforge3-Windows-x86_64.exe'
  user username
  retries 5
end

batch 'install_miniforge' do
  user username
  password user_password
  sensitive false
  # code "start /wait \"\" #{miniforge_installer} /InstallationType=JustMe /RegisterPython=0 /S /D=#{miniforge_install}"
  code "#{miniforge_installer} /InstallationType=JustMe /RegisterPython=0 /S /D=#{miniforge_install}"
end

batch 'check' do
  user username
  password user_password
  sensitive false
  code "dir #{user_home} /s /b"
end

batch 'run help' do
  user username
  password user_password
  sensitive false
  code "#{miniforge_exe} /help"
end
