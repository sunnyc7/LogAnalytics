Event 
| where (Computer contains "SERVERNAME")
| where (EventLog == "Application") 
| where (RenderDescription contains "Starting Chef") 
| summarize AggregatedValue = count() by EventLog

