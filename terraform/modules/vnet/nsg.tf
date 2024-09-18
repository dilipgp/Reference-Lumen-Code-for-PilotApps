locals {
  service_tag_region_suffix_map = {
    uksouth       = ".UKSouth"
    eastasia      = ".EastAsia"
    southeastasia = ".SoutheastAsia"
    centralindia  = ".CentralIndia"
  }
 
  azure_service_ep_rule_base_priority = 400
 
  allowed_outbound_azure_service_tags = lookup(var.vnet_config, "allowed_outbound_azure_service_tags", [])
 
  _allowed_outbound_azure_service_tags_map = zipmap(range(
    local.azure_service_ep_rule_base_priority, local.azure_service_ep_rule_base_priority + length(local.allowed_outbound_azure_service_tags)
  ), local.allowed_outbound_azure_service_tags)
 
  _outbound_service_tag_rules = {
  for pri, name in local._allowed_outbound_azure_service_tags_map : format("Allow_%s_Outbound", name) => [
    pri, "Outbound", "Allow", "*", "*", "*", format("Allow%s", name), "VirtualNetwork", null, name, null
  ]
  }
 
  allowed_inbound_azure_service_tags = lookup(var.vnet_config, "allowed_inbound_azure_service_tags", [])
 
  _allowed_inbound_azure_service_tags_map = zipmap(range(
    local.azure_service_ep_rule_base_priority, local.azure_service_ep_rule_base_priority + length(local.allowed_inbound_azure_service_tags)
  ), local.allowed_inbound_azure_service_tags)
 
  // inbound is limit to https
  _inbound_service_tag_rules = {
  for pri, name in local._allowed_inbound_azure_service_tags_map : format("Allow_%s_Inbound", name) => [
    pri, "Inbound", "Allow", "Tcp", "*", "443", format("Allow%s", name), format("%s%s", name, lookup(local.service_tag_region_suffix_map, var.rg_location, "")), null, "VirtualNetwork", null
  ]
  }
  _nsg_rules_definition = {
    // priority, direction, access, protocol, src port range, dst port range, destination_port_ranges, description, src prefix, src prefixes, dst prefix, dst prefixes
    AllowDNS           = ["100", "Outbound", "Allow", "*", "*", "", ["53"], "For DNS resoulution", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["172.28.148.125", "172.28.148.126", "172.28.146.36"]]
    AllowCA            = ["110", "Outbound", "Allow", "Tcp", "*", "", ["135", "139", "445", "50000-55000"], "For Certificate Authority Servers", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.198.200.207"]]
    AllowADTCP         = ["120", "Outbound", "Allow", "Tcp", "*", "", ["88", "135", "445", "464", "636", "1025-5000", "49152-65535"], "For Active Directory Access over TCP", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.23.218.140", "10.23.218.139"]]
    AllowADUDP         = ["130", "Outbound", "Allow", "Udp", "*", "", ["88", "123", "137", "138", "139", "445", "464", "1025-5000", "49152-65535"], "For NTP and Active Directory Access over UDP", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.23.218.140", "10.23.218.139"]]
    AllowADFS          = ["140", "Outbound", "Allow", "Tcp", "*", "", ["443"], "For ADFS", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.23.111.71"]]
    AllowSCCM          = ["150", "Outbound", "Allow", "Tcp", "*", "", ["8531", "443", "10123"], "For SCCM", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.23.225.85", "10.23.225.84", "10.198.201.137", "10.23.225.86", "10.23.225.87"]]
    AllowProxy         = ["160", "Outbound", "Allow", "Tcp", "*", "", ["443"], "For Internet Access", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.239.9.190", "10.4.80.160"]]
    AllowNAS           = ["170", "Outbound", "Allow", "Tcp", "*", "", ["139", "445"], "For access to NAS", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.198.255.22"]]
    AllowDLP           = ["180", "Outbound", "Allow", "Tcp", "*", "", ["10443"], "For DLP", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.23.226.33"]]
    AllowSEP           = ["190", "Outbound", "Allow", "Tcp", "*", "", ["8014"], "For Symantec Endpoint Protection", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.255.72.0/23", "10.255.75.0/27"]]
    AllowSystrack      = ["200", "Outbound", "Allow", "Tcp", "*", "", ["443","5432","6432"], "For Systrack Access", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.198.200.189"]]
    AllowSplunk        = ["210", "Outbound", "Allow", "Tcp", "*", "", ["8090", "9997"], "For Splunk integration", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.193.106.47", "10.193.106.49"]]
    AllowAzureMonitor  = ["300", "Outbound", "Allow", "*", "*", "", ["443"], "For Azure Monitor", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.255.72.0/23", "10.255.75.0/27"]]
    AllowAVDService    = ["310", "Outbound", "Allow", "Tcp", "*", "", ["443"], "For AVD Platform Services", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.255.72.0/23", "10.255.75.0/27"]]
    AllowSA            = ["320", "Outbound", "Allow", "Tcp", "*", "", ["443", "445"], "For Azure SMB FileShare", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.255.72.0/23", "10.255.75.0/27"]]
    AllowQualysGuard   = ["100", "Inbound", "Allow", "Tcp", "*", "*", [], "All access to all IP Addressess and Ports from QualysGuard Scanning Servers", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.255.72.0/23", "10.255.75.0/27"]]
    AllowSMBInbound    = ["300", "Inbound", "Allow", "Tcp", "*", "", ["443", "445"], "For Azure SMB FileShare, KeyVaults, HostPools", null, ["10.255.72.0/23", "10.255.75.0/27"], null, ["10.255.72.0/23", "10.255.75.0/27"]]
    DenyAllInbound     = ["1000", "Inbound", "Deny", "*", "*", "*", [], "Block all inbound", "*", null, "*", null]
  }
  nsg_rules_definition = merge(local._nsg_rules_definition, local._outbound_service_tag_rules, local._inbound_service_tag_rules)
  nsg_flow_log_retention_days = 0
}
 
//NSG rule
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.vnet_config["subnets"]
  name                = "snet-${var.app_name}-${each.value["index"]}-${var.env_short_name}-${var.location_short}-009-nsg"
  resource_group_name = var.rg_name
  location            = var.rg_location
 
  dynamic "security_rule" {
    for_each = lookup(each.value, "nsg_set", [])
    content {
      name                         = security_rule.value
      priority                     = local.nsg_rules_definition[security_rule.value][0]
      direction                    = local.nsg_rules_definition[security_rule.value][1]
      access                       = local.nsg_rules_definition[security_rule.value][2]
      protocol                     = local.nsg_rules_definition[security_rule.value][3]
      source_port_range            = local.nsg_rules_definition[security_rule.value][4]
      destination_port_range       = local.nsg_rules_definition[security_rule.value][5]
      destination_port_ranges      = local.nsg_rules_definition[security_rule.value][6]
      description                  = local.nsg_rules_definition[security_rule.value][7]
      source_address_prefix        = local.nsg_rules_definition[security_rule.value][8]
      source_address_prefixes      = local.nsg_rules_definition[security_rule.value][9]
      destination_address_prefix   = local.nsg_rules_definition[security_rule.value][10]
      destination_address_prefixes = local.nsg_rules_definition[security_rule.value][11]
    }
  }
}
 
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each                  = var.vnet_config["subnets"]
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
  subnet_id                 = azurerm_subnet.subnet[each.key].id
}
 
resource "azurerm_network_watcher" "network_watcher" {
  count               = var.use_existing_network_watcher == false ? 1 : 0
  name                = "NetworkWatcher_${var.rg_location}"
  location            = var.rg_location
  resource_group_name = var.rg_name
}