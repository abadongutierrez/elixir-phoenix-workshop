$script = <<SCRIPT
sudo apt-get install inotify-tools
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb  
sudo apt-get -y update
sudo apt-get -y install elixir erlang-dev erlang-parsetools

# Install nodejs
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get -y install build-essential nodejs-legacy 

# Install using vagrant user
su vagrant

# install Hex
yes | mix local.hex --force

# install Phoenix
yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# Install coffee-script globally (npm install in new phoenix projects need this)
npm install -g coffee-script
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 4000, host: 4000
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provision 'shell', inline: $script
end