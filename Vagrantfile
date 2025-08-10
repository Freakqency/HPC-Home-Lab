# frozen_string_literal: true

nodes = { 'controller' => '192.168.41.135', 'compute1' => '192.168.41.136', 'compute2' => '192.168.41.137' }

Vagrant.configure('2') do |config|
  nodes.each do |name, ip|
    config.vm.define name do |node|
      node.vm.box = '/Users/surya/Projects/Vagrant-Boxes/r10.box'
      node.vm.network 'private_network', ip: ip, auto_config: true
      node.vm.hostname = name
      if name == "controller"
          node.vm.synced_folder '/Users/surya/Projects/HPC-Ansible', '/opt/HPC-Ansible'
      end
      node.vm.synced_folder '.', '/vagrant', disabled: true
      node.vm.provider 'vmware_fusion' do |vm|
        vm.vmx['name'] = name
        vm.vmx['memsize'] = '1048'
        vm.vmx['numvcpus'] = '1'
        vm.gui = false
      end
    end
  end
end
