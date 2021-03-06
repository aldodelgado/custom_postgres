
  if Gem.respond_to?(:install)
    Gem.install 'pg'
  else
    require 'rubygems/commands/install_command'
    cmd = Gem::Commands::InstallCommand.new
    cmd.handle_options %w(--no-ri --no-rdoc pg)

    begin
      cmd.execute
    rescue Gem::SystemExitException => e
    end
	end

	require 'pg'
	# Create connection
	postgresql_connection_info = {
		:host     => '127.0.0.1',
		:port     => node['postgresql']['config']['port'],
		:username => 'postgres',
		:password => node['postgresql']['password']['postgres']
	}

	# Create databases
	postgresql_database 'charitybox_development' do
		connection postgresql_connection_info
		action     :create
	end
	postgresql_database 'charitybox_test' do
		connection postgresql_connection_info
		action     :create
	end
	postgresql_database 'charitybox_staging' do
		connection postgresql_connection_info
		action     :create
	end

	# Create a postgresql user but grant no privileges
	postgresql_database_user 'vagrant' do
		connection postgresql_connection_info
		password 'vagrant'
		action :create
	end

	# Grant all privileges on all databases/tables from 127.0.0.1
	postgresql_database_user 'vagrant' do
		connection    postgresql_connection_info
		database_name 'charitybox_development'
		privileges    [:all]
		action        :grant
	end
	postgresql_database_user 'vagrant' do
		connection    postgresql_connection_info
		database_name 'charitybox_test'
		privileges    [:all]
		action        :grant
	end
	postgresql_database_user 'vagrant' do
		connection    postgresql_connection_info
		database_name 'charitybox_staging'
		privileges    [:all]
		action        :grant
	end
