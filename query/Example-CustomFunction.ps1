// Custom Function Example

let PerfCountWithin30dRange = (start:date, CounterName:string, CompName:string) {
let period = 30d;

Perf 
| where (TimeGenerated > start and TimeGenerated < start + period)
| where (Computer contains CompName)
| where CounterName == "User Count"
| summarize percentiles(CounterValue, 95)  by bin(TimeGenerated, 15m)
| render timechart
};


let start = ago(60d);
let comp = 'MYSERVER';
let perfcountername = "User Count";

// Call the functions
PerfCountWithin30dRange(start, perfcountername, comp);
