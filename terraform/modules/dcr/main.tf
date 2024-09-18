resource "azurerm_monitor_data_collection_rule" "ama_dcr" {
  name                = var.dcr_name
  resource_group_name = var.resource_group
  location            = var.region
 
  data_sources {
    dynamic "windows_event_log" {
      for_each = {
        "windows_event_log" = {
          x_path_queries = ["*![System/Level=1]"]
          name           = "example-datasource-wineventlog"
          streams        = ["Microsoft-Event"]
        }
      }
 
      content {
        x_path_queries  = windows_event_log.value["x_path_queries"]
        name            = windows_event_log.value["name"]
        streams         = windows_event_log.value["streams"]
      }
    }
 
    dynamic "performance_counter" {
      for_each = {
        "perf_counter1" = {
          streams                       = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
          sampling_frequency_in_seconds = 60
          counter_specifiers            = [
            "\\Processor Information(_Total)\\% Processor Time",
            "\\Processor Information(_Total)\\% Privileged Time",
          ]
          name = "cpu-perfcounter"
        }
      }
 
      content {
        streams                       = performance_counter.value["streams"]
        sampling_frequency_in_seconds = performance_counter.value["sampling_frequency_in_seconds"]
        counter_specifiers            = performance_counter.value["counter_specifiers"]
        name                          = performance_counter.value["name"]
      }
    }
  }
 
  destinations {
    dynamic "log_analytics" {
      for_each = {
        "destination-log" = {
          workspace_resource_id = var.laws_id
          name                  = "destination-log"
        }
      }
 
      content {
        workspace_resource_id = log_analytics.value["workspace_resource_id"]
        name                  = log_analytics.value["name"]
      }
    }
  }
 
  dynamic "data_flow" {
    for_each = {
      "event_log_data_flow" = {
        streams      = ["Microsoft-Event"]
        destinations = ["destination-log"]
      }
      "perf_data_flow" = {
        streams      = ["Microsoft-Perf"]
        destinations = ["destination-log"]
      }
    }
 
    content {
      streams       = data_flow.value["streams"]
      destinations  = data_flow.value["destinations"]
    }
  }
}