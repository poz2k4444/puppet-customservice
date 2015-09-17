# initsystem.rb
Facter.add('initsystem') do
  setcode do
    if File.directory?("/run/systemd/system")
      'systemd'
    elsif
      'init'
    end
  end
end
