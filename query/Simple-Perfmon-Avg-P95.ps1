// Simple Average and 95th percentile
Perf 
| where TimeGenerated > ago(1d)
| where Computer contains "SERVERNAME"
| where CounterName == "Avg. Disk Sec/Read" 
| summarize percentiles(CounterValue, 95) by bin(TimeGenerated, 1h), Computer
| render timechart
