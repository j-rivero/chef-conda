#
# Cookbook:: chef-conda
# Recipe:: default
#
# Copyright:: 2022, Open Source Robotics Foundation.
#

username = node['conda']['user']

miniforge_installer = "C:\\Users\\#{username}\\miniforge.exe"
miniforge_install = "C:\\Users\\#{username}\\Miniforge3"
miniforge_exe = "#{miniforge_install}\\condabin\conda"

remote_file miniforge_installer do
  source 'https://github.com/conda-forge/miniforge/releases/download/24.7.1-0/Miniforge3-Windows-x86_64.exe'
  user username
  retries 5
end

batch 'install_miniforge' do
  user username
  code "start /wait \"\" #{miniforge_installer} /InstallationType=JustMe /RegisterPython=0 /S /D=#{miniforge_install}"
end

batch 'run help' do
  user username
  code "#{miniforge_exe} /help"
end
