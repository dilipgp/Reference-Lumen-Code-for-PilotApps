locals {
  az_supported_region_list = ["uksouth", "eastasia", "southeastasia"]
 
  # The basic tier doesn't support Apache Kafka workloads. Customer-managed key encryption at rest is only available for namespaces of premium SKU
  evhn_sku = "Premium"
}