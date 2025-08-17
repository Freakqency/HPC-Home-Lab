# frozen_string_literal: true

NODES = { 'controller' => '192.168.41.135', 'compute1' => '192.168.41.136', 'compute2' => '192.168.41.137' }.freeze
BOX = '/Users/surya/Projects/Vagrant-Boxes/r10.box'
ANSIBLE_SRC = '/Users/surya/Projects/HPC-Ansible'
ANSIBLE_DEST = '/opt/HPC-Ansible'

$HOSTS = <<~SCRIPT
  echo "192.168.41.135 controller" >> /etc/hosts
  echo "192.168.41.136 compute1" >> /etc/hosts
  echo "192.168.41.137 compute2" >> /etc/hosts
SCRIPT

Vagrant.configure('2') do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.box = BOX
  NODES.each do |name, ip|
    config.vm.define name do |node|
      node.vm.network 'private_network', ip: ip, auto_config: true
      node.vm.hostname = name
      node.vm.provision 'shell', inline: $HOSTS
      if name == 'controller'
        node.vm.synced_folder ANSIBLE_SRC, ANSIBLE_DEST
        node.vm.provision 'shell', inline: 'dnf install -y ansible-core sshpass'
        node.vm.provision 'shell', inline: "yes y | ssh-keygen -q -t ed25519 -f /home/vagrant/.ssh/id_ed25519 -N ''",
                                   privileged: false
        NODES.each_key do |n|
          node.vm.provision 'shell', inline: "sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@#{n}",
                                     privileged: false
        end
      end
      node.vm.provider 'vmware_fusion' do |vm|
        vm.vmx['name'] = name
        vm.vmx['memsize'] = '1048'
        vm.vmx['numvcpus'] = '1'
        vm.gui = false
      end
    end
  end
end
