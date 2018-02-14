// Renders a graph of number of users who are connected to Exchange servers daily.

Perf
| where TimeGenerated > ago(7d)
// EXCASSERVER1 is like -match
| where (Computer contains "EXCASSERVER1"  or Computer contains "EXCASSERVER2")
| where CounterName == "Requests/sec"
| summarize percentiles(CounterValue, 95)  by bin(TimeGenerated, 15m), Computer
| render timechart