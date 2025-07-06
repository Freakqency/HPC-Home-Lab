Vagrant.configure("2") do |config|
	nodes = ["controller", "compute1", "compute2"]
	nodes.each do | node|
			config.vm.define node do |guest| 
					guest.vm.box = "/Users/surya/Projects/Vagrant-Boxes/r10-packer.box"
					guest.vm.provider "vmware_fusion" do |vm|
						vm.vmx["name"] = node
						vm.vmx["memsize"] = "1048"
						vm.vmx["numvcpus"] = "1"
						vm.gui = false
					end
			end
	end
end
