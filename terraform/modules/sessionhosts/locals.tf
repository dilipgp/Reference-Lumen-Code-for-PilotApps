locals {
  zone_support = {
    uksouth       = true
    eastasia      = true
    southeastasia = true
    centralindia  = true
  }
  instance_disks = {
    for pair in setproduct(range(var.vm_count), range(length(var.data_disk_size_gb))) : "${pair[0]}:${pair[1]}" => {
      vm_index  = pair[0]
      disk_key  = pair[1]
      disk_size = var.data_disk_size_gb[pair[1]]
      lun       = pair[1]
    }
  }

 

  domain = {
  dev = "zone1.scbdev.net"
  prd = "zone1.scb.net"
}
vm_disk_suffix = formatdate("YYYYMMDDhhmmss", timestamp())
}