// Renders a graph of EWS connections
Perf
| where TimeGenerated > ago(7d)
| where (Computer contains "CAS1"  or Computer contains "CAS2")
| where CounterName == "Requests/sec"
| summarize percentiles(CounterValue, 95)  by bin(TimeGenerated, 15m), Computer
| render timechart

// Renders a graph of number of users who are connected to Exchange servers daily.
Perf
| where TimeGenerated > ago(7d)
// contains is like -match operator from powershell
// replace CAS with your server name convention.
| where Computer contains "CAS"
| where CounterName == "User Count"
| summarize avg(CounterValue), percentiles(CounterValue, 95)  by bin(TimeGenerated, 15m), Computer
| render timechart