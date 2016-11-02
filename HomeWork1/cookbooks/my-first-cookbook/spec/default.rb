require 'chefspec'

describe 'my-first-cookbook::default' do

    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }


    it 'creates apache config template with a VirtualHost definition' do
		expect(chef_run).to create_template('/etc/apache2/sites-enabled/AAR-apache.conf') 
    end

    it 'restarts apache2 service on config file change' do
		expect(chef_run).to notify('service[apache2]').to(:restart) 
    end

    it 'starts and enables apache2 service' do
		expect(chef_run).to enable_service( ’apache2’ )
		expect(chef_run).to start_service( ’apache2’ )
    end
end
