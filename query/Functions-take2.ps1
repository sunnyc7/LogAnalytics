let PerfCountWithin30dRange = (start:date, CounterName:string, CompName:string) {
let period = 30d;
Perf 
| where (TimeGenerated > start and TimeGenerated < start + period)
| where (Computer contains CompName)
| where CounterName == CounterName
| summarize percentiles(CounterValue, 95)  by bin(TimeGenerated, 15m)
| render timechart
};

let start = ago(60d);
let comp = 'SERVERNAME2';
let perfcountername = "User Count";

PerfCountWithin30dRange(mark, start, perfcountername, comp) 

 
// clipped_average(): calculates percentiles limits, and then makes another 
//                    pass over the data to calcualte average with values inisde the percentiles
let perf_compare_30drange = (T:(x: date), CounterName:string, CompName:string)
{
   let period = 30d;
   Perf 
    | where (TimeGenerated > x and TimeGenerated < x + period)
    | where (Computer contains CompName)
    | where CounterName == CounterName
    | summarize percentiles(CounterValue, 95)  by bin(TimeGenerated, 15m)
    | render timechart
};

let start = ago(60d);
let comp = 'SERVERNAME2';
let perfcountername = "User Count";

range TwoMonths from ago(60d) to now() step 30d | 
| perf_compare_30drange(perfcountername, comp)
