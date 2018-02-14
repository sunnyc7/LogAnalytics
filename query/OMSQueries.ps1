// Chart with 2 perfmon counters
Perf 
| where TimeGenerated > ago(1d)
| where Computer contains "SERVERNAME"
| where CounterName == "Available MBytes"  or  CounterName == "% Processor Time"
| summarize percentiles(CounterValue, 95) by bin(TimeGenerated, 1h), Computer
| render timechart


// Chart with 3 perfmon counters
// Logical flaw in the chart, if though the chart renders.
// What counter is the percentile running on. Need to extract it into separate variables.
Perf 
| where TimeGenerated > ago(7d)
| where Computer contains "SERVERNAME"
| where (CounterName == "Available MBytes" or CounterName == "Pool Nonpaged Bytes" )
| summarize percentiles(CounterValue, 95) by bin(TimeGenerated, 15m), Computer
| render timechart


//Attempt on 2 HOSTS
// Fail
Perf
| where TimeGenerated > ago(7d)
| where (Computer contains "SERVERNAME" or Computer contains "SERVERNAME2")
| where (CounterName contains "Avg. Disk Sec/Read") 
| project TimeGenerated, Computer, cpu=CounterValue 
| summarize avgCpu=avg(cpu), avgCpu2=avg(cpu2) by TimeGenerated bin=15m  
| summarize percentiles(CounterValue, 95)  by bin(TimeGenerated, 15m), Computer
| render timechart


