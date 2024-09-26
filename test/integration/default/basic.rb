username = 'Administrator'
miniforge_install = "C:\\Users\\#{username}\\Miniforge3"
miniforge_exe = "#{miniforge_install}\\condabin\conda"

control 'miniforge install' do
  impact 'critical'
  title 'User jenkins should present in the system'
  # attributes are not directly accesible from inspec. Hardcoding user here
  describe file(miniforge_exe) do
    it { should exist }
  end
end
