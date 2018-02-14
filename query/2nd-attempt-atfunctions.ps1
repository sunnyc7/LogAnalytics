// LogAnalytics function to query a performance counter (CounterName), in computer, starting on date Sart for a 30d period
// Copy paste the query in LogAnalytics window

// Define custom Loganalytics function
let PerfCountWithin30dRange = (start:date, CounterName:string, CompName:string) 
{
//variables
let period = 30d;

//code
Perf 
| where (TimeGenerated > start and TimeGenerated < start + period)
| where (Computer contains CompName)
| where CounterName == CounterName
| summarize percentiles(CounterValue, 95)  by bin(TimeGenerated, 15m) 
| render timechart
};

// VARIABLES
let servername = "ServerName";
// Exchange UserCount Performance counter. Available in Exchange 2007 and above.
let perfcountername = "User Count";
let startfrom = ago(60d);

// Call the functions
PerfCountWithin30dRange(startfrom, perfcountername, servername);
