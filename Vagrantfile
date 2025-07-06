Vagrant.configure("2") do |config|
  config.vm.define "sv01" do |sv01| 
			sv01.vm.box = "/Users/surya/Projects/Vagrant-Boxes/r10-packer.box"
			sv01.vm.provider "vmware_fusion" do |vm|
				vm.vmx["name"] = "lab_sv01"
				vm.vmx["memsize"] = "2048"
				vm.vmx["numvcpus"] = "2"
				vm.gui = false
			end
	end
end
