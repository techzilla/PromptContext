---
title: Troubleshooting ES|QL
description: This section provides some useful resource for troubleshooting ES|QL issues: Query log: Learn how to log ES|QL queries, Task management API: Learn how...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-troubleshooting
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Troubleshooting ES|QL
This section provides some useful resource for troubleshooting ES|QL issues:
- [Query log](https://www.elastic.co/docs/reference/query-languages/esql/esql-query-log): Learn how to log ES|QL queries
- [Task management API](https://www.elastic.co/docs/reference/query-languages/esql/esql-task-management): Learn how to diagnose issues like long-running queries.﻿---
title: ES|QL time series aggregation functions
description: The first STATS under a TS source command supports aggregation functions per time series. These functions accept up to two arguments. The first argument...
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions
---

# ES|QL time series aggregation functions
The first [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) under a [`TS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/ts) source command supports
aggregation functions per time series. These functions accept up to two arguments.
The first argument is required and denotes the metric name of the time series.
The second argument is optional and allows specifying a sliding time window for
aggregating metric values. Note that this is orthogonal to time bucketing of
output results, as specified in the BY clause (e.g. through
[`TBUCKET`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-tbucket)).
For example, the following query calculates the average rate of requests per
host for every minute, using values over a sliding window of 10 minutes:
```esql
TS metrics
  | WHERE TRANGE(1h)
  | STATS AVG(RATE(requests, 10m)) BY TBUCKET(1m), host
```

Accepted window values are currently limited to multiples of the time bucket
interval in the BY clause. If no window is specified, the time bucket interval
is implicitly used as a window.
The following time series aggregation functions are supported:
- [`ABSENT_OVER_TIME`](#esql-absent_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`AVG_OVER_TIME`](#esql-avg_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`COUNT_OVER_TIME`](#esql-count_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`COUNT_DISTINCT_OVER_TIME`](#esql-count_distinct_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`DELTA`](#esql-delta) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`DERIV`](#esql-deriv) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`FIRST_OVER_TIME`](#esql-first_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`IDELTA`](#esql-idelta) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`INCREASE`](#esql-increase) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`IRATE`](#esql-irate) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`LAST_OVER_TIME`](#esql-last_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`MAX_OVER_TIME`](#esql-max_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`MIN_OVER_TIME`](#esql-min_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`PERCENTILE_OVER_TIME`](#esql-percentile_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`PRESENT_OVER_TIME`](#esql-present_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`RATE`](#esql-rate) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`STDDEV_OVER_TIME`](#esql-stddev_over_time) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`SUM_OVER_TIME`](#esql-sum_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`VARIANCE_OVER_TIME`](#esql-variance_over_time) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>


## `ABSENT_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/absent_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the absent over time
  </definition>
</definitions>

**Description**
Calculates the absence of a field in the output result over time range.
**Supported types**

| field                   | window | result  |
|-------------------------|--------|---------|
| aggregate_metric_double |        | boolean |
| boolean                 |        | boolean |
| cartesian_point         |        | boolean |
| cartesian_shape         |        | boolean |
| date                    |        | boolean |
| date_nanos              |        | boolean |
| double                  |        | boolean |
| exponential_histogram   |        | boolean |
| geo_point               |        | boolean |
| geo_shape               |        | boolean |
| geohash                 |        | boolean |
| geohex                  |        | boolean |
| geotile                 |        | boolean |
| histogram               |        | boolean |
| integer                 |        | boolean |
| ip                      |        | boolean |
| keyword                 |        | boolean |
| long                    |        | boolean |
| tdigest                 |        | boolean |
| text                    |        | boolean |
| unsigned_long           |        | boolean |
| version                 |        | boolean |

**Example**
```esql
TS k8s
| WHERE cluster == "prod" AND pod == "two"
| STATS events_received = MAX(ABSENT_OVER_TIME(events_received)) BY pod, time_bucket = TBUCKET(2 minute)
```


| events_received:boolean | pod:keyword | time_bucket:datetime     |
|-------------------------|-------------|--------------------------|
| false                   | two         | 2024-05-10T00:02:00.000Z |
| false                   | two         | 2024-05-10T00:08:00.000Z |
| true                    | two         | 2024-05-10T00:10:00.000Z |
| true                    | two         | 2024-05-10T00:12:00.000Z |


## `AVG_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/avg_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the average
  </definition>
</definitions>

**Description**
Calculates the average over time of a numeric field.
**Supported types**

| field                   | window                                                        | result |
|-------------------------|---------------------------------------------------------------|--------|
| aggregate_metric_double | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| double                  | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| exponential_histogram   | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| integer                 | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| long                    | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| tdigest                 | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |

**Example**
```esql
TS k8s
| STATS max_cost=MAX(AVG_OVER_TIME(network.cost)) BY cluster, time_bucket = TBUCKET(1minute)
```


| max_cost:double | cluster:keyword | time_bucket:datetime     |
|-----------------|-----------------|--------------------------|
| 12.375          | prod            | 2024-05-10T00:17:00.000Z |
| 12.375          | qa              | 2024-05-10T00:01:00.000Z |
| 12.25           | prod            | 2024-05-10T00:19:00.000Z |
| 12.0625         | qa              | 2024-05-10T00:06:00.000Z |


## `COUNT_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/count_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the count over time
  </definition>
</definitions>

**Description**
Calculates the count over time value of a field.
**Supported types**

| field                   | window | result |
|-------------------------|--------|--------|
| aggregate_metric_double |        | long   |
| boolean                 |        | long   |
| cartesian_point         |        | long   |
| cartesian_shape         |        | long   |
| date                    |        | long   |
| date_nanos              |        | long   |
| double                  |        | long   |
| geo_point               |        | long   |
| geo_shape               |        | long   |
| geohash                 |        | long   |
| geohex                  |        | long   |
| geotile                 |        | long   |
| integer                 |        | long   |
| ip                      |        | long   |
| keyword                 |        | long   |
| long                    |        | long   |
| text                    |        | long   |
| unsigned_long           |        | long   |
| version                 |        | long   |

**Example**
```esql
TS k8s
| STATS count=COUNT(COUNT_OVER_TIME(network.cost))
  BY cluster, time_bucket = BUCKET(@timestamp,1minute)
```


| count:long | cluster:keyword | time_bucket:datetime     |
|------------|-----------------|--------------------------|
| 3          | staging         | 2024-05-10T00:22:00.000Z |
| 3          | prod            | 2024-05-10T00:20:00.000Z |
| 3          | prod            | 2024-05-10T00:19:00.000Z |


## `COUNT_DISTINCT_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/count_distinct_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="precision">
    Precision threshold. Refer to [`AGG-COUNT-DISTINCT-APPROXIMATE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-agg-count-distinct-approximate). The maximum supported value is 40000. Thresholds above this number will have the same effect as a threshold of 40000. The default value is 3000.
  </definition>
</definitions>

**Description**
Calculates the count of distinct values over time for a field.
**Supported types**

| field      | precision     | result |
|------------|---------------|--------|
| boolean    | integer       | long   |
| boolean    | long          | long   |
| boolean    | unsigned_long | long   |
| boolean    |               | long   |
| date       | integer       | long   |
| date       | long          | long   |
| date       | unsigned_long | long   |
| date       |               | long   |
| date_nanos | integer       | long   |
| date_nanos | long          | long   |
| date_nanos | unsigned_long | long   |
| date_nanos |               | long   |
| double     | integer       | long   |
| double     | long          | long   |
| double     | unsigned_long | long   |
| double     |               | long   |
| integer    | integer       | long   |
| integer    | long          | long   |
| integer    | unsigned_long | long   |
| integer    |               | long   |
| ip         | integer       | long   |
| ip         | long          | long   |
| ip         | unsigned_long | long   |
| ip         |               | long   |
| keyword    | integer       | long   |
| keyword    | long          | long   |
| keyword    | unsigned_long | long   |
| keyword    |               | long   |
| long       | integer       | long   |
| long       | long          | long   |
| long       | unsigned_long | long   |
| long       |               | long   |
| text       | integer       | long   |
| text       | long          | long   |
| text       | unsigned_long | long   |
| text       |               | long   |
| version    | integer       | long   |
| version    | long          | long   |
| version    | unsigned_long | long   |
| version    |               | long   |

**Example**
```esql
TS k8s
| STATS distincts=COUNT_DISTINCT(COUNT_DISTINCT_OVER_TIME(network.cost)),
        distincts_imprecise=COUNT_DISTINCT(COUNT_DISTINCT_OVER_TIME(network.cost, 100))
  BY cluster, time_bucket = TBUCKET(1minute)
```


| distincts:long | distincts_imprecise:long | cluster:keyword | time_bucket:datetime     |
|----------------|--------------------------|-----------------|--------------------------|
| 3              | 3                        | qa              | 2024-05-10T00:17:00.000Z |
| 3              | 3                        | qa              | 2024-05-10T00:15:00.000Z |
| 3              | 3                        | prod            | 2024-05-10T00:09:00.000Z |


## `DELTA`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/delta.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the delta over time
  </definition>
</definitions>

**Description**
Calculates the absolute change of a gauge field in a time window.
**Supported types**

| field   | window | result |
|---------|--------|--------|
| double  |        | double |
| integer |        | double |
| long    |        | double |

**Example**
```esql
TS k8s
| WHERE pod == "one"
| STATS tx = SUM(DELTA(network.bytes_in)) BY cluster, time_bucket = TBUCKET(10minute)
```


| tx:double | cluster:keyword | time_bucket:datetime     |
|-----------|-----------------|--------------------------|
| -351.0    | prod            | 2024-05-10T00:00:00.000Z |
| 552.0     | qa              | 2024-05-10T00:00:00.000Z |
| 127.0     | staging         | 2024-05-10T00:00:00.000Z |
| 280.0     | prod            | 2024-05-10T00:10:00.000Z |


## `DERIV`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/deriv.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the derivative over time
  </definition>
</definitions>

**Description**
Calculates the derivative over time of a numeric field using linear regression.
**Supported types**

| field   | window | result |
|---------|--------|--------|
| double  |        | double |
| integer |        | double |
| long    |        | double |

**Example**
```esql
TS datenanos-k8s
| WHERE pod == "three"
| STATS max_deriv = MAX(DERIV(network.cost)) BY time_bucket = BUCKET(@timestamp,5minute), pod
```


| max_deriv:double | time_bucket:date_nanos   | pod:keyword |
|------------------|--------------------------|-------------|
| 0.101674         | 2024-05-10T00:00:00.000Z | three       |
| 0.0411           | 2024-05-10T00:05:00.000Z | three       |
| -0.017149        | 2024-05-10T00:10:00.000Z | three       |


## `FIRST_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/first_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the first over time value
  </definition>
</definitions>

**Description**
Calculates the earliest value of a field, where recency determined by the `@timestamp` field.
**Supported types**

| field                 | window                                                        | result                |
|-----------------------|---------------------------------------------------------------|-----------------------|
| counter_double        | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double                |
| counter_integer       | time_duration <applies-to>Elastic Stack: Planned</applies-to> | integer               |
| counter_long          | time_duration <applies-to>Elastic Stack: Planned</applies-to> | long                  |
| double                | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double                |
| exponential_histogram | time_duration <applies-to>Elastic Stack: Planned</applies-to> | exponential_histogram |
| integer               | time_duration <applies-to>Elastic Stack: Planned</applies-to> | integer               |
| long                  | time_duration <applies-to>Elastic Stack: Planned</applies-to> | long                  |

**Example**
```esql
TS k8s
| STATS max_cost=MAX(FIRST_OVER_TIME(network.cost)) BY cluster, time_bucket = TBUCKET(1minute)
```


| max_cost:double | cluster:keyword | time_bucket:datetime     |
|-----------------|-----------------|--------------------------|
| 12.375          | prod            | 2024-05-10T00:17:00.000Z |
| 12.375          | qa              | 2024-05-10T00:01:00.000Z |
| 12.25           | prod            | 2024-05-10T00:19:00.000Z |


## `IDELTA`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/idelta.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the idelta over time
  </definition>
</definitions>

**Description**
Calculates the idelta of a gauge. idelta is the absolute change between the last two data points (it ignores all but the last two data points in each time period). This function is very similar to delta, but is more responsive to recent changes.
**Supported types**

| field   | window | result |
|---------|--------|--------|
| double  |        | double |
| integer |        | double |
| long    |        | double |

**Example**
```esql
TS k8s
| STATS events = SUM(IDELTA(events_received)) by pod, time_bucket = TBUCKET(10minute)
```


| events:double | pod:keyword | time_bucket:datetime     |
|---------------|-------------|--------------------------|
| 9.0           | one         | 2024-05-10T00:10:00.000Z |
| 7.0           | three       | 2024-05-10T00:10:00.000Z |
| 3.0           | two         | 2024-05-10T00:00:00.000Z |
| 0.0           | two         | 2024-05-10T00:20:00.000Z |


## `INCREASE`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/increase.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the increase over time
  </definition>
</definitions>

**Description**
Calculates the absolute increase of a counter field in a time window.
**Supported types**

| field           | window | result |
|-----------------|--------|--------|
| counter_double  |        | double |
| counter_integer |        | double |
| counter_long    |        | double |

**Example**
```esql
TS k8s
| WHERE pod == "one"
| STATS increase_bytes_in = SUM(INCREASE(network.total_bytes_in)) BY cluster, time_bucket = TBUCKET(10minute)
```


| increase_bytes_in:double | cluster:keyword | time_bucket:datetime     |
|--------------------------|-----------------|--------------------------|
| 2453.5                   | prod            | 2024-05-10T00:00:00.000Z |
| 5828.87                  | qa              | 2024-05-10T00:00:00.000Z |
| 2591.440476190476        | staging         | 2024-05-10T00:00:00.000Z |


## `IRATE`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/irate.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the irate
  </definition>
</definitions>

**Description**
Calculates the irate of a counter field. irate is the per-second rate of increase between the last two data points (it ignores all but the last two data points in each time period). This function is very similar to rate, but is more responsive to recent changes in the rate of increase.
**Supported types**

| field           | window | result |
|-----------------|--------|--------|
| counter_double  |        | double |
| counter_integer |        | double |
| counter_long    |        | double |

**Example**
```esql
TS k8s | WHERE pod == "one"
| STATS irate_bytes_in = SUM(IRATE(network.total_bytes_in)) BY cluster, time_bucket = TBUCKET(10minute)
```


| irate_bytes_in:double | cluster:keyword | time_bucket:datetime     |
|-----------------------|-----------------|--------------------------|
| 0.07692307692307693   | prod            | 2024-05-10T00:00:00.000Z |
| 830.0                 | qa              | 2024-05-10T00:00:00.000Z |
| 31.375                | staging         | 2024-05-10T00:00:00.000Z |
| 9.854545454545454     | prod            | 2024-05-10T00:10:00.000Z |
| 18.700000000000003    | qa              | 2024-05-10T00:10:00.000Z |


## `LAST_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/last_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the latest value for
  </definition>
  <definition term="window">
    the time window over which to find the latest value
  </definition>
</definitions>

**Description**
Calculates the latest value of a field, where recency determined by the `@timestamp` field.
**Supported types**

| field                 | window                                                        | result                |
|-----------------------|---------------------------------------------------------------|-----------------------|
| counter_double        | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double                |
| counter_integer       | time_duration <applies-to>Elastic Stack: Planned</applies-to> | integer               |
| counter_long          | time_duration <applies-to>Elastic Stack: Planned</applies-to> | long                  |
| double                | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double                |
| exponential_histogram | time_duration <applies-to>Elastic Stack: Planned</applies-to> | exponential_histogram |
| integer               | time_duration <applies-to>Elastic Stack: Planned</applies-to> | integer               |
| long                  | time_duration <applies-to>Elastic Stack: Planned</applies-to> | long                  |

**Example**
```esql
TS k8s
| STATS max_cost=MAX(LAST_OVER_TIME(network.cost)) BY cluster, time_bucket = TBUCKET(1minute)
```


| max_cost:double | cluster:keyword | time_bucket:datetime     |
|-----------------|-----------------|--------------------------|
| 12.5            | staging         | 2024-05-10T00:09:00.000Z |
| 12.375          | prod            | 2024-05-10T00:17:00.000Z |
| 12.375          | qa              | 2024-05-10T00:06:00.000Z |
| 12.375          | qa              | 2024-05-10T00:01:00.000Z |


## `MAX_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/max_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the maximum
  </definition>
</definitions>

**Description**
Calculates the maximum over time value of a field.
**Supported types**

| field                                                                               | window                                                        | result        |
|-------------------------------------------------------------------------------------|---------------------------------------------------------------|---------------|
| aggregate_metric_double                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double        |
| boolean                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | boolean       |
| date                                                                                | time_duration <applies-to>Elastic Stack: Planned</applies-to> | date          |
| date_nanos                                                                          | time_duration <applies-to>Elastic Stack: Planned</applies-to> | date_nanos    |
| double                                                                              | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double        |
| exponential_histogram                                                               | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double        |
| integer                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | integer       |
| ip                                                                                  | time_duration <applies-to>Elastic Stack: Planned</applies-to> | ip            |
| keyword                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | keyword       |
| long                                                                                | time_duration <applies-to>Elastic Stack: Planned</applies-to> | long          |
| tdigest                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double        |
| text                                                                                | time_duration <applies-to>Elastic Stack: Planned</applies-to> | keyword       |
| unsigned_long <applies-to>Elastic Stack: Generally available since 9.2</applies-to> | time_duration <applies-to>Elastic Stack: Planned</applies-to> | unsigned_long |
| version                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | version       |

**Example**
```esql
TS k8s
| STATS cost=SUM(MAX_OVER_TIME(network.cost)) BY cluster, time_bucket = TBUCKET(1minute)
```


| cost:double | cluster:keyword | time_bucket:datetime     |
|-------------|-----------------|--------------------------|
| 32.75       | qa              | 2024-05-10T00:17:00.000Z |
| 32.25       | staging         | 2024-05-10T00:09:00.000Z |
| 31.75       | qa              | 2024-05-10T00:06:00.000Z |
| 29.0        | prod            | 2024-05-10T00:19:00.000Z |


## `MIN_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/min_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the minimum
  </definition>
</definitions>

**Description**
Calculates the minimum over time value of a field.
**Supported types**

| field                                                                               | window                                                        | result        |
|-------------------------------------------------------------------------------------|---------------------------------------------------------------|---------------|
| aggregate_metric_double                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double        |
| boolean                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | boolean       |
| date                                                                                | time_duration <applies-to>Elastic Stack: Planned</applies-to> | date          |
| date_nanos                                                                          | time_duration <applies-to>Elastic Stack: Planned</applies-to> | date_nanos    |
| double                                                                              | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double        |
| exponential_histogram                                                               | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double        |
| integer                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | integer       |
| ip                                                                                  | time_duration <applies-to>Elastic Stack: Planned</applies-to> | ip            |
| keyword                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | keyword       |
| long                                                                                | time_duration <applies-to>Elastic Stack: Planned</applies-to> | long          |
| tdigest                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double        |
| text                                                                                | time_duration <applies-to>Elastic Stack: Planned</applies-to> | keyword       |
| unsigned_long <applies-to>Elastic Stack: Generally available since 9.2</applies-to> | time_duration <applies-to>Elastic Stack: Planned</applies-to> | unsigned_long |
| version                                                                             | time_duration <applies-to>Elastic Stack: Planned</applies-to> | version       |

**Example**
```esql
TS k8s
| STATS cost=SUM(MIN_OVER_TIME(network.cost)) BY cluster, time_bucket = TBUCKET(1minute)
```


| cost:double | cluster:keyword | time_bucket:datetime     |
|-------------|-----------------|--------------------------|
| 29.0        | prod            | 2024-05-10T00:19:00.000Z |
| 27.625      | qa              | 2024-05-10T00:06:00.000Z |
| 24.25       | qa              | 2024-05-10T00:09:00.000Z |


## `PERCENTILE_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/percentile_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="percentile">
    the percentile value to compute (between 0 and 100)
  </definition>
</definitions>

**Description**
Calculates the percentile over time of a field.
**Supported types**

| field                 | percentile | result |
|-----------------------|------------|--------|
| double                | double     | double |
| double                | integer    | double |
| double                | long       | double |
| exponential_histogram | double     | double |
| exponential_histogram | integer    | double |
| exponential_histogram | long       | double |
| integer               | double     | double |
| integer               | integer    | double |
| integer               | long       | double |
| long                  | double     | double |
| long                  | integer    | double |
| long                  | long       | double |
| tdigest               | double     | double |
| tdigest               | integer    | double |
| tdigest               | long       | double |

**Example**
```esql
TS k8s
| STATS p95_cost=MAX(PERCENTILE_OVER_TIME(network.cost, 95)), p99_cost=MAX(PERCENTILE_OVER_TIME(network.cost, 99)) BY cluster, time_bucket = TBUCKET(1minute)
```


## `PRESENT_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/present_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the present over time
  </definition>
</definitions>

**Description**
Calculates the presence of a field in the output result over time range.
**Supported types**

| field                   | window | result  |
|-------------------------|--------|---------|
| aggregate_metric_double |        | boolean |
| boolean                 |        | boolean |
| cartesian_point         |        | boolean |
| cartesian_shape         |        | boolean |
| date                    |        | boolean |
| date_nanos              |        | boolean |
| double                  |        | boolean |
| exponential_histogram   |        | boolean |
| geo_point               |        | boolean |
| geo_shape               |        | boolean |
| geohash                 |        | boolean |
| geohex                  |        | boolean |
| geotile                 |        | boolean |
| histogram               |        | boolean |
| integer                 |        | boolean |
| ip                      |        | boolean |
| keyword                 |        | boolean |
| long                    |        | boolean |
| tdigest                 |        | boolean |
| text                    |        | boolean |
| unsigned_long           |        | boolean |
| version                 |        | boolean |

**Example**
```esql
TS k8s
| WHERE cluster == "prod" AND pod == "two"
| STATS events_received = MAX(PRESENT_OVER_TIME(events_received)) BY pod, time_bucket = TBUCKET(2 minute)
```


| events_received:boolean | pod:keyword | time_bucket:datetime     |
|-------------------------|-------------|--------------------------|
| true                    | two         | 2024-05-10T00:02:00.000Z |
| true                    | two         | 2024-05-10T00:08:00.000Z |
| false                   | two         | 2024-05-10T00:10:00.000Z |
| false                   | two         | 2024-05-10T00:12:00.000Z |


## `RATE`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/rate.svg)

**Parameters**
<definitions>
  <definition term="field">
    the counter field whose per-second average rate of increase is computed
  </definition>
  <definition term="window">
    the time window over which the rate is computed
  </definition>
</definitions>

**Description**
Calculates the per-second average rate of increase of a [counter](https://www.elastic.co/docs/manage-data/data-store/data-streams/time-series-data-stream-tsds#time-series-metric). Rate calculations account for breaks in monotonicity, such as counter resets when a service restarts, and extrapolate values within each bucketed time interval. Rate is the most appropriate aggregate function for counters. It is only allowed in a [STATS](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command under a [`TS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/ts) source command, to be properly applied per time series.
**Supported types**

| field           | window                                                        | result |
|-----------------|---------------------------------------------------------------|--------|
| counter_double  | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| counter_integer | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| counter_long    | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |

**Example**
```esql
TS k8s
| STATS max_rate=MAX(RATE(network.total_bytes_in)) BY time_bucket = TBUCKET(5minute)
```


| max_rate: double | time_bucket:date         |
|------------------|--------------------------|
| 64.5             | 2024-05-10T00:20:00.000Z |
| 22.359074        | 2024-05-10T00:15:00.000Z |


## `STDDEV_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/stddev_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the standard deviation for
  </definition>
  <definition term="window">
    the time window over which to compute the standard deviation over time
  </definition>
</definitions>

**Description**
Calculates the population standard deviation over time of a numeric field.
**Supported types**

| field   | window | result |
|---------|--------|--------|
| double  |        | double |
| integer |        | double |
| long    |        | double |

**Example**
```esql
TS k8s
| STATS max_stddev_cost=MAX(STDDEV_OVER_TIME(network.cost)) BY cluster, time_bucket = TBUCKET(1minute)
```


| cluster:keyword | time_bucket:datetime     | max_stddev_cost:double |
|-----------------|--------------------------|------------------------|
| staging         | 2024-05-10T00:03:00.000Z | 5.4375                 |
| staging         | 2024-05-10T00:09:00.000Z | 5.1875                 |
| qa              | 2024-05-10T00:18:00.000Z | 4.097764               |
| qa              | 2024-05-10T00:21:00.000Z | 4.0                    |
| staging         | 2024-05-10T00:20:00.000Z | 3.9375                 |


## `VARIANCE_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/variance_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the variance over time
  </definition>
</definitions>

**Description**
Calculates the population variance over time of a numeric field.
**Supported types**

| field   | window | result |
|---------|--------|--------|
| double  |        | double |
| integer |        | double |
| long    |        | double |

**Example**
```esql
TS k8s
| STATS avg_var_cost=AVG(VARIANCE_OVER_TIME(network.cost)) BY cluster, time_bucket = TBUCKET(1minute)
```


| cluster:keyword | time_bucket:datetime     | avg_var_cost:double |
|-----------------|--------------------------|---------------------|
| staging         | 2024-05-10T00:03:00.000Z | 20.478516           |
| qa              | 2024-05-10T00:21:00.000Z | 16.0                |
| qa              | 2024-05-10T00:18:00.000Z | 11.192274           |
| staging         | 2024-05-10T00:09:00.000Z | 10.446904           |


## `SUM_OVER_TIME`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/sum_over_time.svg)

**Parameters**
<definitions>
  <definition term="field">
    the metric field to calculate the value for
  </definition>
  <definition term="window">
    the time window over which to compute the sum over time
  </definition>
</definitions>

**Description**
Calculates the sum over time value of a field.
**Supported types**

| field                   | window                                                        | result |
|-------------------------|---------------------------------------------------------------|--------|
| aggregate_metric_double | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| double                  | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| exponential_histogram   | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |
| integer                 | time_duration <applies-to>Elastic Stack: Planned</applies-to> | long   |
| long                    | time_duration <applies-to>Elastic Stack: Planned</applies-to> | long   |
| tdigest                 | time_duration <applies-to>Elastic Stack: Planned</applies-to> | double |

**Example**
```esql
TS k8s
| STATS sum_cost=SUM(SUM_OVER_TIME(network.cost)) BY cluster, time_bucket = TBUCKET(1minute)
```


| sum_cost:double | cluster:keyword | time_bucket:datetime     |
|-----------------|-----------------|--------------------------|
| 67.625          | qa              | 2024-05-10T00:17:00.000Z |
| 65.75           | staging         | 2024-05-10T00:09:00.000Z |﻿---
title: Combine data from multiple indices with ENRICH
description: This page provides an overview of the ES|QL ENRICH command. For complete syntax details and examples, refer to the ENRICH command reference. The ES|QL...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-enrich-data
applies_to:
  - Elastic Cloud Serverless: Unavailable
  - Elastic Stack: Generally available in 9.0+
---

# Combine data from multiple indices with ENRICH
This page provides an overview of the ES|QL `ENRICH` command. For complete syntax details and examples, refer to the [`ENRICH` command reference](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich).
The ES|QL [`ENRICH`](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich) processing command combines, at query-time, data from one or more source indexes with field-value combinations found in Elasticsearch enrich indexes.
For example, you can use `ENRICH` to:
- Identify web services or vendors based on known IP addresses
- Add product information to retail orders based on product IDs
- Supplement contact information based on an email address


## Compare `ENRICH` and `LOOKUP JOIN`

[`ENRICH`](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich) is similar to [`LOOKUP join`](https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join) in the fact that they both help you join data together. You should use `ENRICH` when:
- Enrichment data doesn't change frequently
- You can accept index-time overhead
- You can accept having multiple matches combined into multi-values
- You can accept being limited to predefined match fields
- You do not need fine-grained security: There are no restrictions to specific enrich policies or document and field level security.
- You want to match using ranges or spatial relations


## Syntax reference

For complete syntax details and examples, refer to the [ENRICH command reference](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich).

## How the `ENRICH` command works

The `ENRICH` command adds new columns to a table, with data from Elasticsearch indices. It requires a few special components:
![esql enrich](https://www.elastic.co/docs/reference/query-languages/images/esql-enrich.png)


<definitions>
  <definition term="Enrich policy">
    A set of configuration options used to add the right enrich data to the input table.
  </definition>
</definitions>

An enrich policy contains:
- A list of one or more *source indices* which store enrich data as documents
- The *policy type* which determines how the processor matches the enrich data to incoming documents
- A *match field* from the source indices used to match incoming documents
- *Enrich fields* containing enrich data from the source indices you want to add to incoming documents

After [creating a policy](#esql-create-enrich-policy), it must be [executed](#esql-execute-enrich-policy) before it can be used. Executing an enrich policy uses data from the policy's source indices to create a streamlined system index called the *enrich index*. The `ENRICH` command uses this index to match and enrich an input table.

<definitions>
  <definition term="Source index">
    An index which stores enrich data that the `ENRICH` command can add to input tables. You can create and manage these indices just like a regular Elasticsearch index. You can use multiple source indices in an enrich policy. You also can use the same source index in multiple enrich policies.
  </definition>
</definitions>


<definitions>
  <definition term="Enrich index">
    A special system index tied to a specific enrich policy.
  </definition>
</definitions>

Directly matching rows from input tables to documents in source indices could be slow and resource intensive. To speed things up, the `ENRICH` command uses an enrich index.
Enrich indices contain enrich data from source indices but have a few special properties to help streamline them:
- They are system indices, meaning they're managed internally by Elasticsearch and only intended for use with enrich processors and the ES|QL `ENRICH` command.
- They always begin with `.enrich-*`.
- They are read-only, meaning you can't directly change them.
- They are [force merged](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-indices-forcemerge) for fast retrieval.


## Using `ENRICH` across clusters

You can use `ENRICH` with remote clusters. For detailed information about cross-cluster enrichment syntax and configuration, refer to [ENRICH across clusters](/docs/reference/query-languages/esql/esql-cross-clusters#ccq-enrich).

## Set up an enrich policy

To start using `ENRICH`, follow these steps:
1. Check the [prerequisites](https://www.elastic.co/docs/manage-data/ingest/transform-enrich/set-up-an-enrich-processor#enrich-prereqs).
2. [Add enrich data](#esql-create-enrich-source-index).
3. [Create an enrich policy](#esql-create-enrich-policy).
4. [Execute the enrich policy](#esql-execute-enrich-policy).
5. [Use the enrich policy](#esql-use-enrich)

Once you have enrich policies set up, you can [update your enrich data](#esql-update-enrich-data) and [update your enrich policies](#esql-update-enrich-policies).
<important>
  The `ENRICH` command performs several operations and may impact the speed of your query.
</important>


### Prerequisites

To use enrich policies, you must have:
- `read` index privileges for any indices used
- The `enrich_user` [built-in role](https://www.elastic.co/docs/reference/elasticsearch/roles)


### Add enrich data

To begin, add documents to one or more source indices. These documents should contain the enrich data you eventually want to add to incoming data.
You can manage source indices just like regular Elasticsearch indices using the [document](https://www.elastic.co/docs/api/doc/elasticsearch/group/endpoint-document) and [index](https://www.elastic.co/docs/api/doc/elasticsearch/group/endpoint-indices) APIs.
You also can set up [Beats](https://www.elastic.co/docs/reference/beats), such as a [Filebeat](https://www.elastic.co/docs/reference/beats/filebeat/filebeat-installation-configuration), to automatically send and index documents to your source indices. See [Getting started with Beats](https://www.elastic.co/docs/reference/beats).

### Create an enrich policy

After adding enrich data to your source indices, use the [create enrich policy API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-enrich-put-policy) or [Index Management in Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-enrich-policies) to create an enrich policy.
<warning>
  Once created, you can't update or change an enrich policy. See [Update an enrich policy](https://www.elastic.co/docs/manage-data/ingest/transform-enrich/set-up-an-enrich-processor#update-enrich-policies).
</warning>


### Execute the enrich policy

Once the enrich policy is created, you need to execute it using the [execute enrich policy API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-enrich-execute-policy) or [Index Management in Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-enrich-policies) to create an [enrich index](https://www.elastic.co/docs/manage-data/ingest/transform-enrich/data-enrichment#enrich-index).
![esql enrich policy](https://www.elastic.co/docs/reference/query-languages/images/esql-enrich-policy.png)

The *enrich index* contains documents from the policy's source indices. Enrich indices always begin with `.enrich-*`, are read-only, and are [force merged](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-indices-forcemerge).
<warning>
  Enrich indices should only be used by the [enrich processor](https://www.elastic.co/docs/reference/enrich-processor/enrich-processor) or the [ES|QL `ENRICH` command](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich). Avoid using enrich indices for other purposes.
</warning>


### Use the enrich policy

After the policy has been executed, you can use the [`ENRICH` command](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich) to enrich your data.
![esql enrich command](https://www.elastic.co/docs/reference/query-languages/images/esql-enrich-command.png)

The following example uses the `languages_policy` enrich policy to add a new column for each enrich field defined in the policy. The match is performed using the `match_field` defined in the [enrich policy](#esql-enrich-policy) and requires that the input table has a column with the same name (`language_code` in this example). `ENRICH` will look for records in the [enrich index](#esql-enrich-index) based on the match field value.
```esql
ROW language_code = "1"
| ENRICH languages_policy
```


| language_code:keyword | language_name:keyword |
|-----------------------|-----------------------|
| 1                     | English               |

To use a column with a different name than the `match_field` defined in the policy as the match field, use `ON <column-name>`:
```esql
ROW a = "1"
| ENRICH languages_policy ON a
```


| a:keyword | language_name:keyword |
|-----------|-----------------------|
| 1         | English               |

By default, each of the enrich fields defined in the policy is added as a column. To explicitly select the enrich fields that are added, use `WITH <field1>, <field2>, ...`:
```esql
ROW a = "1"
| ENRICH languages_policy ON a WITH language_name
```


| a:keyword | language_name:keyword |
|-----------|-----------------------|
| 1         | English               |

You can rename the columns that are added using `WITH new_name=<field1>`:
```esql
ROW a = "1"
| ENRICH languages_policy ON a WITH name = language_name
```


| a:keyword | name:keyword |
|-----------|--------------|
| 1         | English      |

In case of name collisions, the newly created columns will override existing columns.

## Update an enrich index

Once created, you cannot update or index documents to an enrich index. Instead, update your source indices and [execute](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-enrich-execute-policy) the enrich policy again. This creates a new enrich index from your updated source indices. The previous enrich index will be deleted with a delayed maintenance job that executes by default every 15 minutes.

## Update an enrich policy

Once created, you can't update or change an enrich policy. Instead, you can:
1. Create and [execute](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-enrich-execute-policy) a new enrich policy.
2. Replace the previous enrich policy with the new enrich policy in any in-use enrich processors or ES|QL queries.
3. Use the [delete enrich policy](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-enrich-delete-policy) API or [Index Management in Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-enrich-policies) to delete the previous enrich policy.


## Enrich Policy Types and Limitations

The ES|QL `ENRICH` command supports all three enrich policy types:
<definitions>
  <definition term="geo_match">
    Matches enrich data to incoming documents based on a [`geo_shape` query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-geo-shape-query). For an example, refer to [Example: Enrich your data based on geolocation](https://www.elastic.co/docs/manage-data/ingest/transform-enrich/example-enrich-data-based-on-geolocation).
  </definition>
  <definition term="match">
    Matches enrich data to incoming documents based on a [`term` query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-term-query). For an example, refer to [Example: Enrich your data based on exact values](https://www.elastic.co/docs/manage-data/ingest/transform-enrich/example-enrich-data-based-on-exact-values).
  </definition>
  <definition term="range">
    Matches a number, date, or IP address in incoming documents to a range in the enrich index based on a [`term` query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-term-query). For an example, refer to [Example: Enrich your data by matching a value to a range](https://www.elastic.co/docs/manage-data/ingest/transform-enrich/example-enrich-data-by-matching-value-to-range).
  </definition>
</definitions>

While all three enrich policy types are supported, there are some limitations to be aware of:
- The `geo_match` enrich policy type only supports the `intersects` spatial relation.
- It is required that the `match_field` in the `ENRICH` command is of the correct type. For example, if the enrich policy is of type `geo_match`, the `match_field` in the `ENRICH` command must be of type `geo_point` or `geo_shape`. Likewise, a `range` enrich policy requires a `match_field` of type `integer`, `long`, `date`, or `ip`, depending on the type of the range field in the original enrich index.
- However, this constraint is relaxed for `range` policies when the `match_field` is of type `KEYWORD`. In this case the field values will be parsed during query execution, row by row. If any value fails to parse, the output values for that row will be set to `null`, an appropriate warning will be produced and the query will continue to execute.


## Related pages

- [`ENRICH` command reference](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich): Complete syntax documentation and examples
- [`ENRICH` across clusters](/docs/reference/query-languages/esql/esql-cross-clusters#ccq-enrich) - Cross-cluster enrichment configuration
- [LOOKUP JOIN command](https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join) - Alternative approach for joining data﻿---
title: Advanced workflows in ES|QL
description: These guides provide detailed information about more advanced workflows in ES|QL. Extract data with DISSECT and GROK: Learn how to extract and transform...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-advanced
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Advanced workflows in ES|QL
These guides provide detailed information about more advanced workflows in ES|QL.
- [Extract data with `DISSECT` and `GROK`](https://www.elastic.co/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok): Learn how to extract and transform structured data from unstructured text.
- [Augment data with `ENRICH`](https://www.elastic.co/docs/reference/query-languages/esql/esql-enrich-data): Learn how to combine data from different indices.
- [Join data with `LOOKUP JOIN`](https://www.elastic.co/docs/reference/query-languages/esql/esql-lookup-join): Learn how to join data from different indices.﻿---
title: ES|QL operators
description: Operators for performing operations on, or comparing against, one or multiple expressions. 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/operators
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL operators
Operators for performing operations on, or comparing against, one or multiple expressions.
- [Binary operators](#esql-binary-operators)
- [Unary operators](#esql-unary-operators)
- [Logical operators](#esql-logical-operators)
- [suffix operators](#esql-suffix-operators)
- [infix operators](#esql-infix-operators)


## Binary operators

- [Equality](#esql-equals)
- [Inequality `!=`](#esql-not_equals)
- [Less than `<`](#esql-less_than)
- [Less than or equal to `<=`](#esql-less_than_or_equal)
- [Greater than `>`](#esql-greater_than)
- [Greater than or equal to `>=`](#esql-greater_than_or_equal)
- [Add `+`](#esql-add)
- [Subtract `-`](#esql-sub)
- [Multiply `*`](#esql-mul)
- [Divide `/`](#esql-div)
- [Modulus `%`](#esql-mod)


### Equality

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/equals.svg)

Check if two fields are equal. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
<note>
  This is pushed to the underlying search index if one side of the comparison is constant and the other side is a field in the index that has both an [mapping-index](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-index) and [doc-values](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/doc-values).
</note>

**Supported types**

| lhs             | rhs             | result  |
|-----------------|-----------------|---------|
| boolean         | boolean         | boolean |
| cartesian_point | cartesian_point | boolean |
| cartesian_shape | cartesian_shape | boolean |
| date            | date            | boolean |
| date            | date_nanos      | boolean |
| date_nanos      | date            | boolean |
| date_nanos      | date_nanos      | boolean |
| double          | double          | boolean |
| double          | integer         | boolean |
| double          | long            | boolean |
| geo_point       | geo_point       | boolean |
| geo_shape       | geo_shape       | boolean |
| geohash         | geohash         | boolean |
| geohex          | geohex          | boolean |
| geotile         | geotile         | boolean |
| integer         | double          | boolean |
| integer         | integer         | boolean |
| integer         | long            | boolean |
| ip              | ip              | boolean |
| keyword         | keyword         | boolean |
| keyword         | text            | boolean |
| long            | double          | boolean |
| long            | integer         | boolean |
| long            | long            | boolean |
| text            | keyword         | boolean |
| text            | text            | boolean |
| unsigned_long   | unsigned_long   | boolean |
| version         | version         | boolean |


### Inequality `!=`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/not_equals.svg)

Check if two fields are unequal. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
<note>
  This is pushed to the underlying search index if one side of the comparison is constant and the other side is a field in the index that has both an [mapping-index](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-index) and [doc-values](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/doc-values).
</note>

**Supported types**

| lhs             | rhs             | result  |
|-----------------|-----------------|---------|
| boolean         | boolean         | boolean |
| cartesian_point | cartesian_point | boolean |
| cartesian_shape | cartesian_shape | boolean |
| date            | date            | boolean |
| date            | date_nanos      | boolean |
| date_nanos      | date            | boolean |
| date_nanos      | date_nanos      | boolean |
| double          | double          | boolean |
| double          | integer         | boolean |
| double          | long            | boolean |
| geo_point       | geo_point       | boolean |
| geo_shape       | geo_shape       | boolean |
| geohash         | geohash         | boolean |
| geohex          | geohex          | boolean |
| geotile         | geotile         | boolean |
| integer         | double          | boolean |
| integer         | integer         | boolean |
| integer         | long            | boolean |
| ip              | ip              | boolean |
| keyword         | keyword         | boolean |
| keyword         | text            | boolean |
| long            | double          | boolean |
| long            | integer         | boolean |
| long            | long            | boolean |
| text            | keyword         | boolean |
| text            | text            | boolean |
| unsigned_long   | unsigned_long   | boolean |
| version         | version         | boolean |


### Less than `<`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/less_than.svg)

Check if one field is less than another. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
<note>
  This is pushed to the underlying search index if one side of the comparison is constant and the other side is a field in the index that has both an [mapping-index](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-index) and [doc-values](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/doc-values).
</note>

**Supported types**

| lhs           | rhs           | result  |
|---------------|---------------|---------|
| date          | date          | boolean |
| date          | date_nanos    | boolean |
| date_nanos    | date          | boolean |
| date_nanos    | date_nanos    | boolean |
| double        | double        | boolean |
| double        | integer       | boolean |
| double        | long          | boolean |
| integer       | double        | boolean |
| integer       | integer       | boolean |
| integer       | long          | boolean |
| ip            | ip            | boolean |
| keyword       | keyword       | boolean |
| keyword       | text          | boolean |
| long          | double        | boolean |
| long          | integer       | boolean |
| long          | long          | boolean |
| text          | keyword       | boolean |
| text          | text          | boolean |
| unsigned_long | unsigned_long | boolean |
| version       | version       | boolean |


### Less than or equal to `<=`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/less_than_or_equal.svg)

Check if one field is less than or equal to another. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
<note>
  This is pushed to the underlying search index if one side of the comparison is constant and the other side is a field in the index that has both an [mapping-index](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-index) and [doc-values](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/doc-values).
</note>

**Supported types**

| lhs           | rhs           | result  |
|---------------|---------------|---------|
| date          | date          | boolean |
| date          | date_nanos    | boolean |
| date_nanos    | date          | boolean |
| date_nanos    | date_nanos    | boolean |
| double        | double        | boolean |
| double        | integer       | boolean |
| double        | long          | boolean |
| integer       | double        | boolean |
| integer       | integer       | boolean |
| integer       | long          | boolean |
| ip            | ip            | boolean |
| keyword       | keyword       | boolean |
| keyword       | text          | boolean |
| long          | double        | boolean |
| long          | integer       | boolean |
| long          | long          | boolean |
| text          | keyword       | boolean |
| text          | text          | boolean |
| unsigned_long | unsigned_long | boolean |
| version       | version       | boolean |


### Greater than `>`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/greater_than.svg)

Check if one field is greater than another. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
<note>
  This is pushed to the underlying search index if one side of the comparison is constant and the other side is a field in the index that has both an [mapping-index](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-index) and [doc-values](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/doc-values).
</note>

**Supported types**

| lhs           | rhs           | result  |
|---------------|---------------|---------|
| date          | date          | boolean |
| date          | date_nanos    | boolean |
| date_nanos    | date          | boolean |
| date_nanos    | date_nanos    | boolean |
| double        | double        | boolean |
| double        | integer       | boolean |
| double        | long          | boolean |
| integer       | double        | boolean |
| integer       | integer       | boolean |
| integer       | long          | boolean |
| ip            | ip            | boolean |
| keyword       | keyword       | boolean |
| keyword       | text          | boolean |
| long          | double        | boolean |
| long          | integer       | boolean |
| long          | long          | boolean |
| text          | keyword       | boolean |
| text          | text          | boolean |
| unsigned_long | unsigned_long | boolean |
| version       | version       | boolean |


### Greater than or equal to `>=`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/greater_than_or_equal.svg)

Check if one field is greater than or equal to another. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
<note>
  This is pushed to the underlying search index if one side of the comparison is constant and the other side is a field in the index that has both an [mapping-index](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-index) and [doc-values](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/doc-values).
</note>

**Supported types**

| lhs           | rhs           | result  |
|---------------|---------------|---------|
| date          | date          | boolean |
| date          | date_nanos    | boolean |
| date_nanos    | date          | boolean |
| date_nanos    | date_nanos    | boolean |
| double        | double        | boolean |
| double        | integer       | boolean |
| double        | long          | boolean |
| integer       | double        | boolean |
| integer       | integer       | boolean |
| integer       | long          | boolean |
| ip            | ip            | boolean |
| keyword       | keyword       | boolean |
| keyword       | text          | boolean |
| long          | double        | boolean |
| long          | integer       | boolean |
| long          | long          | boolean |
| text          | keyword       | boolean |
| text          | text          | boolean |
| unsigned_long | unsigned_long | boolean |
| version       | version       | boolean |


### Add `+`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/add.svg)

Add two numbers together. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
**Supported types**

| lhs           | rhs           | result        |
|---------------|---------------|---------------|
| date          | date_period   | date          |
| date          | time_duration | date          |
| date_nanos    | date_period   | date_nanos    |
| date_nanos    | time_duration | date_nanos    |
| date_period   | date          | date          |
| date_period   | date_nanos    | date_nanos    |
| date_period   | date_period   | date_period   |
| double        | double        | double        |
| double        | integer       | double        |
| double        | long          | double        |
| integer       | double        | double        |
| integer       | integer       | integer       |
| integer       | long          | long          |
| long          | double        | double        |
| long          | integer       | long          |
| long          | long          | long          |
| time_duration | date          | date          |
| time_duration | date_nanos    | date_nanos    |
| time_duration | time_duration | time_duration |
| unsigned_long | unsigned_long | unsigned_long |


### Subtract `-`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/sub.svg)

Subtract one number from another. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
**Supported types**

| lhs           | rhs           | result        |
|---------------|---------------|---------------|
| date          | date_period   | date          |
| date          | time_duration | date          |
| date_nanos    | date_period   | date_nanos    |
| date_nanos    | time_duration | date_nanos    |
| date_period   | date_nanos    | date_nanos    |
| date_period   | date_period   | date_period   |
| double        | double        | double        |
| double        | integer       | double        |
| double        | long          | double        |
| integer       | double        | double        |
| integer       | integer       | integer       |
| integer       | long          | long          |
| long          | double        | double        |
| long          | integer       | long          |
| long          | long          | long          |
| time_duration | date_nanos    | date_nanos    |
| time_duration | time_duration | time_duration |
| unsigned_long | unsigned_long | unsigned_long |


### Multiply `*`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/mul.svg)

Multiply two numbers together. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
**Supported types**

| lhs           | rhs           | result        |
|---------------|---------------|---------------|
| double        | double        | double        |
| double        | integer       | double        |
| double        | long          | double        |
| integer       | double        | double        |
| integer       | integer       | integer       |
| integer       | long          | long          |
| long          | double        | double        |
| long          | integer       | long          |
| long          | long          | long          |
| unsigned_long | unsigned_long | unsigned_long |


### Divide `/`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/div.svg)

Divide one number by another. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
<note>
  Division of two integer types will yield an integer result, rounding towards 0. If you need floating point division, [`Cast (::)`](#esql-cast-operator) one of the arguments to a `DOUBLE`.
</note>

**Supported types**

| lhs           | rhs           | result        |
|---------------|---------------|---------------|
| double        | double        | double        |
| double        | integer       | double        |
| double        | long          | double        |
| integer       | double        | double        |
| integer       | integer       | integer       |
| integer       | long          | long          |
| long          | double        | double        |
| long          | integer       | long          |
| long          | long          | long          |
| unsigned_long | unsigned_long | unsigned_long |


### Modulus `%`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/mod.svg)

Divide one number by another and return the remainder. If either field is [multivalued](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) then the result is `null`.
**Supported types**

| lhs           | rhs           | result        |
|---------------|---------------|---------------|
| double        | double        | double        |
| double        | integer       | double        |
| double        | long          | double        |
| integer       | double        | double        |
| integer       | integer       | integer       |
| integer       | long          | long          |
| long          | double        | double        |
| long          | integer       | long          |
| long          | long          | long          |
| unsigned_long | unsigned_long | unsigned_long |


## Unary operators

The only unary operator is negation (`-`):
**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/neg.svg)

**Supported types**

| field         | result        |
|---------------|---------------|
| date_period   | date_period   |
| double        | double        |
| integer       | integer       |
| long          | long          |
| time_duration | time_duration |


## Logical operators

The following logical operators are supported:
- `AND`
- `OR`
- `NOT`


## Suffix operators

- [`IS NULL`](#esql-is_null)
- [`IS NOT NULL`](#esql-is_not_null)


### `IS NULL`

For NULL comparison, use the `IS NULL` and `IS NOT NULL` predicates.
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/is_null.svg)

**Example**
```esql
FROM employees
| WHERE birth_date IS NULL
```


| first_name:keyword | last_name:keyword |
|--------------------|-------------------|
| Basil              | Tramer            |
| Florian            | Syrotiuk          |
| Lucien             | Rosenbaum         |


### `IS NOT NULL`

For NULL comparison, use the `IS NULL` and `IS NOT NULL` predicates.
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/is_not_null.svg)

**Example**
```esql
FROM employees
| WHERE is_rehired IS NOT NULL
| STATS COUNT(emp_no)
```


| COUNT(emp_no):long |
|--------------------|
| 84                 |


## Infix operators

- [Cast `::`](#esql-cast-operator)
- [`IN`](#esql-in-operator)
- [`LIKE`](#esql-like)
- [`RLIKE`](#esql-rlike)
- [Match `:`](#esql-match-operator) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>


### Cast (`::`)

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/cast.svg)

The `::` operator provides a convenient alternative syntax to the TO_<type> [conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions).
**Example**
```esql
ROW ver = CONCAT(("0"::INT + 1)::STRING, ".2.3")::VERSION
```


| ver:version |
|-------------|
| 1.2.3       |


### `IN`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/in.svg)

The `IN` operator allows testing whether a field or expression equals an element in a list of literals, fields or expressions.
**Example**
```esql
ROW a = 1, b = 4, c = 3
| WHERE c-a IN (3, b / 2, a)
```


| a:integer | b:integer | c:integer |
|-----------|-----------|-----------|
| 1         | 4         | 3         |


### `LIKE`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/like.svg)

Use `LIKE` to filter data based on string patterns using wildcards. `LIKE` usually acts on a field placed on the left-hand side of the operator, but it can also act on a constant (literal) expression. The right-hand side of the operator represents the pattern.
The following wildcard characters are supported:
- `*` matches zero or more characters.
- `?` matches one character.

**Supported types**

| str     | pattern | result  |
|---------|---------|---------|
| keyword | keyword | boolean |
| text    | keyword | boolean |

**Example**
```esql
FROM employees
| WHERE first_name LIKE """?b*"""
| KEEP first_name, last_name
```


| first_name:keyword | last_name:keyword |
|--------------------|-------------------|
| Ebbe               | Callaway          |
| Eberhardt          | Terkki            |

When used on `text` fields, `LIKE` treats the field as a `keyword` and does not use the analyzer.
This means the pattern matching is case-sensitive and must match the exact string indexed.
To perform full-text search, use the `MATCH` or `QSTR` functions.
Matching the exact characters `*` and `.` will require escaping.
The escape character is backslash `\`. Since also backslash is a special character in string literals,
it will require further escaping.
```esql
ROW message = "foo * bar"
| WHERE message LIKE "foo \\* bar"
```

To reduce the overhead of escaping, we suggest using triple quotes strings `"""`
```esql
ROW message = "foo * bar"
| WHERE message LIKE """foo \* bar"""
```

<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available since 9.1
</applies-to>

Both a single pattern or a list of patterns are supported. If a list of patterns is provided,
the expression will return true if any of the patterns match.
```esql
ROW message = "foobar"
| WHERE message like ("foo*", "bar?")
```

Patterns may be specified with REST query placeholders as well
```esql
FROM employees
| WHERE first_name LIKE ?pattern
| KEEP first_name, last_name
```

<applies-to>
  - Elastic Stack: Planned
</applies-to>


### `RLIKE`

![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/rlike.svg)

Use `RLIKE` to filter data based on string patterns using [regular expressions](https://www.elastic.co/docs/reference/query-languages/query-dsl/regexp-syntax). `RLIKE` usually acts on a field placed on the left-hand side of the operator, but it can also act on a constant (literal) expression. The right-hand side of the operator represents the pattern.
**Supported types**

| str     | pattern | result  |
|---------|---------|---------|
| keyword | keyword | boolean |
| text    | keyword | boolean |

**Example**
```esql
FROM employees
| WHERE first_name RLIKE """.leja.*"""
| KEEP first_name, last_name
```


| first_name:keyword | last_name:keyword |
|--------------------|-------------------|
| Alejandro          | McAlpine          |

When used on `text` fields, `RLIKE` treats the field as a `keyword` and does not use the analyzer.
This means the pattern matching is case-sensitive and must match the exact string indexed.
To perform full-text search, use the `MATCH` or `QSTR` functions.
Matching special characters (eg. `.`, `*`, `(`...) will require escaping.
The escape character is backslash `\`. Since also backslash is a special character in string literals,
it will require further escaping.
```esql
ROW message = "foo ( bar"
| WHERE message RLIKE "foo \\( bar"
```

To reduce the overhead of escaping, we suggest using triple quotes strings `"""`
```esql
ROW message = "foo ( bar"
| WHERE message RLIKE """foo \( bar"""
```

<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available since 9.2
</applies-to>

Both a single pattern or a list of patterns are supported. If a list of patterns is provided,
the expression will return true if any of the patterns match.
```esql
ROW message = "foobar"
| WHERE message RLIKE ("foo.*", "bar.")
```

Patterns may be specified with REST query placeholders as well
```esql
FROM employees
| WHERE first_name RLIKE ?pattern
| KEEP first_name, last_name
```

<applies-to>
  - Elastic Stack: Planned
</applies-to>


### Match operator (`:`)

<applies-to>
  - Elastic Stack: Generally available since 9.1
  - Elastic Stack: Preview in 9.0
</applies-to>

Use the match operator (`:`) to perform full-text search and filter rows that match a given query string.
**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/operators/match_operator.svg)

The match operator performs a [match query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-match-query) on the specified field. Returns true if the provided query matches the row.
The match operator is equivalent to the [match function](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match), which is the standard function for performing full-text search in ESQL.
For using the function syntax, or adding [match query parameters](/docs/reference/query-languages/query-dsl/query-dsl-match-query#match-field-params), you can use the [match function](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match).
**Supported types**

| field         | query         | result  |
|---------------|---------------|---------|
| boolean       | boolean       | boolean |
| boolean       | keyword       | boolean |
| date          | date          | boolean |
| date          | keyword       | boolean |
| date_nanos    | date_nanos    | boolean |
| date_nanos    | keyword       | boolean |
| double        | double        | boolean |
| double        | integer       | boolean |
| double        | keyword       | boolean |
| double        | long          | boolean |
| integer       | double        | boolean |
| integer       | integer       | boolean |
| integer       | keyword       | boolean |
| integer       | long          | boolean |
| ip            | ip            | boolean |
| ip            | keyword       | boolean |
| keyword       | keyword       | boolean |
| long          | double        | boolean |
| long          | integer       | boolean |
| long          | keyword       | boolean |
| long          | long          | boolean |
| text          | keyword       | boolean |
| unsigned_long | double        | boolean |
| unsigned_long | integer       | boolean |
| unsigned_long | keyword       | boolean |
| unsigned_long | long          | boolean |
| unsigned_long | unsigned_long | boolean |
| version       | keyword       | boolean |
| version       | version       | boolean |

**Examples**
The match operator can be used to perform full-text search on a `text` field. Notice how the match operator handles multi-valued columns, if a single value matches the query string, the expression evaluates to `TRUE`.
```esql
FROM books
| WHERE author:"Faulkner"
```


| book_no:keyword | author:text                                        |
|-----------------|----------------------------------------------------|
| 2378            | [Carol Faulkner, Holly Byers Ochoa, Lucretia Mott] |
| 2713            | William Faulkner                                   |
| 2847            | Colleen Faulkner                                   |
| 2883            | William Faulkner                                   |
| 3293            | Danny Faulkner                                     |

The match operator can also be used with `keyword` columns to filter multi-values.
```esql
FROM employees
| WHERE job_positions:"Internship"
| KEEP emp_no, job_positions
```


| emp_no:integer | job_positions:keyword                                                     |
|----------------|---------------------------------------------------------------------------|
| 10008          | [Internship, Junior Developer, Purchase Manager, Senior Python Developer] |
| 10009          | [Internship, Senior Python Developer]                                     |
| 10022          | [Data Scientist, Internship, Python Developer, Reporting Analyst]         |

This example illustrates how to do semantic search using the match operator on `semantic_text` fields. By including the metadata field `_score` and sorting on `_score`, we can retrieve the most relevant results in order.
```esql
FROM books METADATA _score
| WHERE semantic_title:"Shakespeare"
| SORT _score DESC
| KEEP _score, semantic_title
```


| _score:double | semantic_text_field:text |
|---------------|--------------------------|
| 9.5770        | Romeo and Juliet         |
| 9.6850        | Hamlet                   |
| 8.232         | Othello                  |﻿---
title: ES|QL tutorials
description: Use these hands-on tutorials to explore practical use cases with ES|QL: Get started with ES|QL queries: Learn the basic syntax of the language.Search...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-examples
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL tutorials
Use these hands-on tutorials to explore practical use cases with ES|QL:
- [Get started with ES|QL queries](https://www.elastic.co/docs/reference/query-languages/esql/esql-getting-started): Learn the basic syntax of the language.
- [Search and filter with ES|QL](https://www.elastic.co/docs/reference/query-languages/esql/esql-search-tutorial): Learn how to use ES|QL to search and filter data.
- [Threat hunting with ES|QL](https://www.elastic.co/docs/solutions/security/esql-for-security/esql-threat-hunting-tutorial): Learn how to use ES|QL for advanced threat hunting techniques and security analysis.﻿---
title: Use ES|QL across clusters
description: With ES|QL, you can execute a single query across multiple clusters. Cross-cluster search requires remote clusters. To set up remote clusters, see Remote...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-cross-clusters
products:
  - Elasticsearch
applies_to:
  - Elastic Cloud Serverless: Unavailable
  - Elastic Stack: Generally available since 9.1, Preview in 9.0
---

# Use ES|QL across clusters
With ES|QL, you can execute a single query across multiple clusters.

## Prerequisites

- Cross-cluster search requires remote clusters. To set up remote clusters, see [*Remote clusters*](https://www.elastic.co/docs/deploy-manage/remote-clusters).
  To ensure your remote cluster configuration supports cross-cluster search, see [Supported cross-cluster search configurations](https://www.elastic.co/docs/explore-analyze/cross-cluster-search#ccs-supported-configurations).
- For full cross-cluster search capabilities, the local and remote cluster must be on the same [subscription level](https://www.elastic.co/subscriptions).
- The local coordinating node must have the [`remote_cluster_client`](https://www.elastic.co/docs/deploy-manage/distributed-architecture/clusters-nodes-shards/node-roles#remote-node) node role.
- If you use [sniff mode](https://www.elastic.co/docs/deploy-manage/remote-clusters/remote-clusters-self-managed#sniff-mode), the local coordinating node must be able to connect to seed and gateway nodes on the remote cluster.
  We recommend using gateway nodes capable of serving as coordinating nodes. The seed nodes can be a subset of these gateway nodes.
- If you use [proxy mode](https://www.elastic.co/docs/deploy-manage/remote-clusters/remote-clusters-self-managed#proxy-mode), the local coordinating node must be able to connect to the configured `proxy_address`. The proxy at this address must be able to route connections to gateway and coordinating nodes on the remote cluster.
- Cross-cluster search requires different security privileges on the local cluster and remote cluster. See [Configure privileges for cross-cluster search](https://www.elastic.co/docs/deploy-manage/remote-clusters/remote-clusters-cert#remote-clusters-privileges-ccs) and [*Remote clusters*](https://www.elastic.co/docs/deploy-manage/remote-clusters).


## Security model

Elasticsearch supports two security models for cross-cluster search (CCS):
- [TLS certificate authentication](#esql-ccs-security-model-certificate)
- [API key authentication](#esql-ccs-security-model-api-key)

<tip>
  To check which security model is being used to connect your clusters, run `GET _remote/info`. If you’re using the API key authentication method, you’ll see the `"cluster_credentials"` key in the response.
</tip>


### TLS certificate authentication

<admonition title="Deprecated in 9.0.0.">
  Use [API key authentication](#esql-ccs-security-model-api-key) instead.
</admonition>

TLS certificate authentication secures remote clusters with mutual TLS. This could be the preferred model when a single administrator has full control over both clusters. We generally recommend that roles and their privileges be identical in both clusters.
Refer to [TLS certificate authentication](https://www.elastic.co/docs/deploy-manage/remote-clusters/remote-clusters-cert) for prerequisites and detailed setup instructions.

### API key authentication

The following information pertains to using ES|QL across clusters with the [**API key based security model**](https://www.elastic.co/docs/deploy-manage/remote-clusters/remote-clusters-api-key). You’ll need to follow the steps on that page for the **full setup instructions**. This page only contains additional information specific to ES|QL.
API key based cross-cluster search (CCS) enables more granular control over allowed actions between clusters. This may be the preferred model when you have different administrators for different clusters and want more control over who can access what data. In this model, cluster administrators must explicitly define the access given to clusters and users.
You will need to:
- Create an API key on the **remote cluster** using the [Create cross-cluster API key](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-security-create-cross-cluster-api-key) API or using the [Kibana API keys UI](https://www.elastic.co/docs/deploy-manage/api-keys/elasticsearch-api-keys).
- Add the API key to the keystore on the **local cluster**, as part of the steps in [configuring the local cluster](https://www.elastic.co/docs/deploy-manage/remote-clusters/remote-clusters-api-key#remote-clusters-security-api-key-local-actions). All cross-cluster requests from the local cluster are bound by the API key’s privileges.

Using ES|QL with the API key based security model requires some additional permissions that may not be needed when using the traditional query DSL based search. The following example API call creates a role that can query remote indices using ES|QL when using the API key based security model. The final privilege, `remote_cluster`, is required to allow remote enrich operations.
```json

{
  "cluster": ["cross_cluster_search"], <1>
  "indices": [
    {
      "names" : [""], <2>
      "privileges": ["read"]
    }
  ],
  "remote_indices": [ <3>
    {
      "names": [ "logs-*" ],
      "privileges": [ "read","read_cross_cluster" ], <4>
      "clusters" : ["my_remote_cluster"] <5>
    }
  ],
   "remote_cluster": [ <6>
        {
            "privileges": [
                "monitor_enrich"
            ],
            "clusters": [
                "my_remote_cluster"
            ]
        }
    ]
}
```

You will then need a user or API key with the permissions you created above. The following example API call creates a user with the `remote1` role.
```json

{
  "password" : "<PASSWORD>",
  "roles" : [ "remote1" ]
}
```

Remember that all cross-cluster requests from the local cluster are bound by the cross cluster API key’s privileges, which are controlled by the remote cluster’s administrator.
<tip>
  Cross cluster API keys created in versions prior to 8.15.0 will need to replaced or updated to add the new permissions required for ES|QL with ENRICH.
</tip>


## Remote cluster setup

Once the security model is configured, you can add remote clusters.
The following [cluster update settings](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-cluster-put-settings) API request adds three remote clusters: `cluster_one`, `cluster_two`, and `cluster_three`.
```json

{
  "persistent": {
    "cluster": {
      "remote": {
        "cluster_one": {
          "seeds": [
            "35.238.149.1:9300"
          ],
          "skip_unavailable": true
        },
        "cluster_two": {
          "seeds": [
            "35.238.149.2:9300"
          ],
          "skip_unavailable": false
        },
        "cluster_three": {  <1>
          "seeds": [
            "35.238.149.3:9300"
          ]
        }
      }
    }
  }
}
```


## Query across multiple clusters

In the `FROM` command, specify data streams and indices on remote clusters using the format `<remote_cluster_name>:<target>`. For instance, the following ES|QL request queries the `my-index-000001` index on a single remote cluster named `cluster_one`:
```esql
FROM cluster_one:my-index-000001
| LIMIT 10
```

Similarly, this ES|QL request queries the `my-index-000001` index from three clusters:
- The local ("querying") cluster
- Two remote clusters, `cluster_one` and `cluster_two`

```esql
FROM my-index-000001,cluster_one:my-index-000001,cluster_two:my-index-000001
| LIMIT 10
```

Likewise, this ES|QL request queries the `my-index-000001` index from all remote clusters (`cluster_one`, `cluster_two`, and `cluster_three`):
```esql
FROM *:my-index-000001
| LIMIT 10
```


## Cross-cluster metadata

Using the `"include_ccs_metadata": true` option, users can request that ESQL cross-cluster search responses include metadata about the search on each cluster (when the response format is JSON). Here we show an example using the async search endpoint. Cross-cluster search metadata is also present in the synchronous search endpoint response when requested. If the search returns partial results and there are partial shard or remote cluster failures, `_clusters` metadata containing the failures will be included in the response regardless of the `include_ccs_metadata` parameter.
```json

{
  "query": """
    FROM my-index-000001,cluster_one:my-index-000001,cluster_two:my-index*
    | STATS COUNT(http.response.status_code) BY user.id
    | LIMIT 2
  """,
  "include_ccs_metadata": true
}
```

Which returns:
```json
{
  "is_running": false,
  "took": 42,  
  "is_partial": false, 
  "columns" : [
    {
      "name" : "COUNT(http.response.status_code)",
      "type" : "long"
    },
    {
      "name" : "user.id",
      "type" : "keyword"
    }
  ],
  "values" : [
    [4, "elkbee"],
    [1, "kimchy"]
  ],
  "_clusters": {  
    "total": 3,
    "successful": 3,
    "running": 0,
    "skipped": 0,
    "partial": 0,
    "failed": 0,
    "details": { 
      "(local)": { 
        "status": "successful",
        "indices": "blogs",
        "took": 41,  
        "_shards": { 
          "total": 13,
          "successful": 13,
          "skipped": 0,
          "failed": 0
        }
      },
      "cluster_one": {
        "status": "successful",
        "indices": "cluster_one:my-index-000001",
        "took": 38,
        "_shards": {
          "total": 4,
          "successful": 4,
          "skipped": 0,
          "failed": 0
        }
      },
      "cluster_two": {
        "status": "successful",
        "indices": "cluster_two:my-index*",
        "took": 40,
        "_shards": {
          "total": 18,
          "successful": 18,
          "skipped": 1,
          "failed": 0
        }
      }
    }
  }
}
```

The cross-cluster metadata can be used to determine whether any data came back from a cluster. For instance, in the query below, the wildcard expression for `cluster-two` did not resolve to a concrete index (or indices). The cluster is, therefore, marked as *skipped* and the total number of shards searched is set to zero.
```json

{
  "query": """
    FROM cluster_one:my-index*,cluster_two:logs*
    | STATS COUNT(http.response.status_code) BY user.id
    | LIMIT 2
  """,
  "include_ccs_metadata": true
}
```

Which returns:
```json
{
  "is_running": false,
  "took": 55,
  "is_partial": true, 
  "columns": [
     ...
  ],
  "values": [
     ...
  ],
  "_clusters": {
    "total": 2,
    "successful": 1,
    "running": 0,
    "skipped": 1, 
    "partial": 0,
    "failed": 0,
    "details": {
      "cluster_one": {
        "status": "successful",
        "indices": "cluster_one:my-index*",
        "took": 38,
        "_shards": {
          "total": 4,
          "successful": 4,
          "skipped": 0,
          "failed": 0
        }
      },
      "cluster_two": {
        "status": "skipped", 
        "indices": "cluster_two:logs*",
        "took": 0,
        "_shards": {
          "total": 0, 
          "successful": 0,
          "skipped": 0,
          "failed": 0
        }
      }
    }
  }
}
```


## Enrich across clusters

Enrich in ES|QL across clusters operates similarly to [local enrich](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich). If the enrich policy and its enrich indices are consistent across all clusters, simply write the enrich command as you would without remote clusters. In this default mode, ES|QL can execute the enrich command on either the local cluster or the remote clusters, aiming to minimize computation or inter-cluster data transfer. Ensuring that the policy exists with consistent data on both the local cluster and the remote clusters is critical for ESQL to produce a consistent query result.
<tip>
  Enrich in ES|QL across clusters using the API key based security model was introduced in version **8.15.0**. Cross cluster API keys created in versions prior to 8.15.0 will need to replaced or updated to use the new required permissions. Refer to the example in the [API key authentication](#esql-ccs-security-model-api-key) section.
</tip>

In the following example, the enrich with `hosts` policy can be executed on either the local cluster or the remote cluster `cluster_one`.
```esql
FROM my-index-000001,cluster_one:my-index-000001
| ENRICH hosts ON ip
| LIMIT 10
```

Enrich with an ES|QL query against remote clusters only can also happen on the local cluster. This means the below query requires the `hosts` enrich policy to exist on the local cluster as well.
```esql
FROM cluster_one:my-index-000001,cluster_two:my-index-000001
| LIMIT 10
| ENRICH hosts ON ip
```


### Enrich with coordinator mode

ES|QL provides the enrich `_coordinator` mode to force ES|QL to execute the enrich command on the local cluster. This mode should be used when the enrich policy is not available on the remote clusters or maintaining consistency of enrich indices across clusters is challenging.
```esql
FROM my-index-000001,cluster_one:my-index-000001
| ENRICH _coordinator:hosts ON ip
| SORT host_name
| LIMIT 10
```

<important>
  Enrich with the `_coordinator` mode usually increases inter-cluster data transfer and workload on the local cluster.
</important>


### Enrich with remote mode

ES|QL also provides the enrich `_remote` mode to force ES|QL to execute the enrich command independently on each remote cluster where the target indices reside. This mode is useful for managing different enrich data on each cluster, such as detailed information of hosts for each region where the target (main) indices contain log events from these hosts.
In the below example, the `hosts` enrich policy is required to exist on all remote clusters: the `querying` cluster (as local indices are included), the remote cluster `cluster_one`, and `cluster_two`.
```esql
FROM my-index-000001,cluster_one:my-index-000001,cluster_two:my-index-000001
| ENRICH _remote:hosts ON ip
| SORT host_name
| LIMIT 10
```

A `_remote` enrich cannot be executed after a [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command. The following example would result in an error:
```esql
FROM my-index-000001,cluster_one:my-index-000001,cluster_two:my-index-000001
| STATS COUNT(*) BY ip
| ENRICH _remote:hosts ON ip
| SORT host_name
| LIMIT 10
```


### Multiple enrich commands

You can include multiple enrich commands in the same query with different modes. ES|QL will attempt to execute them accordingly. For example, this query performs two enriches, first with the `hosts` policy on any cluster and then with the `vendors` policy on the local cluster.
```esql
FROM my-index-000001,cluster_one:my-index-000001,cluster_two:my-index-000001
| ENRICH hosts ON ip
| ENRICH _coordinator:vendors ON os
| LIMIT 10
```

A `_remote` enrich command can’t be executed after a `_coordinator` enrich command. The following example would result in an error.
```esql
FROM my-index-000001,cluster_one:my-index-000001,cluster_two:my-index-000001
| ENRICH _coordinator:hosts ON ip
| ENRICH _remote:vendors ON os
| LIMIT 10
```


## Excluding clusters or indices from ES|QL query

To exclude an entire cluster, prefix the cluster alias with a minus sign in the `FROM` command, for example: `-my_cluster:*`:
```esql
FROM my-index-000001,cluster*:my-index-000001,-cluster_three:*
| LIMIT 10
```

To exclude a specific remote index, prefix the index with a minus sign in the `FROM` command, such as `my_cluster:-my_index`:
```esql
FROM my-index-000001,cluster*:my-index-*,cluster_three:-my-index-000001
| LIMIT 10
```


## Skipping problematic remote clusters

Cross-cluster search for ES|QL behavior when there are problems connecting to or running query on remote clusters differs between versions.
<applies-switch>
  <applies-item title="stack: ga 9.1+" applies-to="Elastic Stack: Generally available since 9.1">
    Remote clusters are configured with the `skip_unavailable: true` setting by default. With this setting, clusters are marked as `skipped` or `partial` rather than causing queries to fail in the following scenarios:
    - The remote cluster is disconnected from the querying cluster, either before or during the query execution.
    - The remote cluster does not have the requested index, or it is not accessible due to security settings.
    - An error happened while processing the query on the remote cluster.
    The `partial` status means the remote query either has errors or was interrupted by an explicit user action, but some data may be returned.Queries will still fail when `skip_unavailable` is set `true`, if none of the specified indices exist. For example, the
    following queries will fail:
    ```esql
    FROM cluster_one:missing-index | LIMIT 10
    FROM cluster_one:missing-index* | LIMIT 10
    FROM cluster_one:missing-index*,cluster_two:missing-index | LIMIT 10
    ```
  </applies-item>

  <applies-item title="stack: ga =9.0" applies-to="Elastic Stack: Generally available in 9.0">
    If a remote cluster disconnects from the querying cluster, cross-cluster search for ES|QL will set it to `skipped`
    and continue the query with other clusters, unless the remote cluster's `skip_unavailable` setting is set to `false`,
    in which case the query will fail.
  </applies-item>
</applies-switch>


## Query across clusters during an upgrade

You can still search a remote cluster while performing a rolling upgrade on the local cluster. However, the local coordinating node’s "upgrade from" and "upgrade to" version must be compatible with the remote cluster’s gateway node.
<warning>
  Running multiple versions of Elasticsearch in the same cluster beyond the duration of an upgrade is not supported.
</warning>

For more information about upgrades, see [Upgrading Elasticsearch](https://www.elastic.co/docs/deploy-manage/upgrade/deployment-or-cluster).﻿---
title: ES|QL RERANK command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/rerank
---

# ES|QL RERANK command
<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

The `RERANK` command uses an inference model to compute a new relevance score
for an initial set of documents, directly within your ESQL queries.
<important>
  **RERANK processes each row through an inference model, which impacts performance and costs.**
  <applies-switch>
    <applies-item title="stack: ga 9.3+" applies-to="Elastic Stack: Planned">
      `RERANK` automatically limits processing to **1000 rows by default** to prevent accidental high consumption. This limit is applied before the `RERANK` command executes.If you need to process more rows, you can adjust the limit using the cluster setting:
      ```
      PUT _cluster/settings
      {
        "persistent": {
          "esql.command.rerank.limit": 5000
        }
      }
      ```
      You can also disable the command entirely if needed:
      ```
      PUT _cluster/settings
      {
        "persistent": {
          "esql.command.rerank.enabled": false
        }
      }
      ```
    </applies-item>

    <applies-item title="stack: ga =9.2" applies-to="Elastic Stack: Generally available in 9.2">
      No automatic row limit is applied. **You should always use `LIMIT` before or after `RERANK` to control the number of documents processed**, to avoid accidentally reranking large datasets which can result in high latency and increased costs.For example:
      ```esql
      FROM books
      | WHERE title:"search query"
      | SORT _score DESC
      | LIMIT 100 
      | RERANK "search query" ON title WITH { "inference_id" : "my_rerank_endpoint" }
      ```
    </applies-item>
  </applies-switch>
</important>

**Syntax**
```esql
RERANK [column =] query ON field [, field, ...] [WITH { "inference_id" : "my_inference_endpoint" }]
```

**Parameters**
<definitions>
  <definition term="column">
    (Optional) The name of the output column containing the reranked scores.
    If not specified, the results will be stored in a column named `_score`.
    If the specified column already exists, it will be overwritten with the new
    results.
  </definition>
  <definition term="query">
    The query text used to rerank the documents. This is typically the same
    query used in the initial search.
  </definition>
  <definition term="field">
    One or more fields to use for reranking. These fields should contain the
    text that the reranking model will evaluate.
  </definition>
  <definition term="my_inference_endpoint">
    The ID of
    the [inference endpoint](https://www.elastic.co/docs/explore-analyze/elastic-inference/inference-api)
    to use for the task.
    The inference endpoint must be configured with the `rerank` task type.
  </definition>
</definitions>

**Description**
The `RERANK` command uses an inference model to compute a new relevance score
for an initial set of documents, directly within your ESQL queries.
Typically, you first use a `WHERE` clause with a function like `MATCH` to
retrieve an initial set of documents. This set is often sorted by `_score` and
reduced to the top results (for example, 100) using `LIMIT`. The `RERANK`
command then processes this smaller, refined subset, which is a good balance
between performance and accuracy.
**Requirements**
To use this command, you must deploy your reranking model in Elasticsearch as
an [inference endpoint](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-inference-put)
with the
task type `rerank`.

#### Handling timeouts

`RERANK` commands may time out when processing large datasets or complex
queries. The default timeout is 10 minutes, but you can increase this limit if
necessary.
How you increase the timeout depends on your deployment type:
<applies-switch>
  <applies-item title="ess:" applies-to="Elastic Cloud Hosted: Generally available">
    - You can adjust Elasticsearch settings in
      the [Elastic Cloud Console](https://www.elastic.co/docs/deploy-manage/deploy/elastic-cloud/edit-stack-settings)
    - You can also adjust the `search.default_search_timeout` cluster setting
      using [Kibana's Advanced settings](https://www.elastic.co/docs/reference/kibana/advanced-settings#kibana-search-settings)
  </applies-item>

  <applies-item title="self:" applies-to="Self-managed Elastic deployments: Generally available in 9.0+">
    - You can configure at the cluster level by setting
      `search.default_search_timeout` in `elasticsearch.yml` or updating
      via [Cluster Settings API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-cluster-put-settings)
    - You can also adjust the `search:timeout` setting
      using [Kibana's Advanced settings](https://www.elastic.co/docs/reference/kibana/advanced-settings#kibana-search-settings)
    - Alternatively, you can add timeout parameters to individual queries
  </applies-item>

  <applies-item title="serverless:" applies-to="Elastic Cloud Serverless: Generally available">
    - Requires a manual override from Elastic Support because you cannot modify
      timeout settings directly
  </applies-item>
</applies-switch>

If you don't want to increase the timeout limit, try the following:
- Reduce data volume with `LIMIT` or more selective filters before the `RERANK`
  command
- Split complex operations into multiple simpler queries
- Configure your HTTP client's response timeout (Refer
  to [HTTP client configuration](/docs/reference/elasticsearch/configuration-reference/networking-settings#_http_client_configuration))

**Examples**
Rerank search results using a simple query and a single field:
```esql
FROM books METADATA _score
| WHERE MATCH(description, "hobbit")
| SORT _score DESC
| LIMIT 100
| RERANK "hobbit" ON description WITH { "inference_id" : "test_reranker" }
| LIMIT 3
| KEEP title, _score
```


| title:text                        | _score:double         |
|-----------------------------------|-----------------------|
| Poems from the Hobbit             | 0.0015673980815336108 |
| The Lord of the Rings - Boxed Set | 0.0011135857785120606 |
| Letters of J R R Tolkien          | 0.0024999999441206455 |

Rerank search results using a query and multiple fields, and store the new score
in a column named `rerank_score`:
```esql
FROM books METADATA _score
| WHERE MATCH(description, "hobbit") OR MATCH(author, "Tolkien")
| SORT _score DESC
| LIMIT 100
| RERANK rerank_score = "hobbit" ON description, author WITH { "inference_id" : "test_reranker" }
| SORT rerank_score
| LIMIT 3
| KEEP title, _score, rerank_score
```


| title:text                                                       | _score:double      | rerank_score:double  |
|------------------------------------------------------------------|--------------------|----------------------|
| Return of the Shadow                                             | 3.4218082427978516 | 5.740527994930744E-4 |
| Return of the King Being the Third Part of The Lord of the Rings | 2.8398752212524414 | 9.000900317914784E-4 |
| The Lays of Beleriand                                            | 1.5629040002822876 | 9.36329597607255E-4  |

Combine the original score with the reranked score:
```esql
FROM books METADATA _score
| WHERE MATCH(description, "hobbit") OR MATCH(author, "Tolkien")
| SORT _score DESC
| LIMIT 100
| RERANK rerank_score = "hobbit" ON description, author WITH { "inference_id" : "test_reranker" }
| EVAL original_score = _score, _score = rerank_score + original_score
| SORT _score
| LIMIT 3
| KEEP title, original_score, rerank_score, _score
```


| title:text                                                       | _score:double      | rerank_score:double   | rerank_score:double  |
|------------------------------------------------------------------|--------------------|-----------------------|----------------------|
| Poems from the Hobbit                                            | 4.012462615966797  | 0.001396648003719747  | 0.001396648003719747 |
| The Lord of the Rings - Boxed Set                                | 3.768855094909668  | 0.0010020040208473802 | 0.001396648003719747 |
| Return of the King Being the Third Part of The Lord of the Rings | 3.6248698234558105 | 9.000900317914784E-4  | 0.001396648003719747 |﻿---
title: ES|QL FROM command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/from
---

# ES|QL FROM command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `FROM` source command returns a table with data from a data stream, index,
or alias.
**Syntax**
```esql
FROM index_pattern [METADATA fields]
```

**Parameters**
<definitions>
  <definition term="index_pattern">
    A list of indices, data streams or aliases. Supports wildcards and date math.
  </definition>
  <definition term="fields">
    A comma-separated list of [metadata fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-metadata-fields) to retrieve.
  </definition>
</definitions>

**Description**
The `FROM` source command returns a table with data from a data stream, index,
or alias. Each row in the resulting table represents a document. Each column
corresponds to a field, and can be accessed by the name of that field.
<note>
  By default, an ES|QL query without an explicit [`LIMIT`](#esql-limit) uses an implicit
  limit of 1000. This applies to `FROM` too. A `FROM` command without `LIMIT`:
  ```esql
  FROM employees
  ```
  is executed as:
  ```esql
  FROM employees
  | LIMIT 1000
  ```
</note>

**Examples**
```esql
FROM employees
```

You can use [date math](/docs/reference/elasticsearch/rest-apis/api-conventions#api-date-math-index-names) to refer to indices, aliases
and data streams. This can be useful for time series data, for example to access
today’s index:
```esql
FROM <logs-{now/d}>
```

Use comma-separated lists or wildcards to
[query multiple data streams, indices, or aliases](https://www.elastic.co/docs/reference/query-languages/esql/esql-multi-index):
```esql
FROM employees-00001,other-employees-*
```

Use the format `<remote_cluster_name>:<target>` to
[query data streams and indices on remote clusters](https://www.elastic.co/docs/reference/query-languages/esql/esql-cross-clusters):
```esql
FROM cluster_one:employees-00001,cluster_two:other-employees-*
```

Use the optional `METADATA` directive to enable
[metadata fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-metadata-fields):
```esql
FROM employees METADATA _id
```

Use enclosing double quotes (`"`) or three enclosing double quotes (`"""`) to escape index names
that contain special characters:
```esql
FROM "this=that", """this[that"""
```﻿---
title: Get started with ES|QL queries
description: This hands-on guide covers the basics of using ES|QL to query and aggregate your data. To follow along with the queries in this guide, you can either...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-getting-started
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Get started with ES|QL queries
This hands-on guide covers the basics of using ES|QL to query and aggregate your data.
<tip>
  This getting started is also available as an [interactive Python notebook](https://github.com/elastic/elasticsearch-labs/blob/main/notebooks/esql/esql-getting-started.ipynb) in the `elasticsearch-labs` GitHub repository.
</tip>


## Prerequisites

To follow along with the queries in this guide, you can either set up your own deployment, or use Elastic’s public ES|QL demo environment.
<tab-set>
  <tab-item title="Own deployment">
    First ingest some sample data. In Kibana, open the main menu and select **Dev Tools**. Run the following two requests:
    ```json

    {
      "mappings": {
        "properties": {
          "client_ip": {
            "type": "ip"
          },
          "message": {
            "type": "keyword"
          }
        }
      }
    }


    {"index": {}}
    {"@timestamp": "2023-10-23T12:15:03.360Z", "client_ip": "172.21.2.162", "message": "Connected to 10.1.0.3", "event_duration": 3450233}
    {"index": {}}
    {"@timestamp": "2023-10-23T12:27:28.948Z", "client_ip": "172.21.2.113", "message": "Connected to 10.1.0.2", "event_duration": 2764889}
    {"index": {}}
    {"@timestamp": "2023-10-23T13:33:34.937Z", "client_ip": "172.21.0.5", "message": "Disconnected", "event_duration": 1232382}
    {"index": {}}
    {"@timestamp": "2023-10-23T13:51:54.732Z", "client_ip": "172.21.3.15", "message": "Connection error", "event_duration": 725448}
    {"index": {}}
    {"@timestamp": "2023-10-23T13:52:55.015Z", "client_ip": "172.21.3.15", "message": "Connection error", "event_duration": 8268153}
    {"index": {}}
    {"@timestamp": "2023-10-23T13:53:55.832Z", "client_ip": "172.21.3.15", "message": "Connection error", "event_duration": 5033755}
    {"index": {}}
    {"@timestamp": "2023-10-23T13:55:01.543Z", "client_ip": "172.21.3.15", "message": "Connected to 10.1.0.1", "event_duration": 1756467}
    ```
  </tab-item>

  <tab-item title="Demo environment">
    The data set used in this guide has been preloaded into the Elastic ES|QL public demo environment. Visit [ela.st/ql](https://ela.st/ql) to start using it.
  </tab-item>
</tab-set>


## Run an ES|QL query

In Kibana, you can use Console or Discover to run ES|QL queries:
<tab-set>
  <tab-item title="Console">
    To get started with ES|QL in Console, open the main menu and select **Dev Tools**.The general structure of an [ES|QL query API](https://www.elastic.co/docs/api/doc/elasticsearch/group/endpoint-esql) request is:
    ```txt
    POST /_query?format=txt
    {
      "query": """

      """
    }
    ```
    Enter the actual ES|QL query between the two sets of triple quotes. For example:
    ```txt
    POST /_query?format=txt
    {
      "query": """
    FROM kibana_sample_data_logs
      """
    }
    ```
  </tab-item>

  <tab-item title="Discover">
    To get started with ES|QL in Discover, open the main menu and select **Discover**. Next, select **Try ESQL** from the application menu bar.Adjust the time filter so it includes the timestamps in the sample data (October 23rd, 2023).After switching to ES|QL mode, the query bar shows a sample query. You can replace this query with the queries in this getting started guide.You can adjust the editor’s height by dragging its bottom border to your liking.
  </tab-item>
</tab-set>


## Your first ES|QL query

Each ES|QL query starts with a [source command](https://www.elastic.co/docs/reference/query-languages/esql/commands/source-commands). A source command produces a table, typically with data from Elasticsearch.
![A source command producing a table from Elasticsearch](https://www.elastic.co/docs/reference/query-languages/images/elasticsearch-reference-source-command.svg)

The [`FROM`](https://www.elastic.co/docs/reference/query-languages/esql/commands/from) source command returns a table with documents from a data stream, index, or alias. Each row in the resulting table represents a document. This query returns up to 1000 documents from the `sample_data` index:
```esql
FROM sample_data
```

Each column corresponds to a field, and can be accessed by the name of that field.
<tip>
  ES|QL keywords are case-insensitive. The following query is identical to the previous one:
  ```esql
  from sample_data
  ```
</tip>


## Processing commands

A source command can be followed by one or more [processing commands](https://www.elastic.co/docs/reference/query-languages/esql/commands/processing-commands), separated by a pipe character: `|`. Processing commands change an input table by adding, removing, or changing rows and columns. Processing commands can perform filtering, projection, aggregation, and more.
![A processing command changing an input table](https://www.elastic.co/docs/reference/query-languages/images/elasticsearch-reference-esql-limit.png)

For example, you can use the [`LIMIT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/limit) command to limit the number of rows that are returned, up to a maximum of 10,000 rows:
```esql
FROM sample_data
| LIMIT 3
```

<tip>
  For readability, you can put each command on a separate line. However, you don’t have to. The following query is identical to the previous one:
  ```esql
  FROM sample_data | LIMIT 3
  ```
</tip>


### Sort a table

![A processing command sorting an input table](https://www.elastic.co/docs/reference/query-languages/images/elasticsearch-reference-esql-sort.png)

Another processing command is the [`SORT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/sort) command. By default, the rows returned by `FROM` don’t have a defined sort order. Use the `SORT` command to sort rows on one or more columns:
```esql
FROM sample_data
| SORT @timestamp DESC
```


### Query the data

Use the [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where) command to query the data. For example, to find all events with a duration longer than 5ms:
```esql
FROM sample_data
| WHERE event_duration > 5000000
```

`WHERE` supports several [operators](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/operators). For example, you can use [`LIKE`](/docs/reference/query-languages/esql/functions-operators/operators#esql-like) to run a wildcard query against the `message` column:
```esql
FROM sample_data
| WHERE message LIKE "Connected*"
```


### More processing commands

There are many other processing commands, like [`KEEP`](https://www.elastic.co/docs/reference/query-languages/esql/commands/keep) and [`DROP`](https://www.elastic.co/docs/reference/query-languages/esql/commands/drop) to keep or drop columns, [`ENRICH`](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich) to enrich a table with data from indices in Elasticsearch, and [`DISSECT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/dissect) and [`GROK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/grok) to process data. Refer to [Processing commands](https://www.elastic.co/docs/reference/query-languages/esql/commands/processing-commands) for an overview of all processing commands.

## Chain processing commands

You can chain processing commands, separated by a pipe character: `|`. Each processing command works on the output table of the previous command. The result of a query is the table produced by the final processing command.
![Processing commands can be chained](https://www.elastic.co/docs/reference/query-languages/images/elasticsearch-reference-esql-sort-limit.png)

The following example first sorts the table on `@timestamp`, and next limits the result set to 3 rows:
```esql
FROM sample_data
| SORT @timestamp DESC
| LIMIT 3
```

<note>
  The order of processing commands is important. First limiting the result set to 3 rows before sorting those 3 rows would most likely return a result that is different than this example, where the sorting comes before the limit.
</note>


## Compute values

Use the [`EVAL`](https://www.elastic.co/docs/reference/query-languages/esql/commands/eval) command to append columns to a table, with calculated values. For example, the following query appends a `duration_ms` column. The values in the column are computed by dividing `event_duration` by 1,000,000. In other words: `event_duration` converted from nanoseconds to milliseconds.
```esql
FROM sample_data
| EVAL duration_ms = event_duration/1000000.0
```

`EVAL` supports several [functions](https://www.elastic.co/docs/reference/query-languages/esql/commands/eval). For example, to round a number to the closest number with the specified number of digits, use the [`ROUND`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-round) function:
```esql
FROM sample_data
| EVAL duration_ms = ROUND(event_duration/1000000.0, 1)
```


## Calculate statistics

ES|QL can not only be used to query your data, you can also use it to aggregate your data. Use the [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command to calculate statistics. For example, the median duration:
```esql
FROM sample_data
| STATS median_duration = MEDIAN(event_duration)
```

You can calculate multiple stats with one command:
```esql
FROM sample_data
| STATS median_duration = MEDIAN(event_duration), max_duration = MAX(event_duration)
```

Use `BY` to group calculated stats by one or more columns. For example, to calculate the median duration per client IP:
```esql
FROM sample_data
| STATS median_duration = MEDIAN(event_duration) BY client_ip
```


## Access columns

You can access columns by their name. If a name contains special characters, [it needs to be quoted](/docs/reference/query-languages/esql/esql-syntax#esql-identifiers) with backticks (```).
Assigning an explicit name to a column created by `EVAL` or `STATS` is optional. If you don’t provide a name, the new column name is equal to the function expression. For example:
```esql
FROM sample_data
| EVAL event_duration/1000000.0
```

In this query, `EVAL` adds a new column named `event_duration/1000000.0`. Because its name contains special characters, to access this column, quote it with backticks:
```esql
FROM sample_data
| EVAL event_duration/1000000.0
| STATS MEDIAN(`event_duration/1000000.0`)
```


## Create a histogram

To track statistics over time, ES|QL enables you to create histograms using the [`BUCKET`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-bucket) function. `BUCKET` creates human-friendly bucket sizes and returns a value for each row that corresponds to the resulting bucket the row falls into.
Combine `BUCKET` with [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) to create a histogram. For example, to count the number of events per hour:
```esql
FROM sample_data
| STATS c = COUNT(*) BY bucket = BUCKET(@timestamp, 24, "2023-10-23T00:00:00Z", "2023-10-23T23:59:59Z")
```

Or the median duration per hour:
```esql
FROM sample_data
| KEEP @timestamp, event_duration
| STATS median_duration = MEDIAN(event_duration) BY bucket = BUCKET(@timestamp, 24, "2023-10-23T00:00:00Z", "2023-10-23T23:59:59Z")
```


## Enrich data

ES|QL enables you to [enrich](https://www.elastic.co/docs/reference/query-languages/esql/esql-enrich-data) a table with data from indices in Elasticsearch, using the [`ENRICH`](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich) command.
![esql enrich](https://www.elastic.co/docs/reference/query-languages/images/elasticsearch-reference-esql-enrich.png)

Before you can use `ENRICH`, you first need to [create](/docs/reference/query-languages/esql/esql-enrich-data#esql-create-enrich-policy) and [execute](/docs/reference/query-languages/esql/esql-enrich-data#esql-execute-enrich-policy) an [enrich policy](/docs/reference/query-languages/esql/esql-enrich-data#esql-enrich-policy).
<tab-set>
  <tab-item title="Own deployment">
    The following requests create and execute a policy called `clientip_policy`. The policy links an IP address to an environment ("Development", "QA", or "Production"):
    ```json

    {
      "mappings": {
        "properties": {
          "client_ip": {
            "type": "keyword"
          },
          "env": {
            "type": "keyword"
          }
        }
      }
    }


    { "index" : {}}
    { "client_ip": "172.21.0.5", "env": "Development" }
    { "index" : {}}
    { "client_ip": "172.21.2.113", "env": "QA" }
    { "index" : {}}
    { "client_ip": "172.21.2.162", "env": "QA" }
    { "index" : {}}
    { "client_ip": "172.21.3.15", "env": "Production" }
    { "index" : {}}
    { "client_ip": "172.21.3.16", "env": "Production" }


    {
      "match": {
        "indices": "clientips",
        "match_field": "client_ip",
        "enrich_fields": ["env"]
      }
    }
    ```
  </tab-item>

  <tab-item title="Demo environment">
    On the demo environment at [ela.st/ql](https://ela.st/ql/), an enrich policy called `clientip_policy` has already been created an executed. The policy links an IP address to an environment ("Development", "QA", or "Production").
  </tab-item>
</tab-set>

After creating and executing a policy, you can use it with the `ENRICH` command:
```esql
FROM sample_data
| KEEP @timestamp, client_ip, event_duration
| EVAL client_ip = TO_STRING(client_ip)
| ENRICH clientip_policy ON client_ip WITH env
```

You can use the new `env` column that’s added by the `ENRICH` command in subsequent commands. For example, to calculate the median duration per environment:
```esql
FROM sample_data
| KEEP @timestamp, client_ip, event_duration
| EVAL client_ip = TO_STRING(client_ip)
| ENRICH clientip_policy ON client_ip WITH env
| STATS median_duration = MEDIAN(event_duration) BY env
```

For more about data enrichment with ES|QL, refer to [Data enrichment](https://www.elastic.co/docs/reference/query-languages/esql/esql-enrich-data).

## Process data

Your data may contain unstructured strings that you want to [structure](https://www.elastic.co/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok) to make it easier to analyze the data. For example, the sample data contains log messages like:
```txt
"Connected to 10.1.0.3"
```

By extracting the IP address from these messages, you can determine which IP has accepted the most client connections.
To structure unstructured strings at query time, you can use the ES|QL [`DISSECT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/dissect) and [`GROK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/grok) commands. `DISSECT` works by breaking up a string using a delimiter-based pattern. `GROK` works similarly, but uses regular expressions. This makes `GROK` more powerful, but generally also slower.
In this case, no regular expressions are needed, as the `message` is straightforward: "Connected to ", followed by the server IP. To match this string, you can use the following `DISSECT` command:
```esql
FROM sample_data
| DISSECT message "Connected to %{server_ip}"
```

This adds a `server_ip` column to those rows that have a `message` that matches this pattern. For other rows, the value of `server_ip` is `null`.
You can use the new `server_ip` column that’s added by the `DISSECT` command in subsequent commands. For example, to determine how many connections each server has accepted:
```esql
FROM sample_data
| WHERE STARTS_WITH(message, "Connected to")
| DISSECT message "Connected to %{server_ip}"
| STATS COUNT(*) BY server_ip
```

For more about data processing with ES|QL, refer to [Data processing with DISSECT and GROK](https://www.elastic.co/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok).

## Learn more

- Explore the zero-setup, live [ES|QL demo environment](http://esql.demo.elastic.co/).
- Follow along with our hands-on tutorials:
  - [Search and filter with ES|QL](https://www.elastic.co/docs/reference/query-languages/esql/esql-search-tutorial): A hands-on tutorial that shows you how to use ES|QL to search and filter data.
- [Threat hunting with ES|QL](https://www.elastic.co/docs/solutions/security/esql-for-security/esql-threat-hunting-tutorial): A hands-on tutorial that shows you how to use ES|QL for advanced threat hunting techniques and security analysis.﻿---
title: ES|QL processing commands
description: ES|QL processing commands change an input table by adding, removing, or changing rows and columns. ES|QL supports these processing commands: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/processing-commands
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL processing commands
ES|QL processing commands change an input table by adding, removing, or changing rows and columns.
![A processing command changing an input table](https://www.elastic.co/docs/reference/query-languages/images/processing-command.svg)

ES|QL supports these processing commands:
- [`CHANGE_POINT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/change-point)
- [`COMPLETION`](https://www.elastic.co/docs/reference/query-languages/esql/commands/completion) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`DISSECT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/dissect)
- [`DROP`](https://www.elastic.co/docs/reference/query-languages/esql/commands/drop)
- [`ENRICH`](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich)
- [`EVAL`](https://www.elastic.co/docs/reference/query-languages/esql/commands/eval)
- [`GROK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/grok)
- [`FORK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fork) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`FUSE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fuse) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`KEEP`](https://www.elastic.co/docs/reference/query-languages/esql/commands/keep)
- [`LIMIT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/limit)
- [`LOOKUP JOIN`](https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join)
- [`INLINE STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/inlinestats-by)
- [`MV_EXPAND`](https://www.elastic.co/docs/reference/query-languages/esql/commands/mv_expand) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`RENAME`](https://www.elastic.co/docs/reference/query-languages/esql/commands/rename)
- [`RERANK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/rerank) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`SAMPLE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/sample) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`SORT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/sort)
- [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by)
- [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where)﻿---
title: ES|QL INLINE STATS command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/inlinestats-by
---

# ES|QL INLINE STATS command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Preview in 9.2
</applies-to>

The `INLINE STATS` processing command groups rows according to a common value
and calculates one or more aggregated values over the grouped rows. The results
are appended as new columns to the input rows.
The command is identical to [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) except that it preserves all the columns from the input table.
**Syntax**
```esql
INLINE STATS [column1 =] expression1 [WHERE boolean_expression1][,
      ...,
      [columnN =] expressionN [WHERE boolean_expressionN]]
      [BY [grouping_name1 =] grouping_expression1[,
          ...,
          [grouping_nameN = ] grouping_expressionN]]
```

**Parameters**
<definitions>
  <definition term="columnX">
    The name by which the aggregated value is returned. If omitted, the name is
    equal to the corresponding expression (`expressionX`).
    If multiple columns have the same name, all but the rightmost column with this
    name will be ignored.
  </definition>
  <definition term="expressionX">
    An expression that computes an aggregated value.
  </definition>
  <definition term="grouping_expressionX">
    An expression that outputs the values to group by.
    If its name coincides with one of the existing or computed columns, that column will be overridden by this one.
  </definition>
  <definition term="boolean_expressionX">
    The condition that determines which rows are included when evaluating `expressionX`.
  </definition>
</definitions>

<note>
  Individual `null` values are skipped when computing aggregations.
</note>

**Description**
The `INLINE STATS` processing command groups rows according to a common value
(also known as the grouping key), specified after `BY`, and calculates one or more
aggregated values over the grouped rows. The output table contains the same
number of rows as the input table. The command only adds new columns or overrides
existing columns with the same name as the result.
If column names overlap, existing column values may be overridden and column order
may change. The new columns are added/moved so that they appear in the order
they are defined in the `INLINE STATS` command.
For the calculation of each aggregated value, the rows in a group can be filtered with
`WHERE`. If `BY` is omitted the aggregations are applied over the entire dataset.
The following [aggregation functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/aggregation-functions) are supported:
- [`ABSENT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-absent) <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
- [`AVG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-avg)
- [`COUNT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-count)
- [`COUNT_DISTINCT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-count_distinct)
- [`MAX`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-max)
- [`MEDIAN`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-median)
- [`MEDIAN_ABSOLUTE_DEVIATION`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-median_absolute_deviation)
- [`MIN`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-min)
- [`PERCENTILE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-percentile)
- [`PRESENT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-present) <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
- [`SAMPLE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-sample)
- [`ST_CENTROID_AGG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-st_centroid_agg) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_EXTENT_AGG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-st_extent_agg) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`STD_DEV`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-std_dev)
- [`SUM`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-sum)
- [`TOP`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-top)
- [`VALUES`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-values) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`VARIANCE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-variance)
- [`WEIGHTED_AVG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-weighted_avg)

The following [grouping functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/grouping-functions) are supported:
- [`BUCKET`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-bucket)
- [`TBUCKET`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-tbucket)

**Examples**
The following example shows how to calculate a statistic on one column and group
by the values of another column.
<note>
  The `languages` column moves to the last position in the output table because it is
  a column overridden by the `INLINE STATS` command (it's the grouping key) and it is the last column defined by it.
</note>

```esql
FROM employees
| KEEP emp_no, languages, salary
| INLINE STATS max_salary = MAX(salary) BY languages
```


| emp_no:integer | salary:integer | max_salary:integer | languages:integer |
|----------------|----------------|--------------------|-------------------|
| 10001          | 57305          | 73578              | 2                 |
| 10002          | 56371          | 66817              | 5                 |
| 10003          | 61805          | 74572              | 4                 |
| 10004          | 36174          | 66817              | 5                 |
| 10005          | 63528          | 73717              | 1                 |

The following example shows how to calculate an aggregation over the entire dataset
by omitting `BY`. The order of the existing columns is preserved and a new column
with the calculated maximum salary value is added as the last column:
```esql
FROM employees
| KEEP emp_no, languages, salary
| INLINE STATS max_salary = MAX(salary)
```


| emp_no:integer | languages:integer | salary:integer | max_salary:integer |
|----------------|-------------------|----------------|--------------------|
| 10001          | 2                 | 57305          | 74999              |
| 10002          | 5                 | 56371          | 74999              |
| 10003          | 4                 | 61805          | 74999              |
| 10004          | 5                 | 36174          | 74999              |
| 10005          | 1                 | 63528          | 74999              |

The following example shows how to calculate multiple aggregations with multiple grouping keys:
```esql
FROM employees
| WHERE still_hired
| KEEP emp_no, languages, salary, hire_date
| EVAL tenure = DATE_DIFF("year", hire_date, "2025-09-18T00:00:00")
| DROP hire_date
| INLINE STATS avg_salary = AVG(salary), count = count(*) BY languages, tenure
```


| emp_no:integer | salary:integer | avg_salary:double | count:long | languages:integer | tenure:integer |
|----------------|----------------|-------------------|------------|-------------------|----------------|
| 10001          | 57305          | 51130.5           | 2          | 2                 | 39             |
| 10002          | 56371          | 40180.0           | 3          | 5                 | 39             |
| 10004          | 36174          | 30749.0           | 2          | 5                 | 38             |
| 10005          | 63528          | 63528.0           | 1          | 1                 | 36             |
| 10007          | 74572          | 58644.0           | 2          | 4                 | 36             |

The following example shows how to filter which rows are used for each aggregation, using the `WHERE` clause:
```esql
FROM employees
| KEEP emp_no, salary
| INLINE STATS avg_lt_50 = ROUND(AVG(salary)) WHERE salary < 50000,
               avg_lt_60 = ROUND(AVG(salary)) WHERE salary >=50000 AND salary < 60000,
               avg_gt_60 = ROUND(AVG(salary)) WHERE salary >= 60000
```


| emp_no:integer | salary:integer | avg_lt_50:double | avg_lt_60:double | avg_gt_60:double |
|----------------|----------------|------------------|------------------|------------------|
| 10001          | 57305          | 38292.0          | 54221.0          | 67286.0          |
| 10002          | 56371          | 38292.0          | 54221.0          | 67286.0          |
| 10003          | 61805          | 38292.0          | 54221.0          | 67286.0          |
| 10004          | 36174          | 38292.0          | 54221.0          | 67286.0          |
| 10005          | 63528          | 38292.0          | 54221.0          | 67286.0          |

**Limitations**
- The [`CATEGORIZE`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-categorize) grouping function is not currently supported.
- You cannot currently use [`LIMIT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/limit) (explicit or implicit) before `INLINE STATS`, because this can lead to unexpected results.
- You cannot currently use [`FORK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fork) before `INLINE STATS`, because `FORK` adds an implicit [`LIMIT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/limit) to each branch, which can lead to unexpected results.﻿---
title: ES|QL COMPLETION command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/completion
---

# ES|QL COMPLETION command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Preview from 9.1 to 9.2
</applies-to>

The `COMPLETION` command allows you to send prompts and context to a Large Language Model (LLM) directly within your ESQL queries, to perform text generation tasks.
<important>
  **Every row processed by the COMPLETION command generates a separate API call to the LLM endpoint.**
  <applies-switch>
    <applies-item title="stack: ga 9.3+" applies-to="Elastic Stack: Planned">
      `COMPLETION` automatically limits processing to **100 rows by default** to prevent accidental high consumption and costs. This limit is applied before the `COMPLETION` command executes.If you need to process more rows, you can adjust the limit using the cluster setting:
      ```
      PUT _cluster/settings
      {
        "persistent": {
          "esql.command.completion.limit": 500
        }
      }
      ```
      You can also disable the command entirely if needed:
      ```
      PUT _cluster/settings
      {
        "persistent": {
          "esql.command.completion.enabled": false
        }
      }
      ```
    </applies-item>

    <applies-item title="stack: ga 9.1-9.2" applies-to="Elastic Stack: Generally available from 9.1 to 9.2">
      Be careful to test with small datasets first before running on production data or in automated workflows, to avoid unexpected costs.Best practices:
      1. **Start with dry runs**: Validate your query logic and row counts by running without `COMPLETION` initially. Use `| STATS count = COUNT(*)` to check result size.
      2. **Filter first**: Use `WHERE` clauses to limit rows before applying `COMPLETION`.
      3. **Test with `LIMIT`**: Always start with a low [`LIMIT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/limit) and gradually increase.
      4. **Monitor usage**: Track your LLM API consumption and costs.
    </applies-item>
  </applies-switch>
</important>

**Syntax**
<applies-switch>
  <applies-item title="stack: ga 9.2+" applies-to="Elastic Stack: Generally available since 9.2">
    ```esql
    COMPLETION [column =] prompt WITH { "inference_id" : "my_inference_endpoint" }
    ```
  </applies-item>

  <applies-item title="stack: ga =9.1" applies-to="Elastic Stack: Generally available in 9.1">
    ```esql
    COMPLETION [column =] prompt WITH my_inference_endpoint
    ```
  </applies-item>
</applies-switch>

**Parameters**
<definitions>
  <definition term="column">
    (Optional) The name of the output column containing the LLM's response.
    If not specified, the results will be stored in a column named `completion`.
    If the specified column already exists, it will be overwritten with the new results.
  </definition>
  <definition term="prompt">
    The input text or expression used to prompt the LLM.
    This can be a string literal or a reference to a column containing text.
  </definition>
  <definition term="my_inference_endpoint">
    The ID of the [inference endpoint](https://www.elastic.co/docs/explore-analyze/elastic-inference/inference-api) to use for the task.
    The inference endpoint must be configured with the `completion` task type.
  </definition>
</definitions>

**Description**
The `COMPLETION` command provides a general-purpose interface for
text generation tasks using a Large Language Model (LLM) in ESQL.
`COMPLETION` supports a wide range of text generation tasks. Depending on your
prompt and the model you use, you can perform arbitrary text generation tasks
including:
- Question answering
- Summarization
- Translation
- Content rewriting
- Creative generation

**Requirements**
To use this command, you must deploy your LLM model in Elasticsearch as
an [inference endpoint](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-inference-put) with the
task type `completion`.

#### Handling timeouts

`COMPLETION` commands may time out when processing large datasets or complex prompts. The default timeout is 10 minutes, but you can increase this limit if necessary.
How you increase the timeout depends on your deployment type:
<applies-switch>
  <applies-item title="ess:" applies-to="Elastic Cloud Hosted: Generally available">
    - You can adjust Elasticsearch settings in the [Elastic Cloud Console](https://www.elastic.co/docs/deploy-manage/deploy/elastic-cloud/edit-stack-settings)
    - You can also adjust the `search.default_search_timeout` cluster setting using [Kibana's Advanced settings](https://www.elastic.co/docs/reference/kibana/advanced-settings#kibana-search-settings)
  </applies-item>

  <applies-item title="self:" applies-to="Self-managed Elastic deployments: Generally available in 9.0+">
    - You can configure at the cluster level by setting `search.default_search_timeout` in `elasticsearch.yml` or updating via [Cluster Settings API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-cluster-put-settings)
    - You can also adjust the `search:timeout` setting using [Kibana's Advanced settings](https://www.elastic.co/docs/reference/kibana/advanced-settings#kibana-search-settings)
    - Alternatively, you can add timeout parameters to individual queries
  </applies-item>

  <applies-item title="serverless:" applies-to="Elastic Cloud Serverless: Generally available">
    - Requires a manual override from Elastic Support because you cannot modify timeout settings directly
  </applies-item>
</applies-switch>

If you don't want to increase the timeout limit, try the following:
- Reduce data volume with `LIMIT` or more selective filters before the `COMPLETION` command
- Split complex operations into multiple simpler queries
- Configure your HTTP client's response timeout (Refer to [HTTP client configuration](/docs/reference/elasticsearch/configuration-reference/networking-settings#_http_client_configuration))

**Examples**
Use the default column name (results stored in `completion` column):
```esql
ROW question = "What is Elasticsearch?"
| COMPLETION question WITH { "inference_id" : "my_inference_endpoint" }
| KEEP question, completion
```


| question:keyword       | completion:keyword                        |
|------------------------|-------------------------------------------|
| What is Elasticsearch? | A distributed search and analytics engine |

Specify the output column (results stored in `answer` column):
```esql
ROW question = "What is Elasticsearch?"
| COMPLETION answer = question WITH { "inference_id" : "my_inference_endpoint" }
| KEEP question, answer
```


| question:keyword       | answer:keyword                            |
|------------------------|-------------------------------------------|
| What is Elasticsearch? | A distributed search and analytics engine |

Summarize the top 10 highest-rated movies using a prompt:
```esql
FROM movies
| SORT rating DESC
| LIMIT 10
| EVAL prompt = CONCAT(
   "Summarize this movie using the following information: \n",
   "Title: ", title, "\n",
   "Synopsis: ", synopsis, "\n",
   "Actors: ", MV_CONCAT(actors, ", "), "\n",
  )
| COMPLETION summary = prompt WITH { "inference_id" : "my_inference_endpoint" }
| KEEP title, summary, rating
```


| title:keyword            | summary:keyword                                  | rating:double |
|--------------------------|--------------------------------------------------|---------------|
| The Shawshank Redemption | A tale of hope and redemption in prison.         | 9.3           |
| The Godfather            | A mafia family's rise and fall.                  | 9.2           |
| The Dark Knight          | Batman battles the Joker in Gotham.              | 9.0           |
| Pulp Fiction             | Interconnected crime stories with dark humor.    | 8.9           |
| Fight Club               | A man starts an underground fight club.          | 8.8           |
| Inception                | A thief steals secrets through dreams.           | 8.8           |
| The Matrix               | A hacker discovers reality is a simulation.      | 8.7           |
| Parasite                 | Class conflict between two families.             | 8.6           |
| Interstellar             | A team explores space to save humanity.          | 8.6           |
| The Prestige             | Rival magicians engage in dangerous competition. | 8.5           |﻿---
title: Use ES|QL to query multiple indices
description: With ES|QL, you can execute a single query across multiple indices, data streams, or aliases. To do so, use wildcards and date arithmetic. The following...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-multi-index
products:
  - Elasticsearch
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Use ES|QL to query multiple indices
With ES|QL, you can execute a single query across multiple indices, data streams, or aliases. To do so, use wildcards and date arithmetic. The following example uses a comma-separated list and a wildcard:
```esql
FROM employees-00001,other-employees-*
```

Use the format `<remote_cluster_name>:<target>` to [query data streams and indices on remote clusters](https://www.elastic.co/docs/reference/query-languages/esql/esql-cross-clusters):
```esql
FROM cluster_one:employees-00001,cluster_two:other-employees-*
```


## Field type mismatches

When querying multiple indices, data streams, or aliases, you might find that the same field is mapped to multiple different types. For example, consider the two indices with the following field mappings:
**index: events_ip**
```
{
  "mappings": {
    "properties": {
      "@timestamp":     { "type": "date" },
      "client_ip":      { "type": "ip" },
      "event_duration": { "type": "long" },
      "message":        { "type": "keyword" }
    }
  }
}
```

**index: events_keyword**
```
{
  "mappings": {
    "properties": {
      "@timestamp":     { "type": "date" },
      "client_ip":      { "type": "keyword" },
      "event_duration": { "type": "long" },
      "message":        { "type": "keyword" }
    }
  }
}
```

When you query each of these individually with a simple query like `FROM events_ip`, the results are provided with type-specific columns:
```esql
FROM events_ip
| SORT @timestamp DESC
```


| @timestamp:date          | client_ip:ip | event_duration:long | message:keyword       |
|--------------------------|--------------|---------------------|-----------------------|
| 2023-10-23T13:55:01.543Z | 172.21.3.15  | 1756467             | Connected to 10.1.0.1 |
| 2023-10-23T13:53:55.832Z | 172.21.3.15  | 5033755             | Connection error      |
| 2023-10-23T13:52:55.015Z | 172.21.3.15  | 8268153             | Connection error      |

Note how the `client_ip` column is correctly identified as type `ip`, and all values are displayed. However, if instead the query sources two conflicting indices with `FROM events_*`, the type of the `client_ip` column cannot be determined and is reported as `unsupported` with all values returned as `null`.

```esql
FROM events_*
| SORT @timestamp DESC
```


| @timestamp:date          | client_ip:unsupported | event_duration:long | message:keyword       |
|--------------------------|-----------------------|---------------------|-----------------------|
| 2023-10-23T13:55:01.543Z | null                  | 1756467             | Connected to 10.1.0.1 |
| 2023-10-23T13:53:55.832Z | null                  | 5033755             | Connection error      |
| 2023-10-23T13:52:55.015Z | null                  | 8268153             | Connection error      |
| 2023-10-23T13:51:54.732Z | null                  | 725448              | Connection error      |
| 2023-10-23T13:33:34.937Z | null                  | 1232382             | Disconnected          |
| 2023-10-23T12:27:28.948Z | null                  | 2764889             | Connected to 10.1.0.2 |
| 2023-10-23T12:15:03.360Z | null                  | 3450233             | Connected to 10.1.0.3 |

In addition, if the query refers to this unsupported field directly, the query fails:
```esql
FROM events_*
| SORT client_ip DESC
```

```bash
Cannot use field [client_ip] due to ambiguities being mapped as
[2] incompatible types:
    [ip] in [events_ip],
    [keyword] in [events_keyword]
```


## Union types

<warning>
  This functionality is in technical preview and may be changed or removed in a future release. Elastic will work to fix any issues, but features in technical preview are not subject to the support SLA of official GA features.
</warning>

ES|QL has a way to handle [field type mismatches](#esql-multi-index-invalid-mapping). When the same field is mapped to multiple types in multiple indices, the type of the field is understood to be a *union* of the various types in the index mappings. As seen in the preceding examples, this *union type* cannot be used in the results, and cannot be referred to by the query — except in `KEEP`, `DROP` or when it’s passed to a type conversion function that accepts all the types in the *union* and converts the field to a single type. ES|QL offers a suite of [type conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions) to achieve this.
In the above examples, the query can use a command like `EVAL client_ip = TO_IP(client_ip)` to resolve the union of `ip` and `keyword` to just `ip`. You can also use the type-conversion syntax `EVAL client_ip = client_ip::IP`. Alternatively, the query could use [`TO_STRING`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_string) to convert all supported types into `KEYWORD`.
For example, the [query](#query-unsupported) that returned `client_ip:unsupported` with `null` values can be improved using the `TO_IP` function or the equivalent `field::ip` syntax. These changes also resolve the error message. As long as the only reference to the original field is to pass it to a conversion function that resolves the type ambiguity, no error results.
```esql
FROM events_*
| EVAL client_ip = TO_IP(client_ip)
| KEEP @timestamp, client_ip, event_duration, message
| SORT @timestamp DESC
```


| @timestamp:date          | client_ip:ip | event_duration:long | message:keyword       |
|--------------------------|--------------|---------------------|-----------------------|
| 2023-10-23T13:55:01.543Z | 172.21.3.15  | 1756467             | Connected to 10.1.0.1 |
| 2023-10-23T13:53:55.832Z | 172.21.3.15  | 5033755             | Connection error      |
| 2023-10-23T13:52:55.015Z | 172.21.3.15  | 8268153             | Connection error      |
| 2023-10-23T13:51:54.732Z | 172.21.3.15  | 725448              | Connection error      |
| 2023-10-23T13:33:34.937Z | 172.21.0.5   | 1232382             | Disconnected          |
| 2023-10-23T12:27:28.948Z | 172.21.2.113 | 2764889             | Connected to 10.1.0.2 |
| 2023-10-23T12:15:03.360Z | 172.21.2.162 | 3450233             | Connected to 10.1.0.3 |


### Date and date_nanos union type

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

When the type of an ES|QL field is a *union* of `date` and `date_nanos` across different indices, ES|QL automatically casts all values to the `date_nanos` type during query execution. This implicit casting ensures that all values are handled with nanosecond precision, regardless of their original type. As a result, users can write queries against such fields without needing to perform explicit type conversions, and the query engine will seamlessly align the types for consistent and precise results.
`date_nanos` fields offer higher precision but have a narrower range of valid values compared to `date` fields. This limits their representable dates roughly from 1970 to 2262. This is because dates are stored as a `long` representing nanoseconds since the epoch. When a field is mapped as both `date` and `date_nanos` across different indices, ES|QL defaults to the more precise `date_nanos` type. This behavior ensures that no precision is lost when querying multiple indices with differing date field types. For dates that fall outside the valid range of `date_nanos` in fields that are mapped to both `date` and `date_nanos` across different indices, ES|QL returns null by default. However, users can explicitly cast these fields to the `date` type to obtain a valid value, with precision limited to milliseconds.
For example, if the `@timestamp` field is mapped as `date` in one index and `date_nanos` in another, ES|QL will automatically treat all `@timestamp` values as `date_nanos` during query execution. This allows users to write queries that utilize the `@timestamp` field without encountering type mismatch errors, ensuring accurate time-based operations and comparisons across the combined dataset.
**index: events_date**
```
{
  "mappings": {
    "properties": {
      "@timestamp":     { "type": "date" },
      "client_ip":      { "type": "ip" },
      "event_duration": { "type": "long" },
      "message":        { "type": "keyword" }
    }
  }
}
```

**index: events_date_nanos**
```
{
  "mappings": {
    "properties": {
      "@timestamp":     { "type": "date_nanos" },
      "client_ip":      { "type": "ip" },
      "event_duration": { "type": "long" },
      "message":        { "type": "keyword" }
    }
  }
}
```

```esql
FROM events_date*
| EVAL date = @timestamp::date
| KEEP @timestamp, date, client_ip, event_duration, message
| SORT date
```


| @timestamp:date_nanos          | date:date                | client_ip:ip | event_duration:long | message:keyword       |
|--------------------------------|--------------------------|--------------|---------------------|-----------------------|
| null                           | 1969-10-23T13:33:34.937Z | 172.21.0.5   | 1232382             | Disconnected          |
| 2023-10-23T12:15:03.360Z       | 2023-10-23T12:15:03.360Z | 172.21.2.162 | 3450233             | Connected to 10.1.0.3 |
| 2023-10-23T12:15:03.360103847Z | 2023-10-23T12:15:03.360Z | 172.22.2.162 | 3450233             | Connected to 10.1.0.3 |
| 2023-10-23T12:27:28.948Z       | 2023-10-23T12:27:28.948Z | 172.22.2.113 | 2764889             | Connected to 10.1.0.2 |
| 2023-10-23T12:27:28.948Z       | 2023-10-23T12:27:28.948Z | 172.21.2.113 | 2764889             | Connected to 10.1.0.2 |
| 2023-10-23T13:33:34.937193Z    | 2023-10-23T13:33:34.937Z | 172.22.0.5   | 1232382             | Disconnected          |
| null                           | 2263-10-23T13:51:54.732Z | 172.21.3.15  | 725448              | Connection error      |


## Index metadata

It can be helpful to know the particular index from which each row is sourced. To get this information, use the [`METADATA`](https://www.elastic.co/docs/reference/query-languages/esql/esql-metadata-fields) option on the [`FROM`](https://www.elastic.co/docs/reference/query-languages/esql/commands/from) command.
```esql
FROM events_* METADATA _index
| EVAL client_ip = TO_IP(client_ip)
| KEEP _index, @timestamp, client_ip, event_duration, message
| SORT @timestamp DESC
```


| _index:keyword | @timestamp:date          | client_ip:ip | event_duration:long | message:keyword       |
|----------------|--------------------------|--------------|---------------------|-----------------------|
| events_ip      | 2023-10-23T13:55:01.543Z | 172.21.3.15  | 1756467             | Connected to 10.1.0.1 |
| events_ip      | 2023-10-23T13:53:55.832Z | 172.21.3.15  | 5033755             | Connection error      |
| events_ip      | 2023-10-23T13:52:55.015Z | 172.21.3.15  | 8268153             | Connection error      |
| events_keyword | 2023-10-23T13:51:54.732Z | 172.21.3.15  | 725448              | Connection error      |
| events_keyword | 2023-10-23T13:33:34.937Z | 172.21.0.5   | 1232382             | Disconnected          |
| events_keyword | 2023-10-23T12:27:28.948Z | 172.21.2.113 | 2764889             | Connected to 10.1.0.2 |
| events_keyword | 2023-10-23T12:15:03.360Z | 172.21.2.162 | 3450233             | Connected to 10.1.0.3 |﻿---
title: ES|QL metadata fields
description: ES|QL can access metadata fields. To access these fields, use the METADATA directive with the FROM source command. For example: The following metadata...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-metadata-fields
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL metadata fields
ES|QL can access [metadata fields](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/document-metadata-fields).
To access these fields, use the `METADATA` directive with the [`FROM`](https://www.elastic.co/docs/reference/query-languages/esql/commands/from) source command. For example:
```esql
FROM index METADATA _index, _id
```


## Available metadata fields

The following metadata fields are available in ES|QL:

| Metadata field                                                                                            | Type                                                                                     | Description                                                                                                                                                                                               |
|-----------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [`_id`](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-id-field)           | [keyword](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/keyword) | Unique document ID.                                                                                                                                                                                       |
| [`_ignored`](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-ignored-field) | [keyword](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/keyword) | Names every field in a document that was ignored when the document was indexed.                                                                                                                           |
| [`_index`](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-index-field)     | [keyword](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/keyword) | Index name.                                                                                                                                                                                               |
| `_index_mode`                                                                                             | [keyword](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/keyword) | [Index mode](/docs/reference/elasticsearch/index-settings/index-modules#index-mode-setting). For example: `standard`, `lookup`, or `logsdb`.                                                              |
| `_score`                                                                                                  | [`float`](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/number)  | Query relevance score (when enabled). Scores are updated when using [full text search functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/search-functions).        |
| [`_source`](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-source-field)   | Special `_source` type                                                                   | Original JSON document body passed at index time (or a reconstructed version if [synthetic `_source`](/docs/reference/elasticsearch/mapping-reference/mapping-source-field#synthetic-source) is enabled). |
| `_version`                                                                                                | [`long`](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/number)   | Document version number                                                                                                                                                                                   |


## Usage and limitations

- Metadata fields are only available when the data source is an index
- The `_source` type is not supported by functions
- Only the `FROM` command supports the `METADATA` directive
- Once enabled, metadata fields work like regular index fields


## Examples


### Basic metadata usage

Once enabled, metadata fields are available to subsequent processing commands, just like other index fields:
```esql
FROM ul_logs, apps METADATA _index, _version
| WHERE id IN (13, 14) AND _version == 1
| EVAL key = CONCAT(_index, "_", TO_STR(id))
| SORT id, _index
| KEEP id, _index, _version, key
```


| id:long | _index:keyword | _version:long | key:keyword |
|---------|----------------|---------------|-------------|
| 13      | apps           | 1             | apps_13     |
| 13      | ul_logs        | 1             | ul_logs_13  |
| 14      | apps           | 1             | apps_14     |
| 14      | ul_logs        | 1             | ul_logs_14  |


### Metadata fields and aggregations

Similar to index fields, once an aggregation is performed, a metadata field will no longer be accessible to subsequent commands, unless used as a grouping field:
```esql
FROM employees METADATA _index, _id
| STATS max = MAX(emp_no) BY _index
```


| max:integer | _index:keyword |
|-------------|----------------|
| 10100       | employees      |


### Sort results by search score

```esql
FROM products METADATA _score
| WHERE MATCH(description, "wireless headphones")
| SORT _score DESC
| KEEP name, description, _score
```

<tip>
  Refer to [ES|QL for search](https://www.elastic.co/docs/solutions/search/esql-for-search#esql-for-search-scoring) for more information on relevance scoring and how to use `_score` in your queries.
</tip>﻿---
title: ES|QL string functions
description: ES|QL supports these string functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/string-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL string functions
ES|QL supports these string functions:
- [`BIT_LENGTH`](#esql-bit_length)
- [`BYTE_LENGTH`](#esql-byte_length)
- [`CHUNK`](#esql-chunk)
- [`CONCAT`](#esql-concat)
- [`CONTAINS`](#esql-contains)
- [`ENDS_WITH`](#esql-ends_with)
- [`FROM_BASE64`](#esql-from_base64)
- [`HASH`](#esql-hash)
- [`LEFT`](#esql-left)
- [`LENGTH`](#esql-length)
- [`LOCATE`](#esql-locate)
- [`LTRIM`](#esql-ltrim)
- [`MD5`](#esql-md5)
- [`REPEAT`](#esql-repeat)
- [`REPLACE`](#esql-replace)
- [`REVERSE`](#esql-reverse)
- [`RIGHT`](#esql-right)
- [`RTRIM`](#esql-rtrim)
- [`SHA1`](#esql-sha1)
- [`SHA256`](#esql-sha256)
- [`SPACE`](#esql-space)
- [`SPLIT`](#esql-split)
- [`STARTS_WITH`](#esql-starts_with)
- [`SUBSTRING`](#esql-substring)
- [`TO_BASE64`](#esql-to_base64)
- [`TO_LOWER`](#esql-to_lower)
- [`TO_UPPER`](#esql-to_upper)
- [`TRIM`](#esql-trim)
- [`URL_ENCODE`](#esql-url_encode)
- [`URL_ENCODE_COMPONENT`](#esql-url_encode_component)
- [`URL_DECODE`](#esql-url_decode)


## `BIT_LENGTH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/bit_length.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the bit length of a string.
<note>
  All strings are in UTF-8, so a single character can use multiple bytes.
</note>

**Supported types**

| string  | result  |
|---------|---------|
| keyword | integer |
| text    | integer |

**Example**
```esql
FROM airports
| WHERE country == "India"
| KEEP city
| EVAL fn_length = LENGTH(city), fn_bit_length = BIT_LENGTH(city)
```


| city:keyword | fn_length:integer | fn_bit_length:integer |
|--------------|-------------------|-----------------------|
| Agwār        | 5                 | 48                    |
| Ahmedabad    | 9                 | 72                    |
| Bangalore    | 9                 | 72                    |


## `BYTE_LENGTH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/byte_length.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the byte length of a string.
<note>
  All strings are in UTF-8, so a single character can use multiple bytes.
</note>

**Supported types**

| string  | result  |
|---------|---------|
| keyword | integer |
| text    | integer |

**Example**
```esql
FROM airports
| WHERE country == "India"
| KEEP city
| EVAL fn_length = LENGTH(city), fn_byte_length = BYTE_LENGTH(city)
```


| city:keyword | fn_length:integer | fn_byte_length:integer |
|--------------|-------------------|------------------------|
| Agwār        | 5                 | 6                      |
| Ahmedabad    | 9                 | 9                      |
| Bangalore    | 9                 | 9                      |


## `CHUNK`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/chunk.svg)

**Parameters**
<definitions>
  <definition term="field">
    The input to chunk.
  </definition>
  <definition term="chunking_settings">
    Options to customize chunking behavior. Defaults to {"strategy":"sentence","max_chunk_size":300,"sentence_overlap":0}.
  </definition>
</definitions>

**Description**
Use `CHUNK` to split a text field into smaller chunks.
Chunk can be used on fields from the text famiy like [text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/text) and [semantic_text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/semantic-text).
Chunk will split a text field into smaller chunks, using a sentence-based chunking strategy.
The number of chunks returned, and the length of the sentences used to create the chunks can be specified.
**Supported types**

| field   | chunking_settings | result  |
|---------|-------------------|---------|
| keyword | named parameters  | keyword |
| keyword |                   | keyword |
| text    | named parameters  | keyword |
| text    |                   | keyword |

**Supported function named parameters**
<definitions>
  <definition term="separator_group">
    (keyword) Sets a predefined lists of separators based on the selected text type. Values may be `markdown` or `plaintext`.
    Only applicable to the `recursive` chunking strategy. When using the `recursive` chunking strategy one of
    `separators` or `separator_group` must be specified.
  </definition>
  <definition term="overlap">
    (integer) The number of overlapping words for chunks. It is applicable only to a `word` chunking strategy.
    This value cannot be higher than half the `max_chunk_size` value.
  </definition>
  <definition term="sentence_overlap">
    (integer) The number of overlapping sentences for chunks. It is applicable only for a `sentence` chunking strategy.
    It can be either `1` or `0`.
  </definition>
  <definition term="strategy">
    (keyword) The chunking strategy to use. Default value is `sentence`.
  </definition>
  <definition term="max_chunk_size">
    (integer) The maximum size of a chunk in words. This value cannot be lower than `20` (for `sentence` strategy)
    or `10` (for `word` or `recursive` strategies). This model should not exceed the window size for any
    associated models using the output of this function.
  </definition>
  <definition term="separators">
    (keyword) A list of strings used as possible split points when chunking text. Each string can be a plain string or a
    regular expression (regex) pattern. The system tries each separator in order to split the text, starting from
    the first item in the list. After splitting, it attempts to recombine smaller pieces into larger chunks that stay
    within the `max_chunk_size` limit, to reduce the total number of chunks generated. Only applicable to the
    `recursive` chunking strategy. When using the `recursive` chunking strategy one of `separators` or `separator_group`
    must be specified.
  </definition>
</definitions>

**Example**
<applies-to>
  - Elastic Stack: Planned
</applies-to>

```esql
ROW result = CHUNK("It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief.", {"strategy": "word", "max_chunk_size": 10, "overlap": 1})
| MV_EXPAND result
```


| result:keyword                                    |
|---------------------------------------------------|
| It was the best of times, it was the worst        |
| worst of times, it was the age of wisdom, it      |
| , it was the age of foolishness, it was the epoch |
| epoch of belief.                                  |


## `CONCAT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/concat.svg)

**Parameters**
<definitions>
  <definition term="string1">
    Strings to concatenate.
  </definition>
  <definition term="string2">
    Strings to concatenate.
  </definition>
</definitions>

**Description**
Concatenates two or more strings.
**Supported types**

| string1 | string2 | result  |
|---------|---------|---------|
| keyword | keyword | keyword |
| keyword | text    | keyword |
| text    | keyword | keyword |
| text    | text    | keyword |

**Example**
```esql
FROM employees
| KEEP first_name, last_name
| EVAL fullname = CONCAT(first_name, " ", last_name)
```


| first_name:keyword | last_name:keyword | fullname:keyword   |
|--------------------|-------------------|--------------------|
| Alejandro          | McAlpine          | Alejandro McAlpine |
| Amabile            | Gomatam           | Amabile Gomatam    |
| Anneke             | Preusig           | Anneke Preusig     |


## `CONTAINS`

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/contains.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression: input string to check against. If `null`, the function returns `null`.
  </definition>
  <definition term="substring">
    String expression: A substring to find in the input string. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns a boolean that indicates whether a keyword substring is within another string. Returns `null` if either parameter is null.
**Supported types**

| string  | substring | result  |
|---------|-----------|---------|
| keyword | keyword   | boolean |
| keyword | text      | boolean |
| text    | keyword   | boolean |
| text    | text      | boolean |

**Example**
```esql
ROW a = "hello"
| EVAL has_ll = CONTAINS(a, "ll")
```


| a:keyword | has_ll:boolean |
|-----------|----------------|
| hello     | true           |


## `ENDS_WITH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/ends_with.svg)

**Parameters**
<definitions>
  <definition term="str">
    String expression. If `null`, the function returns `null`.
  </definition>
  <definition term="suffix">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns a boolean that indicates whether a keyword string ends with another string.
**Supported types**

| str     | suffix  | result  |
|---------|---------|---------|
| keyword | keyword | boolean |
| keyword | text    | boolean |
| text    | keyword | boolean |
| text    | text    | boolean |

**Example**
```esql
FROM employees
| KEEP last_name
| EVAL ln_E = ENDS_WITH(last_name, "d")
```


| last_name:keyword | ln_E:boolean |
|-------------------|--------------|
| Awdeh             | false        |
| Azuma             | false        |
| Baek              | false        |
| Bamford           | true         |
| Bernatsky         | false        |


## `FROM_BASE64`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/from_base64.svg)

**Parameters**
<definitions>
  <definition term="string">
    A base64 string.
  </definition>
</definitions>

**Description**
Decode a base64 string.
**Supported types**

| string  | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW a = "ZWxhc3RpYw=="
| EVAL d = FROM_BASE64(a)
```


| a:keyword    | d:keyword |
|--------------|-----------|
| ZWxhc3RpYw== | elastic   |


## `HASH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/hash.svg)

**Parameters**
<definitions>
  <definition term="algorithm">
    Hash algorithm to use.
  </definition>
  <definition term="input">
    Input to hash.
  </definition>
</definitions>

**Description**
Computes the hash of the input using various algorithms such as MD5, SHA, SHA-224, SHA-256, SHA-384, SHA-512.
**Supported types**

| algorithm | input   | result  |
|-----------|---------|---------|
| keyword   | keyword | keyword |
| keyword   | text    | keyword |
| text      | keyword | keyword |
| text      | text    | keyword |

**Example**
```esql
FROM sample_data
| WHERE message != "Connection error"
| EVAL md5 = hash("md5", message), sha256 = hash("sha256", message)
| KEEP message, md5, sha256
```


| message:keyword       | md5:keyword                      | sha256:keyword                                                   |
|-----------------------|----------------------------------|------------------------------------------------------------------|
| Connected to 10.1.0.1 | abd7d1ce2bb636842a29246b3512dcae | 6d8372129ad78770f7185554dd39864749a62690216460752d6c075fa38ad85c |
| Connected to 10.1.0.2 | 8f8f1cb60832d153f5b9ec6dc828b93f | b0db24720f15857091b3c99f4c4833586d0ea3229911b8777efb8d917cf27e9a |
| Connected to 10.1.0.3 | 912b6dc13503165a15de43304bb77c78 | 75b0480188db8acc4d5cc666a51227eb2bc5b989cd8ca912609f33e0846eff57 |
| Disconnected          | ef70e46fd3bbc21e3e1f0b6815e750c0 | 04dfac3671b494ad53fcd152f7a14511bfb35747278aad8ce254a0d6e4ba4718 |


## `LEFT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/left.svg)

**Parameters**
<definitions>
  <definition term="string">
    The string from which to return a substring.
  </definition>
  <definition term="length">
    The number of characters to return.
  </definition>
</definitions>

**Description**
Returns the substring that extracts *length* chars from *string* starting from the left.
**Supported types**

| string  | length  | result  |
|---------|---------|---------|
| keyword | integer | keyword |
| text    | integer | keyword |

**Example**
```esql
FROM employees
| KEEP last_name
| EVAL left = LEFT(last_name, 3)
```


| last_name:keyword | left:keyword |
|-------------------|--------------|
| Awdeh             | Awd          |
| Azuma             | Azu          |
| Baek              | Bae          |
| Bamford           | Bam          |
| Bernatsky         | Ber          |


## `LENGTH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/length.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the character length of a string.
<note>
  All strings are in UTF-8, so a single character can use multiple bytes.
</note>

**Supported types**

| string  | result  |
|---------|---------|
| keyword | integer |
| text    | integer |

**Example**
```esql
FROM airports
| WHERE country == "India"
| KEEP city
| EVAL fn_length = LENGTH(city)
```


| city:keyword | fn_length:integer |
|--------------|-------------------|
| Agwār        | 5                 |
| Ahmedabad    | 9                 |
| Bangalore    | 9                 |


## `LOCATE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/locate.svg)

**Parameters**
<definitions>
  <definition term="string">
    An input string
  </definition>
  <definition term="substring">
    A substring to locate in the input string
  </definition>
  <definition term="start">
    The start index
  </definition>
</definitions>

**Description**
Returns an integer that indicates the position of a keyword substring within another string. Returns `0` if the substring cannot be found. Note that string positions start from `1`.
**Supported types**

| string  | substring | start   | result  |
|---------|-----------|---------|---------|
| keyword | keyword   | integer | integer |
| keyword | keyword   |         | integer |
| keyword | text      | integer | integer |
| keyword | text      |         | integer |
| text    | keyword   | integer | integer |
| text    | keyword   |         | integer |
| text    | text      | integer | integer |
| text    | text      |         | integer |

**Example**
```esql
ROW a = "hello"
| EVAL a_ll = LOCATE(a, "ll")
```


| a:keyword | a_ll:integer |
|-----------|--------------|
| hello     | 3            |


## `LTRIM`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/ltrim.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Removes leading whitespaces from a string.
**Supported types**

| string  | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW message = "   some text  ",  color = " red "
| EVAL message = LTRIM(message)
| EVAL color = LTRIM(color)
| EVAL message = CONCAT("'", message, "'")
| EVAL color = CONCAT("'", color, "'")
```


| message:keyword | color:keyword |
|-----------------|---------------|
| 'some text  '   | 'red '        |


## `MD5`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/md5.svg)

**Parameters**
<definitions>
  <definition term="input">
    Input to hash.
  </definition>
</definitions>

**Description**
Computes the MD5 hash of the input (if the MD5 hash is available on the JVM).
**Supported types**

| input   | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
FROM sample_data
| WHERE message != "Connection error"
| EVAL md5 = md5(message)
| KEEP message, md5
```


| message:keyword       | md5:keyword                      |
|-----------------------|----------------------------------|
| Connected to 10.1.0.1 | abd7d1ce2bb636842a29246b3512dcae |
| Connected to 10.1.0.2 | 8f8f1cb60832d153f5b9ec6dc828b93f |
| Connected to 10.1.0.3 | 912b6dc13503165a15de43304bb77c78 |
| Disconnected          | ef70e46fd3bbc21e3e1f0b6815e750c0 |


## `REPEAT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/repeat.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression.
  </definition>
  <definition term="number">
    Number times to repeat.
  </definition>
</definitions>

**Description**
Returns a string constructed by concatenating `string` with itself the specified `number` of times.
**Supported types**

| string  | number  | result  |
|---------|---------|---------|
| keyword | integer | keyword |
| text    | integer | keyword |

**Example**
```esql
ROW a = "Hello!"
| EVAL triple_a = REPEAT(a, 3)
```


| a:keyword | triple_a:keyword   |
|-----------|--------------------|
| Hello!    | Hello!Hello!Hello! |


## `REPLACE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/replace.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression.
  </definition>
  <definition term="regex">
    Regular expression.
  </definition>
  <definition term="newString">
    Replacement string.
  </definition>
</definitions>

**Description**
The function substitutes in the string `str` any match of the regular expression `regex` with the replacement string `newStr`.
**Supported types**

| string  | regex   | newString | result  |
|---------|---------|-----------|---------|
| keyword | keyword | keyword   | keyword |
| keyword | keyword | text      | keyword |
| keyword | text    | keyword   | keyword |
| keyword | text    | text      | keyword |
| text    | keyword | keyword   | keyword |
| text    | keyword | text      | keyword |
| text    | text    | keyword   | keyword |
| text    | text    | text      | keyword |

**Examples**
This example replaces any occurrence of the word "World" with the word "Universe":
```esql
ROW str = "Hello World"
| EVAL str = REPLACE(str, "World", "Universe")
```


| str:keyword    |
|----------------|
| Hello Universe |

This example removes all spaces:
```esql
ROW str = "Hello World"
| EVAL str = REPLACE(str, "\\\\s+", "")
```


| str:keyword |
|-------------|
| HelloWorld  |


## `REVERSE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/reverse.svg)

**Parameters**
<definitions>
  <definition term="str">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns a new string representing the input string in reverse order.
**Supported types**

| str     | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Examples**
```esql
ROW message = "Some Text" | EVAL message_reversed = REVERSE(message);
```


| message:keyword | message_reversed:keyword |
|-----------------|--------------------------|
| Some Text       | txeT emoS                |

`REVERSE` works with unicode, too! It keeps unicode grapheme clusters together during reversal.
```esql
ROW bending_arts = "💧🪨🔥💨" | EVAL bending_arts_reversed = REVERSE(bending_arts);
```


| bending_arts:keyword | bending_arts_reversed:keyword |
|----------------------|-------------------------------|
| 💧🪨🔥💨             | 💨🔥🪨💧                      |


## `RIGHT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/right.svg)

**Parameters**
<definitions>
  <definition term="string">
    The string from which to returns a substring.
  </definition>
  <definition term="length">
    The number of characters to return.
  </definition>
</definitions>

**Description**
Return the substring that extracts *length* chars from *str* starting from the right.
**Supported types**

| string  | length  | result  |
|---------|---------|---------|
| keyword | integer | keyword |
| text    | integer | keyword |

**Example**
```esql
FROM employees
| KEEP last_name
| EVAL right = RIGHT(last_name, 3)
```


| last_name:keyword | right:keyword |
|-------------------|---------------|
| Awdeh             | deh           |
| Azuma             | uma           |
| Baek              | aek           |
| Bamford           | ord           |
| Bernatsky         | sky           |


## `RTRIM`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/rtrim.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Removes trailing whitespaces from a string.
**Supported types**

| string  | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW message = "   some text  ",  color = " red "
| EVAL message = RTRIM(message)
| EVAL color = RTRIM(color)
| EVAL message = CONCAT("'", message, "'")
| EVAL color = CONCAT("'", color, "'")
```


| message:keyword | color:keyword |
|-----------------|---------------|
| '   some text'  | ' red'        |


## `SHA1`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/sha1.svg)

**Parameters**
<definitions>
  <definition term="input">
    Input to hash.
  </definition>
</definitions>

**Description**
Computes the SHA1 hash of the input.
**Supported types**

| input   | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
FROM sample_data
| WHERE message != "Connection error"
| EVAL sha1 = sha1(message)
| KEEP message, sha1
```


| message:keyword       | sha1:keyword                             |
|-----------------------|------------------------------------------|
| Connected to 10.1.0.1 | 42b85531a79088036a17759db7d2de292b92f57f |
| Connected to 10.1.0.2 | d30db445da2e9237c9718d0c7e4fb7cbbe9c2cb4 |
| Connected to 10.1.0.3 | 2733848d943809f0b10cad3e980763e88afb9853 |
| Disconnected          | 771e05f27b99fd59f638f41a7a4e977b1d4691fe |


## `SHA256`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/sha256.svg)

**Parameters**
<definitions>
  <definition term="input">
    Input to hash.
  </definition>
</definitions>

**Description**
Computes the SHA256 hash of the input.
**Supported types**

| input   | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
FROM sample_data
| WHERE message != "Connection error"
| EVAL sha256 = sha256(message)
| KEEP message, sha256
```


| message:keyword       | sha256:keyword                                                   |
|-----------------------|------------------------------------------------------------------|
| Connected to 10.1.0.1 | 6d8372129ad78770f7185554dd39864749a62690216460752d6c075fa38ad85c |
| Connected to 10.1.0.2 | b0db24720f15857091b3c99f4c4833586d0ea3229911b8777efb8d917cf27e9a |
| Connected to 10.1.0.3 | 75b0480188db8acc4d5cc666a51227eb2bc5b989cd8ca912609f33e0846eff57 |
| Disconnected          | 04dfac3671b494ad53fcd152f7a14511bfb35747278aad8ce254a0d6e4ba4718 |


## `SPACE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/space.svg)

**Parameters**
<definitions>
  <definition term="number">
    Number of spaces in result.
  </definition>
</definitions>

**Description**
Returns a string made of `number` spaces.
**Supported types**

| number  | result  |
|---------|---------|
| integer | keyword |

**Example**
```esql
ROW message = CONCAT("Hello", SPACE(1), "World!");
```


| message:keyword |
|-----------------|
| Hello World!    |


## `SPLIT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/split.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression. If `null`, the function returns `null`.
  </definition>
  <definition term="delim">
    Delimiter. Only single byte delimiters are currently supported.
  </definition>
</definitions>

**Description**
Split a single valued string into multiple strings.
**Supported types**

| string  | delim   | result  |
|---------|---------|---------|
| keyword | keyword | keyword |
| keyword | text    | keyword |
| text    | keyword | keyword |
| text    | text    | keyword |

**Example**
```esql
ROW words="foo;bar;baz;qux;quux;corge"
| EVAL word = SPLIT(words, ";")
```


| words:keyword              | word:keyword                 |
|----------------------------|------------------------------|
| foo;bar;baz;qux;quux;corge | [foo,bar,baz,qux,quux,corge] |


## `STARTS_WITH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/starts_with.svg)

**Parameters**
<definitions>
  <definition term="str">
    String expression. If `null`, the function returns `null`.
  </definition>
  <definition term="prefix">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns a boolean that indicates whether a keyword string starts with another string.
**Supported types**

| str     | prefix  | result  |
|---------|---------|---------|
| keyword | keyword | boolean |
| keyword | text    | boolean |
| text    | keyword | boolean |
| text    | text    | boolean |

**Example**
```esql
FROM employees
| KEEP last_name
| EVAL ln_S = STARTS_WITH(last_name, "B")
```


| last_name:keyword | ln_S:boolean |
|-------------------|--------------|
| Awdeh             | false        |
| Azuma             | false        |
| Baek              | true         |
| Bamford           | true         |
| Bernatsky         | true         |


## `SUBSTRING`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/substring.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression. If `null`, the function returns `null`.
  </definition>
  <definition term="start">
    Start position.
  </definition>
  <definition term="length">
    Length of the substring from the start position. Optional; if omitted, all positions after `start` are returned.
  </definition>
</definitions>

**Description**
Returns a substring of a string, specified by a start position and an optional length.
**Supported types**

| string  | start   | length  | result  |
|---------|---------|---------|---------|
| keyword | integer | integer | keyword |
| text    | integer | integer | keyword |

**Examples**
This example returns the first three characters of every last name:
```esql
FROM employees
| KEEP last_name
| EVAL ln_sub = SUBSTRING(last_name, 1, 3)
```


| last_name:keyword | ln_sub:keyword |
|-------------------|----------------|
| Awdeh             | Awd            |
| Azuma             | Azu            |
| Baek              | Bae            |
| Bamford           | Bam            |
| Bernatsky         | Ber            |

A negative start position is interpreted as being relative to the end of the string.
This example returns the last three characters of every last name:
```esql
FROM employees
| KEEP last_name
| EVAL ln_sub = SUBSTRING(last_name, -3, 3)
```


| last_name:keyword | ln_sub:keyword |
|-------------------|----------------|
| Awdeh             | deh            |
| Azuma             | uma            |
| Baek              | aek            |
| Bamford           | ord            |
| Bernatsky         | sky            |

If length is omitted, substring returns the remainder of the string.
This example returns all characters except for the first:
```esql
FROM employees
| KEEP last_name
| EVAL ln_sub = SUBSTRING(last_name, 2)
```


| last_name:keyword | ln_sub:keyword |
|-------------------|----------------|
| Awdeh             | wdeh           |
| Azuma             | zuma           |
| Baek              | aek            |
| Bamford           | amford         |
| Bernatsky         | ernatsky       |


## `TO_BASE64`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_base64.svg)

**Parameters**
<definitions>
  <definition term="string">
    A string.
  </definition>
</definitions>

**Description**
Encode a string to a base64 string.
**Supported types**

| string  | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW a = "elastic"
| EVAL e = TO_BASE64(a)
```


| a:keyword | e:keyword    |
|-----------|--------------|
| elastic   | ZWxhc3RpYw== |


## `TO_LOWER`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_lower.svg)

**Parameters**
<definitions>
  <definition term="str">
    String expression. If `null`, the function returns `null`. The input can be a single-valued column or expression, or a multi-valued column or expression <applies-to>Elastic Stack: Generally available since 9.1</applies-to>.
  </definition>
</definitions>

**Description**
Returns a new string representing the input string converted to lower case.
**Supported types**

| str     | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Examples**
```esql
ROW message = "Some Text"
| EVAL message_lower = TO_LOWER(message)
```


| message:keyword | message_lower:keyword |
|-----------------|-----------------------|
| Some Text       | some text             |

<applies-to>
  - Elastic Stack: Generally available since 9.1
</applies-to>

```esql
ROW v = TO_LOWER(["Some", "Text"])
```


| v:keyword        |
|------------------|
| ["some", "text"] |


## `TO_UPPER`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_upper.svg)

**Parameters**
<definitions>
  <definition term="str">
    String expression. If `null`, the function returns `null`. The input can be a single-valued column or expression, or a multi-valued column or expression <applies-to>Elastic Stack: Generally available since 9.1</applies-to>.
  </definition>
</definitions>

**Description**
Returns a new string representing the input string converted to upper case.
**Supported types**

| str     | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW message = "Some Text"
| EVAL message_upper = TO_UPPER(message)
```


| message:keyword | message_upper:keyword |
|-----------------|-----------------------|
| Some Text       | SOME TEXT             |


## `TRIM`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/trim.svg)

**Parameters**
<definitions>
  <definition term="string">
    String expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Removes leading and trailing whitespaces from a string.
**Supported types**

| string  | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW message = "   some text  ",  color = " red "
| EVAL message = TRIM(message)
| EVAL color = TRIM(color)
```


| message:s | color:s |
|-----------|---------|
| some text | red     |


## `URL_ENCODE`

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/url_encode.svg)

**Parameters**
<definitions>
  <definition term="string">
    The URL to encode.
  </definition>
</definitions>

**Description**
URL-encodes the input. All characters are [percent-encoded](https://en.wikipedia.org/wiki/Percent-encoding) except for alphanumerics, `.`, `-`, `_`, and `~`. Spaces are encoded as `+`.
**Supported types**

| string  | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW u = "https://example.com/?x=foo bar&y=baz" | EVAL u = URL_ENCODE(u)
```


| u:keyword                                            |
|------------------------------------------------------|
| https%3A%2F%2Fexample.com%2F%3Fx%3Dfoo+bar%26y%3Dbaz |


## `URL_ENCODE_COMPONENT`

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/url_encode_component.svg)

**Parameters**
<definitions>
  <definition term="string">
    The URL to encode.
  </definition>
</definitions>

**Description**
URL-encodes the input. All characters are [percent-encoded](https://en.wikipedia.org/wiki/Percent-encoding) except for alphanumerics, `.`, `-`, `_`, and `~`. Spaces are encoded as `%20`.
**Supported types**

| string  | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW u = "https://example.com/?x=foo bar&y=baz"
| EVAL u = URL_ENCODE_COMPONENT(u)
```


| u:keyword                                              |
|--------------------------------------------------------|
| https%3A%2F%2Fexample.com%2F%3Fx%3Dfoo%20bar%26y%3Dbaz |


## `URL_DECODE`

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/url_decode.svg)

**Parameters**
<definitions>
  <definition term="string">
    The URL-encoded string to decode.
  </definition>
</definitions>

**Description**
URL-decodes the input, or returns `null` and adds a warning header to the response if the input cannot be decoded.
**Supported types**

| string  | result  |
|---------|---------|
| keyword | keyword |
| text    | keyword |

**Example**
```esql
ROW u = "https%3A%2F%2Fexample.com%2F%3Fx%3Dfoo%20bar%26y%3Dbaz"
| EVAL u = URL_DECODE(u)
```


| u:keyword                            |
|--------------------------------------|
| https://example.com/?x=foo bar&y=baz |﻿---
title: ES|QL SORT command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/sort
---

# ES|QL SORT command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `SORT` processing command sorts a table on one or more columns.
**Syntax**
```esql
SORT column1 [ASC/DESC][NULLS FIRST/NULLS LAST][, ..., columnN [ASC/DESC][NULLS FIRST/NULLS LAST]]
```

**Parameters**
<definitions>
  <definition term="columnX">
    The column to sort on.
  </definition>
</definitions>

**Description**
The `SORT` processing command sorts a table on one or more columns.
The default sort order is ascending. Use `ASC` or `DESC` to specify an explicit
sort order.
Two rows with the same sort key are considered equal. You can provide additional
sort expressions to act as tie breakers.
Sorting on multivalued columns uses the lowest value when sorting ascending and
the highest value when sorting descending.
By default, `null` values are treated as being larger than any other value. With
an ascending sort order, `null` values are sorted last, and with a descending
sort order, `null` values are sorted first. You can change that by providing
`NULLS FIRST` or `NULLS LAST`.
**Examples**
```esql
FROM employees
| KEEP first_name, last_name, height
| SORT height
```

Explicitly sorting in ascending order with `ASC`:
```esql
FROM employees
| KEEP first_name, last_name, height
| SORT height DESC
```

Providing additional sort expressions to act as tie breakers:
```esql
FROM employees
| KEEP first_name, last_name, height
| SORT height DESC, first_name ASC
```

Sorting `null` values first using `NULLS FIRST`:
```esql
FROM employees
| KEEP first_name, last_name, height
| SORT first_name ASC NULLS FIRST
```﻿---
title: ES|QL multivalue functions
description: ES|QL supports these multivalue functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/mv-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL multivalue functions
ES|QL supports these multivalue functions:
- [`MV_APPEND`](#esql-mv_append)
- [`MV_AVG`](#esql-mv_avg)
- [`MV_CONCAT`](#esql-mv_concat)
- [`MV_CONTAINS`](#esql-mv_contains) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`MV_COUNT`](#esql-mv_count)
- [`MV_DEDUPE`](#esql-mv_dedupe)
- [`MV_FIRST`](#esql-mv_first)
- [`MV_INTERSECTION`](#esql-mv_intersection) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`MV_LAST`](#esql-mv_last)
- [`MV_MAX`](#esql-mv_max)
- [`MV_MEDIAN`](#esql-mv_median)
- [`MV_MEDIAN_ABSOLUTE_DEVIATION`](#esql-mv_median_absolute_deviation)
- [`MV_MIN`](#esql-mv_min)
- [`MV_PERCENTILE`](#esql-mv_percentile)
- [`MV_PSERIES_WEIGHTED_SUM`](#esql-mv_pseries_weighted_sum)
- [`MV_SORT`](#esql-mv_sort)
- [`MV_SLICE`](#esql-mv_slice)
- [`MV_SUM`](#esql-mv_sum)
- [`MV_UNION`](#esql-mv_union) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`MV_ZIP`](#esql-mv_zip)


## `MV_APPEND`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_append.svg)

**Parameters**
<definitions>
  <definition term="field1">
  </definition>
  <definition term="field2">
  </definition>
</definitions>

**Description**
Concatenates values of two multi-value fields.
**Supported types**

| field1          | field2          | result          |
|-----------------|-----------------|-----------------|
| boolean         | boolean         | boolean         |
| cartesian_point | cartesian_point | cartesian_point |
| cartesian_shape | cartesian_shape | cartesian_shape |
| date            | date            | date            |
| date_nanos      | date_nanos      | date_nanos      |
| double          | double          | double          |
| geo_point       | geo_point       | geo_point       |
| geo_shape       | geo_shape       | geo_shape       |
| geohash         | geohash         | geohash         |
| geohex          | geohex          | geohex          |
| geotile         | geotile         | geotile         |
| integer         | integer         | integer         |
| ip              | ip              | ip              |
| keyword         | keyword         | keyword         |
| keyword         | text            | keyword         |
| long            | long            | long            |
| text            | keyword         | keyword         |
| text            | text            | keyword         |
| unsigned_long   | unsigned_long   | unsigned_long   |
| version         | version         | version         |

**Example**
```esql
FROM employees
| WHERE emp_no == 10039 OR emp_no == 10040
| SORT emp_no
| EVAL dates = MV_APPEND(birth_date, hire_date)
| KEEP emp_no, birth_date, hire_date, dates
```


| emp_no:integer | birth_date:date      | hire_date:date       | dates:date                                   |
|----------------|----------------------|----------------------|----------------------------------------------|
| 10039          | 1959-10-01T00:00:00Z | 1988-01-19T00:00:00Z | [1959-10-01T00:00:00Z, 1988-01-19T00:00:00Z] |
| 10040          | null                 | 1993-02-14T00:00:00Z | null                                         |


## `MV_AVG`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_avg.svg)

**Parameters**
<definitions>
  <definition term="number">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalued field into a single valued field containing the average of all of the values.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=[3, 5, 1, 6]
| EVAL avg_a = MV_AVG(a)
```


| a:integer    | avg_a:double |
|--------------|--------------|
| [3, 5, 1, 6] | 3.75         |


## `MV_CONCAT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_concat.svg)

**Parameters**
<definitions>
  <definition term="string">
    Multivalue expression.
  </definition>
  <definition term="delim">
    Delimiter.
  </definition>
</definitions>

**Description**
Converts a multivalued string expression into a single valued column containing the concatenation of all values separated by a delimiter.
**Supported types**

| string  | delim   | result  |
|---------|---------|---------|
| keyword | keyword | keyword |
| keyword | text    | keyword |
| text    | keyword | keyword |
| text    | text    | keyword |

**Examples**
```esql
ROW a=["foo", "zoo", "bar"]
| EVAL j = MV_CONCAT(a, ", ")
```


| a:keyword             | j:keyword       |
|-----------------------|-----------------|
| ["foo", "zoo", "bar"] | "foo, zoo, bar" |

To concat non-string columns, call [`TO_STRING`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_string) first:
```esql
ROW a=[10, 9, 8]
| EVAL j = MV_CONCAT(TO_STRING(a), ", ")
```


| a:integer  | j:keyword  |
|------------|------------|
| [10, 9, 8] | "10, 9, 8" |


## `MV_CONTAINS`

<applies-to>
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_contains.svg)

**Parameters**
<definitions>
  <definition term="superset">
    Multivalue expression.
  </definition>
  <definition term="subset">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Checks if all values yielded by the second multivalue expression are present in the values yielded by the first multivalue expression. Returns a boolean. Null values are treated as an empty set.
**Supported types**

| superset        | subset          | result  |
|-----------------|-----------------|---------|
| boolean         | boolean         | boolean |
| cartesian_point | cartesian_point | boolean |
| cartesian_shape | cartesian_shape | boolean |
| date            | date            | boolean |
| date_nanos      | date_nanos      | boolean |
| double          | double          | boolean |
| geo_point       | geo_point       | boolean |
| geo_shape       | geo_shape       | boolean |
| geohash         | geohash         | boolean |
| geohex          | geohex          | boolean |
| geotile         | geotile         | boolean |
| integer         | integer         | boolean |
| ip              | ip              | boolean |
| keyword         | keyword         | boolean |
| keyword         | text            | boolean |
| long            | long            | boolean |
| text            | keyword         | boolean |
| text            | text            | boolean |
| unsigned_long   | unsigned_long   | boolean |
| version         | version         | boolean |

**Examples**
```esql
ROW set = ["a", "b", "c"], element = "a"
| EVAL set_contains_element = mv_contains(set, element)
```


| set:keyword | element:keyword | set_contains_element:boolean |
|-------------|-----------------|------------------------------|
| [a, b, c]   | a               | true                         |

```esql
ROW setA = ["a","c"], setB = ["a", "b", "c"]
| EVAL a_subset_of_b = mv_contains(setB, setA)
| EVAL b_subset_of_a = mv_contains(setA, setB)
```


| setA:keyword | setB:keyword | a_subset_of_b:boolean | b_subset_of_a:boolean |
|--------------|--------------|-----------------------|-----------------------|
| [a, c]       | [a, b, c]    | true                  | false                 |

```esql
FROM airports
| WHERE mv_contains(type, ["major","military"]) AND scalerank == 9
| KEEP scalerank, name, country
```


| scalerank:integer | name:text        | country:keyword |
|-------------------|------------------|-----------------|
| 9                 | Chandigarh Int'l | India           |


## `MV_COUNT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_count.svg)

**Parameters**
<definitions>
  <definition term="field">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalued expression into a single valued column containing a count of the number of values.
**Supported types**

| field           | result  |
|-----------------|---------|
| boolean         | integer |
| cartesian_point | integer |
| cartesian_shape | integer |
| date            | integer |
| date_nanos      | integer |
| double          | integer |
| geo_point       | integer |
| geo_shape       | integer |
| geohash         | integer |
| geohex          | integer |
| geotile         | integer |
| integer         | integer |
| ip              | integer |
| keyword         | integer |
| long            | integer |
| text            | integer |
| unsigned_long   | integer |
| version         | integer |

**Example**
```esql
ROW a=["foo", "zoo", "bar"]
| EVAL count_a = MV_COUNT(a)
```


| a:keyword             | count_a:integer |
|-----------------------|-----------------|
| ["foo", "zoo", "bar"] | 3               |


## `MV_DEDUPE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_dedupe.svg)

**Parameters**
<definitions>
  <definition term="field">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Remove duplicate values from a multivalued field.
<note>
  `MV_DEDUPE` may, but won’t always, sort the values in the column.
</note>

**Supported types**

| field           | result          |
|-----------------|-----------------|
| boolean         | boolean         |
| cartesian_point | cartesian_point |
| cartesian_shape | cartesian_shape |
| date            | date            |
| date_nanos      | date_nanos      |
| double          | double          |
| geo_point       | geo_point       |
| geo_shape       | geo_shape       |
| geohash         | geohash         |
| geohex          | geohex          |
| geotile         | geotile         |
| integer         | integer         |
| ip              | ip              |
| keyword         | keyword         |
| long            | long            |
| text            | keyword         |
| unsigned_long   | unsigned_long   |
| version         | version         |

**Example**
```esql
ROW a=["foo", "foo", "bar", "foo"]
| EVAL dedupe_a = MV_DEDUPE(a)
```


| a:keyword                    | dedupe_a:keyword |
|------------------------------|------------------|
| ["foo", "foo", "bar", "foo"] | ["foo", "bar"]   |


## `MV_FIRST`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_first.svg)

**Parameters**
<definitions>
  <definition term="field">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalued expression into a single valued column containing the first value. This is most useful when reading from a function that emits multivalued columns in a known order like [`SPLIT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-split).
The order that [multivalued fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) are read from
underlying storage is not guaranteed. It is **frequently** ascending, but don’t
rely on that. If you need the minimum value use [`MV_MIN`](#esql-mv_min) instead of
`MV_FIRST`. `MV_MIN` has optimizations for sorted values so there isn’t a
performance benefit to `MV_FIRST`.
**Supported types**

| field           | result          |
|-----------------|-----------------|
| boolean         | boolean         |
| cartesian_point | cartesian_point |
| cartesian_shape | cartesian_shape |
| date            | date            |
| date_nanos      | date_nanos      |
| double          | double          |
| geo_point       | geo_point       |
| geo_shape       | geo_shape       |
| geohash         | geohash         |
| geohex          | geohex          |
| geotile         | geotile         |
| integer         | integer         |
| ip              | ip              |
| keyword         | keyword         |
| long            | long            |
| text            | keyword         |
| unsigned_long   | unsigned_long   |
| version         | version         |

**Example**
```esql
ROW a="foo;bar;baz"
| EVAL first_a = MV_FIRST(SPLIT(a, ";"))
```


| a:keyword   | first_a:keyword |
|-------------|-----------------|
| foo;bar;baz | "foo"           |


## `MV_INTERSECTION`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_intersection.svg)

**Parameters**
<definitions>
  <definition term="field1">
    Multivalue expression. If null, the function returns null.
  </definition>
  <definition term="field2">
    Multivalue expression. If null, the function returns null.
  </definition>
</definitions>

**Description**
Returns the values that appear in both input fields. Returns `null` if either field is null or if no values match.
**Supported types**

| field1          | field2          | result          |
|-----------------|-----------------|-----------------|
| boolean         | boolean         | boolean         |
| cartesian_point | cartesian_point | cartesian_point |
| cartesian_shape | cartesian_shape | cartesian_shape |
| date            | date            | date            |
| date_nanos      | date_nanos      | date_nanos      |
| double          | double          | double          |
| geo_point       | geo_point       | geo_point       |
| geo_shape       | geo_shape       | geo_shape       |
| geohash         | geohash         | geohash         |
| geohex          | geohex          | geohex          |
| geotile         | geotile         | geotile         |
| integer         | integer         | integer         |
| ip              | ip              | ip              |
| keyword         | keyword         | keyword         |
| keyword         | text            | keyword         |
| long            | long            | long            |
| text            | keyword         | keyword         |
| text            | text            | keyword         |
| unsigned_long   | unsigned_long   | unsigned_long   |
| version         | version         | version         |

**Examples**
```esql
ROW a = [1, 2, 3, 4, 5], b = [2, 3, 4, 5, 6]
| EVAL finalValue = MV_INTERSECTION(a, b)
| KEEP finalValue
```


| finalValue:integer |
|--------------------|
| [2, 3, 4, 5]       |

```esql
ROW a = [1, 2, 3, 4, 5]::long, b = [2, 3, 4, 5, 6]::long
| EVAL finalValue = MV_INTERSECTION(a, b)
| KEEP finalValue
```


| finalValue:long |
|-----------------|
| [2, 3, 4, 5]    |

```esql
ROW a = [true, false, false, false], b = [false]
| EVAL finalValue = MV_INTERSECTION(a, b)
| KEEP finalValue
```


| finalValue:boolean |
|--------------------|
| [false]            |

```esql
ROW a = [5.2, 10.5, 1.12345, 2.6928], b = [10.5, 2.6928]
| EVAL finalValue = MV_INTERSECTION(a, b)
| KEEP finalValue
```


| finalValue:double |
|-------------------|
| [10.5, 2.6928]    |

```esql
ROW a = ["one", "two", "three", "four", "five"], b = ["one", "four"]
| EVAL finalValue = MV_INTERSECTION(a, b)
| KEEP finalValue
```


| finalValue:keyword |
|--------------------|
| ["one", "four"]    |


## `MV_LAST`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_last.svg)

**Parameters**
<definitions>
  <definition term="field">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalue expression into a single valued column containing the last value. This is most useful when reading from a function that emits multivalued columns in a known order like [`SPLIT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-split).
The order that [multivalued fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) are read from
underlying storage is not guaranteed. It is **frequently** ascending, but don’t
rely on that. If you need the maximum value use [`MV_MAX`](#esql-mv_max) instead of
`MV_LAST`. `MV_MAX` has optimizations for sorted values so there isn’t a
performance benefit to `MV_LAST`.
**Supported types**

| field           | result          |
|-----------------|-----------------|
| boolean         | boolean         |
| cartesian_point | cartesian_point |
| cartesian_shape | cartesian_shape |
| date            | date            |
| date_nanos      | date_nanos      |
| double          | double          |
| geo_point       | geo_point       |
| geo_shape       | geo_shape       |
| geohash         | geohash         |
| geohex          | geohex          |
| geotile         | geotile         |
| integer         | integer         |
| ip              | ip              |
| keyword         | keyword         |
| long            | long            |
| text            | keyword         |
| unsigned_long   | unsigned_long   |
| version         | version         |

**Example**
```esql
ROW a="foo;bar;baz"
| EVAL last_a = MV_LAST(SPLIT(a, ";"))
```


| a:keyword   | last_a:keyword |
|-------------|----------------|
| foo;bar;baz | "baz"          |


## `MV_MAX`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_max.svg)

**Parameters**
<definitions>
  <definition term="field">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalued expression into a single valued column containing the maximum value.
**Supported types**

| field         | result        |
|---------------|---------------|
| boolean       | boolean       |
| date          | date          |
| date_nanos    | date_nanos    |
| double        | double        |
| integer       | integer       |
| ip            | ip            |
| keyword       | keyword       |
| long          | long          |
| text          | keyword       |
| unsigned_long | unsigned_long |
| version       | version       |

**Examples**
```esql
ROW a=[3, 5, 1]
| EVAL max_a = MV_MAX(a)
```


| a:integer | max_a:integer |
|-----------|---------------|
| [3, 5, 1] | 5             |

It can be used by any column type, including `keyword` columns. In that case it picks the last string, comparing their utf-8 representation byte by byte:
```esql
ROW a=["foo", "zoo", "bar"]
| EVAL max_a = MV_MAX(a)
```


| a:keyword             | max_a:keyword |
|-----------------------|---------------|
| ["foo", "zoo", "bar"] | "zoo"         |


## `MV_MEDIAN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_median.svg)

**Parameters**
<definitions>
  <definition term="number">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalued field into a single valued field containing the median value.
**Supported types**

| number        | result        |
|---------------|---------------|
| double        | double        |
| integer       | integer       |
| long          | long          |
| unsigned_long | unsigned_long |

**Examples**
```esql
ROW a=[3, 5, 1]
| EVAL median_a = MV_MEDIAN(a)
```


| a:integer | median_a:integer |
|-----------|------------------|
| [3, 5, 1] | 3                |

If the row has an even number of values for a column, the result will be the average of the middle two entries. If the column is not floating point, the average rounds **down**:
```esql
ROW a=[3, 7, 1, 6]
| EVAL median_a = MV_MEDIAN(a)
```


| a:integer    | median_a:integer |
|--------------|------------------|
| [3, 7, 1, 6] | 4                |


## `MV_MEDIAN_ABSOLUTE_DEVIATION`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_median_absolute_deviation.svg)

**Parameters**
<definitions>
  <definition term="number">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalued field into a single valued field containing the median absolute deviation.  It is calculated as the median of each data point’s deviation from the median of the entire sample. That is, for a random variable `X`, the median absolute deviation is `median(|median(X) - X|)`.
<note>
  If the field has an even number of values, the medians will be calculated as the average of the middle two values. If the value is not a floating point number, the averages are rounded towards 0.
</note>

**Supported types**

| number        | result        |
|---------------|---------------|
| double        | double        |
| integer       | integer       |
| long          | long          |
| unsigned_long | unsigned_long |

**Example**
```esql
ROW values = [0, 2, 5, 6]
| EVAL median_absolute_deviation = MV_MEDIAN_ABSOLUTE_DEVIATION(values), median = MV_MEDIAN(values)
```


| values:integer | median_absolute_deviation:integer | median:integer |
|----------------|-----------------------------------|----------------|
| [0, 2, 5, 6]   | 2                                 | 3              |


## `MV_MIN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_min.svg)

**Parameters**
<definitions>
  <definition term="field">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalued expression into a single valued column containing the minimum value.
**Supported types**

| field         | result        |
|---------------|---------------|
| boolean       | boolean       |
| date          | date          |
| date_nanos    | date_nanos    |
| double        | double        |
| integer       | integer       |
| ip            | ip            |
| keyword       | keyword       |
| long          | long          |
| text          | keyword       |
| unsigned_long | unsigned_long |
| version       | version       |

**Examples**
```esql
ROW a=[2, 1]
| EVAL min_a = MV_MIN(a)
```


| a:integer | min_a:integer |
|-----------|---------------|
| [2, 1]    | 1             |

It can be used by any column type, including `keyword` columns. In that case, it picks the first string, comparing their utf-8 representation byte by byte:
```esql
ROW a=["foo", "bar"]
| EVAL min_a = MV_MIN(a)
```


| a:keyword      | min_a:keyword |
|----------------|---------------|
| ["foo", "bar"] | "bar"         |


## `MV_PERCENTILE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_percentile.svg)

**Parameters**
<definitions>
  <definition term="number">
    Multivalue expression.
  </definition>
  <definition term="percentile">
    The percentile to calculate. Must be a number between 0 and 100. Numbers out of range will return a null instead.
  </definition>
</definitions>

**Description**
Converts a multivalued field into a single valued field containing the value at which a certain percentage of observed values occur.
**Supported types**

| number  | percentile | result  |
|---------|------------|---------|
| double  | double     | double  |
| double  | integer    | double  |
| double  | long       | double  |
| integer | double     | integer |
| integer | integer    | integer |
| integer | long       | integer |
| long    | double     | long    |
| long    | integer    | long    |
| long    | long       | long    |

**Example**
```esql
ROW values = [5, 5, 10, 12, 5000]
| EVAL p50 = MV_PERCENTILE(values, 50), median = MV_MEDIAN(values)
```


| values:integer       | p50:integer | median:integer |
|----------------------|-------------|----------------|
| [5, 5, 10, 12, 5000] | 10          | 10             |


## `MV_PSERIES_WEIGHTED_SUM`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_pseries_weighted_sum.svg)

**Parameters**
<definitions>
  <definition term="number">
    Multivalue expression.
  </definition>
  <definition term="p">
    It is a constant number that represents the *p* parameter in the P-Series. It impacts every element’s contribution to the weighted sum.
  </definition>
</definitions>

**Description**
Converts a multivalued expression into a single-valued column by multiplying every element on the input list by its corresponding term in P-Series and computing the sum.
**Supported types**

| number | p      | result |
|--------|--------|--------|
| double | double | double |

**Example**
```esql
ROW a = [70.0, 45.0, 21.0, 21.0, 21.0]
| EVAL sum = MV_PSERIES_WEIGHTED_SUM(a, 1.5)
| KEEP sum
```


| sum:double        |
|-------------------|
| 94.45465156212452 |


## `MV_SLICE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_slice.svg)

**Parameters**
<definitions>
  <definition term="field">
    Multivalue expression. If `null`, the function returns `null`.
  </definition>
  <definition term="start">
    Start position. If `null`, the function returns `null`. The start argument can be negative. An index of -1 is used to specify the last value in the list.
  </definition>
  <definition term="end">
    End position(included). Optional; if omitted, the position at `start` is returned. The end argument can be negative. An index of -1 is used to specify the last value in the list.
  </definition>
</definitions>

**Description**
Returns a subset of the multivalued field using the start and end index values. This is most useful when reading from a function that emits multivalued columns in a known order like [`SPLIT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-split) or [`MV_SORT`](#esql-mv_sort).
The order that [multivalued fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields) are read from
underlying storage is not guaranteed. It is **frequently** ascending, but don’t
rely on that.
**Supported types**

| field           | start   | end     | result          |
|-----------------|---------|---------|-----------------|
| boolean         | integer | integer | boolean         |
| cartesian_point | integer | integer | cartesian_point |
| cartesian_shape | integer | integer | cartesian_shape |
| date            | integer | integer | date            |
| date_nanos      | integer | integer | date_nanos      |
| double          | integer | integer | double          |
| geo_point       | integer | integer | geo_point       |
| geo_shape       | integer | integer | geo_shape       |
| geohash         | integer | integer | geohash         |
| geohex          | integer | integer | geohex          |
| geotile         | integer | integer | geotile         |
| integer         | integer | integer | integer         |
| ip              | integer | integer | ip              |
| keyword         | integer | integer | keyword         |
| long            | integer | integer | long            |
| text            | integer | integer | keyword         |
| unsigned_long   | integer | integer | unsigned_long   |
| version         | integer | integer | version         |

**Examples**
```esql
row a = [1, 2, 2, 3]
| eval a1 = mv_slice(a, 1), a2 = mv_slice(a, 2, 3)
```


| a:integer    | a1:integer | a2:integer |
|--------------|------------|------------|
| [1, 2, 2, 3] | 2          | [2, 3]     |

```esql
row a = [1, 2, 2, 3]
| eval a1 = mv_slice(a, -2), a2 = mv_slice(a, -3, -1)
```


| a:integer    | a1:integer | a2:integer |
|--------------|------------|------------|
| [1, 2, 2, 3] | 2          | [2, 2, 3]  |


## `MV_SORT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_sort.svg)

**Parameters**
<definitions>
  <definition term="field">
    Multivalue expression. If `null`, the function returns `null`.
  </definition>
  <definition term="order">
    Sort order. The valid options are ASC and DESC, the default is ASC.
  </definition>
</definitions>

**Description**
Sorts a multivalued field in lexicographical order.
**Supported types**

| field      | order   | result     |
|------------|---------|------------|
| boolean    | keyword | boolean    |
| date       | keyword | date       |
| date_nanos | keyword | date_nanos |
| double     | keyword | double     |
| integer    | keyword | integer    |
| ip         | keyword | ip         |
| keyword    | keyword | keyword    |
| long       | keyword | long       |
| text       | keyword | keyword    |
| version    | keyword | version    |

**Example**
```esql
ROW a = [4, 2, -3, 2]
| EVAL sa = mv_sort(a), sd = mv_sort(a, "DESC")
```


| a:integer     | sa:integer    | sd:integer    |
|---------------|---------------|---------------|
| [4, 2, -3, 2] | [-3, 2, 2, 4] | [4, 2, 2, -3] |


## `MV_SUM`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_sum.svg)

**Parameters**
<definitions>
  <definition term="number">
    Multivalue expression.
  </definition>
</definitions>

**Description**
Converts a multivalued field into a single valued field containing the sum of all of the values.
**Supported types**

| number        | result        |
|---------------|---------------|
| double        | double        |
| integer       | integer       |
| long          | long          |
| unsigned_long | unsigned_long |

**Example**
```esql
ROW a=[3, 5, 6]
| EVAL sum_a = MV_SUM(a)
```


| a:integer | sum_a:integer |
|-----------|---------------|
| [3, 5, 6] | 14            |


## `MV_UNION`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_union.svg)

**Parameters**
<definitions>
  <definition term="field1">
    Multivalue expression. Null values are treated as empty sets.
  </definition>
  <definition term="field2">
    Multivalue expression. Null values are treated as empty sets.
  </definition>
</definitions>

**Description**
Returns all unique values from the combined input fields (set union). Null values are treated as empty sets; returns `null` only if both fields are null.
**Supported types**

| field1          | field2          | result          |
|-----------------|-----------------|-----------------|
| boolean         | boolean         | boolean         |
| cartesian_point | cartesian_point | cartesian_point |
| cartesian_shape | cartesian_shape | cartesian_shape |
| date            | date            | date            |
| date_nanos      | date_nanos      | date_nanos      |
| double          | double          | double          |
| geo_point       | geo_point       | geo_point       |
| geo_shape       | geo_shape       | geo_shape       |
| geohash         | geohash         | geohash         |
| geohex          | geohex          | geohex          |
| geotile         | geotile         | geotile         |
| integer         | integer         | integer         |
| ip              | ip              | ip              |
| keyword         | keyword         | keyword         |
| keyword         | text            | keyword         |
| long            | long            | long            |
| text            | keyword         | keyword         |
| text            | text            | keyword         |
| unsigned_long   | unsigned_long   | unsigned_long   |
| version         | version         | version         |

**Examples**
```esql
ROW a = [1, 2, 3, 4, 5], b = [2, 3, 4, 5, 6]
| EVAL finalValue = MV_UNION(a, b)
| KEEP finalValue
```


| finalValue:integer |
|--------------------|
| [1, 2, 3, 4, 5, 6] |

```esql
ROW a = [1, 2, 3, 4, 5]::long, b = [2, 3, 4, 5, 6]::long
| EVAL finalValue = MV_UNION(a, b)
| KEEP finalValue
```


| finalValue:long    |
|--------------------|
| [1, 2, 3, 4, 5, 6] |

```esql
ROW a = [true, false], b = [false]
| EVAL finalValue = MV_UNION(a, b)
| KEEP finalValue
```


| finalValue:boolean |
|--------------------|
| [true, false]      |

```esql
ROW a = [5.2, 10.5, 1.12345], b = [10.5, 2.6928]
| EVAL finalValue = MV_UNION(a, b)
| KEEP finalValue
```


| finalValue:double            |
|------------------------------|
| [5.2, 10.5, 1.12345, 2.6928] |

```esql
ROW a = ["one", "two", "three"], b = ["two", "four"]
| EVAL finalValue = MV_UNION(a, b)
| KEEP finalValue
```


| finalValue:keyword              |
|---------------------------------|
| ["one", "two", "three", "four"] |


## `MV_ZIP`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/mv_zip.svg)

**Parameters**
<definitions>
  <definition term="string1">
    Multivalue expression.
  </definition>
  <definition term="string2">
    Multivalue expression.
  </definition>
  <definition term="delim">
    Delimiter. Optional; if omitted, `,` is used as a default delimiter.
  </definition>
</definitions>

**Description**
Combines the values from two multivalued fields with a delimiter that joins them together.
**Supported types**

| string1 | string2 | delim   | result  |
|---------|---------|---------|---------|
| keyword | keyword | keyword | keyword |
| keyword | keyword | text    | keyword |
| keyword | keyword |         | keyword |
| keyword | text    | keyword | keyword |
| keyword | text    | text    | keyword |
| keyword | text    |         | keyword |
| text    | keyword | keyword | keyword |
| text    | keyword | text    | keyword |
| text    | keyword |         | keyword |
| text    | text    | keyword | keyword |
| text    | text    | text    | keyword |
| text    | text    |         | keyword |

**Example**
```esql
ROW a = ["x", "y", "z"], b = ["1", "2"]
| EVAL c = mv_zip(a, b, "-")
| KEEP a, b, c
```


| a:keyword | b:keyword | c:keyword     |
|-----------|-----------|---------------|
| [x, y, z] | [1 ,2]    | [x-1, y-2, z] |﻿---
title: ES|QL conditional functions and expressions
description: Conditional functions return one of their arguments by evaluating in an if-else manner. ES|QL supports these conditional functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL conditional functions and expressions
Conditional functions return one of their arguments by evaluating in an if-else manner. ES|QL supports these conditional functions:
- [`CASE`](#esql-case)
- [`COALESCE`](#esql-coalesce)
- [`GREATEST`](#esql-greatest)
- [`LEAST`](#esql-least)
- [`CLAMP`](#esql-clamp) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`CLAMP_MIN`](#esql-clamp_min) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`CLAMP_MAX`](#esql-clamp_max) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>


## `CASE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/case.svg)

**Parameters**
<definitions>
  <definition term="condition">
    A condition.
  </definition>
  <definition term="trueValue">
    The value that’s returned when the corresponding condition is the first to evaluate to `true`. The default value is returned when no condition matches.
  </definition>
  <definition term="elseValue">
    The value that’s returned when no condition evaluates to `true`.
  </definition>
</definitions>

**Description**
Accepts pairs of conditions and values. The function returns the value that belongs to the first condition that evaluates to `true`.  If the number of arguments is odd, the last argument is the default value which is returned when no condition matches. If the number of arguments is even, and no condition matches, the function returns `null`.
**Supported types**

| condition | trueValue             | elseValue             | result                |
|-----------|-----------------------|-----------------------|-----------------------|
| boolean   | boolean               | boolean               | boolean               |
| boolean   | boolean               |                       | boolean               |
| boolean   | cartesian_point       | cartesian_point       | cartesian_point       |
| boolean   | cartesian_point       |                       | cartesian_point       |
| boolean   | cartesian_shape       | cartesian_shape       | cartesian_shape       |
| boolean   | cartesian_shape       |                       | cartesian_shape       |
| boolean   | date                  | date                  | date                  |
| boolean   | date                  |                       | date                  |
| boolean   | date_nanos            | date_nanos            | date_nanos            |
| boolean   | date_nanos            |                       | date_nanos            |
| boolean   | dense_vector          | dense_vector          | dense_vector          |
| boolean   | dense_vector          |                       | dense_vector          |
| boolean   | double                | double                | double                |
| boolean   | double                |                       | double                |
| boolean   | exponential_histogram | exponential_histogram | exponential_histogram |
| boolean   | exponential_histogram |                       | exponential_histogram |
| boolean   | geo_point             | geo_point             | geo_point             |
| boolean   | geo_point             |                       | geo_point             |
| boolean   | geo_shape             | geo_shape             | geo_shape             |
| boolean   | geo_shape             |                       | geo_shape             |
| boolean   | geohash               | geohash               | geohash               |
| boolean   | geohash               |                       | geohash               |
| boolean   | geohex                | geohex                | geohex                |
| boolean   | geohex                |                       | geohex                |
| boolean   | geotile               | geotile               | geotile               |
| boolean   | geotile               |                       | geotile               |
| boolean   | integer               | integer               | integer               |
| boolean   | integer               |                       | integer               |
| boolean   | ip                    | ip                    | ip                    |
| boolean   | ip                    |                       | ip                    |
| boolean   | keyword               | keyword               | keyword               |
| boolean   | keyword               | text                  | keyword               |
| boolean   | keyword               |                       | keyword               |
| boolean   | long                  | long                  | long                  |
| boolean   | long                  |                       | long                  |
| boolean   | text                  | keyword               | keyword               |
| boolean   | text                  | text                  | keyword               |
| boolean   | text                  |                       | keyword               |
| boolean   | unsigned_long         | unsigned_long         | unsigned_long         |
| boolean   | unsigned_long         |                       | unsigned_long         |
| boolean   | version               | version               | version               |
| boolean   | version               |                       | version               |

**Examples**
Determine whether employees are monolingual, bilingual, or polyglot:
```esql
FROM employees
| EVAL type = CASE(
    languages <= 1, "monolingual",
    languages <= 2, "bilingual",
     "polyglot")
| KEEP emp_no, languages, type
```


| emp_no:integer | languages:integer | type:keyword |
|----------------|-------------------|--------------|
| 10001          | 2                 | bilingual    |
| 10002          | 5                 | polyglot     |
| 10003          | 4                 | polyglot     |
| 10004          | 5                 | polyglot     |
| 10005          | 1                 | monolingual  |

Calculate the total connection success rate based on log messages:
```esql
FROM sample_data
| EVAL successful = CASE(
    STARTS_WITH(message, "Connected to"), 1,
    message == "Connection error", 0
  )
| STATS success_rate = AVG(successful)
```


| success_rate:double |
|---------------------|
| 0.5                 |

Calculate an hourly error rate as a percentage of the total number of log messages:
```esql
FROM sample_data
| EVAL error = CASE(message LIKE "*error*", 1, 0)
| EVAL hour = DATE_TRUNC(1 hour, @timestamp)
| STATS error_rate = AVG(error) by hour
| SORT hour
```


| error_rate:double | hour:date                |
|-------------------|--------------------------|
| 0.0               | 2023-10-23T12:00:00.000Z |
| 0.6               | 2023-10-23T13:00:00.000Z |


## `COALESCE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/coalesce.svg)

**Parameters**
<definitions>
  <definition term="first">
    Expression to evaluate.
  </definition>
  <definition term="rest">
    Other expression to evaluate.
  </definition>
</definitions>

**Description**
Returns the first of its arguments that is not null. If all arguments are null, it returns `null`.
**Supported types**

| first                 | rest                  | result                |
|-----------------------|-----------------------|-----------------------|
| boolean               | boolean               | boolean               |
| boolean               |                       | boolean               |
| cartesian_point       | cartesian_point       | cartesian_point       |
| cartesian_shape       | cartesian_shape       | cartesian_shape       |
| date                  | date                  | date                  |
| date_nanos            | date_nanos            | date_nanos            |
| exponential_histogram | exponential_histogram | exponential_histogram |
| geo_point             | geo_point             | geo_point             |
| geo_shape             | geo_shape             | geo_shape             |
| geohash               | geohash               | geohash               |
| geohex                | geohex                | geohex                |
| geotile               | geotile               | geotile               |
| integer               | integer               | integer               |
| integer               |                       | integer               |
| ip                    | ip                    | ip                    |
| keyword               | keyword               | keyword               |
| keyword               |                       | keyword               |
| long                  | long                  | long                  |
| long                  |                       | long                  |
| text                  | text                  | keyword               |
| text                  |                       | keyword               |
| version               | version               | version               |

**Example**
```esql
ROW a=null, b="b"
| EVAL COALESCE(a, b)
```


| a:null | b:keyword | COALESCE(a, b):keyword |
|--------|-----------|------------------------|
| null   | b         | b                      |


## `GREATEST`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/greatest.svg)

**Parameters**
<definitions>
  <definition term="first">
    First of the columns to evaluate.
  </definition>
  <definition term="rest">
    The rest of the columns to evaluate.
  </definition>
</definitions>

**Description**
Returns the maximum value from multiple columns. This is similar to [`MV_MAX`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_max) except it is intended to run on multiple columns at once.
<note>
  When run on `keyword` or `text` fields, this returns the last string in alphabetical order. When run on `boolean` columns this will return `true` if any values are `true`.
</note>

**Supported types**

| first      | rest       | result     |
|------------|------------|------------|
| boolean    | boolean    | boolean    |
| boolean    |            | boolean    |
| date       | date       | date       |
| date_nanos | date_nanos | date_nanos |
| double     | double     | double     |
| integer    | integer    | integer    |
| integer    |            | integer    |
| ip         | ip         | ip         |
| keyword    | keyword    | keyword    |
| keyword    |            | keyword    |
| long       | long       | long       |
| long       |            | long       |
| text       | text       | keyword    |
| text       |            | keyword    |
| version    | version    | version    |

**Example**
```esql
ROW a = 10, b = 20
| EVAL g = GREATEST(a, b)
```


| a:integer | b:integer | g:integer |
|-----------|-----------|-----------|
| 10        | 20        | 20        |


## `LEAST`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/least.svg)

**Parameters**
<definitions>
  <definition term="first">
    First of the columns to evaluate.
  </definition>
  <definition term="rest">
    The rest of the columns to evaluate.
  </definition>
</definitions>

**Description**
Returns the minimum value from multiple columns. This is similar to [`MV_MIN`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_min) except it is intended to run on multiple columns at once.
**Supported types**

| first      | rest       | result     |
|------------|------------|------------|
| boolean    | boolean    | boolean    |
| boolean    |            | boolean    |
| date       | date       | date       |
| date_nanos | date_nanos | date_nanos |
| double     | double     | double     |
| integer    | integer    | integer    |
| integer    |            | integer    |
| ip         | ip         | ip         |
| keyword    | keyword    | keyword    |
| keyword    |            | keyword    |
| long       | long       | long       |
| long       |            | long       |
| text       | text       | keyword    |
| text       |            | keyword    |
| version    | version    | version    |

**Example**
```esql
ROW a = 10, b = 20
| EVAL l = LEAST(a, b)
```


| a:integer | b:integer | l:integer |
|-----------|-----------|-----------|
| 10        | 20        | 10        |


## `CLAMP`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/clamp.svg)

**Parameters**
<definitions>
  <definition term="field">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
  <definition term="min">
    The min value to clamp data into.
  </definition>
  <definition term="max">
    The max value to clamp data into.
  </definition>
</definitions>

**Description**
Limits (or clamps) the values of all samples to have a lower limit of min and an upper limit of max.
**Supported types**

| field         | min           | max           | result        |
|---------------|---------------|---------------|---------------|
| boolean       | boolean       | boolean       | boolean       |
| date          | date          | date          | date          |
| double        | double        | double        | double        |
| double        | integer       | integer       | double        |
| double        | long          | long          | double        |
| double        | unsigned_long | unsigned_long | double        |
| integer       | double        | double        | double        |
| integer       | integer       | integer       | integer       |
| integer       | long          | long          | long          |
| integer       | unsigned_long | unsigned_long | unsigned_long |
| ip            | ip            | ip            | ip            |
| keyword       | keyword       | keyword       | keyword       |
| long          | double        | double        | double        |
| long          | integer       | integer       | long          |
| long          | long          | long          | long          |
| long          | unsigned_long | unsigned_long | unsigned_long |
| unsigned_long | double        | double        | double        |
| unsigned_long | integer       | integer       | unsigned_long |
| unsigned_long | long          | long          | long          |
| unsigned_long | unsigned_long | unsigned_long | unsigned_long |
| version       | version       | version       | version       |

**Example**
```esql
TS k8s
| EVAL full_clamped_cost = clamp(network.cost, clamp_max(network.bytes_in, 5), network.bytes_in / 100)
| KEEP full_clamped_cost, @timestamp
```


| full_clamped_cost:double | @timestamp:datetime      |
|--------------------------|--------------------------|
| 10.0                     | 2024-05-10T00:18:33.000Z |
| 9.0                      | 2024-05-10T00:04:49.000Z |
| 9.0                      | 2024-05-10T00:15:51.000Z |
| 9.0                      | 2024-05-10T00:17:12.000Z |
| 9.0                      | 2024-05-10T00:20:46.000Z |


## `CLAMP_MIN`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/clamp_min.svg)

**Parameters**
<definitions>
  <definition term="field">
    field to clamp.
  </definition>
  <definition term="min">
    The min value to clamp data into.
  </definition>
</definitions>

**Description**
Limits (or clamps) all input sample values to a lower bound of min. Any value below min is set to min.
**Supported types**

| field         | min           | result        |
|---------------|---------------|---------------|
| boolean       | boolean       | boolean       |
| date          | date          | date          |
| double        | double        | double        |
| double        | integer       | double        |
| double        | long          | double        |
| double        | unsigned_long | double        |
| integer       | double        | double        |
| integer       | integer       | integer       |
| integer       | long          | long          |
| integer       | unsigned_long | unsigned_long |
| ip            | ip            | ip            |
| keyword       | keyword       | keyword       |
| long          | double        | double        |
| long          | integer       | long          |
| long          | long          | long          |
| long          | unsigned_long | unsigned_long |
| unsigned_long | double        | double        |
| unsigned_long | integer       | unsigned_long |
| unsigned_long | long          | long          |
| unsigned_long | unsigned_long | unsigned_long |
| version       | version       | version       |

**Example**
```esql
FROM k8s
| STATS full_clamped_cost=sum(clamp(network.cost, 1, 2)), clamped_cost=sum(clamp_max(network.cost, 1)), clamped_min_cost=sum(clamp_min(network.cost, 10)) BY time_bucket = bucket(@timestamp,1minute)
```


| full_clamped_cost:double | clamped_cost:double | clamped_min_cost:double | time_bucket:datetime     |
|--------------------------|---------------------|-------------------------|--------------------------|
| 39.0                     | 20.0                | 206.25                  | 2024-05-10T00:09:00.000Z |
| 29.125                   | 15.5                | 173.0                   | 2024-05-10T00:18:00.000Z |
| 28.0                     | 14.125              | 155.625                 | 2024-05-10T00:17:00.000Z |
| 23.25                    | 12.0                | 124.875                 | 2024-05-10T00:08:00.000Z |


## `CLAMP_MAX`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/clamp_max.svg)

**Parameters**
<definitions>
  <definition term="field">
    field to clamp.
  </definition>
  <definition term="max">
    The max value to clamp data into.
  </definition>
</definitions>

**Description**
Limits (or clamps) all input sample values to an upper bound of max. Any value above max is reduced to max.
**Supported types**

| field         | max           | result        |
|---------------|---------------|---------------|
| boolean       | boolean       | boolean       |
| date          | date          | date          |
| double        | double        | double        |
| double        | integer       | double        |
| double        | long          | double        |
| double        | unsigned_long | double        |
| integer       | double        | double        |
| integer       | integer       | integer       |
| integer       | long          | long          |
| integer       | unsigned_long | unsigned_long |
| ip            | ip            | ip            |
| keyword       | keyword       | keyword       |
| long          | double        | double        |
| long          | integer       | long          |
| long          | long          | long          |
| long          | unsigned_long | unsigned_long |
| unsigned_long | double        | double        |
| unsigned_long | integer       | unsigned_long |
| unsigned_long | long          | long          |
| unsigned_long | unsigned_long | unsigned_long |
| version       | version       | version       |

**Example**
```esql
TS k8s
| STATS full_clamped_cost=sum(clamp(network.cost, 1, 2)), clamped_cost=sum(clamp_max(network.cost, 1)), clamped_min_cost=sum(clamp_min(network.cost, 10)) BY time_bucket = bucket(@timestamp,1minute)
```


| full_clamped_cost:double | clamped_cost:double | clamped_min_cost:double | time_bucket:datetime     |
|--------------------------|---------------------|-------------------------|--------------------------|
| 18.0                     | 9.0                 | 94.875                  | 2024-05-10T00:09:00.000Z |
| 15.25                    | 8.0                 | 84.125                  | 2024-05-10T00:08:00.000Z |
| 15.0                     | 8.0                 | 83.5                    | 2024-05-10T00:15:00.000Z |
| 13.75                    | 7.0                 | 71.625                  | 2024-05-10T00:22:00.000Z |
| 13.125                   | 7.5                 | 90.5                    | 2024-05-10T00:18:00.000Z |﻿---
title: ES|QL for search tutorial
description: This hands-on tutorial covers full-text search, semantic search, hybrid search, vector search, and AI-powered search capabilities using ES|QL. In this...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-search-tutorial
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL for search tutorial
This hands-on tutorial covers full-text search, semantic search, hybrid search, vector search, and AI-powered search capabilities using ES|QL.
In this scenario, we're implementing search for a cooking blog. The blog contains recipes with various attributes including textual content, categorical data, and numerical ratings.
<note>
  This tutorial uses a small dataset for learning purposes. The goal is to demonstrate search concepts and ES|QL syntax.
</note>


## Requirements

You need a running Elasticsearch cluster, together with Kibana to use the Dev Tools API Console. Refer to [choose your deployment type](https://www.elastic.co/docs/deploy-manage/deploy#choosing-your-deployment-type) for deployment options.
Want to get started quickly? Run the following command in your terminal to set up a [single-node local cluster in Docker](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/local-development-installation-quickstart):
```sh
curl -fsSL https://elastic.co/start-local | sh
```


## Running ES|QL queries

In this tutorial, ES|QL examples are displayed in the following format:
```esql
FROM cooking_blog
| WHERE description:"fluffy pancakes"
| LIMIT 1000
```

If you want to run these queries in the [Dev Tools Console](/docs/reference/query-languages/esql/esql-rest#esql-kibana-console), you need to use the following syntax:
```json

{
  "query": """
    FROM cooking_blog
    | WHERE description:"fluffy pancakes"
    | LIMIT 1000
  """
}
```

If you'd prefer to use your favorite programming language, refer to [Client libraries](https://www.elastic.co/docs/solutions/search/site-or-app/clients) for a list of official and community-supported clients.

## Step 1: Create an index

Create the `cooking_blog` index to get started:
```json
```

Now define the mappings for the index:
```json

{
  "properties": {
    "title": {
      "type": "text",
      "analyzer": "standard", <1>
      "fields": { <2>
        "keyword": {
          "type": "keyword",
          "ignore_above": 256 <3>
        }
      }
    },
    "description": {
      "type": "text" <1>
    },
    "author": {
      "type": "text",
      "fields": {
        "keyword": {
          "type": "keyword"
        }
      }
    },
    "date": {
      "type": "date",
      "format": "yyyy-MM-dd"
    },
    "category": {
      "type": "text",
      "fields": {
        "keyword": {
          "type": "keyword"
        }
      }
    },
    "tags": {
      "type": "text",
      "fields": {
        "keyword": {
          "type": "keyword"
        }
      }
    },
    "rating": {
      "type": "float"
    }
  }
}
```

<tip>
  Full-text search is powered by [text analysis](https://www.elastic.co/docs/solutions/search/full-text/text-analysis-during-search). Text analysis normalizes and standardizes text data so it can be efficiently stored in an inverted index and searched in near real-time. Analysis happens at both [index and search time](https://www.elastic.co/docs/manage-data/data-store/text-analysis/index-search-analysis). This tutorial won't cover analysis in detail, but it's important to understand how text is processed to create effective search queries.
</tip>


## Step 2: Add sample blog posts to your index

Next, you’ll need to index some example blog posts using the [Bulk API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-indices-put-settings). Note that `text` fields are analyzed and multi-fields are generated at index time.
```json

{"index":{"_id":"1"}}
{"title":"Perfect Pancakes: A Fluffy Breakfast Delight","description":"Learn the secrets to making the fluffiest pancakes, so amazing you won't believe your tastebuds. This recipe uses buttermilk and a special folding technique to create light, airy pancakes that are perfect for lazy Sunday mornings.","author":"Maria Rodriguez","date":"2023-05-01","category":"Breakfast","tags":["pancakes","breakfast","easy recipes"],"rating":4.8}
{"index":{"_id":"2"}}
{"title":"Spicy Thai Green Curry: A Vegetarian Adventure","description":"Dive into the flavors of Thailand with this vibrant green curry. Packed with vegetables and aromatic herbs, this dish is both healthy and satisfying. Don't worry about the heat - you can easily adjust the spice level to your liking.","author":"Liam Chen","date":"2023-05-05","category":"Main Course","tags":["thai","vegetarian","curry","spicy"],"rating":4.6}
{"index":{"_id":"3"}}
{"title":"Classic Beef Stroganoff: A Creamy Comfort Food","description":"Indulge in this rich and creamy beef stroganoff. Tender strips of beef in a savory mushroom sauce, served over a bed of egg noodles. It's the ultimate comfort food for chilly evenings.","author":"Emma Watson","date":"2023-05-10","category":"Main Course","tags":["beef","pasta","comfort food"],"rating":4.7}
{"index":{"_id":"4"}}
{"title":"Vegan Chocolate Avocado Mousse","description":"Discover the magic of avocado in this rich, vegan chocolate mousse. Creamy, indulgent, and secretly healthy, it's the perfect guilt-free dessert for chocolate lovers.","author":"Alex Green","date":"2023-05-15","category":"Dessert","tags":["vegan","chocolate","avocado","healthy dessert"],"rating":4.5}
{"index":{"_id":"5"}}
{"title":"Crispy Oven-Fried Chicken","description":"Get that perfect crunch without the deep fryer! This oven-fried chicken recipe delivers crispy, juicy results every time. A healthier take on the classic comfort food.","author":"Maria Rodriguez","date":"2023-05-20","category":"Main Course","tags":["chicken","oven-fried","healthy"],"rating":4.9}
```


## Step 3: Basic search operations

Full-text search involves executing text-based queries across one or more document fields. In this section, you'll start with simple text matching and build up to understanding how search results are ranked.
ES|QL provides multiple functions for full-text search, including `MATCH`, `MATCH_PHRASE`, and `QSTR`. For basic text matching, you can use either:
1. Full [match function](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match) syntax: `match(field, "search terms")`
2. Compact syntax using the [match operator "`:`"](/docs/reference/query-languages/esql/functions-operators/operators#esql-match-operator): `field:"search terms"`

Both are equivalent for basic matching and can be used interchangeably. The compact syntax is more concise, while the function syntax allows for more configuration options. We use the compact syntax in most examples for brevity.
Refer to the [`MATCH` function](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match) reference docs for advanced parameters available with the function syntax.

### Perform your first search query

Let's start with the simplest possible search - looking for documents that contain specific words:
```esql
FROM cooking_blog
| WHERE description:"fluffy pancakes"
| LIMIT 1000
```

This query searches the `description` field for documents containing either "fluffy" OR "pancakes" (or both). By default, ES|QL uses OR logic between search terms, so it matches documents that contain any of the specified words.

### Control which fields appear in results

You can specify the exact fields to include in your results using the `KEEP` command:
```esql
FROM cooking_blog
| WHERE description:"fluffy pancakes"
| KEEP title, description, rating
| LIMIT 1000
```

This helps reduce the amount of data returned and focuses on the information you need.

### Understand relevance scoring

Search results can be ranked based on how well they match your query. To calculate and use relevance scores, you need to explicitly request the `_score` metadata:
```esql
FROM cooking_blog METADATA _score
| WHERE description:"fluffy pancakes"
| KEEP title, description, _score
| SORT _score DESC
| LIMIT 1000
```

Notice two important things:
1. `METADATA _score` tells ES|QL to include relevance scores in the results
2. `SORT _score DESC` orders results by relevance (highest scores first)

If you don't include `METADATA _score` in your query, you won't see relevance scores in your results. This means you won't be able to sort by relevance or filter based on relevance scores.
Without explicit sorting, results aren't ordered by relevance even when scores are calculated. If you want the most relevant results first, you must sort by `_score`, by explicitly using `SORT _score DESC` or `SORT _score ASC`.
<tip>
  When you include `METADATA _score`, search functions included in `WHERE` conditions contribute to the relevance score. Filtering operations (like range conditions and exact matches) don't affect the score.
</tip>


### Find exact matches

Sometimes you need exact matches rather than full-text search. Use the `.keyword` field for case-sensitive exact matching:
```esql
FROM cooking_blog
| WHERE category.keyword == "Breakfast" 
| KEEP title, category, rating
| SORT rating DESC
| LIMIT 1000
```

This is fundamentally different from full-text search - it's a binary yes/no filter that doesn't affect relevance scoring.

## Step 4: Search precision control

Now that you understand basic searching, explore how to control the precision of your text matches.

### Require all search terms (`AND` logic)

By default, searches with match use OR logic between terms. To require ALL terms to match, use the function syntax with the `operator` parameter to specify AND logic:
```esql
FROM cooking_blog
| WHERE match(description, "fluffy pancakes", {"operator": "AND"})
| LIMIT 1000
```

This stricter search returns *zero hits* on our sample data, as no document contains both "fluffy" and "pancakes" in the description.
<note>
  The `MATCH` function with AND logic doesn't require terms to be adjacent or in order. It only requires that all terms appear somewhere in the field. Use `MATCH_PHRASE` to [search for exact phrases](#search-for-exact-phrases).
</note>


### Set a minimum number of terms to match

Sometimes requiring all terms is too strict, but the default OR behavior is too lenient. You can specify a minimum number of terms that must match:
```esql
FROM cooking_blog
| WHERE match(title, "fluffy pancakes breakfast", {"minimum_should_match": 2})
| LIMIT 1000
```

This query searches the title field to match at least 2 of the 3 terms: "fluffy", "pancakes", or "breakfast".

### Search for exact phrases

When you need to find documents containing an exact sequence of words, use the `MATCH_PHRASE` function:
```esql
FROM cooking_blog
| WHERE MATCH_PHRASE(description, "rich and creamy")
| KEEP title, description
| LIMIT 1000
```

This query only matches documents where the words "rich and creamy" appear exactly in that order in the description field.

## Step 5: Multi-field search and query strings

Once you're comfortable with basic search precision, learn how to search across multiple fields and use query string syntax for complex patterns.

### Use query string for complex patterns

The `QSTR` function enables powerful search patterns using a compact query language. It's ideal for when you need wildcards, fuzzy matching, and boolean logic in a single expression:
```esql
FROM cooking_blog
| WHERE QSTR("description: (fluffy AND pancak*) OR (creamy -vegan)")
| KEEP title, description
| LIMIT 1000
```

Query string syntax lets you:
- Use boolean operators: `AND`, `OR`, `-` (NOT)
- Apply wildcards: `pancak*` matches "pancake" and "pancakes"
- Enable fuzzy matching: `pancake~1` for typo tolerance
- Group terms: `(thai AND curry) OR pasta`
- Search exact phrases: `"fluffy pancakes"`
- Search across fields: `QSTR("(title:pancake OR description:pancake) AND creamy")`


### Search across multiple fields

When users enter a search query, they often don't know (or care) whether their search terms appear in a specific field. You can search across multiple fields simultaneously:
```esql
FROM cooking_blog
| WHERE title:"vegetarian curry" OR description:"vegetarian curry" OR tags:"vegetarian curry"
| LIMIT 1000
```

This query searches for "vegetarian curry" across the title, description, and tags fields. Each field is treated with equal importance.

### Weight different fields

In many cases, matches in certain fields (like the title) might be more relevant than others. You can adjust the importance of each field using boost scoring:
```esql
FROM cooking_blog METADATA _score
| WHERE MATCH(title, "vegetarian curry", {"boost": 2.0}) 
    OR MATCH(description, "vegetarian curry")
    OR MATCH(tags, "vegetarian curry")
| KEEP title, description, tags, _score
| SORT _score DESC
| LIMIT 1000
```


## Step 6: Filtering and exact matching

Filtering allows you to narrow down your search results based on exact criteria. Unlike full-text searches, filters are binary (yes/no) and do not affect the relevance score. Filters execute faster than queries because excluded results don't need to be scored.

### Basic filtering by category

```esql
FROM cooking_blog
| WHERE category.keyword == "Breakfast" 
| KEEP title, author, rating, tags
| SORT rating DESC
| LIMIT 1000
```


### Date range filtering

Often users want to find content published within a specific time frame:
```esql
FROM cooking_blog
| WHERE date >= "2023-05-01" AND date <= "2023-05-31" 
| KEEP title, author, date, rating
| LIMIT 1000
```


### Numerical range filtering

Filter by ratings or other numerical values:
```esql
FROM cooking_blog
| WHERE rating >= 4.5 
| KEEP title, author, rating, tags
| SORT rating DESC
| LIMIT 1000
```


### Exact author matching

Find recipes by a specific author:
```esql
FROM cooking_blog
| WHERE author.keyword == "Maria Rodriguez" 
| KEEP title, author, rating, tags
| SORT rating DESC
| LIMIT 1000
```


## Step 7: Complex search solutions

Real-world search often requires combining multiple types of criteria. This section shows how to build sophisticated search experiences by combining the techniques you've learned.

### Combine filters with full-text search

Mix filters, full-text search, and custom scoring in a single query:
```esql
FROM cooking_blog METADATA _score
| WHERE rating >= 4.5 
    AND NOT category.keyword == "Dessert" 
    AND (title:"curry spicy" OR description:"curry spicy") 
| SORT _score DESC
| KEEP title, author, rating, tags, description
| LIMIT 1000
```


### Advanced relevance scoring

For complex relevance scoring with combined criteria, you can use the `EVAL` command to calculate custom scores:
```esql
FROM cooking_blog METADATA _score
| WHERE NOT category.keyword == "Dessert"
| EVAL tags_concat = MV_CONCAT(tags.keyword, ",") 
| WHERE tags_concat LIKE "*vegetarian*" AND rating >= 4.5 
| WHERE MATCH(title, "curry spicy", {"boost": 2.0}) OR MATCH(description, "curry spicy")
| EVAL category_boost = CASE(category.keyword == "Main Course", 1.0, 0.0) 
| EVAL date_boost = CASE(DATE_DIFF("month", date, NOW()) <= 1, 0.5, 0.0) 
| EVAL custom_score = _score + category_boost + date_boost 
| WHERE custom_score > 0 
| SORT custom_score DESC
| LIMIT 1000
```


## Step 8: Semantic search and hybrid search


### Index semantic content

Elasticsearch allows you to semantically search for documents based on the meaning of the text, rather than just the presence of specific keywords. This is useful when you want to find documents that are conceptually similar to a given query, even if they don't contain the exact search terms.
ESQL supports semantic search when your mappings include fields of the [`semantic_text`](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/semantic-text) type. This example mapping update adds a new field called `semantic_description` with the type `semantic_text`:
```json

{
  "properties": {
    "semantic_description": {
      "type": "semantic_text"
    }
  }
}
```

Next, index a document with content into the new field:
```json

{
  "title": "Mediterranean Quinoa Bowl",
  "semantic_description": "A protein-rich bowl with quinoa, chickpeas, fresh vegetables, and herbs. This nutritious Mediterranean-inspired dish is easy to prepare and perfect for a quick, healthy dinner.",
  "author": "Jamie Oliver",
  "date": "2023-06-01",
  "category": "Main Course",
  "tags": ["vegetarian", "healthy", "mediterranean", "quinoa"],
  "rating": 4.7
}
```


### Perform semantic search

Once the document has been processed by the underlying model running on the inference endpoint, you can perform semantic searches. Use the [`MATCH` function](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match) (or the ["`:`" operator](/docs/reference/query-languages/esql/functions-operators/operators#esql-match-operator) shorthand) on `semantic_text` fields to perform semantic queries:
```esql
FROM cooking_blog METADATA _score
| WHERE semantic_description:"I need plant-based meals that aren't difficult to make"
| SORT _score DESC
| LIMIT 5
```

When you use `MATCH` or "`:`" on a `semantic_text` field, ES|QL automatically performs a semantic search rather than a lexical search. This means the query finds documents based on semantic similarity, not just keyword matching.
<tip>
  If you'd like to test out the semantic search workflow against a large dataset, follow the [semantic-search-tutorial](https://www.elastic.co/docs/solutions/search/semantic-search/semantic-search-semantic-text).
</tip>


### Perform hybrid search

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

Hybrid search combines different search strategies (like lexical and semantic search) to leverage the strengths of each approach. Use [`FORK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fork) and [`FUSE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fuse) to execute different search strategies in parallel, then merge and score the combined results.
`FUSE` supports different merging algorithms, namely Reciprocal Rank Fusion (RRF) and linear combination.
<tab-set>
  <tab-item title="RRF (default)">
    RRF is a ranking algorithm that combines rankings from multiple search strategies without needing to tune weights. It's effective when you want to blend different search approaches without manual score tuning.
    ```esql
    FROM cooking_blog METADATA _id, _index, _score
    | FORK (
        WHERE title:"vegetarian curry" 
        | SORT _score DESC
        | LIMIT 5
    ) (
        WHERE semantic_description:"easy vegetarian curry recipes" 
        | SORT _score DESC
        | LIMIT 5
    )
    | FUSE 
    | KEEP title, description, rating, _score
    | SORT _score DESC
    | LIMIT 5
    ```
  </tab-item>

  <tab-item title="Linear combination">
    Linear combination allows you to specify explicit weights for each search strategy. This gives you fine-grained control over how much each strategy contributes to the final score.
    ```esql
    FROM cooking_blog METADATA _id, _index, _score
    | FORK (
        WHERE title:"vegetarian curry" 
        | SORT _score DESC
        | LIMIT 5
    ) (
        WHERE semantic_description:"easy vegetarian curry recipes" 
        | SORT _score DESC
        | LIMIT 5
    )
    | FUSE LINEAR WITH { "weights": { "fork1": 0.7, "fork2": 0.3 } } 
    | KEEP title, description, rating, _score
    | SORT _score DESC
    | LIMIT 5
    ```
  </tab-item>
</tab-set>


## Step 9: Advanced AI-powered search

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

ES|QL provides commands for AI-powered search enhancements and text generation tasks. You will need to set up an inference endpoint with appropriate models to follow along with these examples.

### Semantic reranking with `RERANK`

The [`RERANK` command](https://www.elastic.co/docs/reference/query-languages/esql/commands/rerank) re-scores search results using inference models for improved relevance. This is particularly useful for improving the ranking of initial search results by applying more sophisticated semantic understanding.
<tip>
  `RERANK` requires an inference endpoint configured for the `rerank` task. Refer to the [setup instructions](https://www.elastic.co/docs/explore-analyze/machine-learning/nlp/ml-nlp-rerank#ml-nlp-rerank-deploy).
</tip>

```esql
FROM cooking_blog METADATA _score
| WHERE description:"vegetarian recipes" 
| SORT _score DESC
| LIMIT 100 
| RERANK "healthy quick meals" ON description 
| LIMIT 5 
| KEEP title, description, _score
```

You can configure `RERANK` to use a specific reranking model. See the [`RERANK` command documentation](https://www.elastic.co/docs/reference/query-languages/esql/commands/rerank) for configuration options.

### Text generation with `COMPLETION`

<tip>
  COMPLETION requires a configured inference endpoint with an LLM. Refer to the [Inference API documentation](https://www.elastic.co/docs/explore-analyze/elastic-inference/inference-api) for setup instructions.
</tip>

The [`COMPLETION` command](https://www.elastic.co/docs/reference/query-languages/esql/commands/completion) sends prompts to a Large Language Model (LLM) for text generation tasks like question answering, summarization, or translation.
```esql
FROM cooking_blog
| WHERE category.keyword == "Dessert"
| LIMIT 3
| EVAL prompt = CONCAT("Summarize this recipe: ", title, " - ", description)
| COMPLETION summary = prompt WITH { "inference_id": "my_llm_endpoint" }
| KEEP title, summary
```

This enables you to:
- Generate summaries of search results
- Answer questions about document content
- Translate or transform text using LLMs
- Create dynamic content based on your data


### Vector search with KNN, similarity functions and TEXT_EMBEDDING

<note>
  This subsection is for advanced users who want explicit control over vector search. For most use cases, the `semantic_text` field type covered in [Step 8](#step-8-semantic-search-and-hybrid-search) is recommended as it handles embeddings automatically.
</note>

The [`KNN` function](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-knn) finds the k nearest vectors to a query vector through approximate search on indexed `dense_vector` fields.

#### `KNN` with pre-computed vectors

First, add a `dense_vector` field and index a document with a pre-computed vector. This example uses a toy example for readability: the vector has only 3 dimensions.
```json

{
  "properties": {
    "recipe_vector": {
      "type": "dense_vector",
      "dims": 3
    }
  }
}


{
  "title": "Quick Vegan Stir-Fry",
  "description": "A fast and healthy vegan stir-fry with tofu and vegetables",
  "recipe_vector": [0.5, 0.8, 0.3],
  "rating": 4.6
}
```

Then search using a query vector:
```esql
FROM cooking_blog METADATA _score
| WHERE KNN(recipe_vector, [0.5, 0.8, 0.3])
| SORT _score DESC
| LIMIT 5
```


#### `KNN` with `TEXT_EMBEDDING`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

The [`TEXT_EMBEDDING` function](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-text_embedding)  generates dense vector embeddings from text input at query time using an inference model.
<tip>
  You'll need to set up an inference endpoint with an embedding model to use this feature. Refer to the [Inference API documentation](https://www.elastic.co/docs/explore-analyze/elastic-inference/inference-api) for setup instructions.
</tip>

```esql
FROM cooking_blog METADATA _score
| WHERE KNN(recipe_vector, TEXT_EMBEDDING("vegan recipe", "my_embedding_model"))
| SORT _score DESC
| LIMIT 5
```

This approach gives you full control over vector embeddings, unlike `semantic_text` which handles embeddings automatically.
<note>
  The vectors in your index must be generated by the same embedding model you specify in `TEXT_EMBEDDING`, otherwise the similarity calculations will be meaningless and you won't get relevant results.
</note>


#### Exact vector search with similarity functions

<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Planned
</applies-to>

While `KNN` performs approximate nearest neighbor search, ES|QL also provides [vector similarity functions](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#vector-similarity-functions) for exact vector search. These functions calculate similarity over all the query vectors, guaranteeing accurate results at the cost of slower performance.
<tip>
  **When to use exact search instead of KNN**Use [vector similarity functions](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#vector-similarity-functions) when:
  - Accuracy is more important than speed.
  - Your dataset is small enough for exhaustive search, or you are applying restrictive filters. 10,000 documents is a good rule of thumb for using exact search, but results depend on your vector [element type](/docs/reference/elasticsearch/mapping-reference/dense-vector#dense-vector-quantization) and use of [quantization](/docs/reference/elasticsearch/mapping-reference/dense-vector#dense-vector-quantization).
  - You want to provide custom scoring using vector similarity.
  To learn more, read this blog: [how to choose between exact and approximate kNN search in Elasticsearch](https://www.elastic.co/search-labs/blog/knn-exact-vs-approximate-search).
</tip>

**Example: Cosine similarity with threshold filtering**
```esql
FROM cooking_blog
| EVAL similarity = V_COSINE(recipe_vector, TEXT_EMBEDDING("vegan recipe", "my_embedding_model"))
| WHERE similarity > 0.8
| SORT similarity DESC
| LIMIT 10
```

This query:
1. Calculates exact cosine similarity between each document's vector and the query vector (calculated via TEXT_EMBEDDING) using the [V_COSINE function](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-v_cosine)
2. Filters results to only include results with vector similarity above 0.8
3. Sorts by similarity (highest first)

**Example: Combining exact vector search with other filters**
```esql
FROM cooking_blog
| WHERE category.keyword == "Main Course" AND rating >= 4.5
| EVAL similarity = V_COSINE(recipe_vector, TEXT_EMBEDDING("vegan recipe", "my_embedding_model"))
| EVAL combined_score = similarity + (rating / 5.0)
| SORT combined_score DESC
| LIMIT 10
```

This advanced query combines:
1. Exact filters (category) and range filters (rating)
2. Exact vector similarity using the [V_COSINE function](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-v_dot_product)
3. Custom scoring that blends vector similarity with rating


## Learn more


### Documentation

This tutorial introduced search, filtering, and AI-powered capabilities in ES|QL. Here are some resources once you're ready to dive deeper:
- [Search with ES|QL](https://www.elastic.co/docs/solutions/search/esql-for-search): Learn about all search capabilities in ES|QL.
- [Semantic search](https://www.elastic.co/docs/solutions/search/semantic-search): Understand your various options for semantic search in Elasticsearch.
  - [The `semantic_text` workflow](https://www.elastic.co/docs/solutions/search/semantic-search#_semantic_text_workflow): Learn how to use the `semantic_text` field type for semantic search. This is the recommended approach for most users looking to perform semantic search in Elasticsearch, because it abstracts away the complexity of setting up inference endpoints and models.
- [Inference API](https://www.elastic.co/docs/explore-analyze/elastic-inference/inference-api): Set up inference endpoints for the `RERANK`, `COMPLETION`, and `TEXT_EMBEDDING` commands.


### Related blog posts

- [ES|QL, you know for Search](https://www.elastic.co/search-labs/blog/esql-introducing-scoring-semantic-search): Introducing scoring and semantic search
- [Introducing full text filtering in ES|QL](https://www.elastic.co/search-labs/blog/filtering-in-esql-full-text-search-match-qstr): Overview of ES|QL's text filtering capabilities﻿---
title: ES|QL dense vector functions
description: ES|QL supports dense vector functions for vector similarity calculations and k-nearest neighbor search. Dense vector functions work with  dense_vector...
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/dense-vector-functions
applies_to:
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
---

# ES|QL dense vector functions
<tip>
  For more examples of these functions in action, refer to [the ES|QL for search tutorial](/docs/reference/query-languages/esql/esql-search-tutorial#vector-search-with-knn-similarity-functions-and-text_embedding).
</tip>

ES|QL supports dense vector functions for vector similarity calculations and
k-nearest neighbor search.
Dense vector functions work with [
`dense_vector` fields](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/dense-vector)
and require appropriate field mappings.
ES|QL supports these vector functions:
- [`KNN`](#esql-knn) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`TEXT_EMBEDDING`](#esql-text_embedding) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`V_COSINE`](#esql-v_cosine) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`V_DOT_PRODUCT`](#esql-v_dot_product) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`V_HAMMING`](#esql-v_hamming) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`V_L1_NORM`](#esql-v_l1_norm) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`V_L2_NORM`](#esql-v_l2_norm) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>


## `KNN`

<applies-to>
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/knn.svg)

**Parameters**
<definitions>
  <definition term="field">
    Field that the query will target. knn function can be used with dense_vector or semantic_text fields. Other text fields are not allowed
  </definition>
  <definition term="query">
    Vector value to find top nearest neighbours for.
  </definition>
  <definition term="options">
    (Optional) kNN additional options as [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params). See [knn query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-knn-query) for more information.
  </definition>
</definitions>

**Description**
Finds the k nearest vectors to a query vector, as measured by a similarity metric. knn function finds nearest vectors through approximate search on indexed dense_vectors or semantic_text fields.
**Supported types**

| field        | query        | options          | result  |
|--------------|--------------|------------------|---------|
| dense_vector | dense_vector | named parameters | boolean |
| text         | dense_vector | named parameters | boolean |

**Supported function named parameters**
<definitions>
  <definition term="boost">
    (float) Floating point number used to decrease or increase the relevance scores of the query.Defaults to 1.0.
  </definition>
  <definition term="k">
    (integer) The number of nearest neighbors to return from each shard. Elasticsearch collects k results from each shard, then merges them to find the global top results. This value must be less than or equal to num_candidates. This value is automatically set with any LIMIT applied to the function.
  </definition>
  <definition term="visit_percentage">
    (float) The percentage of vectors to explore per shard while doing knn search with bbq_disk. Must be between 0 and 100. 0 will default to using num_candidates for calculating the percent visited. Increasing visit_percentage tends to improve the accuracy of the final results. If visit_percentage is set for bbq_disk, num_candidates is ignored. Defaults to ~1% per shard for every 1 million vectors
  </definition>
  <definition term="min_candidates">
    (integer) The minimum number of nearest neighbor candidates to consider per shard while doing knn search.  KNN may use a higher number of candidates in case the query can't use a approximate results. Cannot exceed 10,000. Increasing min_candidates tends to improve the accuracy of the final results. Defaults to 1.5 * k (or LIMIT) used for the query.
  </definition>
  <definition term="rescore_oversample">
    (double) Applies the specified oversampling for rescoring quantized vectors. See [oversampling and rescoring quantized vectors](https://www.elastic.co/docs/solutions/search/vector/knn#dense-vector-knn-search-rescoring) for details.
  </definition>
  <definition term="similarity">
    (double) The minimum similarity required for a document to be considered a match. The similarity value calculated relates to the raw similarity used, not the document score.
  </definition>
</definitions>

**Example**
```esql
from colors metadata _score
| where knn(rgb_vector, [0, 120, 0])
| sort _score desc, color asc
```


| color:text | rgb_vector:dense_vector |
|------------|-------------------------|
| green      | [0.0, 128.0, 0.0]       |
| black      | [0.0, 0.0, 0.0]         |
| olive      | [128.0, 128.0, 0.0]     |
| teal       | [0.0, 128.0, 128.0]     |
| lime       | [0.0, 255.0, 0.0]       |
| sienna     | [160.0, 82.0, 45.0]     |
| maroon     | [128.0, 0.0, 0.0]       |
| navy       | [0.0, 0.0, 128.0]       |
| gray       | [128.0, 128.0, 128.0]   |
| chartreuse | [127.0, 255.0, 0.0]     |


## `TEXT_EMBEDDING`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/text_embedding.svg)

**Parameters**
<definitions>
  <definition term="text">
    Text string to generate embeddings from. Must be a non-null literal string value.
  </definition>
  <definition term="inference_id">
    Identifier of an existing inference endpoint the that will generate the embeddings. The inference endpoint must have the `text_embedding` task type and should use the same model that was used to embed your indexed data.
  </definition>
</definitions>

**Description**
Generates dense vector embeddings from text input using a specified [inference endpoint](https://www.elastic.co/docs/explore-analyze/elastic-inference/inference-api). Use this function to generate query vectors for KNN searches against your vectorized data or others dense vector based operations.
**Supported types**

| text    | inference_id | result       |
|---------|--------------|--------------|
| keyword | keyword      | dense_vector |

**Example**
Generate text embeddings using the 'test_dense_inference' inference endpoint.
```esql
FROM dense_vector_text METADATA _score
| WHERE KNN(text_embedding_field, TEXT_EMBEDDING("be excellent to each other", "test_dense_inference"))
```


## Vector similarity functions

Vector similarity functions calculate the similarity between two vectors as a double value, that represents how similar the vectors are.

### `V_COSINE`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/v_cosine.svg)

**Parameters**
<definitions>
  <definition term="left">
    first dense_vector to calculate cosine similarity
  </definition>
  <definition term="right">
    second dense_vector to calculate cosine similarity
  </definition>
</definitions>

**Description**
Calculates the cosine similarity between two dense_vectors.
**Supported types**

| left         | right        | result |
|--------------|--------------|--------|
| dense_vector | dense_vector | double |

**Example**
```esql
from colors
| where color != "black"
| eval similarity = v_cosine(rgb_vector, [0, 255, 255])
| sort similarity desc, color asc
```


| color:text  | similarity:double  |
|-------------|--------------------|
| cyan        | 1.0                |
| teal        | 1.0                |
| turquoise   | 0.9781067967414856 |
| aqua marine | 0.929924726486206  |
| azure       | 0.8324936032295227 |
| lavender    | 0.827340304851532  |
| mint cream  | 0.8245516419410706 |
| honeydew    | 0.8244848847389221 |
| gainsboro   | 0.8164966106414795 |
| gray        | 0.8164966106414795 |


### `V_DOT_PRODUCT`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/v_dot_product.svg)

**Parameters**
<definitions>
  <definition term="left">
    first dense_vector to calculate dot product similarity
  </definition>
  <definition term="right">
    second dense_vector to calculate dot product similarity
  </definition>
</definitions>

**Description**
Calculates the dot product between two dense_vectors.
**Supported types**

| left         | right        | result |
|--------------|--------------|--------|
| dense_vector | dense_vector | double |

**Example**
```esql
from colors
| eval similarity = v_dot_product(rgb_vector, [0, 255, 255])
| sort similarity desc, color asc
```


| color:text | similarity:double |
|------------|-------------------|
| azure      | 130050.0          |
| cyan       | 130050.0          |
| white      | 130050.0          |
| mint cream | 128775.0          |
| snow       | 127500.0          |
| honeydew   | 126225.0          |
| ivory      | 126225.0          |
| sea shell  | 123165.0          |
| lavender   | 122400.0          |
| old lace   | 121125.0          |


### `V_HAMMING`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/v_hamming.svg)

**Parameters**
<definitions>
  <definition term="left">
    First dense_vector to use to calculate the Hamming distance
  </definition>
  <definition term="right">
    Second dense_vector to use to calculate the Hamming distance
  </definition>
</definitions>

**Description**
Calculates the Hamming distance between two dense vectors.
**Supported types**

| left         | right        | result |
|--------------|--------------|--------|
| dense_vector | dense_vector | double |

**Example**
```esql
from colors
| eval similarity = v_hamming(rgb_byte_vector, [0, 127, 127])
| sort similarity desc, color asc
```


| color:text | similarity:double |
|------------|-------------------|
| red        | 23.0              |
| indigo     | 19.0              |
| orange     | 19.0              |
| black      | 17.0              |
| gold       | 17.0              |
| bisque     | 16.0              |
| chartreuse | 16.0              |
| green      | 16.0              |
| maroon     | 16.0              |
| navy       | 16.0              |


### `V_L1_NORM`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/v_l1_norm.svg)

**Parameters**
<definitions>
  <definition term="left">
    first dense_vector to calculate l1 norm similarity
  </definition>
  <definition term="right">
    second dense_vector to calculate l1 norm similarity
  </definition>
</definitions>

**Description**
Calculates the l1 norm between two dense_vectors.
**Supported types**

| left         | right        | result |
|--------------|--------------|--------|
| dense_vector | dense_vector | double |

**Example**
```esql
from colors
| eval similarity = v_l1_norm(rgb_vector, [0, 255, 255])
| sort similarity desc, color asc
```


| color:text | similarity:double |
|------------|-------------------|
| red        | 765.0             |
| crimson    | 650.0             |
| maroon     | 638.0             |
| firebrick  | 620.0             |
| orange     | 600.0             |
| tomato     | 595.0             |
| brown      | 591.0             |
| chocolate  | 585.0             |
| coral      | 558.0             |
| gold       | 550.0             |

lists/dense-vector-functions.md

### `V_L2_NORM`

<applies-to>
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/v_l2_norm.svg)

**Parameters**
<definitions>
  <definition term="left">
    first dense_vector to calculate l2 norm similarity
  </definition>
  <definition term="right">
    second dense_vector to calculate l2 norm similarity
  </definition>
</definitions>

**Description**
Calculates the l2 norm between two dense_vectors.
**Supported types**

| left         | right        | result |
|--------------|--------------|--------|
| dense_vector | dense_vector | double |

**Example**
```esql
from colors
| eval similarity = v_l2_norm(rgb_vector, [0, 255, 255])
| sort similarity desc, color asc
```


| color:text | similarity:double  |
|------------|--------------------|
| red        | 441.6729431152344  |
| maroon     | 382.6669616699219  |
| crimson    | 376.36419677734375 |
| orange     | 371.68536376953125 |
| gold       | 362.8360595703125  |
| black      | 360.62445068359375 |
| magenta    | 360.62445068359375 |
| yellow     | 360.62445068359375 |
| firebrick  | 359.67486572265625 |
| tomato     | 351.0227966308594  |﻿---
title: Use the ES|QL REST API
description: The _query API accepts an ES|QL query string in the query parameter, runs it, and returns the results. For example: Which returns: We recommend using...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-rest
products:
  - Elasticsearch
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Use the ES|QL REST API
<tip>
  The [Search and filter with ES|QL](https://www.elastic.co/docs/reference/query-languages/esql/esql-search-tutorial) tutorial provides a hands-on introduction to the ES|QL `_query` API.
</tip>


## Overview

The [`_query` API](https://www.elastic.co/docs/api/doc/elasticsearch/group/endpoint-esql) accepts an ES|QL query string in the `query` parameter, runs it, and returns the results. For example:
```json

{
  "query": "FROM library | KEEP author, name, page_count, release_date | SORT page_count DESC | LIMIT 5"
}
```

Which returns:
```text
     author      |        name        |  page_count   | release_date
-----------------+--------------------+---------------+------------------------
Peter F. Hamilton|Pandora's Star      |768            |2004-03-02T00:00:00.000Z
Vernor Vinge     |A Fire Upon the Deep|613            |1992-06-01T00:00:00.000Z
Frank Herbert    |Dune                |604            |1965-06-01T00:00:00.000Z
Alastair Reynolds|Revelation Space    |585            |2000-03-15T00:00:00.000Z
James S.A. Corey |Leviathan Wakes     |561            |2011-06-02T00:00:00.000Z
```


### Run the ES|QL query API in Console

We recommend using [Console](https://www.elastic.co/docs/explore-analyze/query-filter/tools/console) to run the ES|QL query API, because of its rich autocomplete features.
When creating the query, using triple quotes (`"""`) allows you to use special characters like quotes (`"`) without having to escape them. They also make it easier to write multi-line requests.
```json

{
  "query": """
    FROM library
    | KEEP author, name, page_count, release_date
    | SORT page_count DESC
    | LIMIT 5
  """
}
```


### Response formats

ES|QL can return the data in the following human readable and binary formats. You can set the format by specifying the `format` parameter in the URL or by setting the `Accept` or `Content-Type` HTTP header.
For example:
```json

{
  "query": """
    FROM library
    | KEEP author, name, page_count, release_date
    | SORT page_count DESC
    | LIMIT 5
  """
}
```

<note>
  The URL parameter takes precedence over the HTTP headers. If neither is specified then the response is returned in the same format as the request.
</note>


#### Structured formats

Complete responses with metadata. Useful for automatic parsing.

| `format` | HTTP header        | Description                                                                                   |
|----------|--------------------|-----------------------------------------------------------------------------------------------|
| `json`   | `application/json` | [JSON](https://www.json.org/) (JavaScript Object Notation) human-readable format              |
| `yaml`   | `application/yaml` | [YAML](https://en.wikipedia.org/wiki/YAML) (YAML Ain’t Markup Language) human-readable format |


#### Tabular formats

Query results only, without metadata. Useful for quick and manual data previews.

| `format` | HTTP header                 | Description                                                                    |
|----------|-----------------------------|--------------------------------------------------------------------------------|
| `csv`    | `text/csv`                  | [Comma-separated values](https://en.wikipedia.org/wiki/Comma-separated_values) |
| `tsv`    | `text/tab-separated-values` | [Tab-separated values](https://en.wikipedia.org/wiki/Tab-separated_values)     |
| `txt`    | `text/plain`                | CLI-like representation                                                        |

<tip>
  The `csv` format accepts a formatting URL query attribute, `delimiter`, which indicates which character should be used to separate the CSV values. It defaults to comma (`,`) and cannot take any of the following values: double quote (`"`), carriage-return (`\r`) and new-line (`\n`). The tab (`\t`) can also not be used. Use the `tsv` format instead.
</tip>


#### Binary formats

Compact binary encoding. To be used by applications.

| `format` | HTTP header                           | Description                                                                                                                                                             |
|----------|---------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cbor`   | `application/cbor`                    | [Concise Binary Object Representation](https://cbor.io/)                                                                                                                |
| `smile`  | `application/smile`                   | [Smile](https://en.wikipedia.org/wiki/Smile_(data_interchange_format)) binary data format similarto CBOR                                                                |
| `arrow`  | `application/vnd.apache.arrow.stream` | **Experimental.** [Apache Arrow](https://arrow.apache.org/) dataframes, [IPC streaming format](https://arrow.apache.org/docs/format/Columnar.html#ipc-streaming-format) |


### Filtering using Elasticsearch Query DSL

Specify a Query DSL query in the `filter` parameter to filter the set of documents that an ES|QL query runs on.
```json

{
  "query": """
    FROM library
    | KEEP author, name, page_count, release_date
    | SORT page_count DESC
    | LIMIT 5
  """,
  "filter": {
    "range": {
      "page_count": {
        "gte": 100,
        "lte": 200
      }
    }
  }
}
```

Which returns:
```text
    author     |                name                |  page_count   | release_date
---------------+------------------------------------+---------------+------------------------
Douglas Adams  |The Hitchhiker's Guide to the Galaxy|180            |1979-10-12T00:00:00.000Z
```


#### Filter vs WHERE clause behavior

The `filter` parameter can eliminate columns from the result set when it skips entire indices.
This is useful for resolving type conflicts between attributes of different indices.
For example, if several days of data in a data stream were indexed with an incorrect type, you can use a filter to exclude the incorrect range.
This allows ES|QL to use the correct type for the remaining data without changing the source pattern.

##### Example

Consider querying `index-1` with an `f1` attribute and `index-2` with an `f2` attribute.
Using a filter the following query returns only the `f1` column:
```json

{
  "query": "FROM index-*",
  "filter": {
    "term": {
      "f1": "*"
    }
  }
}
```

Using a WHERE clause returns both the `f1` and `f2` columns:
```json

{
  "query": "FROM index-* WHERE f1 is not null"
}
```


### Columnar results

By default, ES|QL returns results as rows. For example, `FROM` returns each individual document as one row. For the `json`, `yaml`, `cbor` and `smile` [formats](#esql-rest-format), ES|QL can return the results in a columnar fashion where one row represents all the values of a certain column in the results.
```json

{
  "query": """
    FROM library
    | KEEP author, name, page_count, release_date
    | SORT page_count DESC
    | LIMIT 5
  """,
  "columnar": true
}
```

Which returns:
```json
{
  "took": 28,
  "is_partial": false,
  "columns": [
    {"name": "author", "type": "text"},
    {"name": "name", "type": "text"},
    {"name": "page_count", "type": "integer"},
    {"name": "release_date", "type": "date"}
  ],
  "values": [
    ["Peter F. Hamilton", "Vernor Vinge", "Frank Herbert", "Alastair Reynolds", "James S.A. Corey"],
    ["Pandora's Star", "A Fire Upon the Deep", "Dune", "Revelation Space", "Leviathan Wakes"],
    [768, 613, 604, 585, 561],
    ["2004-03-02T00:00:00.000Z", "1992-06-01T00:00:00.000Z", "1965-06-01T00:00:00.000Z", "2000-03-15T00:00:00.000Z", "2011-06-02T00:00:00.000Z"]
  ]
}
```


### Returning localized results

Use the `locale` parameter in the request body to return results (especially dates) formatted per the conventions of the locale. If `locale` is not specified, defaults to `en-US` (English). Refer to [JDK Supported Locales](https://www.oracle.com/java/technologies/javase/jdk17-suported-locales.html).
Syntax: the `locale` parameter accepts language tags in the (case-insensitive) format `xy` and `xy-XY`.
For example, to return a month name in French:
```json

{
  "locale": "fr-FR",
  "query": """
          ROW birth_date_string = "2023-01-15T00:00:00.000Z"
          | EVAL birth_date = date_parse(birth_date_string)
          | EVAL month_of_birth = DATE_FORMAT("MMMM",birth_date)
          | LIMIT 5
   """
}
```


### Passing parameters to a query

Values, for example for a condition, can be passed to a query "inline", by integrating the value in the query string itself:
```json

{
  "query": """
    FROM library
    | EVAL year = DATE_EXTRACT("year", release_date)
    | WHERE page_count > 300 AND author == "Frank Herbert"
    | STATS count = COUNT(*) by year
    | WHERE count > 0
    | LIMIT 5
  """
}
```

To avoid any attempts of hacking or code injection, extract the values in a separate list of parameters. Use question mark placeholders (`?`) in the query string for each of the parameters:
```json

{
  "query": """
    FROM library
    | EVAL year = DATE_EXTRACT("year", release_date)
    | WHERE page_count > ? AND author == ?
    | STATS count = COUNT(*) by year
    | WHERE count > ?
    | LIMIT 5
  """,
  "params": [300, "Frank Herbert", 0]
}
```

The parameters can be named parameters or positional parameters.
Named parameters use question mark placeholders (`?`) followed by a string.
```json

{
  "query": """
    FROM library
    | EVAL year = DATE_EXTRACT("year", release_date)
    | WHERE page_count > ?page_count AND author == ?author
    | STATS count = COUNT(*) by year
    | WHERE count > ?count
    | LIMIT 5
  """,
  "params": [{"page_count" : 300}, {"author" : "Frank Herbert"}, {"count" : 0}]
}
```

Positional parameters use question mark placeholders (`?`) followed by an integer.
```json

{
  "query": """
    FROM library
    | EVAL year = DATE_EXTRACT("year", release_date)
    | WHERE page_count > ?1 AND author == ?2
    | STATS count = COUNT(*) by year
    | WHERE count > ?3
    | LIMIT 5
  """,
  "params": [300, "Frank Herbert", 0]
}
```


### Running an async ES|QL query

The [ES|QL async query API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-esql-async-query) lets you asynchronously execute a query request, monitor its progress, and retrieve results when they become available.
Executing an ES|QL query is commonly quite fast, however queries across large data sets or frozen data can take some time. To avoid long waits, run an async ES|QL query.
Queries initiated by the async query API may return results or not. The `wait_for_completion_timeout` property determines how long to wait for the results. If the results are not available by this time, a [query id](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-esql-async-query#esql-async-query-api-response-body-query-id) is returned which can be later used to retrieve the results. For example:
```json

{
  "query": """
    FROM library
    | EVAL year = DATE_TRUNC(1 YEARS, release_date)
    | STATS MAX(page_count) BY year
    | SORT year
    | LIMIT 5
  """,
  "wait_for_completion_timeout": "2s"
}
```

If the results are not available within the given timeout period, 2 seconds in this case, no results are returned but rather a response that includes:
- A query ID
- An `is_running` value of *true*, indicating the query is ongoing

The query continues to run in the background without blocking other requests.
```json
{
  "id": "FmNJRUZ1YWZCU3dHY1BIOUhaenVSRkEaaXFlZ3h4c1RTWFNocDdnY2FSaERnUTozNDE=",
  "is_running": true
}
```

To check the progress of an async query, use the [ES|QL async query get API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-esql-async-query-get) with the query ID. Specify how long you’d like to wait for complete results in the `wait_for_completion_timeout` parameter.
```json
```

If the response’s `is_running` value is `false`, the query has finished and the results are returned, along with the `took` time for the query.
```json
{
  "is_running": false,
  "took": 48,
  "columns": ...
}
```

To stop a running async query and return the results computed so far, use the [async stop API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-esql-async-query-stop) with the query ID.
```json
```

The query will be stopped and the response will contain the results computed so far. The response format is the same as the `get` API.
```json
{
  "is_running": false,
  "took": 48,
  "is_partial": true,
  "columns": ...
}
```

This API can be used to retrieve results even if the query has already completed, as long as it's within the `keep_alive` window.
The `is_partial` field indicates result completeness. A value of `true` means the results are potentially incomplete.
Use the [ES|QL async query delete API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-esql-async-query-delete) to delete an async query before the `keep_alive` period ends. If the query is still running, Elasticsearch cancels it.
```json
```

<note>
  You will also receive the async ID and running status in the `X-Elasticsearch-Async-Id` and `X-Elasticsearch-Async-Is-Running` HTTP headers of the response, respectively.
  Useful if you use a tabular text format like `txt`, `csv` or `tsv`, as you won't receive those fields in the body there.
</note>﻿---
title: ES|QL KEEP command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/keep
---

# ES|QL KEEP command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `KEEP` processing command enables you to specify what columns are returned
and the order in which they are returned.
**Syntax**
```esql
KEEP columns
```

**Parameters**
<definitions>
  <definition term="columns">
    A comma-separated list of columns to keep. Supports wildcards.
    See below for the behavior in case an existing column matches multiple
    given wildcards or column names.
  </definition>
</definitions>

**Description**
The `KEEP` processing command enables you to specify what columns are returned
and the order in which they are returned.
Precedence rules are applied when a field name matches multiple expressions.
Fields are added in the order they appear. If one field matches multiple expressions, the following precedence rules apply (from highest to lowest priority):
1. Complete field name (no wildcards)
2. Partial wildcard expressions (for example: `fieldNam*`)
3. Wildcard only (`*`)

If a field matches two expressions with the same precedence, the rightmost expression wins.
Refer to the examples for illustrations of these precedence rules.
**Examples**
The columns are returned in the specified order:
```esql
FROM employees
| KEEP emp_no, first_name, last_name, height
```


| emp_no:integer | first_name:keyword | last_name:keyword | height:double |
|----------------|--------------------|-------------------|---------------|
| 10001          | Georgi             | Facello           | 2.03          |
| 10002          | Bezalel            | Simmel            | 2.08          |
| 10003          | Parto              | Bamford           | 1.83          |
| 10004          | Chirstian          | Koblick           | 1.78          |
| 10005          | Kyoichi            | Maliniak          | 2.05          |

Rather than specify each column by name, you can use wildcards to return all
columns with a name that matches a pattern:
```esql
FROM employees
| KEEP h*
```


| height:double | height.float:double | height.half_float:double | height.scaled_float:double | hire_date:date |
|---------------|---------------------|--------------------------|----------------------------|----------------|

The asterisk wildcard (`*`) by itself translates to all columns that do not
match the other arguments.
This query will first return all columns with a name
that starts with `h`, followed by all other columns:
```esql
FROM employees
| KEEP h*, *
```


| height:double | height.float:double | height.half_float:double | height.scaled_float:double | hire_date:date | avg_worked_seconds:long | birth_date:date | emp_no:integer | first_name:keyword | gender:keyword | is_rehired:boolean | job_positions:keyword | languages:integer | languages.byte:integer | languages.long:long | languages.short:integer | last_name:keyword | salary:integer | salary_change:double | salary_change.int:integer | salary_change.keyword:keyword | salary_change.long:long | still_hired:boolean |
|---------------|---------------------|--------------------------|----------------------------|----------------|-------------------------|-----------------|----------------|--------------------|----------------|--------------------|-----------------------|-------------------|------------------------|---------------------|-------------------------|-------------------|----------------|----------------------|---------------------------|-------------------------------|-------------------------|---------------------|

The following examples show how precedence rules work when a field name matches multiple expressions.
Complete field name has precedence over wildcard expressions:
```esql
FROM employees
| KEEP first_name, last_name, first_name*
```


| first_name:keyword | last_name:keyword |
|--------------------|-------------------|

Wildcard expressions have the same priority, but last one wins (despite being less specific):
```esql
FROM employees
| KEEP first_name*, last_name, first_na*
```


| last_name:keyword | first_name:keyword |
|-------------------|--------------------|

A simple wildcard expression `*` has the lowest precedence.
Output order is determined by the other arguments:
```esql
FROM employees
| KEEP *, first_name
```


| avg_worked_seconds:long | birth_date:date | emp_no:integer | gender:keyword | height:double | height.float:double | height.half_float:double | height.scaled_float:double | hire_date:date | is_rehired:boolean | job_positions:keyword | languages:integer | languages.byte:integer | languages.long:long | languages.short:integer | last_name:keyword | salary:integer | salary_change:double | salary_change.int:integer | salary_change.keyword:keyword | salary_change.long:long | still_hired:boolean | first_name:keyword |
|-------------------------|-----------------|----------------|----------------|---------------|---------------------|--------------------------|----------------------------|----------------|--------------------|-----------------------|-------------------|------------------------|---------------------|-------------------------|-------------------|----------------|----------------------|---------------------------|-------------------------------|-------------------------|---------------------|--------------------|﻿---
title: ES|QL reference
description: Elasticsearch Query Language (ES|QL) is a piped query language for filtering, transforming, and analyzing data. You can author ES|QL queries to find specific...
url: https://www.elastic.co/docs/reference/query-languages/esql
products:
  - Elasticsearch
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL reference
**Elasticsearch Query Language (ES|QL)** is a piped query language for filtering, transforming, and analyzing data.

## What's ES|QL?

You can author ES|QL queries to find specific events, perform statistical analysis, and create visualizations. It supports a wide range of commands, functions, and operators to perform various data operations, such as filter, aggregation, time-series analysis, and more. It initially supported a subset of the features available in Query DSL, but it is rapidly evolving with every Elastic Cloud Serverless and Stack release.
ES|QL is designed to be easy to read and write, making it accessible for users with varying levels of technical expertise. It is particularly useful for data analysts, security professionals, and developers who need to work with large datasets in Elasticsearch.

## How does it work?

ES|QL uses pipes (`|`) to manipulate and transform data in a step-by-step fashion. This approach allows you to compose a series of operations, where the output of one operation becomes the input for the next, enabling complex data transformations and analysis.
Here's a simple example of an ES|QL query:
```esql
FROM sample_data
| SORT @timestamp DESC
| LIMIT 3
```

Note that each line in the query represents a step in the data processing pipeline:
- The `FROM` clause specifies the index or data stream to query
- The `SORT` clause sorts the data by the `@timestamp` field in descending order
- The `LIMIT` clause restricts the output to the top 3 results


### User interfaces

You can interact with ES|QL in two ways:
- **Programmatic access**: Use ES|QL syntax with the Elasticsearch `_query` endpoint.
  - Refer to [Use the ES|QL REST API](https://www.elastic.co/docs/reference/query-languages/esql/esql-rest)
- **Interactive interfaces**: Work with ES|QL through Elastic user interfaces including Kibana Discover, Dashboards, Dev Tools, and analysis tools in Elastic Security and Observability.
  - Refer to [Using ES|QL in Kibana](https://www.elastic.co/docs/explore-analyze/query-filter/languages/esql-kibana).﻿---
title: ES|QL LIMIT command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/limit
---

# ES|QL LIMIT command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `LIMIT` processing command enables you to limit the number of rows that are
returned.
**Syntax**
```esql
LIMIT max_number_of_rows
```

**Parameters**
<definitions>
  <definition term="max_number_of_rows">
    The maximum number of rows to return.
  </definition>
</definitions>

**Description**
The `LIMIT` processing command enables you to limit the number of rows that are
returned.
For instance,
```esql
FROM index | WHERE field = "value"
```

is equivalent to:
```esql
FROM index | WHERE field = "value" | LIMIT 1000
```

Queries do not return more than 10,000 rows, regardless of the `LIMIT` command’s value. This is a configurable upper limit.
To overcome this limitation:
- Reduce the result set size by modifying the query to only return relevant data. Use [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where) to select a smaller subset of the data.
- Shift any post-query processing to the query itself. You can use the ES|QL [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command to aggregate data in the query.

The upper limit only applies to the number of rows that are output by the query, not to the number of documents it processes: the query runs on the full data set.
Consider the following two queries:
```esql
FROM index | WHERE field0 == "value" | LIMIT 20000
```

and
```esql
FROM index | STATS AVG(field1) BY field2 | LIMIT 20000
```

In both cases, the filtering by `field0` in the first query or the grouping by `field2` in the second is applied over all the documents present in the `index`, irrespective of their number or indexes size. However, both queries will return at most 10,000 rows, even if there were more rows available to return.
The default and maximum limits can be changed using these dynamic cluster settings:
- `esql.query.result_truncation_default_size`
- `esql.query.result_truncation_max_size`

However, doing so involves trade-offs. A larger result-set involves a higher memory pressure and increased processing times; the internode traffic within and across clusters can also increase.
These limitations are similar to those enforced by the [search API for pagination](https://www.elastic.co/docs/reference/elasticsearch/rest-apis/paginate-search-results).

| Functionality                    | Search                  | ES|QL                                     |
|----------------------------------|-------------------------|-------------------------------------------|
| Results returned by default      | 10                      | 1.000                                     |
| Default upper limit              | 10,000                  | 10,000                                    |
| Specify number of results        | `size`                  | `LIMIT`                                   |
| Change default number of results | n/a                     | esql.query.result_truncation_default_size |
| Change default upper limit       | index-max-result-window | esql.query.result_truncation_max_size     |

**Example**
```esql
FROM employees
| SORT emp_no ASC
| LIMIT 5
```﻿---
title: ES|QL SHOW command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/show
---

# ES|QL SHOW command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `SHOW` source command returns information about the deployment and
its capabilities.
**Syntax**
```esql
SHOW item
```

**Parameters**
<definitions>
  <definition term="item">
    Can only be `INFO`.
  </definition>
</definitions>

**Examples**
Use `SHOW INFO` to return the deployment’s version, build date and hash.
```esql
SHOW INFO
```


| version | date                           | hash                                     |
|---------|--------------------------------|------------------------------------------|
| 8.13.0  | 2024-02-23T10:04:18.123117961Z | 04ba8c8db2507501c88f215e475de7b0798cb3b3 |﻿---
title: Types and special fields in ES|QL
description: This section details how ES|QL handles different data types and special fields. Implicit casting: Understand how ES|QL automatically converts between...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-types-and-fields
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Types and special fields in ES|QL
This section details how ES|QL handles different data types and special fields.
- [Implicit casting](https://www.elastic.co/docs/reference/query-languages/esql/esql-implicit-casting): Understand how ES|QL automatically converts between data types in expressions.
- [Time spans](https://www.elastic.co/docs/reference/query-languages/esql/esql-time-spans): Learn how to work with time intervals in ES|QL.
- [Metadata fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-metadata-fields): Learn about the metadata fields supported by ES|QL, including `_index` and `_score`.
- [Multivalued fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields): Learn how to work with fields that contain multiple values in ES|QL.﻿---
title: ES|QL implicit casting
description: Often users will input date, date_period, time_duration, ip or version as simple strings in their queries for use in predicates, functions, or expressions...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-implicit-casting
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL implicit casting
Often users will input `date`, `date_period`, `time_duration`, `ip` or `version` as simple strings in their queries for use in predicates, functions, or expressions. ES|QL provides [type conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions) to explicitly convert these strings into the desired data types.
Without implicit casting users must explicitly code these `to_X` functions in their queries, when string literals don’t match the target data types they are assigned or compared to. Here is an example of using `to_datetime` to explicitly perform a data type conversion.
```esql
FROM employees
| EVAL dd_ns1=date_diff("day", to_datetime("2023-12-02T11:00:00.00Z"), birth_date)
| SORT emp_no
| KEEP dd_ns1
| LIMIT 1
```


## Implicit casting example

Implicit casting automatically converts string literals to the target data type. This allows users to specify string values for types like `date`, `date_period`, `time_duration`, `ip` and `version` in their queries.
The first query can be coded without calling the `to_datetime` function, as follows:
```esql
FROM employees
| EVAL dd_ns1=date_diff("day", "2023-12-02T11:00:00.00Z", birth_date)
| SORT emp_no
| KEEP dd_ns1
| LIMIT 1
```


## Operations that support implicit casting

The following table details which ES|QL operations support implicit casting for different data types.

|                           | ScalarFunctions | Operators | [GroupingFunctions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/grouping-functions) | [AggregateFunctions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/aggregation-functions) |
|---------------------------|-----------------|-----------|------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| DATE                      | Y               | Y         | Y                                                                                                                      | N                                                                                                                          |
| DATE_PERIOD/TIME_DURATION | Y               | N         | Y                                                                                                                      | N                                                                                                                          |
| IP                        | Y               | Y         | Y                                                                                                                      | N                                                                                                                          |
| VERSION                   | Y               | Y         | Y                                                                                                                      | N                                                                                                                          |
| BOOLEAN                   | Y               | Y         | Y                                                                                                                      | N                                                                                                                          |

ScalarFunctions includes:
- [Conditional Functions and Expressions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions)
- [Date and Time Functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/date-time-functions)
- [IP Functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/ip-functions)

Operators includes:
- [Binary Operators](/docs/reference/query-languages/esql/functions-operators/operators#esql-binary-operators)
- [Unary Operator](/docs/reference/query-languages/esql/functions-operators/operators#esql-unary-operators)
- [IN](/docs/reference/query-languages/esql/functions-operators/operators#esql-in-operator)﻿---
title: Query multiple indices or clusters with ES|QL
description: ES|QL allows you to query across multiple indices or clusters. Learn more in the following sections: Query multiple indices, Query across clusters. 
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-multi
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Query multiple indices or clusters with ES|QL
ES|QL allows you to query across multiple indices or clusters. Learn more in the following sections:
- [Query multiple indices](https://www.elastic.co/docs/reference/query-languages/esql/esql-multi-index)
- [Query across clusters](https://www.elastic.co/docs/reference/query-languages/esql/esql-cross-clusters)﻿---
title: ES|QL CHANGE_POINT command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/change-point
---

# ES|QL CHANGE_POINT command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available since 9.2
  - Elastic Stack: Preview in 9.1
</applies-to>

<note>
  The `CHANGE_POINT` command requires a [platinum license](https://www.elastic.co/subscriptions).
</note>

`CHANGE_POINT` detects spikes, dips, and change points in a metric.
**Syntax**
```esql
CHANGE_POINT value [ON key] [AS type_name, pvalue_name]
```

**Parameters**
<definitions>
  <definition term="value">
    The column with the metric in which you want to detect a change point.
  </definition>
  <definition term="key">
    The column with the key to order the values by. If not specified, `@timestamp` is used.
  </definition>
  <definition term="type_name">
    The name of the output column with the change point type. If not specified, `type` is used.
  </definition>
  <definition term="pvalue_name">
    The name of the output column with the p-value that indicates how extreme the change point is. If not specified, `pvalue` is used.
  </definition>
</definitions>

**Description**
`CHANGE_POINT` detects spikes, dips, and change points in a metric. The command adds columns to
the table with the change point type and p-value, that indicates how extreme the change point is
(lower values indicate greater changes).
The possible change point types are:
- `dip`: a significant dip occurs at this change point
- `distribution_change`: the overall distribution of the values has changed significantly
- `spike`: a significant spike occurs at this point
- `step_change`: the change indicates a statistically significant step up or down in value distribution
- `trend_change`: there is an overall trend change occurring at this point

<note>
  There must be at least 22 values for change point detection. Fewer than 1,000 is preferred.
</note>

**Examples**
The following example shows the detection of a step change:
```esql
ROW key=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
| MV_EXPAND key
| EVAL value = CASE(key<13, 0, 42)
| CHANGE_POINT value ON key
| WHERE type IS NOT NULL
```


| key:integer | value:integer | type:keyword | pvalue:double |
|-------------|---------------|--------------|---------------|
| 13          | 42            | step_change  | 0.0           |﻿---
title: ES|QL STATS command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by
---

# ES|QL STATS command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `STATS` processing command groups rows according to a common value
and calculates one or more aggregated values over the grouped rows.
**Syntax**
```esql
STATS [column1 =] expression1 [WHERE boolean_expression1][,
      ...,
      [columnN =] expressionN [WHERE boolean_expressionN]]
      [BY grouping_expression1[, ..., grouping_expressionN]]
```

**Parameters**
<definitions>
  <definition term="columnX">
    The name by which the aggregated value is returned. If omitted, the name is
    equal to the corresponding expression (`expressionX`).
    If multiple columns have the same name, all but the rightmost column with this
    name will be ignored.
  </definition>
  <definition term="expressionX">
    An expression that computes an aggregated value.
  </definition>
  <definition term="grouping_expressionX">
    An expression that outputs the values to group by.
    If its name coincides with one of the computed columns, that column will be ignored.
  </definition>
  <definition term="boolean_expressionX">
    The condition that must be met for a row to be included in the evaluation of `expressionX`.
  </definition>
</definitions>

<note>
  Individual `null` values are skipped when computing aggregations.
</note>

**Description**
The `STATS` processing command groups rows according to a common value
and calculates one or more aggregated values over the grouped rows. For the
calculation of each aggregated value, the rows in a group can be filtered with
`WHERE`. If `BY` is omitted, the output table contains exactly one row with
the aggregations applied over the entire dataset.
The following [aggregation functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/aggregation-functions) are supported:
- [`ABSENT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-absent) <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
- [`AVG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-avg)
- [`COUNT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-count)
- [`COUNT_DISTINCT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-count_distinct)
- [`MAX`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-max)
- [`MEDIAN`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-median)
- [`MEDIAN_ABSOLUTE_DEVIATION`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-median_absolute_deviation)
- [`MIN`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-min)
- [`PERCENTILE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-percentile)
- [`PRESENT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-present) <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
- [`SAMPLE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-sample)
- [`ST_CENTROID_AGG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-st_centroid_agg) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_EXTENT_AGG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-st_extent_agg) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`STD_DEV`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-std_dev)
- [`SUM`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-sum)
- [`TOP`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-top)
- [`VALUES`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-values) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`VARIANCE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-variance)
- [`WEIGHTED_AVG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-weighted_avg)

When `STATS` is used under the [`TS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/ts) source command,
[time series aggregation functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions)
are also supported.
The following [grouping functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/grouping-functions) are supported:
- [`BUCKET`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-bucket)
- [`TBUCKET`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-tbucket)
- [`CATEGORIZE`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-categorize)

<note>
  `STATS` without any groups is much much faster than adding a group.
</note>

<note>
  Grouping on a single expression is currently much more optimized than grouping
  on many expressions. In some tests we have seen grouping on a single `keyword`
  column to be five times faster than grouping on two `keyword` columns. Do
  not try to work around this by combining the two columns together with
  something like [`CONCAT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-concat)
  and then grouping - that is not going to be faster.
</note>


### Examples

Calculating a statistic and grouping by the values of another column:
```esql
FROM employees
| STATS count = COUNT(emp_no) BY languages
| SORT languages
```


| count:long | languages:integer |
|------------|-------------------|
| 15         | 1                 |
| 19         | 2                 |
| 17         | 3                 |
| 18         | 4                 |
| 21         | 5                 |
| 10         | null              |

Omitting `BY` returns one row with the aggregations applied over the entire
dataset:
```esql
FROM employees
| STATS avg_lang = AVG(languages)
```


| avg_lang:double    |
|--------------------|
| 3.1222222222222222 |

It’s possible to calculate multiple values:
```esql
FROM employees
| STATS avg_lang = AVG(languages), max_lang = MAX(languages)
```


| avg_lang:double    | max_lang:integer |
|--------------------|------------------|
| 3.1222222222222222 | 5                |

To filter the rows that go into an aggregation, use the `WHERE` clause:
```esql
FROM employees
| STATS avg50s = AVG(salary)::LONG WHERE birth_date < "1960-01-01",
        avg60s = AVG(salary)::LONG WHERE birth_date >= "1960-01-01"
        BY gender
| SORT gender
```


| avg50s:long | avg60s:long | gender:keyword |
|-------------|-------------|----------------|
| 55462       | 46637       | F              |
| 48279       | 44879       | M              |

The aggregations can be mixed, with and without a filter and grouping is
optional as well:
```esql
FROM employees
| EVAL Ks = salary / 1000
| STATS under_40K = COUNT(*) WHERE Ks < 40,
        inbetween = COUNT(*) WHERE 40 <= Ks AND Ks < 60,
        over_60K  = COUNT(*) WHERE 60 <= Ks,
        total     = COUNT(*)
```


| under_40K:long | inbetween:long | over_60K:long | total:long |
|----------------|----------------|---------------|------------|
| 36             | 39             | 25            | 100        |

It’s also possible to group by multiple values:
```esql
FROM employees
| EVAL hired = DATE_FORMAT("yyyy", hire_date)
| STATS avg_salary = AVG(salary) BY hired, languages.long
| EVAL avg_salary = ROUND(avg_salary)
| SORT hired, languages.long
```



#### Multivalued inputs

If the grouping key is multivalued then the input row is in all groups:
```esql
ROW price = 10, color = ["blue", "pink", "yellow"]
| STATS SUM(price) BY color
```


| SUM(price):long | color:keyword |
|-----------------|---------------|
| 10              | blue          |
| 10              | pink          |
| 10              | yellow        |

If all the grouping keys are multivalued then the input row is in all groups:
```esql
ROW price = 10, color = ["blue", "pink", "yellow"], size = ["s", "m", "l"]
| STATS SUM(price) BY color, size
```


| SUM(price):long | color:keyword | size:keyword |
|-----------------|---------------|--------------|
| 10              | blue          | l            |
| 10              | blue          | m            |
| 10              | blue          | s            |
| 10              | pink          | l            |
| 10              | pink          | m            |
| 10              | pink          | s            |
| 10              | yellow        | l            |
| 10              | yellow        | m            |
| 10              | yellow        | s            |

The input **ROW** is in all groups. The entire row. All the values. Even group
keys. That means that:
```esql
ROW color = ["blue", "pink", "yellow"]
| STATS VALUES(color) BY color
```


| VALUES(color):keyword | color:keyword |
|-----------------------|---------------|
| [blue, pink, yellow]  | blue          |
| [blue, pink, yellow]  | pink          |
| [blue, pink, yellow]  | yellow        |

The `VALUES` function above sees the whole row - all of the values of the group
key. If you want to send the group key to the function then `MV_EXPAND` first:
```esql
ROW color = ["blue", "pink", "yellow"]
| MV_EXPAND color
| STATS VALUES(color) BY color
```


| VALUES(color):keyword | color:keyword |
|-----------------------|---------------|
| blue                  | blue          |
| pink                  | pink          |
| yellow                | yellow        |

Refer to [elasticsearch/issues/134792](https://github.com/elastic/elasticsearch/issues/134792#issuecomment-3361168090)
for an even more in depth explanation.

#### Multivalue functions

Both the aggregating functions and the grouping expressions accept other
functions. This is useful for using `STATS` on multivalue columns.
For example, to calculate the average salary change, you can use `MV_AVG` to
first average the multiple values per employee, and use the result with the
`AVG` function:
```esql
FROM employees
| STATS avg_salary_change = ROUND(AVG(MV_AVG(salary_change)), 10)
```


| avg_salary_change:double |
|--------------------------|
| 1.3904535865             |

An example of grouping by an expression is grouping employees on the first
letter of their last name:
```esql
FROM employees
| STATS my_count = COUNT() BY LEFT(last_name, 1)
| SORT `LEFT(last_name, 1)`
```


| my_count:long | LEFT(last_name, 1):keyword |
|---------------|----------------------------|
| 2             | A                          |
| 11            | B                          |
| 5             | C                          |
| 5             | D                          |
| 2             | E                          |
| 4             | F                          |
| 4             | G                          |
| 6             | H                          |
| 2             | J                          |
| 3             | K                          |
| 5             | L                          |
| 12            | M                          |
| 4             | N                          |
| 1             | O                          |
| 7             | P                          |
| 5             | R                          |
| 13            | S                          |
| 4             | T                          |
| 2             | W                          |
| 3             | Z                          |


#### Naming

Specifying the output column name is optional. If not specified, the new column
name is equal to the expression. The following query returns a column named
`AVG(salary)`:
```esql
FROM employees
| STATS AVG(salary)
```


| AVG(salary):double |
|--------------------|
| 48248.55           |

Because this name contains special characters,
[it needs to be quoted](/docs/reference/query-languages/esql/esql-syntax#esql-identifiers)
with backticks (```) when using it in subsequent commands:
```esql
FROM employees
| STATS AVG(salary)
| EVAL avg_salary_rounded = ROUND(`AVG(salary)`)
```


| AVG(salary):double | avg_salary_rounded:double |
|--------------------|---------------------------|
| 48248.55           | 48249.0                   |﻿---
title: ES|QL date-time functions
description: ES|QL supports these date-time functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/date-time-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL date-time functions
ES|QL supports these date-time functions:
- [`DATE_DIFF`](#esql-date_diff)
- [`DATE_EXTRACT`](#esql-date_extract)
- [`DATE_FORMAT`](#esql-date_format)
- [`DATE_PARSE`](#esql-date_parse)
- [`DATE_TRUNC`](#esql-date_trunc)
- [`DAY_NAME`](#esql-day_name)
- [`MONTH_NAME`](#esql-month_name)
- [`NOW`](#esql-now)
- [`TRANGE`](#esql-trange)


## `DATE_DIFF`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/date_diff.svg)

**Parameters**
<definitions>
  <definition term="unit">
    Time difference unit
  </definition>
  <definition term="startTimestamp">
    A string representing a start timestamp
  </definition>
  <definition term="endTimestamp">
    A string representing an end timestamp
  </definition>
</definitions>

**Description**
Subtracts the `startTimestamp` from the `endTimestamp` and returns the difference in multiples of `unit`. If `startTimestamp` is later than the `endTimestamp`, negative values are returned.
**Datetime difference units**

| unit        | abbreviations     |
|-------------|-------------------|
| year        | years, yy, yyyy   |
| quarter     | quarters, qq, q   |
| month       | months, mm, m     |
| dayofyear   | dy, y             |
| day         | days, dd, d       |
| week        | weeks, wk, ww     |
| weekday     | weekdays, dw      |
| hour        | hours, hh         |
| minute      | minutes, mi, n    |
| second      | seconds, ss, s    |
| millisecond | milliseconds, ms  |
| microsecond | microseconds, mcs |
| nanosecond  | nanoseconds, ns   |

Note that while there is an overlap between the function’s supported units and
ES|QL’s supported time span literals, these sets are distinct and not
interchangeable. Similarly, the supported abbreviations are conveniently shared
with implementations of this function in other established products and not
necessarily common with the date-time nomenclature used by Elasticsearch.
**Supported types**

| unit    | startTimestamp | endTimestamp | result  |
|---------|----------------|--------------|---------|
| keyword | date           | date         | integer |
| keyword | date           | date_nanos   | integer |
| keyword | date_nanos     | date         | integer |
| keyword | date_nanos     | date_nanos   | integer |
| text    | date           | date         | integer |
| text    | date           | date_nanos   | integer |
| text    | date_nanos     | date         | integer |
| text    | date_nanos     | date_nanos   | integer |

**Examples**
```esql
ROW date1 = TO_DATETIME("2023-12-02T11:00:00.000Z"),
    date2 = TO_DATETIME("2023-12-02T11:00:00.001Z")
| EVAL dd_ms = DATE_DIFF("microseconds", date1, date2)
```


| date1:date               | date2:date               | dd_ms:integer |
|--------------------------|--------------------------|---------------|
| 2023-12-02T11:00:00.000Z | 2023-12-02T11:00:00.001Z | 1000          |

When subtracting in calendar units - like year, month a.s.o. - only the fully elapsed units are counted.
To avoid this and obtain also remainders, simply switch to the next smaller unit and do the date math accordingly.
```esql
ROW end_23 = TO_DATETIME("2023-12-31T23:59:59.999Z"),
  start_24 = TO_DATETIME("2024-01-01T00:00:00.000Z"),
    end_24 = TO_DATETIME("2024-12-31T23:59:59.999")
| EVAL end23_to_start24 = DATE_DIFF("year", end_23, start_24)
| EVAL end23_to_end24   = DATE_DIFF("year", end_23, end_24)
| EVAL start_to_end_24  = DATE_DIFF("year", start_24, end_24)
```


| end_23:date              | start_24:date            | end_24:date              | end23_to_start24:integer | end23_to_end24:integer | start_to_end_24:integer |
|--------------------------|--------------------------|--------------------------|--------------------------|------------------------|-------------------------|
| 2023-12-31T23:59:59.999Z | 2024-01-01T00:00:00.000Z | 2024-12-31T23:59:59.999Z | 0                        | 1                      | 0                       |


## `DATE_EXTRACT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/date_extract.svg)

**Parameters**
<definitions>
  <definition term="datePart">
    Part of the date to extract.  Can be: `aligned_day_of_week_in_month`, `aligned_day_of_week_in_year`, `aligned_week_of_month`, `aligned_week_of_year`, `ampm_of_day`, `clock_hour_of_ampm`, `clock_hour_of_day`, `day_of_month`, `day_of_week`, `day_of_year`, `epoch_day`, `era`, `hour_of_ampm`, `hour_of_day`, `instant_seconds`, `micro_of_day`, `micro_of_second`, `milli_of_day`, `milli_of_second`, `minute_of_day`, `minute_of_hour`, `month_of_year`, `nano_of_day`, `nano_of_second`, `offset_seconds`, `proleptic_month`, `second_of_day`, `second_of_minute`, `year`, or `year_of_era`. Refer to [java.time.temporal.ChronoField](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/ChronoField.html) for a description of these values.  If `null`, the function returns `null`.
  </definition>
  <definition term="date">
    Date expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Extracts parts of a date, like year, month, day, hour.
**Supported types**

| datePart | date       | result |
|----------|------------|--------|
| keyword  | date       | long   |
| keyword  | date_nanos | long   |
| text     | date       | long   |
| text     | date_nanos | long   |

**Examples**
```esql
ROW date = DATE_PARSE("yyyy-MM-dd", "2022-05-06")
| EVAL year = DATE_EXTRACT("year", date)
```


| date:date                | year:long |
|--------------------------|-----------|
| 2022-05-06T00:00:00.000Z | 2022      |

Find all events that occurred outside of business hours (before 9 AM or after 5PM), on any given date:
```esql
FROM sample_data
| WHERE DATE_EXTRACT("hour_of_day", @timestamp) < 9
    AND DATE_EXTRACT("hour_of_day", @timestamp) >= 17
```


| @timestamp:date | client_ip:ip | event_duration:long | message:keyword |
|-----------------|--------------|---------------------|-----------------|


## `DATE_FORMAT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/date_format.svg)

**Parameters**
<definitions>
  <definition term="dateFormat">
    Date format (optional).  If no format is specified, the `yyyy-MM-dd'T'HH:mm:ss.SSSZ` format is used. If `null`, the function returns `null`.
  </definition>
  <definition term="date">
    Date expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns a string representation of a date, in the provided format.
**Supported types**

| dateFormat | date       | result  |
|------------|------------|---------|
| keyword    | date       | keyword |
| keyword    | date_nanos | keyword |
| text       | date       | keyword |
| text       | date_nanos | keyword |
|            | date       | keyword |
|            | date_nanos | keyword |

**Example**
```esql
FROM employees
| KEEP first_name, last_name, hire_date
| EVAL hired = DATE_FORMAT("yyyy-MM-dd", hire_date)
```


| first_name:keyword | last_name:keyword | hire_date:date           | hired:keyword |
|--------------------|-------------------|--------------------------|---------------|
| Alejandro          | McAlpine          | 1991-06-26T00:00:00.000Z | 1991-06-26    |
| Amabile            | Gomatam           | 1992-11-18T00:00:00.000Z | 1992-11-18    |
| Anneke             | Preusig           | 1989-06-02T00:00:00.000Z | 1989-06-02    |


## `DATE_PARSE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/date_parse.svg)

**Parameters**
<definitions>
  <definition term="datePattern">
    The date format. Refer to the [`DateTimeFormatter` documentation](https://docs.oracle.com/en/java/javase/14/docs/api/java.base/java/time/format/DateTimeFormatter.html) for the syntax. If `null`, the function returns `null`.
  </definition>
  <definition term="dateString">
    Date expression as a string. If `null` or an empty string, the function returns `null`.
  </definition>
  <definition term="options">
    (Optional) Additional options for date parsing, specifying time zone and locale as [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params).
  </definition>
</definitions>

**Description**
Returns a date by parsing the second argument using the format specified in the first argument.
**Supported types**

| datePattern | dateString | options          | result |
|-------------|------------|------------------|--------|
| keyword     | keyword    | named parameters | date   |
| keyword     | keyword    |                  | date   |
| keyword     | text       | named parameters | date   |
| keyword     | text       |                  | date   |
| text        | keyword    | named parameters | date   |
| text        | keyword    |                  | date   |
| text        | text       | named parameters | date   |
| text        | text       |                  | date   |
|             | keyword    | named parameters | date   |
|             | keyword    |                  | date   |
|             | text       | named parameters | date   |
|             | text       |                  | date   |

**Supported function named parameters**
<definitions>
  <definition term="time_zone">
    (keyword) Coordinated Universal Time (UTC) offset or IANA time zone used to convert date values in the query string to UTC.
  </definition>
  <definition term="locale">
    (keyword) The locale to use when parsing the date, relevant when parsing month names or week days.
  </definition>
</definitions>

**Example**
```esql
ROW date_string = "2022-05-06"
| EVAL date = DATE_PARSE("yyyy-MM-dd", date_string)
```


| date_string:keyword | date:date                |
|---------------------|--------------------------|
| 2022-05-06          | 2022-05-06T00:00:00.000Z |


## `DATE_TRUNC`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/date_trunc.svg)

**Parameters**
<definitions>
  <definition term="interval">
    Interval; expressed using the timespan literal syntax.
  </definition>
  <definition term="date">
    Date expression
  </definition>
</definitions>

**Description**
Rounds down a date to the closest interval since epoch, which starts at `0001-01-01T00:00:00Z`.
**Supported types**

| interval      | date       | result     |
|---------------|------------|------------|
| date_period   | date       | date       |
| date_period   | date_nanos | date_nanos |
| time_duration | date       | date       |
| time_duration | date_nanos | date_nanos |

**Examples**
```esql
FROM employees
| KEEP first_name, last_name, hire_date
| EVAL year_hired = DATE_TRUNC(1 year, hire_date)
```


| first_name:keyword | last_name:keyword | hire_date:date           | year_hired:date          |
|--------------------|-------------------|--------------------------|--------------------------|
| Alejandro          | McAlpine          | 1991-06-26T00:00:00.000Z | 1991-01-01T00:00:00.000Z |
| Amabile            | Gomatam           | 1992-11-18T00:00:00.000Z | 1992-01-01T00:00:00.000Z |
| Anneke             | Preusig           | 1989-06-02T00:00:00.000Z | 1989-01-01T00:00:00.000Z |

Combine `DATE_TRUNC` with [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) to create date histograms. For example, the number of hires per year:
```esql
FROM employees
| EVAL year = DATE_TRUNC(1 year, hire_date)
| STATS hires = COUNT(emp_no) BY year
| SORT year
```


| hires:long | year:date                |
|------------|--------------------------|
| 11         | 1985-01-01T00:00:00.000Z |
| 11         | 1986-01-01T00:00:00.000Z |
| 15         | 1987-01-01T00:00:00.000Z |
| 9          | 1988-01-01T00:00:00.000Z |
| 13         | 1989-01-01T00:00:00.000Z |
| 12         | 1990-01-01T00:00:00.000Z |
| 6          | 1991-01-01T00:00:00.000Z |
| 8          | 1992-01-01T00:00:00.000Z |
| 3          | 1993-01-01T00:00:00.000Z |
| 4          | 1994-01-01T00:00:00.000Z |
| 5          | 1995-01-01T00:00:00.000Z |
| 1          | 1996-01-01T00:00:00.000Z |
| 1          | 1997-01-01T00:00:00.000Z |
| 1          | 1999-01-01T00:00:00.000Z |

Or an hourly error rate:
```esql
FROM sample_data
| EVAL error = CASE(message LIKE "*error*", 1, 0)
| EVAL hour = DATE_TRUNC(1 hour, @timestamp)
| STATS error_rate = AVG(error) by hour
| SORT hour
```


| error_rate:double | hour:date                |
|-------------------|--------------------------|
| 0.0               | 2023-10-23T12:00:00.000Z |
| 0.6               | 2023-10-23T13:00:00.000Z |


## `DAY_NAME`

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/day_name.svg)

**Parameters**
<definitions>
  <definition term="date">
    Date expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the name of the weekday for date based on the configured Locale.
**Supported types**

| date       | result  |
|------------|---------|
| date       | keyword |
| date_nanos | keyword |

**Example**
```esql
ROW dt = to_datetime("1953-09-02T00:00:00.000Z")
| EVAL weekday = DAY_NAME(dt);
```


## `MONTH_NAME`

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/month_name.svg)

**Parameters**
<definitions>
  <definition term="date">
    Date expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the month name for the provided date based on the configured Locale.
**Supported types**

| date       | result  |
|------------|---------|
| date       | keyword |
| date_nanos | keyword |

**Example**
```esql
ROW dt = to_datetime("1996-03-21T00:00:00.000Z")
| EVAL monthName = MONTH_NAME(dt);
```


## `NOW`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/now.svg)

**Parameters**
**Description**
Returns current date and time.
**Supported types**

| result |
|--------|
| date   |

**Examples**
```esql
ROW current_date = NOW()
```


| y:keyword |
|-----------|
| 20        |

To retrieve logs from the last hour:
```esql
FROM sample_data
| WHERE @timestamp > NOW() - 1 hour
```


## `TRANGE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/trange.svg)

**Parameters**
<definitions>
  <definition term="start_time_or_offset">
    Offset from NOW for the single parameter mode. Start time for two parameter mode.  In two parameter mode, the start time value can be a date string, date, date_nanos or epoch milliseconds.
  </definition>
  <definition term="end_time">
    Explicit end time that can be a date string, date, date_nanos or epoch milliseconds.
  </definition>
</definitions>

**Description**
Filters data for the given time range using the @timestamp attribute.
**Supported types**

| start_time_or_offset | end_time   | result  |
|----------------------|------------|---------|
| date                 | date       | boolean |
| date_nanos           | date_nanos | boolean |
| date_period          |            | boolean |
| keyword              | keyword    | boolean |
| long                 | long       | boolean |
| time_duration        |            | boolean |

**Examples**
```esql
FROM k8s
| WHERE TRANGE(1h)
| KEEP @timestamp
```

```esql
FROM k8s
| WHERE TRANGE("2024-05-10T00:17:14.000Z", "2024-05-10T00:18:33.000Z")
| SORT @timestamp
| KEEP @timestamp
| LIMIT 10
```


| @timestamp:datetime      |
|--------------------------|
| 2024-05-10T00:17:16.000Z |
| 2024-05-10T00:17:20.000Z |
| 2024-05-10T00:17:30.000Z |
| 2024-05-10T00:17:30.000Z |
| 2024-05-10T00:17:39.000Z |
| 2024-05-10T00:17:39.000Z |
| 2024-05-10T00:17:55.000Z |
| 2024-05-10T00:18:02.000Z |
| 2024-05-10T00:18:02.000Z |
| 2024-05-10T00:18:02.000Z |

```esql
FROM k8s
| WHERE TRANGE(to_datetime("2024-05-10T00:17:14Z"), to_datetime("2024-05-10T00:18:33Z"))
| SORT @timestamp
| KEEP @timestamp
| LIMIT 10
```


| @timestamp:datetime      |
|--------------------------|
| 2024-05-10T00:17:16.000Z |
| 2024-05-10T00:17:20.000Z |
| 2024-05-10T00:17:30.000Z |
| 2024-05-10T00:17:30.000Z |
| 2024-05-10T00:17:39.000Z |
| 2024-05-10T00:17:39.000Z |
| 2024-05-10T00:17:55.000Z |
| 2024-05-10T00:18:02.000Z |
| 2024-05-10T00:18:02.000Z |
| 2024-05-10T00:18:02.000Z |

```esql
FROM k8s
| WHERE TRANGE(to_datetime("2024-05-10T00:17:14.000Z"), to_datetime("2024-05-10T00:18:33.000Z"))
| SORT @timestamp
| KEEP @timestamp
| LIMIT 10
```


| @timestamp:datetime      |
|--------------------------|
| 2024-05-10T00:17:16.000Z |
| 2024-05-10T00:17:20.000Z |
| 2024-05-10T00:17:30.000Z |
| 2024-05-10T00:17:30.000Z |
| 2024-05-10T00:17:39.000Z |
| 2024-05-10T00:17:39.000Z |
| 2024-05-10T00:17:55.000Z |
| 2024-05-10T00:18:02.000Z |
| 2024-05-10T00:18:02.000Z |
| 2024-05-10T00:18:02.000Z |

```esql
FROM k8s
| WHERE TRANGE(1715300236000, 1715300282000)
| SORT @timestamp
| KEEP @timestamp
| LIMIT 10
```


| @timestamp:datetime      |
|--------------------------|
| 2024-05-10T00:17:20.000Z |
| 2024-05-10T00:17:30.000Z |
| 2024-05-10T00:17:30.000Z |
| 2024-05-10T00:17:39.000Z |
| 2024-05-10T00:17:39.000Z |
| 2024-05-10T00:17:55.000Z |
| 2024-05-10T00:18:02.000Z |
| 2024-05-10T00:18:02.000Z |
| 2024-05-10T00:18:02.000Z |﻿---
title: ES|QL IP functions
description: ES|QL supports these IP functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/ip-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL IP functions
ES|QL supports these IP functions:
- [`CIDR_MATCH`](#esql-cidr_match)
- [`IP_PREFIX`](#esql-ip_prefix)


## `CIDR_MATCH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/cidr_match.svg)

**Parameters**
<definitions>
  <definition term="ip">
    IP address of type `ip` (both IPv4 and IPv6 are supported).
  </definition>
  <definition term="blockX">
    CIDR block to test the IP against.
  </definition>
</definitions>

**Description**
Returns true if the provided IP is contained in one of the provided CIDR blocks.
**Supported types**

| ip | blockX  | result  |
|----|---------|---------|
| ip | keyword | boolean |
| ip | text    | boolean |

**Example**
```esql
FROM hosts
| WHERE CIDR_MATCH(ip1, "127.0.0.2/32", "127.0.0.3/32")
| KEEP card, host, ip0, ip1
```


| card:keyword | host:keyword | ip0:ip                    | ip1:ip    |
|--------------|--------------|---------------------------|-----------|
| eth1         | beta         | 127.0.0.1                 | 127.0.0.2 |
| eth0         | gamma        | fe80::cae2:65ff:fece:feb9 | 127.0.0.3 |


## `IP_PREFIX`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/ip_prefix.svg)

**Parameters**
<definitions>
  <definition term="ip">
    IP address of type `ip` (both IPv4 and IPv6 are supported).
  </definition>
  <definition term="prefixLengthV4">
    Prefix length for IPv4 addresses.
  </definition>
  <definition term="prefixLengthV6">
    Prefix length for IPv6 addresses.
  </definition>
</definitions>

**Description**
Truncates an IP to a given prefix length.
**Supported types**

| ip | prefixLengthV4 | prefixLengthV6 | result |
|----|----------------|----------------|--------|
| ip | integer        | integer        | ip     |

**Example**
```esql
ROW ip4 = to_ip("1.2.3.4"), ip6 = TO_IP("fe80::cae2:65ff:fece:feb9")
| EVAL ip4_prefix = IP_PREFIX(ip4, 24, 0), ip6_prefix = IP_PREFIX(ip6, 0, 112);
```


| ip4:ip  | ip6:ip                    | ip4_prefix:ip | ip6_prefix:ip             |
|---------|---------------------------|---------------|---------------------------|
| 1.2.3.4 | fe80::cae2:65ff:fece:feb9 | 1.2.3.0       | fe80::cae2:65ff:fece:0000 |﻿---
title: ES|QL EVAL command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/eval
---

# ES|QL EVAL command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `EVAL` processing command enables you to append new columns with calculated
values.
**Syntax**
```esql
EVAL [column1 =] value1[, ..., [columnN =] valueN]
```

**Parameters**
<definitions>
  <definition term="columnX">
    The column name.
    If a column with the same name already exists, the existing column is dropped.
    If a column name is used more than once, only the rightmost duplicate creates a column.
  </definition>
  <definition term="valueX">
    The value for the column. Can be a literal, an expression, or a
    [function](/docs/reference/query-languages/esql/esql-functions-operators#esql-functions).
    Can use columns defined left of this one.
  </definition>
</definitions>

**Description**
The `EVAL` processing command enables you to append new columns with calculated
values. `EVAL` supports various functions for calculating values. Refer to
[Functions](/docs/reference/query-languages/esql/esql-functions-operators#esql-functions) for more information.
**Examples**
```esql
FROM employees
| SORT emp_no
| KEEP first_name, last_name, height
| EVAL height_feet = height * 3.281, height_cm = height * 100
```


| first_name:keyword | last_name:keyword | height:double | height_feet:double | height_cm:double   |
|--------------------|-------------------|---------------|--------------------|--------------------|
| Georgi             | Facello           | 2.03          | 6.66043            | 202.99999999999997 |
| Bezalel            | Simmel            | 2.08          | 6.82448            | 208.0              |
| Parto              | Bamford           | 1.83          | 6.004230000000001  | 183.0              |

If the specified column already exists, the existing column will be dropped, and
the new column will be appended to the table:
```esql
FROM employees
| SORT emp_no
| KEEP first_name, last_name, height
| EVAL height = height * 3.281
```


| first_name:keyword | last_name:keyword | height:double     |
|--------------------|-------------------|-------------------|
| Georgi             | Facello           | 6.66043           |
| Bezalel            | Simmel            | 6.82448           |
| Parto              | Bamford           | 6.004230000000001 |

Specifying the output column name is optional. If not specified, the new column
name is equal to the expression. The following query adds a column named
`height*3.281`:
```esql
FROM employees
| SORT emp_no
| KEEP first_name, last_name, height
| EVAL height * 3.281
```


| first_name:keyword | last_name:keyword | height:double | height * 3.281:double |
|--------------------|-------------------|---------------|-----------------------|
| Georgi             | Facello           | 2.03          | 6.66043               |
| Bezalel            | Simmel            | 2.08          | 6.82448               |
| Parto              | Bamford           | 1.83          | 6.004230000000001     |

Because this name contains special characters,
[it needs to be quoted](/docs/reference/query-languages/esql/esql-syntax#esql-identifiers)
with backticks (```) when using it in subsequent commands:
```esql
FROM employees
| EVAL height * 3.281
| STATS avg_height_feet = AVG(`height * 3.281`)
```


| avg_height_feet:double |
|------------------------|
| 5.801464200000001      |﻿---
title: ES|QL type conversion functions
description: ES|QL supports these type conversion functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL type conversion functions
<tip>
  ES|QL supports implicit casting from string literals to certain data types. Refer to [implicit casting](https://www.elastic.co/docs/reference/query-languages/esql/esql-implicit-casting) for details.
</tip>

ES|QL supports these type conversion functions:
- [`TO_AGGREGATE_METRIC_DOUBLE`](#esql-to_aggregate_metric_double) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`TO_BOOLEAN`](#esql-to_boolean)
- [`TO_CARTESIANPOINT`](#esql-to_cartesianpoint)
- [`TO_CARTESIANSHAPE`](#esql-to_cartesianshape)
- [`TO_DATEPERIOD`](#esql-to_dateperiod)
- [`TO_DATETIME`](#esql-to_datetime)
- [`TO_DATE_NANOS`](#esql-to_date_nanos)
- [`TO_DEGREES`](#esql-to_degrees)
- [`TO_DENSE_VECTOR`](#esql-to_dense_vector) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`TO_DOUBLE`](#esql-to_double)
- [`TO_GEOHASH`](#esql-to_geohash) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`TO_GEOHEX`](#esql-to_geohex) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`TO_GEOPOINT`](#esql-to_geopoint)
- [`TO_GEOSHAPE`](#esql-to_geoshape)
- [`TO_GEOTILE`](#esql-to_geotile) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`TO_INTEGER`](#esql-to_integer)
- [`TO_IP`](#esql-to_ip)
- [`TO_LONG`](#esql-to_long)
- [`TO_RADIANS`](#esql-to_radians)
- [`TO_STRING`](#esql-to_string)
- [`TO_TIMEDURATION`](#esql-to_timeduration)
- [`TO_UNSIGNED_LONG`](#esql-to_unsigned_long) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`TO_VERSION`](#esql-to_version)


## `TO_AGGREGATE_METRIC_DOUBLE`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_aggregate_metric_double.svg)

**Parameters**
<definitions>
  <definition term="number">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Encode a numeric to an aggregate_metric_double.
**Supported types**

| number                  | result                  |
|-------------------------|-------------------------|
| aggregate_metric_double | aggregate_metric_double |
| double                  | aggregate_metric_double |
| integer                 | aggregate_metric_double |
| long                    | aggregate_metric_double |
| unsigned_long           | aggregate_metric_double |

**Examples**
```esql
ROW x = 3892095203
| EVAL agg_metric = TO_AGGREGATE_METRIC_DOUBLE(x)
```


| x:long     | agg_metric:aggregate_metric_double                                         |
|------------|----------------------------------------------------------------------------|
| 3892095203 | {"min":3892095203.0,"max":3892095203.0,"sum":3892095203.0,"value_count":1} |

The expression also accepts multi-values
```esql
ROW x = [5032, 11111, 40814]
| EVAL agg_metric = TO_AGGREGATE_METRIC_DOUBLE(x)
```


| x:integer            | agg_metric:aggregate_metric_double                         |
|----------------------|------------------------------------------------------------|
| [5032, 11111, 40814] | {"min":5032.0,"max":40814.0,"sum":56957.0,"value_count":3} |


## `TO_BOOLEAN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_boolean.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a boolean value. A string value of `true` will be case-insensitive converted to the Boolean `true`. For anything else, including the empty string, the function will return `false`. The numerical value of `0` will be converted to `false`, anything else will be converted to `true`.
**Supported types**

| field         | result  |
|---------------|---------|
| boolean       | boolean |
| double        | boolean |
| integer       | boolean |
| keyword       | boolean |
| long          | boolean |
| text          | boolean |
| unsigned_long | boolean |

**Example**
```esql
ROW str = ["true", "TRuE", "false", "", "yes", "1"]
| EVAL bool = TO_BOOLEAN(str)
```


| str:keyword                               | bool:boolean                             |
|-------------------------------------------|------------------------------------------|
| ["true", "TRuE", "false", "", "yes", "1"] | [true, true, false, false, false, false] |


## `TO_CARTESIANPOINT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_cartesianpoint.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a `cartesian_point` value. A string will only be successfully converted if it respects the [WKT Point](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry) format.
**Supported types**

| field           | result          |
|-----------------|-----------------|
| cartesian_point | cartesian_point |
| keyword         | cartesian_point |
| text            | cartesian_point |

**Example**
```esql
ROW wkt = ["POINT(4297.11 -1475.53)", "POINT(7580.93 2272.77)"]
| MV_EXPAND wkt
| EVAL pt = TO_CARTESIANPOINT(wkt)
```


| wkt:keyword               | pt:cartesian_point      |
|---------------------------|-------------------------|
| "POINT(4297.11 -1475.53)" | POINT(4297.11 -1475.53) |
| "POINT(7580.93 2272.77)"  | POINT(7580.93 2272.77)  |


## `TO_CARTESIANSHAPE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_cartesianshape.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a `cartesian_shape` value. A string will only be successfully converted if it respects the [WKT](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry) format.
**Supported types**

| field           | result          |
|-----------------|-----------------|
| cartesian_point | cartesian_shape |
| cartesian_shape | cartesian_shape |
| keyword         | cartesian_shape |
| text            | cartesian_shape |

**Example**
```esql
ROW wkt = ["POINT(4297.11 -1475.53)", "POLYGON ((3339584.72 1118889.97, 4452779.63 4865942.27, 2226389.81 4865942.27, 1113194.90 2273030.92, 3339584.72 1118889.97))"]
| MV_EXPAND wkt
| EVAL geom = TO_CARTESIANSHAPE(wkt)
```


| wkt:keyword                                                                                                                     | geom:cartesian_shape                                                                                                          |
|---------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| "POINT(4297.11 -1475.53)"                                                                                                       | POINT(4297.11 -1475.53)                                                                                                       |
| "POLYGON ((3339584.72 1118889.97, 4452779.63 4865942.27, 2226389.81 4865942.27, 1113194.90 2273030.92, 3339584.72 1118889.97))" | POLYGON ((3339584.72 1118889.97, 4452779.63 4865942.27, 2226389.81 4865942.27, 1113194.90 2273030.92, 3339584.72 1118889.97)) |


## `TO_DATEPERIOD`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_dateperiod.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input is a valid constant date period expression.
  </definition>
</definitions>

**Description**
Converts an input value into a `date_period` value.
**Supported types**

| field       | result      |
|-------------|-------------|
| date_period | date_period |
| keyword     | date_period |
| text        | date_period |

**Example**
```esql
ROW x = "2024-01-01"::datetime
| EVAL y = x + "3 DAYS"::date_period, z = x - TO_DATEPERIOD("3 days");
```


| x:datetime | y:datetime | z:datetime |
|------------|------------|------------|
| 2024-01-01 | 2024-01-04 | 2023-12-29 |


## `TO_DATETIME`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_datetime.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a date value. A string will only be successfully converted if it’s respecting the format `yyyy-MM-dd'T'HH:mm:ss.SSS'Z'`. To convert dates in other formats, use [`DATE_PARSE`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-date_parse).
<note>
  Note that when converting from nanosecond resolution to millisecond resolution with this function, the nanosecond date is truncated, not rounded.
</note>

**Supported types**

| field         | result |
|---------------|--------|
| date          | date   |
| date_nanos    | date   |
| double        | date   |
| integer       | date   |
| keyword       | date   |
| long          | date   |
| text          | date   |
| unsigned_long | date   |

**Examples**
```esql
ROW string = ["1953-09-02T00:00:00.000Z", "1964-06-02T00:00:00.000Z", "1964-06-02 00:00:00"]
| EVAL datetime = TO_DATETIME(string)
```


| string:keyword                                                                  | datetime:date                                        |
|---------------------------------------------------------------------------------|------------------------------------------------------|
| ["1953-09-02T00:00:00.000Z", "1964-06-02T00:00:00.000Z", "1964-06-02 00:00:00"] | [1953-09-02T00:00:00.000Z, 1964-06-02T00:00:00.000Z] |

Note that in this example, the last value in the source multi-valued field has not been converted.
The reason being that if the date format is not respected, the conversion will result in a `null` value.
When this happens a _Warning_ header is added to the response.
The header will provide information on the source of the failure:
`"Line 1:112: evaluation of [TO_DATETIME(string)] failed, treating result as null. "Only first 20 failures recorded."`
A following header will contain the failure reason and the offending value:
`"java.lang.IllegalArgumentException: failed to parse date field [1964-06-02 00:00:00] with format [yyyy-MM-dd'T'HH:mm:ss.SSS'Z']"`
If the input parameter is of a numeric type,
its value will be interpreted as milliseconds since the [Unix epoch](https://en.wikipedia.org/wiki/Unix_time). For example:
```esql
ROW int = [0, 1]
| EVAL dt = TO_DATETIME(int)
```


| int:integer | dt:date                                              |
|-------------|------------------------------------------------------|
| [0, 1]      | [1970-01-01T00:00:00.000Z, 1970-01-01T00:00:00.001Z] |


## `TO_DATE_NANOS`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_date_nanos.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input to a nanosecond-resolution date value (aka date_nanos).
<note>
  The range for date nanos is 1970-01-01T00:00:00.000000000Z to 2262-04-11T23:47:16.854775807Z, attempting to convert values outside of that range will result in null with a warning.  Additionally, integers cannot be converted into date nanos, as the range of integer nanoseconds only covers about 2 seconds after epoch.
</note>

**Supported types**

| field         | result     |
|---------------|------------|
| date          | date_nanos |
| date_nanos    | date_nanos |
| double        | date_nanos |
| keyword       | date_nanos |
| long          | date_nanos |
| text          | date_nanos |
| unsigned_long | date_nanos |

**Example**
```esql
FROM date_nanos
| WHERE MV_MIN(nanos) < TO_DATE_NANOS("2023-10-23T12:27:28.948Z")
    AND millis > "2000-01-01"
| SORT nanos DESC
```


| millis:date              | nanos:date_nanos               | num:long            |
|--------------------------|--------------------------------|---------------------|
| 2023-10-23T12:15:03.360Z | 2023-10-23T12:15:03.360103847Z | 1698063303360103847 |
| 2023-10-23T12:15:03.360Z | 2023-10-23T12:15:03.360103847Z | 1698063303360103847 |


## `TO_DEGREES`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_degrees.svg)

**Parameters**
<definitions>
  <definition term="number">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts a number in [radians](https://en.wikipedia.org/wiki/Radian) to [degrees](https://en.wikipedia.org/wiki/Degree_(angle)).
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW rad = [1.57, 3.14, 4.71]
| EVAL deg = TO_DEGREES(rad)
```


| rad:double         | deg:double                                                 |
|--------------------|------------------------------------------------------------|
| [1.57, 3.14, 4.71] | [89.95437383553924, 179.9087476710785, 269.86312150661774] |


## `TO_DENSE_VECTOR`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_dense_vector.svg)

**Parameters**
<definitions>
  <definition term="field">
    multi-valued input of numbers or hexadecimal string to convert.
  </definition>
</definitions>

**Description**
Converts a multi-valued input of numbers, or a hexadecimal string, to a dense_vector.
**Supported types**

| field   | result       |
|---------|--------------|
| double  | dense_vector |
| integer | dense_vector |
| keyword | dense_vector |
| long    | dense_vector |

**Example**
```esql
row ints = [1, 2, 3]
| eval vector = to_dense_vector(ints)
| keep vector
```


| vector:dense_vector |
|---------------------|
| [1.0, 2.0, 3.0]     |


## `TO_DOUBLE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_double.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a double value. If the input parameter is of a date type, its value will be interpreted as milliseconds since the [Unix epoch](https://en.wikipedia.org/wiki/Unix_time), converted to double. Boolean `true` will be converted to double `1.0`, `false` to `0.0`.
**Supported types**

| field           | result |
|-----------------|--------|
| boolean         | double |
| counter_double  | double |
| counter_integer | double |
| counter_long    | double |
| date            | double |
| double          | double |
| integer         | double |
| keyword         | double |
| long            | double |
| text            | double |
| unsigned_long   | double |

**Example**
```esql
ROW str1 = "5.20128E11", str2 = "foo"
| EVAL dbl = TO_DOUBLE("520128000000"), dbl1 = TO_DOUBLE(str1), dbl2 = TO_DOUBLE(str2)
```


| str1:keyword | str2:keyword | dbl:double | dbl1:double | dbl2:double |
|--------------|--------------|------------|-------------|-------------|
| 5.20128E11   | foo          | 5.20128E11 | 5.20128E11  | null        |

Note that in this example, the last conversion of the string isn’t possible.
When this happens, the result is a `null` value. In this case a _Warning_ header is added to the response.
The header will provide information on the source of the failure:
`"Line 1:115: evaluation of [TO_DOUBLE(str2)] failed, treating result as null. Only first 20 failures recorded."`
A following header will contain the failure reason and the offending value:
`"java.lang.NumberFormatException: For input string: "foo""`

## `TO_GEOHASH`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_geohash.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a `geohash` value. A string will only be successfully converted if it respects the `geohash` format, as described for the [geohash grid aggregation](https://www.elastic.co/docs/reference/aggregations/search-aggregations-bucket-geohashgrid-aggregation).
**Supported types**

| field   | result  |
|---------|---------|
| geohash | geohash |
| keyword | geohash |
| long    | geohash |
| text    | geohash |

**Example**
```esql
ROW string = "u3bu"
| EVAL geohash = TO_GEOHASH(string)
```


| string:keyword | geohash:geohash |
|----------------|-----------------|
| u3bu           | u3bu            |


## `TO_GEOHEX`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_geohex.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a `geohex` value. A string will only be successfully converted if it respects the `geohex` format, as described for the [geohex grid aggregation](https://www.elastic.co/docs/reference/aggregations/search-aggregations-bucket-geohexgrid-aggregation).
**Supported types**

| field   | result |
|---------|--------|
| geohex  | geohex |
| keyword | geohex |
| long    | geohex |
| text    | geohex |

**Example**
```esql
ROW string = "841f059ffffffff"
| EVAL geohex = TO_GEOHEX(string)
```


| string:keyword  | geohex:geohex   |
|-----------------|-----------------|
| 841f059ffffffff | 841f059ffffffff |


## `TO_GEOPOINT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_geopoint.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a `geo_point` value. A string will only be successfully converted if it respects the [WKT Point](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry) format.
**Supported types**

| field     | result    |
|-----------|-----------|
| geo_point | geo_point |
| keyword   | geo_point |
| text      | geo_point |

**Example**
```esql
ROW wkt = "POINT(42.97109630194 14.7552534413725)"
| EVAL pt = TO_GEOPOINT(wkt)
```


| wkt:keyword                              | pt:geo_point                           |
|------------------------------------------|----------------------------------------|
| "POINT(42.97109630194 14.7552534413725)" | POINT(42.97109630194 14.7552534413725) |


## `TO_GEOSHAPE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_geoshape.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a `geo_shape` value. A string will only be successfully converted if it respects the [WKT](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry) format.
**Supported types**

| field     | result    |
|-----------|-----------|
| geo_point | geo_shape |
| geo_shape | geo_shape |
| geohash   | geo_shape |
| geohex    | geo_shape |
| geotile   | geo_shape |
| keyword   | geo_shape |
| text      | geo_shape |

**Example**
```esql
ROW wkt = "POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10))"
| EVAL geom = TO_GEOSHAPE(wkt)
```


| wkt:keyword                                     | geom:geo_shape                                |
|-------------------------------------------------|-----------------------------------------------|
| "POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10))" | POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10)) |


## `TO_GEOTILE`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_geotile.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to a `geotile` value. A string will only be successfully converted if it respects the `geotile` format, as described for the [geotile grid aggregation](https://www.elastic.co/docs/reference/aggregations/search-aggregations-bucket-geotilegrid-aggregation).
**Supported types**

| field   | result  |
|---------|---------|
| geotile | geotile |
| keyword | geotile |
| long    | geotile |
| text    | geotile |

**Example**
```esql
ROW string = "4/8/5"
| EVAL geotile = TO_GEOTILE(string)
```


| string:keyword | geotile:geotile |
|----------------|-----------------|
| 4/8/5          | 4/8/5           |


## `TO_INTEGER`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_integer.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
  <definition term="base">
    (Optional) Radix or base used to convert the input value.When a base is specified the input type must be `keyword` or `text`.<applies-to>Elastic Stack: Planned</applies-to>
  </definition>
</definitions>

**Description**
Converts an input value to an integer value. If the input parameter is of a date type, its value will be interpreted as milliseconds since the [Unix epoch](https://en.wikipedia.org/wiki/Unix_time), converted to integer. Boolean `true` will be converted to integer `1`, `false` to `0`.
When given two arguments, a string value and a whole number base,
the string is parsed as an integer in the given base.
If parsing fails a warning is generated as described below and the result is null.
A leading '0x' prefix is allowed for base 16.
<applies-to>Elastic Stack: Planned</applies-to>
**Supported types**

| field           | base          | result  |
|-----------------|---------------|---------|
| boolean         |               | integer |
| counter_integer |               | integer |
| date            |               | integer |
| double          |               | integer |
| integer         |               | integer |
| keyword         | integer       | integer |
| keyword         | long          | integer |
| keyword         | unsigned_long | integer |
| keyword         |               | integer |
| long            |               | integer |
| text            | integer       | integer |
| text            | long          | integer |
| text            | unsigned_long | integer |
| text            |               | integer |
| unsigned_long   |               | integer |

**Examples**
```esql
ROW long = [5013792, 2147483647, 501379200000]
| EVAL int = TO_INTEGER(long)
```


| long:long                           | int:integer           |
|-------------------------------------|-----------------------|
| [5013792, 2147483647, 501379200000] | [5013792, 2147483647] |

Note that in this example, the last value of the multi-valued field cannot be converted as an integer.
When this happens, the result is a `null` value. In this case a _Warning_ header is added to the response.
The header will provide information on the source of the failure:
`"Line 1:61: evaluation of [TO_INTEGER(long)] failed, treating result as null. Only first 20 failures recorded."`
A following header will contain the failure reason and the offending value:
`"org.elasticsearch.xpack.esql.core.InvalidArgumentException: [501379200000] out of [integer] range"`
```esql
ROW str1 = "0x32", str2 = "31"
| EVAL int1 = TO_INTEGER(str1, 16), int2 = TO_INTEGER(str2, 13)
| KEEP str1, int1, str2, int2
```


| str1:keyword | int1:integer | str2:keyword | int2:integer |
|--------------|--------------|--------------|--------------|
| 0x32         | 50           | 31           | 40           |

This example demonstrates parsing a base 16 value and a base 13 value. <applies-to>Elastic Stack: Planned</applies-to>
```esql
ROW str1 = "Kona"
| EVAL int1 = TO_INTEGER(str1, 27), fail1 = TO_INTEGER(str1, 10)
```


| str1:keyword | int1:integer | fail1:integer |
|--------------|--------------|---------------|
| Kona         | 411787       | null          |

This example demonstrates parsing a string that is valid in base 27 but invalid in base 10.Observe in the second case a warning is generated and null is returned. <applies-to>Elastic Stack: Planned</applies-to>

## `TO_IP`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_ip.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
  <definition term="options">
    (Optional) Additional options.
  </definition>
</definitions>

**Description**
Converts an input string to an IP value.
**Supported types**

| field   | options          | result |
|---------|------------------|--------|
| ip      | named parameters | ip     |
| ip      |                  | ip     |
| keyword | named parameters | ip     |
| keyword |                  | ip     |
| text    | named parameters | ip     |
| text    |                  | ip     |

**Supported function named parameters**
<definitions>
  <definition term="leading_zeros">
    (keyword) What to do with leading 0s in IPv4 addresses.
  </definition>
</definitions>

**Examples**
```esql
ROW str1 = "1.1.1.1", str2 = "foo"
| EVAL ip1 = TO_IP(str1), ip2 = TO_IP(str2)
| WHERE CIDR_MATCH(ip1, "1.0.0.0/8")
```


| str1:keyword | str2:keyword | ip1:ip  | ip2:ip |
|--------------|--------------|---------|--------|
| 1.1.1.1      | foo          | 1.1.1.1 | null   |

Note that in this example, the last conversion of the string isn’t possible.
When this happens, the result is a `null` value. In this case a _Warning_ header is added to the response.
The header will provide information on the source of the failure:
`"Line 1:68: evaluation of [TO_IP(str2)] failed, treating result as null. Only first 20 failures recorded."`
A following header will contain the failure reason and the offending value:
`"java.lang.IllegalArgumentException: 'foo' is not an IP string literal."`
```esql
ROW s = "1.1.010.1" | EVAL ip = TO_IP(s, {"leading_zeros":"octal"})
```


| s:keyword | ip:ip   |
|-----------|---------|
| 1.1.010.1 | 1.1.8.1 |

Parse v4 addresses with leading zeros as octal. Like `ping` or `ftp`.
```esql
ROW s = "1.1.010.1" | EVAL ip = TO_IP(s, {"leading_zeros":"decimal"})
```


| s:keyword | ip:ip    |
|-----------|----------|
| 1.1.010.1 | 1.1.10.1 |

Parse v4 addresses with leading zeros as decimal. Java's `InetAddress.getByName`.

## `TO_LONG`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_long.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
  <definition term="base">
    (Optional) Radix or base used to convert the input value.When a base is specified the input type must be `keyword` or `text`.<applies-to>Elastic Stack: Planned</applies-to>
  </definition>
</definitions>

**Description**
Converts the input value to a long. If the input parameter is of a date type, its value will be interpreted as milliseconds since the [Unix epoch](https://en.wikipedia.org/wiki/Unix_time), converted to long. Boolean `true` will be converted to long `1`, `false` to `0`.
When given two arguments, a string value and a whole number base,
the string is parsed as a long in the given base.
If parsing fails a warning is generated as described below and the result is null.
A leading '0x' prefix is allowed for base 16.
<applies-to>Elastic Stack: Planned</applies-to>
**Supported types**

| field           | base          | result |
|-----------------|---------------|--------|
| boolean         |               | long   |
| counter_integer |               | long   |
| counter_long    |               | long   |
| date            |               | long   |
| date_nanos      |               | long   |
| double          |               | long   |
| geohash         |               | long   |
| geohex          |               | long   |
| geotile         |               | long   |
| integer         |               | long   |
| keyword         | integer       | long   |
| keyword         | long          | long   |
| keyword         | unsigned_long | long   |
| keyword         |               | long   |
| long            |               | long   |
| text            | integer       | long   |
| text            | long          | long   |
| text            | unsigned_long | long   |
| text            |               | long   |
| unsigned_long   |               | long   |

**Examples**
```esql
ROW str1 = "2147483648", str2 = "2147483648.2", str3 = "foo"
| EVAL long1 = TO_LONG(str1), long2 = TO_LONG(str2), long3 = TO_LONG(str3)
```


| str1:keyword | str2:keyword | str3:keyword | long1:long | long2:long | long3:long |
|--------------|--------------|--------------|------------|------------|------------|
| 2147483648   | 2147483648.2 | foo          | 2147483648 | 2147483648 | null       |

Note in this example the last conversion of the string isn’t possible.
When this happens, the result is a `null` value.
In this case a _Warning_ header is added to the response.
The header will provide information on the source of the failure:
`"Line 1:113: evaluation of [TO_LONG(str3)] failed, treating result as null. Only first 20 failures recorded."`
A following header will contain the failure reason and the offending value:
`"java.lang.NumberFormatException: For input string: "foo""`
```esql
ROW str1 = "0x32", str2 = "31"
| EVAL long1 = TO_LONG(str1, 16), long2 = TO_LONG(str2, 13)
| KEEP str1, long1, str2, long2
```


| str1:keyword | long1:long | str2:keyword | long2:long |
|--------------|------------|--------------|------------|
| 0x32         | 50         | 31           | 40         |

This example demonstrates parsing a base 16 value and a base 13 value. <applies-to>Elastic Stack: Planned</applies-to>
```esql
ROW str1 = "Hazelnut"
| EVAL long1 = TO_LONG(str1, 36), fail1 = TO_LONG(str1, 10)
```


| str1:keyword | long1:long    | fail1:long |
|--------------|---------------|------------|
| Hazelnut     | 1356099454469 | null       |

This example demonstrates parsing a string that is valid in base 36 but invalid in base 10.Observe in the second case a warning is generated and null is returned. <applies-to>Elastic Stack: Planned</applies-to>

## `TO_RADIANS`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_radians.svg)

**Parameters**
<definitions>
  <definition term="number">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts a number in [degrees](https://en.wikipedia.org/wiki/Degree_(angle)) to [radians](https://en.wikipedia.org/wiki/Radian).
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW deg = [90.0, 180.0, 270.0]
| EVAL rad = TO_RADIANS(deg)
```


| deg:double           | rad:double                                                |
|----------------------|-----------------------------------------------------------|
| [90.0, 180.0, 270.0] | [1.5707963267948966, 3.141592653589793, 4.71238898038469] |


## `TO_STRING`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_string.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value into a string.
**Supported types**

| field                   | result  |
|-------------------------|---------|
| aggregate_metric_double | keyword |
| boolean                 | keyword |
| cartesian_point         | keyword |
| cartesian_shape         | keyword |
| date                    | keyword |
| date_nanos              | keyword |
| dense_vector            | keyword |
| double                  | keyword |
| exponential_histogram   | keyword |
| geo_point               | keyword |
| geo_shape               | keyword |
| geohash                 | keyword |
| geohex                  | keyword |
| geotile                 | keyword |
| histogram               | keyword |
| integer                 | keyword |
| ip                      | keyword |
| keyword                 | keyword |
| long                    | keyword |
| text                    | keyword |
| unsigned_long           | keyword |
| version                 | keyword |

**Examples**
```esql
ROW a=10
| EVAL j = TO_STRING(a)
```


| a:integer | j:keyword |
|-----------|-----------|
| 10        | "10"      |

It also works fine on multivalued fields:
```esql
ROW a=[10, 9, 8]
| EVAL j = TO_STRING(a)
```


| a:integer  | j:keyword        |
|------------|------------------|
| [10, 9, 8] | ["10", "9", "8"] |


## `TO_TIMEDURATION`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_timeduration.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input is a valid constant time duration expression.
  </definition>
</definitions>

**Description**
Converts an input value into a `time_duration` value.
**Supported types**

| field         | result        |
|---------------|---------------|
| keyword       | time_duration |
| text          | time_duration |
| time_duration | time_duration |

**Example**
```esql
ROW x = "2024-01-01"::datetime
| EVAL y = x + "3 hours"::time_duration, z = x - TO_TIMEDURATION("3 hours");
```


| x:datetime | y:datetime               | z:datetime               |
|------------|--------------------------|--------------------------|
| 2024-01-01 | 2024-01-01T03:00:00.000Z | 2023-12-31T21:00:00.000Z |


## `TO_UNSIGNED_LONG`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_unsigned_long.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input value to an unsigned long value. If the input parameter is of a date type, its value will be interpreted as milliseconds since the [Unix epoch](https://en.wikipedia.org/wiki/Unix_time), converted to unsigned long. Boolean `true` will be converted to unsigned long `1`, `false` to `0`.
**Supported types**

| field         | result        |
|---------------|---------------|
| boolean       | unsigned_long |
| date          | unsigned_long |
| double        | unsigned_long |
| integer       | unsigned_long |
| keyword       | unsigned_long |
| long          | unsigned_long |
| text          | unsigned_long |
| unsigned_long | unsigned_long |

**Example**
```esql
ROW str1 = "2147483648", str2 = "2147483648.2", str3 = "foo"
| EVAL long1 = TO_UNSIGNED_LONG(str1), long2 = TO_ULONG(str2), long3 = TO_UL(str3)
```


| str1:keyword | str2:keyword | str3:keyword | long1:unsigned_long | long2:unsigned_long | long3:unsigned_long |
|--------------|--------------|--------------|---------------------|---------------------|---------------------|
| 2147483648   | 2147483648.2 | foo          | 2147483648          | 2147483648          | null                |

Note that in this example, the last conversion of the string isn’t possible.
When this happens, the result is a `null` value. In this case a _Warning_ header is added to the response.
The header will provide information on the source of the failure:
`"Line 1:133: evaluation of [TO_UL(str3)] failed, treating result as null. Only first 20 failures recorded."`
A following header will contain the failure reason and the offending value:
`"java.lang.NumberFormatException: Character f is neither a decimal digit number, decimal point,
- "nor "e" notation exponential mark."`


## `TO_VERSION`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/to_version.svg)

**Parameters**
<definitions>
  <definition term="field">
    Input value. The input can be a single- or multi-valued column or an expression.
  </definition>
</definitions>

**Description**
Converts an input string to a version value.
**Supported types**

| field   | result  |
|---------|---------|
| keyword | version |
| text    | version |
| version | version |

**Example**
```esql
ROW v = TO_VERSION("1.2.3")
```


| v:version |
|-----------|
| 1.2.3     |﻿---
title: ES|QL RENAME command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/rename
---

# ES|QL RENAME command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `RENAME` processing command renames one or more columns.
**Syntax**
```esql
RENAME old_name1 AS new_name1[, ..., old_nameN AS new_nameN]
```

The following syntax is also supported <applies-to>Elastic Stack: Generally available since 9.1</applies-to>:
```esql
RENAME new_name1 = old_name1[, ..., new_nameN = old_nameN]
```

<tip>
  Both syntax options can be used interchangeably but we recommend sticking to one for consistency and readability.
</tip>

**Parameters**
<definitions>
  <definition term="old_nameX">
    The name of a column you want to rename.
  </definition>
  <definition term="new_nameX">
    The new name of the column. If it conflicts with an existing column name,
    the existing column is dropped. If multiple columns are renamed to the same
    name, all but the rightmost column with the same new name are dropped.
  </definition>
</definitions>

**Description**
The `RENAME` processing command renames one or more columns. If a column with
the new name already exists, it will be replaced by the new column.
A `RENAME` with multiple column renames is equivalent to multiple sequential `RENAME` commands.
**Examples**
```esql
FROM employees
| KEEP first_name, last_name, still_hired
| RENAME  still_hired AS employed
```

Multiple columns can be renamed with a single `RENAME` command:
```esql
FROM employees
| KEEP first_name, last_name
| RENAME first_name AS fn, last_name AS ln
```

With multiple `RENAME` commands:
```esql
FROM employees
| KEEP first_name, last_name
| RENAME first_name AS fn
| RENAME last_name AS ln
```﻿---
title: ES|QL FORK command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/fork
---

# ES|QL FORK command
<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.1
</applies-to>

The `FORK` processing command creates multiple execution branches to operate
on the same input data and combines the results in a single output table.
**Syntax**
```esql
FORK ( <processing_commands> ) ( <processing_commands> ) ... ( <processing_commands> )
```

**Description**
The `FORK` processing command creates multiple execution branches to operate
on the same input data and combines the results in a single output table. A discriminator column (`_fork`) is added to identify which branch each row came from.
Together with the [`FUSE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fuse) command, `FORK` enables hybrid search to combine and score results from multiple queries. To learn more about using ES|QL for search, refer to [ES|QL for search](https://www.elastic.co/docs/solutions/search/esql-for-search).
**Branch identification:**
- The `_fork` column identifies each branch with values like `fork1`, `fork2`, `fork3`
- Values correspond to the order branches are defined
- `fork1` always indicates the first branch

**Column handling:**
- `FORK` branches can output different columns
- Columns with the same name must have the same data type across all branches
- Missing columns are filled with `null` values

**Row ordering:**
- `FORK` preserves row order within each branch
- Rows from different branches may be interleaved
- Use `SORT _fork` to group results by branch

<note>
  `FORK` branches default to `LIMIT 1000` if no `LIMIT` is provided.
</note>

**Limitations**
- `FORK` supports at most 8 execution branches.
- In versions older than 9.3.0 using remote cluster references and `FORK` is not supported.
- Using more than one `FORK` command in a query is not supported.

**Examples**
In the following example, each `FORK` branch returns one row.
Notice how `FORK` adds a `_fork` column that indicates which row the branch originates from:
```esql
FROM employees
| FORK ( WHERE emp_no == 10001 )
       ( WHERE emp_no == 10002 )
| KEEP emp_no, _fork
| SORT emp_no
```


| emp_no:integer | _fork:keyword |
|----------------|---------------|
| 10001          | fork1         |
| 10002          | fork2         |﻿---
title: ES|QL syntax reference
description: This section covers the essential syntax of the ESQL language. Basic syntax: Learn the fundamentals of ESQL query structure, including pipes, commands,...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-syntax-reference
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL syntax reference
This section covers the essential syntax of the ESQL language.
- [Basic syntax](https://www.elastic.co/docs/reference/query-languages/esql/esql-syntax): Learn the fundamentals of ESQL query structure, including pipes, commands, and expressions.
- [Commands](https://www.elastic.co/docs/reference/query-languages/esql/esql-commands): Discover the core commands for data retrieval, filtering, aggregation, and transformation.
- [Functions and operators](https://www.elastic.co/docs/reference/query-languages/esql/esql-functions-operators): Explore the full range of functions and operators available for data manipulation and analysis.﻿---
title: ES|QL aggregation functions
description: The STATS and INLINE STATS commands support these aggregate functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/aggregation-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL aggregation functions
The [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) and [`INLINE STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/inlinestats-by) commands support these aggregate functions:
- [`ABSENT`](#esql-absent) <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
- [`AVG`](#esql-avg)
- [`COUNT`](#esql-count)
- [`COUNT_DISTINCT`](#esql-count_distinct)
- [`MAX`](#esql-max)
- [`MEDIAN`](#esql-median)
- [`MEDIAN_ABSOLUTE_DEVIATION`](#esql-median_absolute_deviation)
- [`MIN`](#esql-min)
- [`PERCENTILE`](#esql-percentile)
- [`PRESENT`](#esql-present) <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
- [`SAMPLE`](#esql-sample)
- [`ST_CENTROID_AGG`](#esql-st_centroid_agg) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_EXTENT_AGG`](#esql-st_extent_agg) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`STD_DEV`](#esql-std_dev)
- [`SUM`](#esql-sum)
- [`TOP`](#esql-top)
- [`VALUES`](#esql-values) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`VARIANCE`](#esql-variance)
- [`WEIGHTED_AVG`](#esql-weighted_avg)


## `ABSENT`

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/absent.svg)

**Parameters**
<definitions>
  <definition term="field">
    Expression that outputs values to be checked for absence.
  </definition>
</definitions>

**Description**
Returns true if the input expression yields no non-null values within the current aggregation context. Otherwise it returns false.
**Supported types**

| field                   | result  |
|-------------------------|---------|
| aggregate_metric_double | boolean |
| boolean                 | boolean |
| cartesian_point         | boolean |
| cartesian_shape         | boolean |
| date                    | boolean |
| date_nanos              | boolean |
| dense_vector            | boolean |
| double                  | boolean |
| exponential_histogram   | boolean |
| geo_point               | boolean |
| geo_shape               | boolean |
| geohash                 | boolean |
| geohex                  | boolean |
| geotile                 | boolean |
| histogram               | boolean |
| integer                 | boolean |
| ip                      | boolean |
| keyword                 | boolean |
| long                    | boolean |
| tdigest                 | boolean |
| text                    | boolean |
| unsigned_long           | boolean |
| version                 | boolean |

**Examples**
```esql
FROM employees
| WHERE emp_no == 10020
| STATS is_absent = ABSENT(languages)
```


| is_absent:boolean |
|-------------------|
| true              |

To check for the absence inside a group use `ABSENT()` and `BY` clauses
```esql
FROM employees
| STATS is_absent = ABSENT(salary) BY languages
```


| is_absent:boolean | languages:integer |
|-------------------|-------------------|
| false             | 1                 |
| false             | 2                 |
| false             | 3                 |
| false             | 4                 |
| false             | 5                 |
| false             | null              |

To check for the absence and return 1 when it's true and 0 when it's false you can use to_integer()
```esql
FROM employees
| WHERE emp_no == 10020
| STATS is_absent = TO_INTEGER(ABSENT(languages))
```


| is_absent:integer |
|-------------------|
| 1                 |


## `AVG`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/avg.svg)

**Parameters**
<definitions>
  <definition term="number">
    Expression that outputs values to average.
  </definition>
</definitions>

**Description**
The average of a numeric field.
**Supported types**

| number                  | result |
|-------------------------|--------|
| aggregate_metric_double | double |
| double                  | double |
| exponential_histogram   | double |
| integer                 | double |
| long                    | double |
| tdigest                 | double |

**Examples**
```esql
FROM employees
| STATS AVG(height)
```


| AVG(height):double |
|--------------------|
| 1.7682             |

The expression can use inline functions. For example, to calculate the average over a multivalued column, first use `MV_AVG` to average the multiple values per row, and use the result with the `AVG` function
```esql
FROM employees
| STATS avg_salary_change = ROUND(AVG(MV_AVG(salary_change)), 10)
```


| avg_salary_change:double |
|--------------------------|
| 1.3904535865             |


## `COUNT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/count.svg)

**Parameters**
<definitions>
  <definition term="field">
    Expression that outputs values to be counted. If omitted, equivalent to `COUNT(*)` (the number of rows).
  </definition>
</definitions>

**Description**
Returns the total number (count) of input values.
**Supported types**

| field                   | result |
|-------------------------|--------|
| aggregate_metric_double | long   |
| boolean                 | long   |
| cartesian_point         | long   |
| cartesian_shape         | long   |
| date                    | long   |
| date_nanos              | long   |
| dense_vector            | long   |
| double                  | long   |
| geo_point               | long   |
| geo_shape               | long   |
| geohash                 | long   |
| geohex                  | long   |
| geotile                 | long   |
| integer                 | long   |
| ip                      | long   |
| keyword                 | long   |
| long                    | long   |
| text                    | long   |
| unsigned_long           | long   |
| version                 | long   |

**Examples**
```esql
FROM employees
| STATS COUNT(height)
```


| COUNT(height):long |
|--------------------|
| 100                |

To count the number of rows, use `COUNT()` or `COUNT(*)`
```esql
FROM employees
| STATS count = COUNT(*) BY languages
| SORT languages DESC
```


| count:long | languages:integer |
|------------|-------------------|
| 10         | null              |
| 21         | 5                 |
| 18         | 4                 |
| 17         | 3                 |
| 19         | 2                 |
| 15         | 1                 |

The expression can use inline functions. This example splits a string into multiple values using the `SPLIT` function and counts the values
```esql
ROW words="foo;bar;baz;qux;quux;foo"
| STATS word_count = COUNT(SPLIT(words, ";"))
```


| word_count:long |
|-----------------|
| 6               |

To count the number of times an expression returns `TRUE` use a [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where) command to remove rows that shouldn’t be included
```esql
ROW n=1
| WHERE n < 0
| STATS COUNT(n)
```


| COUNT(n):long |
|---------------|
| 0             |

To count the same stream of data based on two different expressions use the pattern `COUNT(<expression> OR NULL)`. This builds on the three-valued logic ([3VL](https://en.wikipedia.org/wiki/Three-valued_logic)) of the language: `TRUE OR NULL` is `TRUE`, but `FALSE OR NULL` is `NULL`, plus the way COUNT handles `NULL`s: `COUNT(TRUE)` and `COUNT(FALSE)` are both 1, but `COUNT(NULL)` is 0.
```esql
ROW n=1
| STATS COUNT(n > 0 OR NULL), COUNT(n < 0 OR NULL)
```


| COUNT(n > 0 OR NULL):long | COUNT(n < 0 OR NULL):long |
|---------------------------|---------------------------|
| 1                         | 0                         |


## `COUNT_DISTINCT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/count_distinct.svg)

**Parameters**
<definitions>
  <definition term="field">
    Column or literal for which to count the number of distinct values.
  </definition>
  <definition term="precision">
    Precision threshold. Refer to [`AGG-COUNT-DISTINCT-APPROXIMATE`](#esql-agg-count-distinct-approximate). The maximum supported value is 40000. Thresholds above this number will have the same effect as a threshold of 40000. The default value is 3000.
  </definition>
</definitions>

**Description**
Returns the approximate number of distinct values.
<note>
  [Counts are approximate](#esql-agg-count-distinct-approximate).
</note>

**Supported types**

| field      | precision     | result |
|------------|---------------|--------|
| boolean    | integer       | long   |
| boolean    | long          | long   |
| boolean    | unsigned_long | long   |
| boolean    |               | long   |
| date       | integer       | long   |
| date       | long          | long   |
| date       | unsigned_long | long   |
| date       |               | long   |
| date_nanos | integer       | long   |
| date_nanos | long          | long   |
| date_nanos | unsigned_long | long   |
| date_nanos |               | long   |
| double     | integer       | long   |
| double     | long          | long   |
| double     | unsigned_long | long   |
| double     |               | long   |
| integer    | integer       | long   |
| integer    | long          | long   |
| integer    | unsigned_long | long   |
| integer    |               | long   |
| ip         | integer       | long   |
| ip         | long          | long   |
| ip         | unsigned_long | long   |
| ip         |               | long   |
| keyword    | integer       | long   |
| keyword    | long          | long   |
| keyword    | unsigned_long | long   |
| keyword    |               | long   |
| long       | integer       | long   |
| long       | long          | long   |
| long       | unsigned_long | long   |
| long       |               | long   |
| text       | integer       | long   |
| text       | long          | long   |
| text       | unsigned_long | long   |
| text       |               | long   |
| version    | integer       | long   |
| version    | long          | long   |
| version    | unsigned_long | long   |
| version    |               | long   |

**Examples**
```esql
FROM hosts
| STATS COUNT_DISTINCT(ip0), COUNT_DISTINCT(ip1)
```


| COUNT_DISTINCT(ip0):long | COUNT_DISTINCT(ip1):long |
|--------------------------|--------------------------|
| 7                        | 8                        |

With the optional second parameter to configure the precision threshold
```esql
FROM hosts
| STATS COUNT_DISTINCT(ip0, 80000), COUNT_DISTINCT(ip1, 5)
```


| COUNT_DISTINCT(ip0, 80000):long | COUNT_DISTINCT(ip1, 5):long |
|---------------------------------|-----------------------------|
| 7                               | 9                           |

The expression can use inline functions. This example splits a string into multiple values using the `SPLIT` function and counts the unique values
```esql
ROW words="foo;bar;baz;qux;quux;foo"
| STATS distinct_word_count = COUNT_DISTINCT(SPLIT(words, ";"))
```


| distinct_word_count:long |
|--------------------------|
| 5                        |


### Counts are approximate

Computing exact counts requires loading values into a set and returning its
size. This doesn’t scale when working on high-cardinality sets and/or large
values as the required memory usage and the need to communicate those
per-shard sets between nodes would utilize too many resources of the cluster.
This `COUNT_DISTINCT` function is based on the
[HyperLogLog++](https://static.googleusercontent.com/media/research.google.com/fr//pubs/archive/40671.pdf)
algorithm, which counts based on the hashes of the values with some interesting
properties:
- configurable precision, which decides on how to trade memory for accuracy,
- excellent accuracy on low-cardinality sets,
- fixed memory usage: no matter if there are tens or billions of unique values, memory usage only depends on the configured precision.

For a precision threshold of `c`, the implementation that we are using requires about `c * 8` bytes.
The following chart shows how the error varies before and after the threshold:
![cardinality error](https://www.elastic.co/docs/reference/query-languages/images/cardinality_error.png)
For all 3 thresholds, counts have been accurate up to the configured threshold. Although not guaranteed,
this is likely to be the case. Accuracy in practice depends on the dataset in question. In general,
most datasets show consistently good accuracy. Also note that even with a threshold as low as 100,
the error remains very low (1-6% as seen in the above graph) even when counting millions of items.
The HyperLogLog++ algorithm depends on the leading zeros of hashed values, the exact distributions of
hashes in a dataset can affect the accuracy of the cardinality.
The `COUNT_DISTINCT` function takes an optional second parameter to configure
the precision threshold. The `precision_threshold` options allows to trade memory
for accuracy, and defines a unique count below which counts are expected to be
close to accurate. Above this value, counts might become a bit more fuzzy. The
maximum supported value is `40000`, thresholds above this number will have the
same effect as a threshold of `40000`. The default value is `3000`.

## `MAX`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/max.svg)

**Parameters**
<definitions>
  <definition term="field">
  </definition>
</definitions>

**Description**
The maximum value of a field.
**Supported types**

| field                                                                               | result        |
|-------------------------------------------------------------------------------------|---------------|
| aggregate_metric_double                                                             | double        |
| boolean                                                                             | boolean       |
| date                                                                                | date          |
| date_nanos                                                                          | date_nanos    |
| double                                                                              | double        |
| exponential_histogram                                                               | double        |
| integer                                                                             | integer       |
| ip                                                                                  | ip            |
| keyword                                                                             | keyword       |
| long                                                                                | long          |
| tdigest                                                                             | double        |
| text                                                                                | keyword       |
| unsigned_long <applies-to>Elastic Stack: Generally available since 9.2</applies-to> | unsigned_long |
| version                                                                             | version       |

**Examples**
```esql
FROM employees
| STATS MAX(languages)
```


| MAX(languages):integer |
|------------------------|
| 5                      |

The expression can use inline functions. For example, to calculate the maximum over an average of a multivalued column, use `MV_AVG` to first average the multiple values per row, and use the result with the `MAX` function
```esql
FROM employees
| STATS max_avg_salary_change = MAX(MV_AVG(salary_change))
```


| max_avg_salary_change:double |
|------------------------------|
| 13.75                        |


## `MEDIAN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/median.svg)

**Parameters**
<definitions>
  <definition term="number">
    Expression that outputs values to calculate the median of.
  </definition>
</definitions>

**Description**
The value that is greater than half of all values and less than half of all values, also known as the 50% [`PERCENTILE`](#esql-percentile).
<note>
  Like [`PERCENTILE`](#esql-percentile), `MEDIAN` is [usually approximate](#esql-percentile-approximate).
</note>

**Supported types**

| number                | result |
|-----------------------|--------|
| double                | double |
| exponential_histogram | double |
| integer               | double |
| long                  | double |

**Examples**
```esql
FROM employees
| STATS MEDIAN(salary), PERCENTILE(salary, 50)
```


| MEDIAN(salary):double | PERCENTILE(salary, 50):double |
|-----------------------|-------------------------------|
| 47003                 | 47003                         |

The expression can use inline functions. For example, to calculate the median of the maximum values of a multivalued column, first use `MV_MAX` to get the maximum value per row, and use the result with the `MEDIAN` function
```esql
FROM employees
| STATS median_max_salary_change = MEDIAN(MV_MAX(salary_change))
```


| median_max_salary_change:double |
|---------------------------------|
| 7.69                            |

<warning>
  `MEDIAN` is also [non-deterministic](https://en.wikipedia.org/wiki/Nondeterministic_algorithm).
  This means you can get slightly different results using the same data.
</warning>


## `MEDIAN_ABSOLUTE_DEVIATION`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/median_absolute_deviation.svg)

**Parameters**
<definitions>
  <definition term="number">
  </definition>
</definitions>

**Description**
Returns the median absolute deviation, a measure of variability. It is a robust statistic, meaning that it is useful for describing data that may have outliers, or may not be normally distributed. For such data it can be more descriptive than standard deviation.  It is calculated as the median of each data point’s deviation from the median of the entire sample. That is, for a random variable `X`, the median absolute deviation is `median(|median(X) - X|)`.
<note>
  Like [`PERCENTILE`](#esql-percentile), `MEDIAN_ABSOLUTE_DEVIATION` is [usually approximate](#esql-percentile-approximate).
</note>

**Supported types**

| number  | result |
|---------|--------|
| double  | double |
| integer | double |
| long    | double |

**Examples**
```esql
FROM employees
| STATS MEDIAN(salary), MEDIAN_ABSOLUTE_DEVIATION(salary)
```


| MEDIAN(salary):double | MEDIAN_ABSOLUTE_DEVIATION(salary):double |
|-----------------------|------------------------------------------|
| 47003                 | 10096.5                                  |

The expression can use inline functions. For example, to calculate the median absolute deviation of the maximum values of a multivalued column, first use `MV_MAX` to get the maximum value per row, and use the result with the `MEDIAN_ABSOLUTE_DEVIATION` function
```esql
FROM employees
| STATS m_a_d_max_salary_change = MEDIAN_ABSOLUTE_DEVIATION(MV_MAX(salary_change))
```


| m_a_d_max_salary_change:double |
|--------------------------------|
| 5.69                           |

<warning>
  `MEDIAN_ABSOLUTE_DEVIATION` is also [non-deterministic](https://en.wikipedia.org/wiki/Nondeterministic_algorithm).
  This means you can get slightly different results using the same data.
</warning>


## `MIN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/min.svg)

**Parameters**
<definitions>
  <definition term="field">
  </definition>
</definitions>

**Description**
The minimum value of a field.
**Supported types**

| field                                                                               | result        |
|-------------------------------------------------------------------------------------|---------------|
| aggregate_metric_double                                                             | double        |
| boolean                                                                             | boolean       |
| date                                                                                | date          |
| date_nanos                                                                          | date_nanos    |
| double                                                                              | double        |
| exponential_histogram                                                               | double        |
| integer                                                                             | integer       |
| ip                                                                                  | ip            |
| keyword                                                                             | keyword       |
| long                                                                                | long          |
| tdigest                                                                             | double        |
| text                                                                                | keyword       |
| unsigned_long <applies-to>Elastic Stack: Generally available since 9.2</applies-to> | unsigned_long |
| version                                                                             | version       |

**Examples**
```esql
FROM employees
| STATS MIN(languages)
```


| MIN(languages):integer |
|------------------------|
| 1                      |

The expression can use inline functions. For example, to calculate the minimum over an average of a multivalued column, use `MV_AVG` to first average the multiple values per row, and use the result with the `MIN` function
```esql
FROM employees
| STATS min_avg_salary_change = MIN(MV_AVG(salary_change))
```


| min_avg_salary_change:double |
|------------------------------|
| -8.46                        |


## `PERCENTILE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/percentile.svg)

**Parameters**
<definitions>
  <definition term="number">
  </definition>
  <definition term="percentile">
  </definition>
</definitions>

**Description**
Returns the value at which a certain percentage of observed values occur. For example, the 95th percentile is the value which is greater than 95% of the observed values and the 50th percentile is the `MEDIAN`.
**Supported types**

| number                | percentile | result |
|-----------------------|------------|--------|
| double                | double     | double |
| double                | integer    | double |
| double                | long       | double |
| exponential_histogram | double     | double |
| exponential_histogram | integer    | double |
| exponential_histogram | long       | double |
| integer               | double     | double |
| integer               | integer    | double |
| integer               | long       | double |
| long                  | double     | double |
| long                  | integer    | double |
| long                  | long       | double |
| tdigest               | double     | double |
| tdigest               | integer    | double |
| tdigest               | long       | double |

**Examples**
```esql
FROM employees
| STATS p0 = PERCENTILE(salary,  0)
     , p50 = PERCENTILE(salary, 50)
     , p99 = PERCENTILE(salary, 99)
```


| p0:double | p50:double | p99:double |
|-----------|------------|------------|
| 25324     | 47003      | 74970.29   |

The expression can use inline functions. For example, to calculate a percentile of the maximum values of a multivalued column, first use `MV_MAX` to get the maximum value per row, and use the result with the `PERCENTILE` function
```esql
FROM employees
| STATS p80_max_salary_change = PERCENTILE(MV_MAX(salary_change), 80)
```


| p80_max_salary_change:double |
|------------------------------|
| 12.132                       |


### `PERCENTILE` is (usually) approximate

There are many different algorithms to calculate percentiles. The naive implementation simply stores all the values in a sorted array. To find the 50th percentile, you simply find the value that is at `my_array[count(my_array) * 0.5]`.
Clearly, the naive implementation does not scale — the sorted array grows linearly with the number of values in your dataset. To calculate percentiles across potentially billions of values in an Elasticsearch cluster, *approximate* percentiles are calculated.
The algorithm used by the `percentile` metric is called TDigest (introduced by Ted Dunning in [Computing Accurate Quantiles using T-Digests](https://github.com/tdunning/t-digest/blob/master/docs/t-digest-paper/histo.pdf)).
When using this metric, there are a few guidelines to keep in mind:
- Accuracy is proportional to `q(1-q)`. This means that extreme percentiles (e.g. 99%) are more accurate than less extreme percentiles, such as the median
- For small sets of values, percentiles are highly accurate (and potentially 100% accurate if the data is small enough).
- As the quantity of values in a bucket grows, the algorithm begins to approximate the percentiles. It is effectively trading accuracy for memory savings. The exact level of inaccuracy is difficult to generalize, since it depends on your data distribution and volume of data being aggregated

The following chart shows the relative error on a uniform distribution depending on the number of collected values and the requested percentile:
![percentiles error](https://www.elastic.co/docs/reference/query-languages/images/percentiles_error.png)
It shows how precision is better for extreme percentiles. The reason why error diminishes for large number of values is that the law of large numbers makes the distribution of values more and more uniform and the t-digest tree can do a better job at summarizing it. It would not be the case on more skewed distributions.
<warning>
  `PERCENTILE` is also [non-deterministic](https://en.wikipedia.org/wiki/Nondeterministic_algorithm).
  This means you can get slightly different results using the same data.
</warning>


## `PRESENT`

<applies-to>
  - Elastic Stack: Generally available since 9.2
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/present.svg)

**Parameters**
<definitions>
  <definition term="field">
    Expression that outputs values to be checked for presence.
  </definition>
</definitions>

**Description**
Returns true if the input expression yields any non-null values within the current aggregation context. Otherwise it returns false.
**Supported types**

| field                   | result  |
|-------------------------|---------|
| aggregate_metric_double | boolean |
| boolean                 | boolean |
| cartesian_point         | boolean |
| cartesian_shape         | boolean |
| date                    | boolean |
| date_nanos              | boolean |
| dense_vector            | boolean |
| double                  | boolean |
| exponential_histogram   | boolean |
| geo_point               | boolean |
| geo_shape               | boolean |
| geohash                 | boolean |
| geohex                  | boolean |
| geotile                 | boolean |
| histogram               | boolean |
| integer                 | boolean |
| ip                      | boolean |
| keyword                 | boolean |
| long                    | boolean |
| tdigest                 | boolean |
| text                    | boolean |
| unsigned_long           | boolean |
| version                 | boolean |

**Examples**
```esql
FROM employees
| STATS is_present = PRESENT(languages)
```


| is_present:boolean |
|--------------------|
| true               |

To check for the presence inside a group use `PRESENT()` and `BY` clauses
```esql
FROM employees
| STATS is_present = PRESENT(salary) BY languages
```


| is_present:boolean | languages:integer |
|--------------------|-------------------|
| true               | 1                 |
| true               | 2                 |
| true               | 3                 |
| true               | 4                 |
| true               | 5                 |
| true               | null              |

To check for the presence and return 1 when it's true and 0 when it's false
```esql
FROM employees
| WHERE emp_no == 10020
| STATS is_present = TO_INTEGER(PRESENT(languages))
```


| is_present:integer |
|--------------------|
| 0                  |


## `SAMPLE`

<applies-to>
  - Elastic Stack: Generally available since 9.1
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/sample.svg)

**Parameters**
<definitions>
  <definition term="field">
    The field to collect sample values for.
  </definition>
  <definition term="limit">
    The maximum number of values to collect.
  </definition>
</definitions>

**Description**
Collects sample values for a field.
**Supported types**

| field           | limit   | result          |
|-----------------|---------|-----------------|
| boolean         | integer | boolean         |
| cartesian_point | integer | cartesian_point |
| cartesian_shape | integer | cartesian_shape |
| date            | integer | date            |
| date_nanos      | integer | date_nanos      |
| double          | integer | double          |
| geo_point       | integer | geo_point       |
| geo_shape       | integer | geo_shape       |
| geohash         | integer | geohash         |
| geohex          | integer | geohex          |
| geotile         | integer | geotile         |
| integer         | integer | integer         |
| ip              | integer | ip              |
| keyword         | integer | keyword         |
| long            | integer | long            |
| text            | integer | keyword         |
| unsigned_long   | integer | unsigned_long   |
| version         | integer | version         |

**Example**
```esql
FROM employees
| STATS sample = SAMPLE(gender, 5)
```


| sample:keyword  |
|-----------------|
| [F, M, M, F, M] |


## `ST_CENTROID_AGG`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_centroid_agg.svg)

**Parameters**
<definitions>
  <definition term="field">
  </definition>
</definitions>

**Description**
Calculate the spatial centroid over a field with spatial point geometry type.
**Supported types**

| field           | result          |
|-----------------|-----------------|
| cartesian_point | cartesian_point |
| geo_point       | geo_point       |

**Example**
```esql
FROM airports
| STATS centroid=ST_CENTROID_AGG(location)
```


| centroid:geo_point                             |
|------------------------------------------------|
| POINT(-0.030548143003023033 24.37553649504829) |


## `ST_EXTENT_AGG`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_extent_agg.svg)

**Parameters**
<definitions>
  <definition term="field">
  </definition>
</definitions>

**Description**
Calculate the spatial extent over a field with geometry type. Returns a bounding box for all values of the field.
**Supported types**

| field           | result          |
|-----------------|-----------------|
| cartesian_point | cartesian_shape |
| cartesian_shape | cartesian_shape |
| geo_point       | geo_shape       |
| geo_shape       | geo_shape       |

**Example**
```esql
FROM airports
| WHERE country == "India"
| STATS extent = ST_EXTENT_AGG(location)
```


| extent:geo_shape                                                               |
|--------------------------------------------------------------------------------|
| BBOX (70.77995480038226, 91.5882289968431, 33.9830909203738, 8.47650992218405) |


## `STD_DEV`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/std_dev.svg)

**Parameters**
<definitions>
  <definition term="number">
  </definition>
</definitions>

**Description**
The population standard deviation of a numeric field.
**Supported types**

| number  | result |
|---------|--------|
| double  | double |
| integer | double |
| long    | double |

**Examples**
```esql
FROM employees
| STATS std_dev_height = STD_DEV(height)
```


| std_dev_height:double |
|-----------------------|
| 0.2063704             |

The expression can use inline functions. For example, to calculate the population standard deviation of each employee’s maximum salary changes, first use `MV_MAX` on each row, and then use `STD_DEV` on the result
```esql
FROM employees
| STATS stddev_salary_change = STD_DEV(MV_MAX(salary_change))
```


| stddev_salary_change:double |
|-----------------------------|
| 6.87583                     |


## `SUM`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/sum.svg)

**Parameters**
<definitions>
  <definition term="number">
  </definition>
</definitions>

**Description**
The sum of a numeric expression.
**Supported types**

| number                  | result |
|-------------------------|--------|
| aggregate_metric_double | double |
| double                  | double |
| exponential_histogram   | double |
| integer                 | long   |
| long                    | long   |
| tdigest                 | double |

**Examples**
```esql
FROM employees
| STATS SUM(languages)
```


| SUM(languages):long |
|---------------------|
| 281                 |

The expression can use inline functions. For example, to calculate the sum of each employee’s maximum salary changes, apply the `MV_MAX` function to each row and then sum the results
```esql
FROM employees
| STATS total_salary_changes = SUM(MV_MAX(salary_change))
```


| total_salary_changes:double |
|-----------------------------|
| 446.75                      |


## `TOP`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/top.svg)

**Parameters**
<definitions>
  <definition term="field">
    The field to collect the top values for.
  </definition>
  <definition term="limit">
    The maximum number of values to collect.
  </definition>
  <definition term="order">
    The order to calculate the top values. Either `asc` or `desc`, and defaults to `asc` if omitted.
  </definition>
  <definition term="outputField">
    The extra field that, if present, will be the output of the TOP call instead of `field`.<applies-to>Elastic Stack: Planned</applies-to>
  </definition>
</definitions>

**Description**
Collects the top values for a field. Includes repeated values.
**Supported types**

| field   | limit   | order   | outputField | result  |
|---------|---------|---------|-------------|---------|
| boolean | integer | keyword |             | boolean |
| boolean | integer |         |             | boolean |
| date    | integer | keyword | date        | date    |
| date    | integer | keyword | double      | double  |
| date    | integer | keyword | integer     | integer |
| date    | integer | keyword | long        | long    |
| date    | integer | keyword |             | date    |
| date    | integer |         |             | date    |
| double  | integer | keyword | date        | date    |
| double  | integer | keyword | double      | double  |
| double  | integer | keyword | integer     | integer |
| double  | integer | keyword | long        | long    |
| double  | integer | keyword |             | double  |
| double  | integer |         |             | double  |
| integer | integer | keyword | date        | date    |
| integer | integer | keyword | double      | double  |
| integer | integer | keyword | integer     | integer |
| integer | integer | keyword | long        | long    |
| integer | integer | keyword |             | integer |
| integer | integer |         |             | integer |
| ip      | integer | keyword |             | ip      |
| ip      | integer |         |             | ip      |
| keyword | integer | keyword |             | keyword |
| keyword | integer |         |             | keyword |
| long    | integer | keyword | date        | date    |
| long    | integer | keyword | double      | double  |
| long    | integer | keyword | integer     | integer |
| long    | integer | keyword | long        | long    |
| long    | integer | keyword |             | long    |
| long    | integer |         |             | long    |
| text    | integer | keyword |             | keyword |
| text    | integer |         |             | keyword |

**Example**
```esql
FROM employees
| STATS top_salaries = TOP(salary, 3, "desc"), top_salary = MAX(salary)
```


| top_salaries:integer  | top_salary:integer |
|-----------------------|--------------------|
| [74999, 74970, 74572] | 74999              |


## `VALUES`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/values.svg)

**Parameters**
<definitions>
  <definition term="field">
  </definition>
</definitions>

**Description**
Returns unique values as a multivalued field. The order of the returned values isn’t guaranteed. If you need the values returned in order use [`MV_SORT`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_sort).
**Supported types**

| field           | result          |
|-----------------|-----------------|
| boolean         | boolean         |
| cartesian_point | cartesian_point |
| cartesian_shape | cartesian_shape |
| date            | date            |
| date_nanos      | date_nanos      |
| double          | double          |
| geo_point       | geo_point       |
| geo_shape       | geo_shape       |
| geohash         | geohash         |
| geohex          | geohex          |
| geotile         | geotile         |
| integer         | integer         |
| ip              | ip              |
| keyword         | keyword         |
| long            | long            |
| text            | keyword         |
| unsigned_long   | unsigned_long   |
| version         | version         |

**Example**
```esql
FROM employees
| EVAL first_letter = SUBSTRING(first_name, 0, 1)
| STATS first_name = MV_SORT(VALUES(first_name)) BY first_letter
| SORT first_letter
```


| first_name:keyword                                                                                | first_letter:keyword |
|---------------------------------------------------------------------------------------------------|----------------------|
| [Alejandro, Amabile, Anneke, Anoosh, Arumugam]                                                    | A                    |
| [Basil, Berhard, Berni, Bezalel, Bojan, Breannda, Brendon]                                        | B                    |
| [Charlene, Chirstian, Claudi, Cristinel]                                                          | C                    |
| [Danel, Divier, Domenick, Duangkaew]                                                              | D                    |
| [Ebbe, Eberhardt, Erez]                                                                           | E                    |
| Florian                                                                                           | F                    |
| [Gao, Georgi, Georgy, Gino, Guoxiang]                                                             | G                    |
| [Heping, Hidefumi, Hilari, Hironobu, Hironoby, Hisao]                                             | H                    |
| [Jayson, Jungsoon]                                                                                | J                    |
| [Kazuhide, Kazuhito, Kendra, Kenroku, Kshitij, Kwee, Kyoichi]                                     | K                    |
| [Lillian, Lucien]                                                                                 | L                    |
| [Magy, Margareta, Mary, Mayuko, Mayumi, Mingsen, Mokhtar, Mona, Moss]                             | M                    |
| Otmar                                                                                             | O                    |
| [Parto, Parviz, Patricio, Prasadram, Premal]                                                      | P                    |
| [Ramzi, Remzi, Reuven]                                                                            | R                    |
| [Sailaja, Saniya, Sanjiv, Satosi, Shahaf, Shir, Somnath, Sreekrishna, Sudharsan, Sumant, Suzette] | S                    |
| [Tse, Tuval, Tzvetan]                                                                             | T                    |
| [Udi, Uri]                                                                                        | U                    |
| [Valdiodio, Valter, Vishv]                                                                        | V                    |
| Weiyi                                                                                             | W                    |
| Xinglin                                                                                           | X                    |
| [Yinghua, Yishay, Yongqiao]                                                                       | Y                    |
| [Zhongwei, Zvonko]                                                                                | Z                    |
| null                                                                                              | null                 |

<tip>
  Use [`TOP`](#esql-top)
  if you need to keep repeated values.
</tip>

<warning>
  This can use a significant amount of memory and ES|QL doesn’t yet
  grow aggregations beyond memory. So this aggregation will work until
  it is used to collect more values than can fit into memory. Once it
  collects too many values it will fail the query with
  a [Circuit Breaker Error](https://www.elastic.co/docs/troubleshoot/elasticsearch/circuit-breaker-errors).
</warning>


## `VARIANCE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/variance.svg)

**Parameters**
<definitions>
  <definition term="number">
  </definition>
</definitions>

**Description**
The population variance of a numeric field.
**Supported types**

| number  | result |
|---------|--------|
| double  | double |
| integer | double |
| long    | double |

**Example**
```esql
FROM employees
| STATS var_height = VARIANCE(height)
```


| var_height:double |
|-------------------|
| 0.0425888         |


## `WEIGHTED_AVG`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/weighted_avg.svg)

**Parameters**
<definitions>
  <definition term="number">
    A numeric value.
  </definition>
  <definition term="weight">
    A numeric weight.
  </definition>
</definitions>

**Description**
The weighted average of a numeric expression.
**Supported types**

| number  | weight  | result |
|---------|---------|--------|
| double  | double  | double |
| double  | integer | double |
| double  | long    | double |
| integer | double  | double |
| integer | integer | double |
| integer | long    | double |
| long    | double  | double |
| long    | integer | double |
| long    | long    | double |

**Example**
```esql
FROM employees
| STATS w_avg = WEIGHTED_AVG(salary, height) BY languages
| EVAL w_avg = ROUND(w_avg)
| KEEP w_avg, languages
| SORT languages
```


| w_avg:double | languages:integer |
|--------------|-------------------|
| 51464.0      | 1                 |
| 48477.0      | 2                 |
| 52379.0      | 3                 |
| 47990.0      | 4                 |
| 42119.0      | 5                 |
| 52142.0      | null              |﻿---
title: ES|QL Query log
description: The ES|QL query log allows to log ES|QL queries based on their execution time. You can use these logs to investigate, analyze or troubleshoot your cluster’s...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-query-log
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL Query log
The ES|QL query log allows to log ES|QL queries based on their execution time.
You can use these logs to investigate, analyze or troubleshoot your cluster’s historical ES|QL performance.
ES|QL query log reports task duration at coordinator level, but might not encompass the full task execution time observed on the client. For example, logs don’t surface HTTP network delays.
Events that meet the specified threshold are emitted into  [Elasticsearch server logs](https://www.elastic.co/docs/deploy-manage/monitor/logging-configuration/update-elasticsearch-logging-levels).
These logs can be found in local Elasticsearch service logs directory. Slow log files have a suffix of `_esql_querylog.json`.

## Query log format

The following is an example of a successful query event in the query log:
```js
{
    "@timestamp": "2025-03-11T08:39:50.076Z",
    "log.level": "TRACE",
    "auth.type": "REALM",
    "elasticsearch.querylog.planning.took": 3108666,
    "elasticsearch.querylog.planning.took_millis": 3,
    "elasticsearch.querylog.query": "from index | limit 100",
    "elasticsearch.querylog.search_type": "ESQL",
    "elasticsearch.querylog.success": true,
    "elasticsearch.querylog.took": 8050416,
    "elasticsearch.querylog.took_millis": 8,
    "user.name": "elastic-admin",
    "user.realm": "default_file",
    "ecs.version": "1.2.0",
    "service.name": "ES_ECS",
    "event.dataset": "elasticsearch.esql_querylog",
    "process.thread.name": "elasticsearch[runTask-0][esql_worker][T#12]",
    "log.logger": "esql.querylog.query",
    "elasticsearch.cluster.uuid": "KZo1V7TcQM-O6fnqMm1t_g",
    "elasticsearch.node.id": "uPgRE2TrSfa9IvnUpNT1Uw",
    "elasticsearch.node.name": "runTask-0",
    "elasticsearch.cluster.name": "runTask"
}
```

The following is an example of a failing query event in the query log:
```js
{
    "@timestamp": "2025-03-11T08:41:54.172Z",
    "log.level": "TRACE",
    "auth.type": "REALM",
    "elasticsearch.querylog.error.message": "line 1:15: mismatched input 'limitxyz' expecting {DEV_CHANGE_POINT, 'enrich', 'dissect', 'eval', 'grok', 'limit', 'sort', 'stats', 'where', DEV_INLINESTATS, DEV_FORK, 'lookup', DEV_JOIN_LEFT, DEV_JOIN_RIGHT, DEV_LOOKUP, 'mv_expand', 'drop', 'keep', DEV_INSIST, 'rename'}",
    "elasticsearch.querylog.error.type": "org.elasticsearch.xpack.esql.parser.ParsingException",
    "elasticsearch.querylog.query": "from person | limitxyz 100",
    "elasticsearch.querylog.search_type": "ESQL",
    "elasticsearch.querylog.success": false,
    "elasticsearch.querylog.took": 963750,
    "elasticsearch.querylog.took_millis": 0,
    "user.name": "elastic-admin",
    "user.realm": "default_file",
    "ecs.version": "1.2.0",
    "service.name": "ES_ECS",
    "event.dataset": "elasticsearch.esql_querylog",
    "process.thread.name": "elasticsearch[runTask-0][search][T#16]",
    "log.logger": "esql.querylog.query",
    "elasticsearch.cluster.uuid": "KZo1V7TcQM-O6fnqMm1t_g",
    "elasticsearch.node.id": "uPgRE2TrSfa9IvnUpNT1Uw",
    "elasticsearch.node.name": "runTask-0",
    "elasticsearch.cluster.name": "runTask"
}
```


## Enable query logging

You can enable query logging at cluster level.
By default, all thresholds are set to `-1`, which results in no events being logged.
Query log thresholds can be enabled for the four logging levels: `trace`, `debug`, `info`, and `warn`.
To view the current query log settings, use the [get cluster settings API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-cluster-get-settings):
```json
```

You can use the `esql.querylog.include.user` setting to append `user.*` and `auth.type` fields to slow log entries. These fields contain information about the user who triggered the request.
The following snippet adjusts all available ES|QL query log settings [update cluster settings API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-cluster-put-settings):
```json

{
  "transient": {
    "esql.querylog.threshold.warn": "10s",
    "esql.querylog.threshold.info": "5s",
    "esql.querylog.threshold.debug": "2s",
    "esql.querylog.threshold.trace": "500ms",
    "esql.querylog.include.user": true
  }
}
```


## Best practices for query logging

Logging slow requests can be resource intensive to your Elasticsearch cluster depending on the qualifying traffic’s volume. For example, emitted logs might increase the index disk usage of your [Elasticsearch monitoring](https://www.elastic.co/docs/deploy-manage/monitor/stack-monitoring) cluster. To reduce the impact of slow logs, consider the following:
- Set high thresholds to reduce the number of logged events.
- Enable slow logs only when troubleshooting.

If you aren’t sure how to start investigating traffic issues, consider enabling the `warn` threshold with a high `30s` threshold at the index level using the [update cluster settings API](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-cluster-put-settings):
Here is an example of how to change cluster settings to enable query logging at `warn` level, for queries taking more than 30 seconds, and include user information in the logs:
```json

{
  "transient": {
    "esql.querylog.include.user": true,
    "esql.querylog.threshold.warn": "30s"
  }
}
```﻿---
title: ES|QL WHERE command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/where
---

# ES|QL WHERE command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `WHERE` processing command produces a table that contains all the rows from
the input table for which the provided condition evaluates to `true`.
<tip>
  In case of value exclusions, fields with `null` values will be excluded from search results.
  In this context a `null` means either there is an explicit `null` value in the document or
  there is no value at all. For example: `WHERE field != "value"` will be interpreted as
  `WHERE field != "value" AND field IS NOT NULL`.
</tip>

**Syntax**
```esql
WHERE expression
```

**Parameters**
<definitions>
  <definition term="expression">
    A boolean expression.
  </definition>
</definitions>

**Examples**
```esql
FROM employees
| KEEP first_name, last_name, still_hired
| WHERE still_hired == true
```

Which, if `still_hired` is a boolean field, can be simplified to:
```esql
FROM employees
| KEEP first_name, last_name, still_hired
| WHERE still_hired
```

Use date math to retrieve data from a specific time range. For example, to
retrieve the last hour of logs:
```esql
FROM sample_data
| WHERE @timestamp > NOW() - 1 hour
```

`WHERE` supports various [functions](/docs/reference/query-languages/esql/esql-functions-operators#esql-functions).
For example the [`LENGTH`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-length) function:
```esql
FROM employees
| KEEP first_name, last_name, height
| WHERE LENGTH(first_name) < 4
```

For a complete list of all functions, refer to [Functions overview](/docs/reference/query-languages/esql/esql-functions-operators#esql-functions).

### NULL Predicates

For NULL comparison, use the `IS NULL` and `IS NOT NULL` predicates.
**Example**
```esql
FROM employees
| WHERE birth_date IS NULL
```


| first_name:keyword | last_name:keyword |
|--------------------|-------------------|
| Basil              | Tramer            |
| Florian            | Syrotiuk          |
| Lucien             | Rosenbaum         |

**Example**
```esql
FROM employees
| WHERE is_rehired IS NOT NULL
| STATS COUNT(emp_no)
```


| COUNT(emp_no):long |
|--------------------|
| 84                 |


### Matching text

For matching text, you can use [full text search functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/search-functions) like `MATCH`.
Use [`MATCH`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match) to perform a
[match query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-match-query) on a specified field.
Match can be used on text fields, as well as other field types like boolean, dates, and numeric types.
**Examples**
```esql
FROM books
| WHERE MATCH(author, "Faulkner")
```


| book_no:keyword | author:text                                        |
|-----------------|----------------------------------------------------|
| 2378            | [Carol Faulkner, Holly Byers Ochoa, Lucretia Mott] |
| 2713            | William Faulkner                                   |
| 2847            | Colleen Faulkner                                   |
| 2883            | William Faulkner                                   |
| 3293            | Danny Faulkner                                     |

```esql
FROM books
| WHERE MATCH(title, "Hobbit Back Again", {"operator": "AND"})
| KEEP title;
```


| title:text                         |
|------------------------------------|
| The Hobbit or There and Back Again |

<tip>
  You can also use the shorthand [match operator](/docs/reference/query-languages/esql/functions-operators/operators#esql-match-operator) `:` instead of `MATCH`.
</tip>


### LIKE and RLIKE

Use `LIKE` to filter data based on string patterns using wildcards. `LIKE` usually acts on a field placed on the left-hand side of the operator, but it can also act on a constant (literal) expression. The right-hand side of the operator represents the pattern.
The following wildcard characters are supported:
- `*` matches zero or more characters.
- `?` matches one character.

**Supported types**

| str     | pattern | result  |
|---------|---------|---------|
| keyword | keyword | boolean |
| text    | keyword | boolean |

**Example**
```esql
FROM employees
| WHERE first_name LIKE """?b*"""
| KEEP first_name, last_name
```


| first_name:keyword | last_name:keyword |
|--------------------|-------------------|
| Ebbe               | Callaway          |
| Eberhardt          | Terkki            |

When used on `text` fields, `LIKE` treats the field as a `keyword` and does not use the analyzer.
This means the pattern matching is case-sensitive and must match the exact string indexed.
To perform full-text search, use the `MATCH` or `QSTR` functions.
Matching the exact characters `*` and `.` will require escaping.
The escape character is backslash `\`. Since also backslash is a special character in string literals,
it will require further escaping.
```esql
ROW message = "foo * bar"
| WHERE message LIKE "foo \\* bar"
```

To reduce the overhead of escaping, we suggest using triple quotes strings `"""`
```esql
ROW message = "foo * bar"
| WHERE message LIKE """foo \* bar"""
```

<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available since 9.1
</applies-to>

Both a single pattern or a list of patterns are supported. If a list of patterns is provided,
the expression will return true if any of the patterns match.
```esql
ROW message = "foobar"
| WHERE message like ("foo*", "bar?")
```

Patterns may be specified with REST query placeholders as well
```esql
FROM employees
| WHERE first_name LIKE ?pattern
| KEEP first_name, last_name
```

<applies-to>
  - Elastic Stack: Planned
</applies-to>

Use `RLIKE` to filter data based on string patterns using using [regular expressions](https://www.elastic.co/docs/reference/query-languages/query-dsl/regexp-syntax). `RLIKE` usually acts on a field placed on the left-hand side of the operator, but it can also act on a constant (literal) expression. The right-hand side of the operator represents the pattern.
**Supported types**

| str     | pattern | result  |
|---------|---------|---------|
| keyword | keyword | boolean |
| text    | keyword | boolean |

**Example**
```esql
FROM employees
| WHERE first_name RLIKE """.leja.*"""
| KEEP first_name, last_name
```


| first_name:keyword | last_name:keyword |
|--------------------|-------------------|
| Alejandro          | McAlpine          |

When used on `text` fields, `RLIKE` treats the field as a `keyword` and does not use the analyzer.
This means the pattern matching is case-sensitive and must match the exact string indexed.
To perform full-text search, use the `MATCH` or `QSTR` functions.
Matching special characters (eg. `.`, `*`, `(`...) will require escaping.
The escape character is backslash `\`. Since also backslash is a special character in string literals,
it will require further escaping.
```esql
ROW message = "foo ( bar"
| WHERE message RLIKE "foo \\( bar"
```

To reduce the overhead of escaping, we suggest using triple quotes strings `"""`
```esql
ROW message = "foo ( bar"
| WHERE message RLIKE """foo \( bar"""
```

<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available since 9.2
</applies-to>

Both a single pattern or a list of patterns are supported. If a list of patterns is provided,
the expression will return true if any of the patterns match.
```esql
ROW message = "foobar"
| WHERE message RLIKE ("foo.*", "bar.")
```

Patterns may be specified with REST query placeholders as well
```esql
FROM employees
| WHERE first_name RLIKE ?pattern
| KEEP first_name, last_name
```

<applies-to>
  - Elastic Stack: Planned
</applies-to>


### IN

The `IN` operator allows testing whether a field or expression equals an element
in a list of literals, fields or expressions:
**Example**
```esql
ROW a = 1, b = 4, c = 3
| WHERE c-a IN (3, b / 2, a)
```


| a:integer | b:integer | c:integer |
|-----------|-----------|-----------|
| 1         | 4         | 3         |

For a complete list of all operators, refer to [Operators](/docs/reference/query-languages/esql/esql-functions-operators#esql-operators-overview).﻿---
title: ES|QL GROK command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/grok
---

# ES|QL GROK command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

`GROK` enables you to [extract structured data out of a string](https://www.elastic.co/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok).
**Syntax**
```esql
GROK input "pattern"
```

**Parameters**
<definitions>
  <definition term="input">
    The column that contains the string you want to structure. If the column has
    multiple values, `GROK` will process each value.
  </definition>
  <definition term="pattern">
    A grok pattern. If a field name conflicts with an existing column, the existing column is discarded.
    If a field name is used more than once, a multi-valued column will be created with one value
    per each occurrence of the field name.
  </definition>
</definitions>

**Description**
`GROK` enables you to [extract structured data out of a string](https://www.elastic.co/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok).
`GROK` matches the string against patterns, based on regular expressions,
and extracts the specified patterns as columns.
Refer to [Process data with `GROK`](/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok#esql-process-data-with-grok) for the syntax of grok patterns.
**Examples**
The following example parses a string that contains a timestamp, an IP address,
an email address, and a number:
```esql
ROW a = "2023-01-23T12:15:00.000Z 127.0.0.1 some.email@foo.com 42"
| GROK a """%{TIMESTAMP_ISO8601:date} %{IP:ip} %{EMAILADDRESS:email} %{NUMBER:num}"""
| KEEP date, ip, email, num
```


| date:keyword             | ip:keyword | email:keyword      | num:keyword |
|--------------------------|------------|--------------------|-------------|
| 2023-01-23T12:15:00.000Z | 127.0.0.1  | some.email@foo.com | 42          |

By default, `GROK` outputs keyword string columns. `int` and `float` types can
be converted by appending `:type` to the semantics in the pattern. For example
`{NUMBER:num:int}`:
```esql
ROW a = "2023-01-23T12:15:00.000Z 127.0.0.1 some.email@foo.com 42"
| GROK a """%{TIMESTAMP_ISO8601:date} %{IP:ip} %{EMAILADDRESS:email} %{NUMBER:num:int}"""
| KEEP date, ip, email, num
```


| date:keyword             | ip:keyword | email:keyword      | num:integer |
|--------------------------|------------|--------------------|-------------|
| 2023-01-23T12:15:00.000Z | 127.0.0.1  | some.email@foo.com | 42          |

For other type conversions, use [Type conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions):
```esql
ROW a = "2023-01-23T12:15:00.000Z 127.0.0.1 some.email@foo.com 42"
| GROK a """%{TIMESTAMP_ISO8601:date} %{IP:ip} %{EMAILADDRESS:email} %{NUMBER:num:int}"""
| KEEP date, ip, email, num
| EVAL date = TO_DATETIME(date)
```


| ip:keyword | email:keyword      | num:integer | date:date                |
|------------|--------------------|-------------|--------------------------|
| 127.0.0.1  | some.email@foo.com | 42          | 2023-01-23T12:15:00.000Z |

If a field name is used more than once, `GROK` creates a multi-valued column:
```esql
FROM addresses
| KEEP city.name, zip_code
| GROK zip_code """%{WORD:zip_parts} %{WORD:zip_parts}"""
```


| city.name:keyword | zip_code:keyword | zip_parts:keyword |
|-------------------|------------------|-------------------|
| Amsterdam         | 1016 ED          | ["1016", "ED"]    |
| San Francisco     | CA 94108         | ["CA", "94108"]   |
| Tokyo             | 100-7014         | null              |﻿---
title: ES|QL time spans
description: Time spans represent intervals between two datetime values. There are currently two supported types of time spans: DATE_PERIOD specifies intervals in...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-time-spans
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL time spans
Time spans represent intervals between two datetime values. There are currently two supported types of time spans:
- `DATE_PERIOD` specifies intervals in years, quarters, months, weeks and days
- `TIME_DURATION` specifies intervals in hours, minutes, seconds and milliseconds

A time span requires two elements: an integer value and a temporal unit.
Time spans work with grouping functions such as [BUCKET](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-bucket),
scalar functions such as [DATE_TRUNC](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-date_trunc)
and arithmetic operators such as [`+`](/docs/reference/query-languages/esql/functions-operators/operators#esql-add)
and [`-`](/docs/reference/query-languages/esql/functions-operators/operators#esql-sub).
Convert strings to time spans using [TO_DATEPERIOD](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_dateperiod),
[TO_TIMEDURATION](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_timeduration),
or the [cast operators](/docs/reference/query-languages/esql/functions-operators/operators#esql-cast-operator) `::DATE_PERIOD`, `::TIME_DURATION`.

## Examples of using time spans in ES|QL

With `BUCKET`:
```esql
FROM employees
| WHERE hire_date >= "1985-01-01T00:00:00Z" AND hire_date < "1986-01-01T00:00:00Z"
| STATS hires_per_week = COUNT(*) BY week = BUCKET(hire_date, 1 week)
| SORT week
```


| hires_per_week:long | week:date                |
|---------------------|--------------------------|
| 2                   | 1985-02-18T00:00:00.000Z |
| 1                   | 1985-05-13T00:00:00.000Z |
| 1                   | 1985-07-08T00:00:00.000Z |
| 1                   | 1985-09-16T00:00:00.000Z |
| 2                   | 1985-10-14T00:00:00.000Z |
| 4                   | 1985-11-18T00:00:00.000Z |

With `DATE_TRUNC`:
```esql
FROM employees
| KEEP first_name, last_name, hire_date
| EVAL year_hired = DATE_TRUNC(1 year, hire_date)
```


| first_name:keyword | last_name:keyword | hire_date:date           | year_hired:date          |
|--------------------|-------------------|--------------------------|--------------------------|
| Alejandro          | McAlpine          | 1991-06-26T00:00:00.000Z | 1991-01-01T00:00:00.000Z |
| Amabile            | Gomatam           | 1992-11-18T00:00:00.000Z | 1992-01-01T00:00:00.000Z |
| Anneke             | Preusig           | 1989-06-02T00:00:00.000Z | 1989-01-01T00:00:00.000Z |

With `+` and/or `-`:
```esql
FROM sample_data
| WHERE @timestamp > NOW() - 1 hour
```


| @timestamp:date | client_ip:ip | event_duration:long | message:keyword |
|-----------------|--------------|---------------------|-----------------|

When a time span is provided as a named parameter in string format, `TO_DATEPERIOD`, `::DATE_PERIOD`, `TO_TIMEDURATION` or `::TIME_DURATION` can be used to convert to its corresponding time span value for arithmetic operations like `+` and/or `-`.
```esql
POST /_query
{
   "query": """
   FROM employees
   | EVAL x = hire_date + ?timespan::DATE_PERIOD, y = hire_date - TO_DATEPERIOD(?timespan)
   """,
   "params": [{"timespan" : "1 day"}]
}
```

When a time span is provided as a named parameter in string format, it can be automatically converted to its corresponding time span value in grouping functions and scalar functions, like `BUCKET` and `DATE_TRUNC`.
```esql
POST /_query
{
   "query": """
   FROM employees
   | WHERE hire_date >= "1985-01-01T00:00:00Z" AND hire_date < "1986-01-01T00:00:00Z"
   | STATS hires_per_week = COUNT(*) BY week = BUCKET(hire_date, ?timespan)
   | SORT week
   """,
   "params": [{"timespan" : "1 week"}]
}
```

```esql
POST /_query
{
   "query": """
   FROM employees
   | KEEP first_name, last_name, hire_date
   | EVAL year_hired = DATE_TRUNC(?timespan, hire_date)
   """,
   "params": [{"timespan" : "1 year"}]
}
```


## Supported temporal units


| Temporal Units | Valid Abbreviations |
|----------------|---------------------|
| year           | y, yr, years        |
| quarter        | q, quarters         |
| month          | mo, months          |
| week           | w, weeks            |
| day            | d, days             |
| hour           | h, hours            |
| minute         | m, min, minutes     |
| second         | s, sec, seconds     |
| millisecond    | ms, milliseconds    |﻿---
title: ES|QL Search functions
description: Use these functions for full-text search and semantic search. Full text functions can be used to match multivalued fields. A multivalued field that contains...
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/search-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL Search functions
<tip>
  Get started with ES|QL for search use cases with
  our [hands-on tutorial](https://www.elastic.co/docs/reference/query-languages/esql/esql-search-tutorial).For a high-level overview of search functionalities in ES|QL, and to learn about relevance scoring, refer to [ES|QL for search](https://www.elastic.co/docs/solutions/search/esql-for-search#esql-for-search-scoring).For information regarding dense vector search functions,
  including [KNN](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-knn), please refer to
  the [Dense vector functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/dense-vector-functions) documentation.
</tip>

Use these functions for [full-text search](https://www.elastic.co/docs/solutions/search/full-text)
and [semantic search](https://www.elastic.co/docs/solutions/search/semantic-search/semantic-search-semantic-text).
Full text functions can be used to
match [multivalued fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields).
A multivalued field that contains a value that matches a full text query is
considered to match the query.
Full text functions are significantly more performant for text search use cases
on large data sets than using pattern matching or regular expressions with
`LIKE` or `RLIKE`.
See [full text search limitations](/docs/reference/query-languages/esql/limitations#esql-limitations-full-text-search)
for information on the limitations of full text search.
ES|QL supports these full-text search functions:
- [`DECAY`](#esql-decay) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`KQL`](#esql-kql)
- [`MATCH`](#esql-match)
- [`MATCH_PHRASE`](#esql-match_phrase)
- [`QSTR`](#esql-qstr)
- [`SCORE`](#esql-score) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>

- [`TOP_SNIPPETS`](#esql-top_snippets) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>


## `DECAY`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/decay.svg)

**Parameters**
<definitions>
  <definition term="value">
    The input value to apply decay scoring to.
  </definition>
  <definition term="origin">
    Central point from which the distances are calculated.
  </definition>
  <definition term="scale">
    Distance from the origin where the function returns the decay value.
  </definition>
  <definition term="options">
  </definition>
</definitions>

**Description**
Calculates a relevance score that decays based on the distance of a numeric, spatial or date type value from a target origin, using configurable decay functions.
`DECAY` calculates a score between 0 and 1 based on how far a field value is from a specified origin point (called distance).
The distance can be a numeric distance, spatial distance or temporal distance depending on the specific data type.
`DECAY` can use [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params) to specify additional `options`
for the decay function.
For spatial queries, scale and offset for geo points use distance units (e.g., "10km", "5mi"),
while cartesian points use numeric values. For date queries, scale and offset use time_duration values.
For numeric queries you also use numeric values.
**Supported types**

| value           | origin          | scale         | options          | result |
|-----------------|-----------------|---------------|------------------|--------|
| cartesian_point | cartesian_point | double        | named parameters | double |
| date            | date            | time_duration | named parameters | double |
| date_nanos      | date_nanos      | time_duration | named parameters | double |
| double          | double          | double        | named parameters | double |
| geo_point       | geo_point       | keyword       | named parameters | double |
| geo_point       | geo_point       | text          | named parameters | double |
| integer         | integer         | integer       | named parameters | double |
| long            | long            | long          | named parameters | double |

**Supported function named parameters**
<definitions>
  <definition term="offset">
    (double, integer, long, time_duration, keyword, text) Distance from the origin where no decay occurs.
  </definition>
  <definition term="type">
    (keyword) Decay function to use: linear, exponential or gaussian.
  </definition>
  <definition term="decay">
    (double) Multiplier value returned at the scale distance from the origin.
  </definition>
</definitions>

**Example**
```esql
FROM employees
| EVAL decay_result = decay(salary, 0, 100000, {"offset": 5, "decay": 0.5, "type": "linear"})
| SORT decay_result DESC
```


| decay_result:double |
|---------------------|
| 0.873405            |
| 0.8703              |
| 0.870145            |
| 0.867845            |
| 0.86395             |


## `KQL`

<applies-to>
  - Elastic Stack: Generally available since 9.1
  - Elastic Stack: Preview in 9.0
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/kql.svg)

**Parameters**
<definitions>
  <definition term="query">
    Query string in KQL query string format.
  </definition>
  <definition term="options">
    (Optional) KQL additional options as [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params). Available in stack version 9.3.0 and later.
  </definition>
</definitions>

**Description**
Performs a KQL query. Returns true if the provided KQL query string matches the row.
**Supported types**

| query   | options          | result  |
|---------|------------------|---------|
| keyword | named parameters | boolean |
| keyword |                  | boolean |
| text    | named parameters | boolean |
| text    |                  | boolean |

**Supported function named parameters**
<definitions>
  <definition term="boost">
    (float) Floating point number used to decrease or increase the relevance scores of the query. Defaults to 1.0.
  </definition>
  <definition term="time_zone">
    (keyword) UTC offset or IANA time zone used to interpret date literals in the query string.
  </definition>
  <definition term="case_insensitive">
    (boolean) If true, performs case-insensitive matching for keyword fields. Defaults to false.
  </definition>
  <definition term="default_field">
    (keyword) Default field to search if no field is provided in the query string. Supports wildcards (*).
  </definition>
</definitions>

**Examples**
Use KQL to filter by a specific field value
```esql
FROM books
| WHERE KQL("author: Faulkner")
```


| book_no:keyword | author:text                                        |
|-----------------|----------------------------------------------------|
| 2378            | [Carol Faulkner, Holly Byers Ochoa, Lucretia Mott] |
| 2713            | William Faulkner                                   |
| 2847            | Colleen Faulkner                                   |
| 2883            | William Faulkner                                   |
| 3293            | Danny Faulkner                                     |

<applies-to>
  - Elastic Stack: Planned
</applies-to>

Use KQL with additional options for case-insensitive matching and custom settings
```esql
FROM employees
| WHERE KQL("mary", {"case_insensitive": true, "default_field": "first_name", "boost": 1.5})
```


## `MATCH`

<applies-to>
  - Elastic Stack: Generally available since 9.1
  - Elastic Stack: Preview in 9.0
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/match.svg)

**Parameters**
<definitions>
  <definition term="field">
    Field that the query will target.
  </definition>
  <definition term="query">
    Value to find in the provided field.
  </definition>
  <definition term="options">
    (Optional) Match additional options as [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params).
  </definition>
</definitions>

**Description**
Use `MATCH` to perform a [match query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-match-query) on the specified field. Using `MATCH` is equivalent to using the `match` query in the Elasticsearch Query DSL.
Match can be used on fields from the text family like [text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/text) and [semantic_text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/semantic-text),
as well as other field types like keyword, boolean, dates, and numeric types.
When Match is used on a [semantic_text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/semantic-text) field, it will perform a semantic query on the field.
Match can use [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params) to specify additional options
for the match query.
All [match query parameters](/docs/reference/query-languages/query-dsl/query-dsl-match-query#match-field-params) are supported.
For a simplified syntax, you can use the [match operator](/docs/reference/query-languages/esql/functions-operators/operators#esql-match-operator) `:` operator instead of `MATCH`.
`MATCH` returns true if the provided query matches the row.
**Supported types**

| field         | query         | options          | result  |
|---------------|---------------|------------------|---------|
| boolean       | boolean       | named parameters | boolean |
| boolean       | keyword       | named parameters | boolean |
| date          | date          | named parameters | boolean |
| date          | keyword       | named parameters | boolean |
| date_nanos    | date_nanos    | named parameters | boolean |
| date_nanos    | keyword       | named parameters | boolean |
| double        | double        | named parameters | boolean |
| double        | integer       | named parameters | boolean |
| double        | keyword       | named parameters | boolean |
| double        | long          | named parameters | boolean |
| integer       | double        | named parameters | boolean |
| integer       | integer       | named parameters | boolean |
| integer       | keyword       | named parameters | boolean |
| integer       | long          | named parameters | boolean |
| ip            | ip            | named parameters | boolean |
| ip            | keyword       | named parameters | boolean |
| keyword       | keyword       | named parameters | boolean |
| long          | double        | named parameters | boolean |
| long          | integer       | named parameters | boolean |
| long          | keyword       | named parameters | boolean |
| long          | long          | named parameters | boolean |
| text          | keyword       | named parameters | boolean |
| unsigned_long | double        | named parameters | boolean |
| unsigned_long | integer       | named parameters | boolean |
| unsigned_long | keyword       | named parameters | boolean |
| unsigned_long | long          | named parameters | boolean |
| unsigned_long | unsigned_long | named parameters | boolean |
| version       | keyword       | named parameters | boolean |
| version       | version       | named parameters | boolean |

**Supported function named parameters**
<definitions>
  <definition term="fuzziness">
    (keyword) Maximum edit distance allowed for matching.
  </definition>
  <definition term="auto_generate_synonyms_phrase_query">
    (boolean) If true, match phrase queries are automatically created for multi-term synonyms. Defaults to true.
  </definition>
  <definition term="analyzer">
    (keyword) Analyzer used to convert the text in the query value into token. Defaults to the index-time analyzer mapped for the field. If no analyzer is mapped, the index’s default analyzer is used.
  </definition>
  <definition term="minimum_should_match">
    (integer) Minimum number of clauses that must match for a document to be returned.
  </definition>
  <definition term="zero_terms_query">
    (keyword) Indicates whether all documents or none are returned if the analyzer removes all tokens, such as when using a stop filter. Defaults to none.
  </definition>
  <definition term="boost">
    (float) Floating point number used to decrease or increase the relevance scores of the query. Defaults to 1.0.
  </definition>
  <definition term="fuzzy_transpositions">
    (boolean) If true, edits for fuzzy matching include transpositions of two adjacent characters (ab → ba). Defaults to true.
  </definition>
  <definition term="fuzzy_rewrite">
    (keyword) Method used to rewrite the query. See the rewrite parameter for valid values and more information. If the fuzziness parameter is not 0, the match query uses a fuzzy_rewrite method of top_terms_blended_freqs_${max_expansions} by default.
  </definition>
  <definition term="prefix_length">
    (integer) Number of beginning characters left unchanged for fuzzy matching. Defaults to 0.
  </definition>
  <definition term="lenient">
    (boolean) If false, format-based errors, such as providing a text query value for a numeric field, are returned. Defaults to false.
  </definition>
  <definition term="operator">
    (keyword) Boolean logic used to interpret text in the query value. Defaults to OR.
  </definition>
  <definition term="max_expansions">
    (integer) Maximum number of terms to which the query will expand. Defaults to 50.
  </definition>
</definitions>

**Examples**
```esql
FROM books
| WHERE MATCH(author, "Faulkner")
```


| book_no:keyword | author:text                                        |
|-----------------|----------------------------------------------------|
| 2378            | [Carol Faulkner, Holly Byers Ochoa, Lucretia Mott] |
| 2713            | William Faulkner                                   |
| 2847            | Colleen Faulkner                                   |
| 2883            | William Faulkner                                   |
| 3293            | Danny Faulkner                                     |

```esql
FROM books
| WHERE MATCH(title, "Hobbit Back Again", {"operator": "AND"})
| KEEP title;
```


| title:text                         |
|------------------------------------|
| The Hobbit or There and Back Again |


## `MATCH_PHRASE`

<applies-to>
  - Elastic Stack: Generally available since 9.1
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/match_phrase.svg)

**Parameters**
<definitions>
  <definition term="field">
    Field that the query will target.
  </definition>
  <definition term="query">
    Value to find in the provided field.
  </definition>
  <definition term="options">
    (Optional) MatchPhrase additional options as [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params). See [`match_phrase`](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-match-query-phrase) for more information.
  </definition>
</definitions>

**Description**
Use `MATCH_PHRASE` to perform a [`match_phrase`](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-match-query-phrase) on the specified field. Using `MATCH_PHRASE` is equivalent to using the `match_phrase` query in the Elasticsearch Query DSL.
MatchPhrase can be used on [text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/text) fields, as well as other field types like keyword, boolean, or date types.
MatchPhrase is not supported for [semantic_text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/semantic-text) or numeric types.
MatchPhrase can use [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params) to specify additional options for the
match_phrase query.
All [`match_phrase`](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-match-query-phrase) query parameters are supported.
`MATCH_PHRASE` returns true if the provided query matches the row.
**Supported types**

| field   | query   | options          | result  |
|---------|---------|------------------|---------|
| keyword | keyword | named parameters | boolean |
| text    | keyword | named parameters | boolean |

**Supported function named parameters**
<definitions>
  <definition term="zero_terms_query">
    (keyword) Indicates whether all documents or none are returned if the analyzer removes all tokens, such as when using a stop filter. Defaults to none.
  </definition>
  <definition term="boost">
    (float) Floating point number used to decrease or increase the relevance scores of the query. Defaults to 1.0.
  </definition>
  <definition term="analyzer">
    (keyword) Analyzer used to convert the text in the query value into token. Defaults to the index-time analyzer mapped for the field. If no analyzer is mapped, the index’s default analyzer is used.
  </definition>
  <definition term="slop">
    (integer) Maximum number of positions allowed between matching tokens. Defaults to 0. Transposed terms have a slop of 2.
  </definition>
</definitions>

**Example**
<applies-to>
  - Elastic Stack: Generally available since 9.1
</applies-to>

```esql
FROM books
| WHERE MATCH_PHRASE(author, "William Faulkner")
```


| book_no:keyword | author:text      |
|-----------------|------------------|
| 2713            | William Faulkner |
| 2883            | William Faulkner |
| 4724            | William Faulkner |
| 4977            | William Faulkner |
| 5119            | William Faulkner |


## `QSTR`

<applies-to>
  - Elastic Stack: Generally available since 9.1
  - Elastic Stack: Preview in 9.0
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/qstr.svg)

**Parameters**
<definitions>
  <definition term="query">
    Query string in Lucene query string format.
  </definition>
  <definition term="options">
    (Optional) Additional options for Query String as [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params). See [query string query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-query-string-query) for more information.
  </definition>
</definitions>

**Description**
Performs a [query string query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-query-string-query). Returns true if the provided query string matches the row.
**Supported types**

| query   | options          | result  |
|---------|------------------|---------|
| keyword | named parameters | boolean |
| text    | named parameters | boolean |

**Supported function named parameters**
<definitions>
  <definition term="max_determinized_states">
    (integer) Maximum number of automaton states required for the query. Default is 10000.
  </definition>
  <definition term="fuzziness">
    (keyword) Maximum edit distance allowed for matching.
  </definition>
  <definition term="auto_generate_synonyms_phrase_query">
    (boolean) If true, match phrase queries are automatically created for multi-term synonyms. Defaults to true.
  </definition>
  <definition term="phrase_slop">
    (integer) Maximum number of positions allowed between matching tokens for phrases. Defaults to 0 (which means exact matches are required).
  </definition>
  <definition term="default_field">
    (keyword) Default field to search if no field is provided in the query string. Supports wildcards (*).
  </definition>
  <definition term="allow_leading_wildcard">
    (boolean) If true, the wildcard characters * and ? are allowed as the first character of the query string. Defaults to true.
  </definition>
  <definition term="minimum_should_match">
    (string) Minimum number of clauses that must match for a document to be returned.
  </definition>
  <definition term="fuzzy_transpositions">
    (boolean) If true, edits for fuzzy matching include transpositions of two adjacent characters (ab → ba). Defaults to true.
  </definition>
  <definition term="fuzzy_prefix_length">
    (integer) Number of beginning characters left unchanged for fuzzy matching. Defaults to 0.
  </definition>
  <definition term="time_zone">
    (keyword) Coordinated Universal Time (UTC) offset or IANA time zone used to convert date values in the query string to UTC.
  </definition>
  <definition term="lenient">
    (boolean) If false, format-based errors, such as providing a text query value for a numeric field, are returned. Defaults to false.
  </definition>
  <definition term="rewrite">
    (keyword) Method used to rewrite the query.
  </definition>
  <definition term="default_operator">
    (keyword) Default boolean logic used to interpret text in the query string if no operators are specified.
  </definition>
  <definition term="analyzer">
    (keyword) Analyzer used to convert the text in the query value into token. Defaults to the index-time analyzer mapped for the default_field.
  </definition>
  <definition term="fuzzy_max_expansions">
    (integer) Maximum number of terms to which the query expands for fuzzy matching. Defaults to 50.
  </definition>
  <definition term="quote_analyzer">
    (keyword) Analyzer used to convert quoted text in the query string into tokens. Defaults to the search_quote_analyzer mapped for the default_field.
  </definition>
  <definition term="allow_wildcard">
    (boolean) If true, the query attempts to analyze wildcard terms in the query string. Defaults to false.
  </definition>
  <definition term="boost">
    (float) Floating point number used to decrease or increase the relevance scores of the query.
  </definition>
  <definition term="quote_field_suffix">
    (keyword) Suffix appended to quoted text in the query string.
  </definition>
  <definition term="enable_position_increments">
    (boolean) If true, enable position increments in queries constructed from a query_string search. Defaults to true.
  </definition>
  <definition term="fields">
    (keyword) Array of fields to search. Supports wildcards (*).
  </definition>
</definitions>

**Examples**
```esql
FROM books
| WHERE QSTR("author: Faulkner")
```


| book_no:keyword | author:text                                        |
|-----------------|----------------------------------------------------|
| 2378            | [Carol Faulkner, Holly Byers Ochoa, Lucretia Mott] |
| 2713            | William Faulkner                                   |
| 2847            | Colleen Faulkner                                   |
| 2883            | William Faulkner                                   |
| 3293            | Danny Faulkner                                     |

<applies-to>
  - Elastic Stack: Generally available since 9.1
</applies-to>

```esql
FROM books
| WHERE QSTR("title: Hobbjt~", {"fuzziness": 2})
```


| book_no:keyword | title:text                         |
|-----------------|------------------------------------|
| 4289            | Poems from the Hobbit              |
| 6405            | The Hobbit or There and Back Again |
| 7480            | The Hobbit                         |


## `SCORE`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/score.svg)

**Parameters**
<definitions>
  <definition term="query">
    Boolean expression that contains full text function(s) to be scored.
  </definition>
</definitions>

**Description**
Scores an expression. Only full text functions will be scored. Returns scores for all the resulting docs.
**Supported types**

| query   | result |
|---------|--------|
| boolean | double |

**Example**
```esql
FROM books METADATA _score
| WHERE match(title, "Return") AND match(author, "Tolkien")
| EVAL first_score = score(match(title, "Return"))
```


## `TOP_SNIPPETS`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/top_snippets.svg)

**Parameters**
<definitions>
  <definition term="field">
    The input to chunk.
  </definition>
  <definition term="query">
    The input text containing only query terms for snippet extraction. Lucene query syntax, operators, and wildcards are not allowed.
  </definition>
  <definition term="options">
    (Optional) `TOP_SNIPPETS` additional options as [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params).
  </definition>
</definitions>

**Description**
Use `TOP_SNIPPETS` to extract the best snippets for a given query string from a text field.
`TOP_SNIPPETS` can be used on fields from the text famiy like [text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/text) and [semantic_text](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/semantic-text).
`TOP_SNIPPETS` will extract the best snippets for a given query string.
**Supported types**

| field   | query   | options          | result  |
|---------|---------|------------------|---------|
| keyword | keyword | named parameters | keyword |
| keyword | keyword |                  | keyword |
| text    | keyword | named parameters | keyword |
| text    | keyword |                  | keyword |

**Supported function named parameters**
<definitions>
  <definition term="num_words">
    (integer) The maximum number of words to return in each snippet.
    This allows better control of inference costs by limiting the size of tokens per snippet.
  </definition>
  <definition term="num_snippets">
    (integer) The maximum number of matching snippets to return.
  </definition>
</definitions>

**Examples**
<applies-to>
  - Elastic Stack: Planned
</applies-to>

```esql
FROM books
| EVAL snippets = TOP_SNIPPETS(description, "Tolkien")
```


| book_no:keyword | title:text                                            | snippets:keyword                                                                                                                                                                                                                                                         |
|-----------------|-------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1211            | The brothers Karamazov                                | null                                                                                                                                                                                                                                                                     |
| 1463            | Realms of Tolkien: Images of Middle-earth             | Twenty new and familiar Tolkien artists are represented in this fabulous volume, breathing an extraordinary variety of life into 58 different scenes, each of which is accompanied by appropriate passage from The Hobbit and The Lord of the Rings and The Silmarillion |
| 1502            | Selected Passages from Correspondence with Friends    | null                                                                                                                                                                                                                                                                     |
| 1937            | The Best Short Stories of Dostoevsky (Modern Library) | null                                                                                                                                                                                                                                                                     |
| 1985            | Brothers Karamazov                                    | null                                                                                                                                                                                                                                                                     |

<applies-to>
  - Elastic Stack: Planned
</applies-to>

```esql
FROM books
| WHERE MATCH(title, "Return")
| EVAL snippets = TOP_SNIPPETS(description, "Tolkien", { "num_snippets": 3, "num_words": 25 })
```


| book_no:keyword | title:text                                                       | snippets:keyword                                                                                                                                                                                                                                                                                                                                                                                                                                |
|-----------------|------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 2714            | Return of the King Being the Third Part of The Lord of the Rings | [Concluding the story begun in The Hobbit, this is the final part of Tolkien s epic masterpiece, The Lord of the Rings, featuring an exclusive, Tolkien s epic masterpiece, The Lord of the Rings, featuring an exclusive cover image from the film, the definitive text, and a detailed map of, Tolkien s classic tale of magic and adventure, begun in The Fellowship of the Ring and The Two Towers, features the definitive edition of the] |
| 7350            | Return of the Shadow                                             | [Tolkien for long believed would be a far shorter book, 'a sequel to The Hobbit'., In The Return of the Shadow (an abandoned title for the first volume) Christopher Tolkien describes, with full citation of the earliest notes, outline plans, ) Christopher Tolkien describes, with full citation of the earliest notes, outline plans, and narrative drafts, the intricate evolution of The Fellowship of the Ring and]                     |﻿---
title: ES|QL ROW command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/row
---

# ES|QL ROW command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `ROW` source command produces a row with one or more columns with values
that you specify. This can be useful for testing.
**Syntax**
```esql
ROW column1 = value1[, ..., columnN = valueN]
```

**Parameters**
<definitions>
  <definition term="columnX">
    The column name.
    In case of duplicate column names, only the rightmost duplicate creates a column.
  </definition>
  <definition term="valueX">
    The value for the column. Can be a literal, an expression, or a
    [function](/docs/reference/query-languages/esql/esql-functions-operators#esql-functions).
  </definition>
</definitions>

**Examples**
```esql
ROW a = 1, b = "two", c = null
```


| a:integer | b:keyword | c:null |
|-----------|-----------|--------|
| 1         | "two"     | null   |

Use square brackets to create multi-value columns:
```esql
ROW a = [2, 1]
```

`ROW` supports the use of [functions](/docs/reference/query-languages/esql/esql-functions-operators#esql-functions):
```esql
ROW a = ROUND(1.23, 0)
```﻿---
title: Basic ES|QL syntax
description: An ES|QL query is composed of a source command followed by an optional series of processing commands, separated by a pipe character: |. For example: The...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-syntax
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Basic ES|QL syntax
## Query structure

An ES|QL query is composed of a [source command](https://www.elastic.co/docs/reference/query-languages/esql/esql-commands) followed by an optional series of [processing commands](https://www.elastic.co/docs/reference/query-languages/esql/esql-commands), separated by a pipe character: `|`. For example:
```esql
source-command
| processing-command1
| processing-command2
```

The result of a query is the table produced by the final processing command.
For an overview of all supported commands, functions, and operators, refer to [Commands](https://www.elastic.co/docs/reference/query-languages/esql/esql-commands) and [Functions and operators](https://www.elastic.co/docs/reference/query-languages/esql/esql-functions-operators).
<note>
  For readability, this documentation puts each processing command on a new line. However, you can write an ES|QL query as a single line. The following query is identical to the previous one:
  ```esql
  source-command | processing-command1 | processing-command2
  ```
</note>


### Identifiers

Identifiers need to be quoted with backticks (```) if:
- they don’t start with a letter, `_` or `@`
- any of the other characters is not a letter, number, or `_`

For example:
```esql
FROM index
| KEEP `1.field`
```

When referencing a function alias that itself uses a quoted identifier, the backticks of the quoted identifier need to be escaped with another backtick. For example:
```esql
FROM index
| STATS COUNT(`1.field`)
| EVAL my_count = `COUNT(``1.field``)`
```


### Literals

ES|QL currently supports numeric and string literals.

#### String literals

A string literal is a sequence of unicode characters delimited by double quotes (`"`).
```esql
// Filter by a string value
FROM index
| WHERE first_name == "Georgi"
```

If the literal string itself contains quotes, these need to be escaped (`\"`). ES|QL also supports the triple-quotes (`"""`) delimiter, for convenience:
```esql
ROW name = """Indiana "Indy" Jones"""
```

The special characters CR, LF and TAB can be provided with the usual escaping: `\r`, `\n`, `\t`, respectively.

#### Numerical literals

The numeric literals are accepted in decimal and in the scientific notation with the exponent marker (`e` or `E`), starting either with a digit, decimal point `.` or the negative sign `-`:
```sql
1969    -- integer notation
3.14    -- decimal notation
.1234   -- decimal notation starting with decimal point
4E5     -- scientific notation (with exponent marker)
1.2e-3  -- scientific notation with decimal point
-.1e2   -- scientific notation starting with the negative sign
```

The integer numeric literals are implicitly converted to the `integer`, `long` or the `double` type, whichever can first accommodate the literal’s value.
The floating point literals are implicitly converted the `double` type.
To obtain constant values of different types, use one of the numeric [conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions).

### Comments

ES|QL uses C++ style comments:
- double slash `//` for single line comments
- `/*` and `*/` for block comments

```esql
// Query the employees index
FROM employees
| WHERE height > 2
```

```esql
FROM /* Query the employees index */ employees
| WHERE height > 2
```

```esql
FROM employees
/* Query the
 * employees
 * index */
| WHERE height > 2
```


### Timespan literals

Datetime intervals and timespans can be expressed using timespan literals. Timespan literals are a combination of a number and a temporal unit. The supported temporal units are listed in [time span unit](/docs/reference/query-languages/esql/esql-time-spans#esql-time-spans-table). More examples of the usages of time spans can be found in [Use time spans in ES|QL](https://www.elastic.co/docs/reference/query-languages/esql/esql-time-spans).
Timespan literals are not whitespace sensitive. These expressions are all valid:
- `1day`
- `1 day`
- `1       day`


### Function named parameters

Some functions like [match](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match) use named parameters to provide additional options.
Named parameters allow specifying name value pairs, using the following syntax:
`{"option_name": option_value, "another_option_name": another_value}`
Valid value types are strings, numbers and booleans.
An example using [match](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match):
```json

{
"query": """
FROM library
| WHERE match(author, "Frank Herbert", {"minimum_should_match": 2, "operator": "AND"})
| LIMIT 5
"""
}
```

You can also use [query parameters](/docs/reference/query-languages/esql/esql-rest#esql-rest-params) in function named parameters:
```json

{
"query": """
FROM library
| EVAL year = DATE_EXTRACT("year", release_date)
| WHERE page_count > ? AND match(author, ?, {"minimum_should_match": ?})
| LIMIT 5
""",
"params": [300, "Frank Herbert", 2]
}
```﻿---
title: ES|QL multivalued fields
description: ES|QL can read from multivalued fields: Multivalued fields come back as a JSON array: The relative order of values in a multivalued field is undefined...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL multivalued fields
ES|QL can read from multivalued fields:

```json

{ "index" : {} }
{ "a": 1, "b": [2, 1] }
{ "index" : {} }
{ "a": 2, "b": 3 }


{
  "query": "FROM mv | LIMIT 2"
}
```

Multivalued fields come back as a JSON array:
```json
{
  "took": 28,
  "is_partial": false,
  "columns": [
    { "name": "a", "type": "long"},
    { "name": "b", "type": "long"}
  ],
  "values": [
    [1, [1, 2]],
    [2,      3]
  ]
}
```

The relative order of values in a multivalued field is undefined. They’ll frequently be in ascending order but don’t rely on that.

## Duplicate values

Some field types, like [`keyword`](/docs/reference/elasticsearch/mapping-reference/keyword#keyword-field-type) remove duplicate values on write:

```json

{
  "mappings": {
    "properties": {
      "b": {"type": "keyword"}
    }
  }
}


{ "index" : {} }
{ "a": 1, "b": ["foo", "foo", "bar"] }
{ "index" : {} }
{ "a": 2, "b": ["bar", "bar"] }


{
  "query": "FROM mv | LIMIT 2"
}
```

And ES|QL sees that removal:
```json
{
  "took": 28,
  "is_partial": false,
  "columns": [
    { "name": "a", "type": "long"},
    { "name": "b", "type": "keyword"}
  ],
  "values": [
    [1, ["bar", "foo"]],
    [2,          "bar"]
  ]
}
```

But other types, like `long` don’t remove duplicates.

```json

{
  "mappings": {
    "properties": {
      "b": {"type": "long"}
    }
  }
}


{ "index" : {} }
{ "a": 1, "b": [2, 2, 1] }
{ "index" : {} }
{ "a": 2, "b": [1, 1] }


{
  "query": "FROM mv | LIMIT 2"
}
```

And ES|QL also sees that:
```json
{
  "took": 28,
  "is_partial": false,
  "columns": [
    { "name": "a", "type": "long"},
    { "name": "b", "type": "long"}
  ],
  "values": [
    [1, [1, 2, 2]],
    [2,    [1, 1]]
  ]
}
```

This is all at the storage layer. If you store duplicate `long`s and then convert them to strings the duplicates will stay:

```json

{
  "mappings": {
    "properties": {
      "b": {"type": "long"}
    }
  }
}


{ "index" : {} }
{ "a": 1, "b": [2, 2, 1] }
{ "index" : {} }
{ "a": 2, "b": [1, 1] }


{
  "query": "FROM mv | EVAL b=TO_STRING(b) | LIMIT 2"
}
```

```json
{
  "took": 28,
  "is_partial": false,
  "columns": [
    { "name": "a", "type": "long"},
    { "name": "b", "type": "keyword"}
  ],
  "values": [
    [1, ["1", "2", "2"]],
    [2,      ["1", "1"]]
  ]
}
```


## `null` in a list

`null` values in a list are not preserved at the storage layer:

```json

{ "a": [2, null, 1] }


{
  "query": "FROM mv | LIMIT 1"
}
```

```json
{
  "took": 28,
  "is_partial": false,
  "columns": [
    { "name": "a", "type": "long"}
  ],
  "values": [
    [[1, 2]]
  ]
}
```


## Functions

Unless otherwise documented functions will return `null` when applied to a multivalued field.

```json

{ "index" : {} }
{ "a": 1, "b": [2, 1] }
{ "index" : {} }
{ "a": 2, "b": 3 }
```

```json

{
  "query": "FROM mv | EVAL b + 2, a + b | LIMIT 4"
}
```

```json
{
  "took": 28,
  "is_partial": false,
  "columns": [
    { "name": "a",   "type": "long"},
    { "name": "b",   "type": "long"},
    { "name": "b + 2", "type": "long"},
    { "name": "a + b", "type": "long"}
  ],
  "values": [
    [1, [1, 2], null, null],
    [2,      3,    5,    5]
  ]
}
```

Work around this limitation by converting the field to single value with one of:
- [`MV_AVG`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_avg)
- [`MV_CONCAT`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_concat)
- [`MV_COUNT`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_count)
- [`MV_MAX`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_max)
- [`MV_MEDIAN`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_median)
- [`MV_MIN`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_min)
- [`MV_SUM`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_sum)

```json

{
  "query": "FROM mv | EVAL b=MV_MIN(b) | EVAL b + 2, a + b | LIMIT 4"
}
```

```json
{
  "took": 28,
  "is_partial": false,
  "columns": [
    { "name": "a",   "type": "long"},
    { "name": "b",   "type": "long"},
    { "name": "b + 2", "type": "long"},
    { "name": "a + b", "type": "long"}
  ],
  "values": [
    [1, 1, 3, 2],
    [2, 3, 5, 5]
  ]
}
```﻿---
title: ES|QL DISSECT command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/dissect
---

# ES|QL DISSECT command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

`DISSECT` enables you to [extract structured data out of a string](https://www.elastic.co/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok).
**Syntax**
```esql
DISSECT input "pattern" [APPEND_SEPARATOR="<separator>"]
```

**Parameters**
<definitions>
  <definition term="input">
    The column that contains the string you want to structure.  If the column has
    multiple values, `DISSECT` will process each value.
  </definition>
  <definition term="pattern">
    A [dissect pattern](/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok#esql-dissect-patterns).
    If a field name conflicts with an existing column, the existing column is dropped.
    If a field name is used more than once, only the rightmost duplicate creates a column.
  </definition>
  <definition term="<separator>">
    A string used as the separator between appended values, when using the [append modifier](/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok#esql-append-modifier).
  </definition>
</definitions>

**Description**
`DISSECT` enables you to [extract structured data out of a string](https://www.elastic.co/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok).
`DISSECT` matches the string against a delimiter-based pattern, and extracts the specified keys as columns.
Refer to [Process data with `DISSECT`](/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok#esql-process-data-with-dissect) for the syntax of dissect patterns.
**Examples**
The following example parses a string that contains a timestamp, some text, and
an IP address:
```esql
ROW a = "2023-01-23T12:15:00.000Z - some text - 127.0.0.1"
| DISSECT a """%{date} - %{msg} - %{ip}"""
| KEEP date, msg, ip
```


| date:keyword             | msg:keyword | ip:keyword |
|--------------------------|-------------|------------|
| 2023-01-23T12:15:00.000Z | some text   | 127.0.0.1  |

By default, `DISSECT` outputs keyword string columns. To convert to another
type, use [Type conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions):
```esql
ROW a = "2023-01-23T12:15:00.000Z - some text - 127.0.0.1"
| DISSECT a """%{date} - %{msg} - %{ip}"""
| KEEP date, msg, ip
| EVAL date = TO_DATETIME(date)
```


| msg:keyword | ip:keyword | date:date                |
|-------------|------------|--------------------------|
| some text   | 127.0.0.1  | 2023-01-23T12:15:00.000Z |﻿---
title: ES|QL ENRICH command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich
---

# ES|QL ENRICH command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

`ENRICH` enables you to add data from existing indices as new columns using an
enrich policy.
**Syntax**
```esql
ENRICH policy [ON match_field] [WITH [new_name1 = ]field1, [new_name2 = ]field2, ...]
```

**Parameters**
<definitions>
  <definition term="policy">
    The name of the enrich policy.
    You need to [create](/docs/reference/query-languages/esql/esql-enrich-data#esql-set-up-enrich-policy)
    and [execute](/docs/reference/query-languages/esql/esql-enrich-data#esql-execute-enrich-policy)
    the enrich policy first.
  </definition>
  <definition term="mode">
    The mode of the enrich command in cross cluster ES|QL.
    See [enrich across clusters](/docs/reference/query-languages/esql/esql-cross-clusters#ccq-enrich).
  </definition>
  <definition term="match_field">
    The match field. `ENRICH` uses its value to look for records in the enrich
    index. If not specified, the match will be performed on the column with the same
    name as the `match_field` defined in the [enrich policy](/docs/reference/query-languages/esql/esql-enrich-data#esql-enrich-policy).
  </definition>
  <definition term="fieldX">
    The enrich fields from the enrich index that are added to the result as new
    columns. If a column with the same name as the enrich field already exists, the
    existing column will be replaced by the new column. If not specified, each of
    the enrich fields defined in the policy is added.
    A column with the same name as the enrich field will be dropped unless the
    enrich field is renamed.
  </definition>
  <definition term="new_nameX">
    Enables you to change the name of the column that’s added for each of the enrich
    fields. Defaults to the enrich field name.
    If a column has the same name as the new name, it will be discarded.
    If a name (new or original) occurs more than once, only the rightmost duplicate
    creates a new column.
  </definition>
</definitions>

**Description**
`ENRICH` enables you to add data from existing indices as new columns using an
enrich policy. Refer to [Data enrichment](https://www.elastic.co/docs/reference/query-languages/esql/esql-enrich-data)
for information about setting up a policy.
![esql enrich](https://www.elastic.co/docs/reference/query-languages/images/esql-enrich.png)

<tip>
  Before you can use `ENRICH`, you need to [create and execute an enrich policy](/docs/reference/query-languages/esql/esql-enrich-data#esql-set-up-enrich-policy).
</tip>

**Examples**
The following example uses the `languages_policy` enrich policy to add a new
column for each enrich field defined in the policy. The match is performed using
the `match_field` defined in the [enrich policy](/docs/reference/query-languages/esql/esql-enrich-data#esql-enrich-policy) and
requires that the input table has a column with the same name (`language_code`
in this example). `ENRICH` will look for records in th
[enrich index](/docs/reference/query-languages/esql/esql-enrich-data#esql-enrich-index)
based on the match field value.
```esql
ROW language_code = "1"
| ENRICH languages_policy
```


| language_code:keyword | language_name:keyword |
|-----------------------|-----------------------|
| 1                     | English               |

To use a column with a different name than the `match_field` defined in the
policy as the match field, use `ON <column-name>`:
```esql
ROW a = "1"
| ENRICH languages_policy ON a
```


| a:keyword | language_name:keyword |
|-----------|-----------------------|
| 1         | English               |

By default, each of the enrich fields defined in the policy is added as a
column. To explicitly select the enrich fields that are added, use
`WITH <field1>, <field2>, ...`:
```esql
ROW a = "1"
| ENRICH languages_policy ON a WITH language_name
```


| a:keyword | language_name:keyword |
|-----------|-----------------------|
| 1         | English               |

You can rename the columns that are added using `WITH new_name=<field1>`:
```esql
ROW a = "1"
| ENRICH languages_policy ON a WITH name = language_name
```


| a:keyword | name:keyword |
|-----------|--------------|
| 1         | English      |

In case of name collisions, the newly created columns will override existing
columns.﻿---
title: ES|QL LOOKUP JOIN command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join
---

# ES|QL LOOKUP JOIN command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available since 9.1
  - Elastic Stack: Preview in 9.0
</applies-to>

`LOOKUP JOIN` enables you to add data from another index, AKA a 'lookup'
index, to your ES|QL query results, simplifying data enrichment
and analysis workflows.
Refer to [the high-level landing page](https://www.elastic.co/docs/reference/query-languages/esql/esql-lookup-join) for an overview of the `LOOKUP JOIN` command, including use cases, prerequisites, and current limitations.
**Syntax**
```esql
FROM <source_index>
| LOOKUP JOIN <lookup_index> ON <join_condition>
```

**Parameters**
<definitions>
  <definition term="<lookup_index>">
    The name of the lookup index. This must be a specific index name - wildcards, aliases, and remote cluster references are not supported. Indices used for lookups must be configured with the [`lookup` index mode](/docs/reference/elasticsearch/index-settings/index-modules#index-mode-setting).
  </definition>
  <definition term="<join_condition>">
    Can be one of the following:
    - A single field name
    - A comma-separated list of field names, for example `<field1>, <field2>, <field3>`  <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
    - An expression with one or more predicates linked by `AND`, for example `<left_field1> >= <lookup_field1> AND <left_field2> == <lookup_field2>`. Each predicate compares a field from the left index with a field from the lookup index using [binary operators](/docs/reference/query-languages/esql/functions-operators/operators#esql-binary-operators) (`==`, `>=`, `<=`, `>`, `<`, `!=`). Each field name in the join condition must exist in only one of the indexes. Use RENAME to resolve naming conflicts. <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
    - An expression that includes [full text functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/search-functions) and other Lucene-pushable functions, for example `MATCH(<lookup_field>, "search term") AND <left_field> == <lookup_field>`. These functions can be combined with binary operators and logical operators (`AND`, `OR`, `NOT`) to create complex join conditions. At least one condition that relates the lookup index fields to the left side of the join fields is still required. <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  </definition>
  <definition term="If using join on a single field or a field list, the fields used must exist in both your current query results and in the lookup index. If the fields contains multi-valued entries, those entries will not match anything (the added fields will contain null for those rows).">
  </definition>
</definitions>

**Description**
The `LOOKUP JOIN` command adds new columns to your ES|QL query
results table by finding documents in a lookup index that share the same
join field value as your result rows.
For each row in your results table that matches a document in the lookup
index based on the join fields, all fields from the matching document are
added as new columns to that row.
If multiple documents in the lookup index match a single row in your
results, the output will contain one row for each matching combination.
<tip>
  For important information about using `LOOKUP JOIN`, refer to [Usage notes](/docs/reference/query-languages/esql/esql-lookup-join#usage-notes).
</tip>

**Supported types**

| field from the left index | field from the lookup index                                         |
|---------------------------|---------------------------------------------------------------------|
| boolean                   | boolean                                                             |
| byte                      | byte, short, integer, long, half_float, float, double, scaled_float |
| date                      | date                                                                |
| date_nanos                | date_nanos                                                          |
| double                    | half_float, float, double, scaled_float, byte, short, integer, long |
| float                     | half_float, float, double, scaled_float, byte, short, integer, long |
| half_float                | half_float, float, double, scaled_float, byte, short, integer, long |
| integer                   | byte, short, integer, long, half_float, float, double, scaled_float |
| ip                        | ip                                                                  |
| keyword                   | keyword                                                             |
| long                      | byte, short, integer, long, half_float, float, double, scaled_float |
| scaled_float              | half_float, float, double, scaled_float, byte, short, integer, long |
| short                     | byte, short, integer, long, half_float, float, double, scaled_float |
| text                      | keyword                                                             |

**Examples**
**IP Threat correlation**: This query would allow you to see if any source
IPs match known malicious addresses.
```esql
FROM firewall_logs
| LOOKUP JOIN threat_list ON source.IP
```

To filter only for those rows that have a matching `threat_list` entry, use `WHERE ... IS NOT NULL` with a field from the lookup index:
```esql
FROM firewall_logs
| LOOKUP JOIN threat_list ON source.IP
| WHERE threat_level IS NOT NULL
```

**Host metadata correlation**: This query pulls in environment or
ownership details for each host to correlate with your metrics data.
```esql
FROM system_metrics
| LOOKUP JOIN host_inventory ON host.name
| LOOKUP JOIN ownerships ON host.name
```

**Service ownership mapping**: This query would show logs with the owning
team or escalation information for faster triage and incident response.
```esql
FROM app_logs
| LOOKUP JOIN service_owners ON service_id
```

`LOOKUP JOIN` is generally faster when there are fewer rows to join
with. ES|QL will try and perform any `WHERE` clause before the
`LOOKUP JOIN` where possible.
The following two examples will have the same results. One has the
`WHERE` clause before and the other after the `LOOKUP JOIN`. It does not
matter how you write your query, our optimizer will move the filter
before the lookup when possible.
```esql
FROM employees
| EVAL language_code = languages
| WHERE emp_no >= 10091 AND emp_no < 10094
| LOOKUP JOIN languages_lookup ON language_code
```


| emp_no:integer | language_code:integer | language_name:keyword |
|----------------|-----------------------|-----------------------|
| 10091          | 3                     | Spanish               |
| 10092          | 1                     | English               |
| 10093          | 3                     | Spanish               |

```esql
FROM employees
| EVAL language_code = languages
| LOOKUP JOIN languages_lookup ON language_code
| WHERE emp_no >= 10091 AND emp_no < 10094
```


| emp_no:integer | language_code:integer | language_name:keyword |
|----------------|-----------------------|-----------------------|
| 10091          | 3                     | Spanish               |
| 10092          | 1                     | English               |
| 10093          | 3                     | Spanish               |﻿---
title: Find long-running ES|QL queries
description: You can list running ES|QL queries with the task management APIs: Which returns a list of statuses like this: You can use this to find long running queries...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-task-management
products:
  - Elasticsearch
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Find long-running ES|QL queries
You can list running ES|QL queries with the [task management APIs](https://www.elastic.co/docs/api/doc/elasticsearch/group/endpoint-tasks):

```json
```

Which returns a list of statuses like this:
```js
{
  "node" : "2j8UKw1bRO283PMwDugNNg",
  "id" : 5326,
  "type" : "transport",
  "action" : "indices:data/read/esql",
  "description" : "FROM test | STATS MAX(d) by a, b",  
  "start_time" : "2023-07-31T15:46:32.328Z",
  "start_time_in_millis" : 1690818392328,
  "running_time" : "41.7ms",                           
  "running_time_in_nanos" : 41770830,
  "cancellable" : true,
  "cancelled" : false,
  "headers" : { }
}
```

You can use this to find long running queries and, if you need to, cancel them with the [task cancellation API](https://www.elastic.co/docs/api/doc/elasticsearch/group/endpoint-tasks#task-cancellation):

```json
```

It may take a few seconds for the query to be stopped.﻿---
title: ES|QL commands
description: ES|QL commands come in two flavors: source commands and processing commands: An ES|QL query must start with a source command.Use processing commands to...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-commands
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL commands
ES|QL commands come in two flavors: source commands and processing commands:
- An ES|QL query must start with a [source command](https://www.elastic.co/docs/reference/query-languages/esql/commands/source-commands).
- Use [processing commands](https://www.elastic.co/docs/reference/query-languages/esql/commands/processing-commands) to modify an input table by adding, removing, or transforming rows and columns.﻿---
title: ES|QL SAMPLE command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/sample
---

# ES|QL SAMPLE command
<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.1
</applies-to>

The `SAMPLE` command samples a fraction of the table rows.
**Syntax**
```esql
SAMPLE probability
```

**Parameters**
<definitions>
  <definition term="probability">
    The probability that a row is included in the sample. The value must be between 0 and 1, exclusive.
  </definition>
</definitions>

**Examples**
```esql
FROM employees
| KEEP emp_no
| SAMPLE 0.05
```


| emp_no:integer |
|----------------|
| 10018          |
| 10024          |
| 10062          |
| 10081          |﻿---
title: ES|QL limitations
description: By default, an ES|QL query returns up to 1,000 rows. You can increase the number of rows up to 10,000 using the LIMIT command. ES|QL currently supports...
url: https://www.elastic.co/docs/reference/query-languages/esql/limitations
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL limitations
## Result set size limit

By default, an ES|QL query returns up to 1,000 rows. You can increase the number of rows up to 10,000 using the [`LIMIT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/limit) command.
For instance,
```esql
FROM index | WHERE field = "value"
```

is equivalent to:
```esql
FROM index | WHERE field = "value" | LIMIT 1000
```

Queries do not return more than 10,000 rows, regardless of the `LIMIT` command’s value. This is a configurable upper limit.
To overcome this limitation:
- Reduce the result set size by modifying the query to only return relevant data. Use [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where) to select a smaller subset of the data.
- Shift any post-query processing to the query itself. You can use the ES|QL [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command to aggregate data in the query.

The upper limit only applies to the number of rows that are output by the query, not to the number of documents it processes: the query runs on the full data set.
Consider the following two queries:
```esql
FROM index | WHERE field0 == "value" | LIMIT 20000
```

and
```esql
FROM index | STATS AVG(field1) BY field2 | LIMIT 20000
```

In both cases, the filtering by `field0` in the first query or the grouping by `field2` in the second is applied over all the documents present in the `index`, irrespective of their number or indexes size. However, both queries will return at most 10,000 rows, even if there were more rows available to return.
The default and maximum limits can be changed using these dynamic cluster settings:
- `esql.query.result_truncation_default_size`
- `esql.query.result_truncation_max_size`

However, doing so involves trade-offs. A larger result-set involves a higher memory pressure and increased processing times; the internode traffic within and across clusters can also increase.
These limitations are similar to those enforced by the [search API for pagination](https://www.elastic.co/docs/reference/elasticsearch/rest-apis/paginate-search-results).

| Functionality                    | Search                  | ES|QL                                     |
|----------------------------------|-------------------------|-------------------------------------------|
| Results returned by default      | 10                      | 1.000                                     |
| Default upper limit              | 10,000                  | 10,000                                    |
| Specify number of results        | `size`                  | `LIMIT`                                   |
| Change default number of results | n/a                     | esql.query.result_truncation_default_size |
| Change default upper limit       | index-max-result-window | esql.query.result_truncation_max_size     |


## Field types


### Supported types

ES|QL currently supports the following [field types](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/field-data-types):
- `alias`
- `boolean`
- `date`
- `date_nanos` (Tech Preview)
  - The following functions don’t yet support date nanos: `bucket`, `date_format`, `date_parse`, `date_diff`, `date_extract`
- You can use `to_datetime` to cast to millisecond dates to use unsupported functions
- `double` (`float`, `half_float`, `scaled_float` are represented as `double`)
- `dense_vector` <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- `ip`
- `keyword` [family](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/keyword) including `keyword`, `constant_keyword`, and `wildcard`
- `int` (`short` and `byte` are represented as `int`)
- `long`
- `null`
- `text` [family](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/text) including `text`, `semantic_text` and `match_only_text`
- `unsigned_long` <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- `version`
- Spatial types
  - `geo_point`
- `geo_shape`
- `point`
- `shape`
- TSDB metrics <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - `counter`
- `gauge`
- `aggregate_metric_double`
- `exponential_histogram` <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>


### Unsupported types

ES|QL does not support certain field types. If the limitation only applies to specific product versions, it is indicated in the following list:
- <applies-to>Elastic Stack: Generally available from 9.0 to 9.1</applies-to> `dense_vector`
- <applies-to>Elastic Stack: Generally available from 9.0 to 9.1</applies-to> TSDB metrics
  - `counter`
- `gauge`
- `aggregate_metric_double`
- Date/time
  - `date_range`
- Other types
  - `binary`
- `completion`
- `double_range`
- `flattened`
- `float_range`
- `histogram`
- `integer_range`
- `ip_range`
- `long_range`
- `nested`
- `rank_feature`
- `rank_features`
- `search_as_you_type`

Querying a column with an unsupported type returns an error. If a column with an unsupported type is not explicitly used in a query, it is returned with `null` values, with the exception of nested fields. Nested fields are not returned at all.

### Limitations on supported types

Some [field types](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/field-data-types) are not supported in all contexts:
- Spatial types are not supported in the [SORT](https://www.elastic.co/docs/reference/query-languages/esql/commands/sort) processing command. Specifying a column of one of these types as a sort parameter will result in an error:
  - `geo_point`
- `geo_shape`
- `cartesian_point`
- `cartesian_shape`

- In addition, when [querying multiple indexes](https://www.elastic.co/docs/reference/query-languages/esql/esql-multi-index), it’s possible for the same field to be mapped to multiple types. These fields cannot be directly used in queries or returned in results, unless they’re [explicitly converted to a single type](/docs/reference/query-languages/esql/esql-multi-index#esql-multi-index-union-types).


#### Partial support in 9.2.0

- <applies-to>Elastic Stack: Preview since 9.2</applies-to> The following types are only partially supported on 9.2.0. This is fixed in 9.2.1:
  - `dense_vector`: The [`KNN` function](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-knn) and the [`TO_DENSE_VECTOR` function](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_dense_vector) will work and any field data will be retrieved as part of the results. However, the type will appear as `unsupported` when these functions are not used.
- `aggregate_metric_double`: Using the [`TO_AGGREGATE_METRIC_DOUBLE` function](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_aggregate_metric_double) will work and any field data will be retrieved as part of the results. However, the type will appear as `unsupported` if this function is not used.
  <note>
  This means that a simple query like `FROM test` will not retrieve `dense_vector` or `aggregate_metric_double` data. However, using the appropriate functions will work:
  - `FROM test WHERE KNN("dense_vector_field", [0, 1, 2, ...])`
  - `FROM test | EVAL agm_data = TO_AGGREGATE_METRIC_DOUBLE(aggregate_metric_double_field)`
  </note>


## _source availability

ES|QL does not support configurations where the [_source field](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/mapping-source-field) is [disabled](/docs/reference/elasticsearch/mapping-reference/mapping-source-field#disable-source-field).

## Full-text search

One limitation of [full-text search](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/search-functions) is that it is necessary to use the search function,
like [`MATCH`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match),
in a [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where) command directly after the
[`FROM`](https://www.elastic.co/docs/reference/query-languages/esql/commands/from) source command, or close enough to it.
Otherwise, the query will fail with a validation error.
For example, this query is valid:
```esql
FROM books
| WHERE MATCH(author, "Faulkner") AND MATCH(author, "Tolkien")
```

But this query will fail due to the [STATS](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command:
```esql
FROM books
| STATS AVG(price) BY author
| WHERE MATCH(author, "Faulkner")
```

Note that any queries on `text` fields that do not explicitly use the full-text functions,
[`MATCH`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match),
[`QSTR`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-qstr) or
[`KQL`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-kql),
will behave as if the fields are actually `keyword` fields: they are case-sensitive and need to match the full string.

## Using ES|QL to query multiple indices

As discussed in more detail in [Using ES|QL to query multiple indices](https://www.elastic.co/docs/reference/query-languages/esql/esql-multi-index), ES|QL can execute a single query across multiple indices, data streams, or aliases. However, there are some limitations to be aware of:
- All underlying indexes and shards must be active. Using admin commands or UI, it is possible to pause an index or shard, for example by disabling a frozen tier instance, but then any ES|QL query that includes that index or shard will fail, even if the query uses [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where) to filter out the results from the paused index. If you see an error of type `search_phase_execution_exception`, with the message `Search rejected due to missing shards`, you likely have an index or shard in `UNASSIGNED` state.
- The same field must have the same type across all indexes. If the same field is mapped to different types it is still possible to query the indexes, but the field must be [explicitly converted to a single type](/docs/reference/query-languages/esql/esql-multi-index#esql-multi-index-union-types).


## Time series data streams

<applies-switch>
  <applies-item title="stack: preview 9.2+" applies-to="Elastic Stack: Preview since 9.2">
    Time series data streams (TSDS) are supported in technical preview.
  </applies-item>

  <applies-item title="stack: ga 9.0-9.1" applies-to="Elastic Stack: Generally available from 9.0 to 9.1">
    ES|QL does not support querying time series data streams (TSDS).
  </applies-item>
</applies-switch>


## Date math limitations

Date math expressions work well when the leftmost expression is a datetime, for example:
```txt
now() + 1 year - 2hour + ...
```

But using parentheses or putting the datetime to the right is not always supported yet. For example, the following expressions fail:
```txt
1year + 2hour + now()
now() + (1year + 2hour)
```

Date math does not allow subtracting two datetimes, for example:
```txt
now() - 2023-10-26
```


## Enrich limitations

While all three enrich policy types are supported, there are some limitations to be aware of:
- The `geo_match` enrich policy type only supports the `intersects` spatial relation.
- It is required that the `match_field` in the `ENRICH` command is of the correct type. For example, if the enrich policy is of type `geo_match`, the `match_field` in the `ENRICH` command must be of type `geo_point` or `geo_shape`. Likewise, a `range` enrich policy requires a `match_field` of type `integer`, `long`, `date`, or `ip`, depending on the type of the range field in the original enrich index.
- However, this constraint is relaxed for `range` policies when the `match_field` is of type `KEYWORD`. In this case the field values will be parsed during query execution, row by row. If any value fails to parse, the output values for that row will be set to `null`, an appropriate warning will be produced and the query will continue to execute.


## Dissect limitations

The `DISSECT` command does not support reference keys.

## Grok limitations

The `GROK` command does not support configuring [custom patterns](/docs/reference/enrich-processor/grok-processor#custom-patterns), or [multiple patterns](/docs/reference/enrich-processor/grok-processor#trace-match). The `GROK` command is not subject to [Grok watchdog settings](/docs/reference/enrich-processor/grok-processor#grok-watchdog).

## Multivalue limitations

ES|QL [supports multivalued fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-multivalued-fields),
but functions return `null` when applied to a multivalued field, unless documented otherwise.
Work around this limitation by converting the field to single value with one of the
[multivalue functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/mv-functions).

## Timezone support

ES|QL only supports the UTC timezone.

## INLINE STATS limitations

[`CATEGORIZE`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-categorize) grouping function is not currently supported.
Also, [`INLINE STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/inlinestats-by) cannot yet have an unbounded [`SORT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/sort) before it. You must either move the SORT after it, or add a [`LIMIT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/limit) before the [`SORT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/sort).

## Kibana limitations

- The filter bar interface is not enabled when Discover is in ES|QL mode. To filter data, use [variable controls](https://www.elastic.co/docs/explore-analyze/discover/try-esql#add-variable-control), filter buttons within the table and field list, or write a query that uses the [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where) command instead.
- Discover shows no more than 10,000 rows. This limit only applies to the number of rows that are retrieved by the query and displayed in Discover. Queries and aggregations run on the full data set.
- Discover shows no more than 50 columns. If a query returns more than 50 columns, Discover only shows the first 50.
- CSV export from Discover shows no more than 10,000 rows. This limit only applies to the number of rows that are retrieved by the query and displayed in Discover. Queries and aggregations run on the full data set.
- Querying many indices at once without any filters can cause an error in kibana which looks like `[esql] > Unexpected error from Elasticsearch: The content length (536885793) is bigger than the maximum allowed string (536870888)`. The response from ES|QL is too long. Use [`DROP`](https://www.elastic.co/docs/reference/query-languages/esql/commands/drop) or [`KEEP`](https://www.elastic.co/docs/reference/query-languages/esql/commands/keep) to limit the number of fields returned.


## Cross-cluster search limitations

ES|QL does not support [Cross-Cluster Search (CCS)](https://www.elastic.co/docs/explore-analyze/cross-cluster-search) on [`semantic_text` fields](https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/semantic-text).

## Known issues

Refer to [Known issues](https://www.elastic.co/docs/release-notes/elasticsearch/known-issues) for a list of known issues for ES|QL.﻿---
title: ES|QL source commands
description: An ES|QL source command produces a table, typically with data from Elasticsearch. An ES|QL query must start with a source command. ES|QL supports these...
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/source-commands
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL source commands
An ES|QL source command produces a table, typically with data from Elasticsearch. An ES|QL query must start with a source command.
![A source command producing a table from Elasticsearch](https://www.elastic.co/docs/reference/query-languages/images/source-command.svg)

ES|QL supports these source commands:
- [`FROM`](https://www.elastic.co/docs/reference/query-languages/esql/commands/from)
- [`ROW`](https://www.elastic.co/docs/reference/query-languages/esql/commands/row)
- [`SHOW`](https://www.elastic.co/docs/reference/query-languages/esql/commands/show)
- [`TS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/ts)﻿---
title: ES|QL spatial functions
description: ES|QL supports these spatial functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/spatial-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL spatial functions
ES|QL supports these spatial functions:
- Geospatial predicates
  - [`ST_DISTANCE`](#esql-st_distance)
- [`ST_INTERSECTS`](#esql-st_intersects)
- [`ST_DISJOINT`](#esql-st_disjoint)
- [`ST_CONTAINS`](#esql-st_contains)
- [`ST_WITHIN`](#esql-st_within)
- Geometry functions
  - [`ST_X`](#esql-st_x)
- [`ST_Y`](#esql-st_y)
- [`ST_NPOINTS`](#esql-st_npoints) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_SIMPLIFY`](#esql-st_simplify) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_ENVELOPE`](#esql-st_envelope) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_XMAX`](#esql-st_xmax) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_XMIN`](#esql-st_xmin) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_YMAX`](#esql-st_ymax) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_YMIN`](#esql-st_ymin) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- Grid encoding functions
  - [`ST_GEOTILE`](#esql-st_geotile) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_GEOHEX`](#esql-st_geohex) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- [`ST_GEOHASH`](#esql-st_geohash) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>


## Geospatial predicates


### `ST_DISTANCE`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_distance.svg)

**Parameters**
<definitions>
  <definition term="geomA">
    Expression of type `geo_point` or `cartesian_point`. If `null`, the function returns `null`.
  </definition>
  <definition term="geomB">
    Expression of type `geo_point` or `cartesian_point`. If `null`, the function returns `null`. The second parameter must also have the same coordinate system as the first. This means it is not possible to combine `geo_point` and `cartesian_point` parameters.
  </definition>
</definitions>

**Description**
Computes the distance between two points. For cartesian geometries, this is the pythagorean distance in the same units as the original coordinates. For geographic geometries, this is the circular distance along the great circle in meters.
**Supported types**

| geomA           | geomB           | result |
|-----------------|-----------------|--------|
| cartesian_point | cartesian_point | double |
| geo_point       | geo_point       | double |

**Example**
```esql
FROM airports
| WHERE abbrev == "CPH"
| EVAL distance = ST_DISTANCE(location, city_location)
| KEEP abbrev, name, location, city_location, distance
```


| abbrev:k | name:text  | location:geo_point                       | city_location:geo_point | distance:d        |
|----------|------------|------------------------------------------|-------------------------|-------------------|
| CPH      | Copenhagen | POINT(12.6493508684508 55.6285017221528) | POINT(12.5683 55.6761)  | 7339.573896618216 |


### `ST_INTERSECTS`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_intersects.svg)

**Parameters**
<definitions>
  <definition term="geomA">
    Expression that is either a geometry (`geo_point`, `cartesian_point`, `geo_shape` or `cartesian_shape`) or a geo-grid value (`geohash`, `geotile`, `geohex`). If `null`, the function returns `null`.
  </definition>
  <definition term="geomB">
    Expression that is either a geometry (`geo_point`, `cartesian_point`, `geo_shape` or `cartesian_shape`) or a geo-grid value (`geohash`, `geotile`, `geohex`). If `null`, the function returns `null`. The second parameter must also have the same coordinate system as the first. This means it is not possible to combine `geo_*` and `cartesian_*` parameters.
  </definition>
</definitions>

**Description**
Returns true if two geometries intersect. They intersect if they have any point in common, including their interior points (points along lines or within polygons). This is the inverse of the [ST_DISJOINT](#esql-st_disjoint) function. In mathematical terms: ST_Intersects(A, B) ⇔ A ⋂ B ≠ ∅
**Supported types**

| geomA           | geomB           | result  |
|-----------------|-----------------|---------|
| cartesian_point | cartesian_point | boolean |
| cartesian_point | cartesian_shape | boolean |
| cartesian_shape | cartesian_point | boolean |
| cartesian_shape | cartesian_shape | boolean |
| geo_point       | geo_point       | boolean |
| geo_point       | geo_shape       | boolean |
| geo_point       | geohash         | boolean |
| geo_point       | geohex          | boolean |
| geo_point       | geotile         | boolean |
| geo_shape       | geo_point       | boolean |
| geo_shape       | geo_shape       | boolean |
| geohash         | geo_point       | boolean |
| geohex          | geo_point       | boolean |
| geotile         | geo_point       | boolean |

**Example**
```esql
FROM airports
| WHERE ST_INTERSECTS(location, TO_GEOSHAPE("POLYGON((42 14, 43 14, 43 15, 42 15, 42 14))"))
```


| abbrev:keyword | city:keyword | city_location:geo_point | country:keyword | location:geo_point                     | name:text      | scalerank:i | type:k |
|----------------|--------------|-------------------------|-----------------|----------------------------------------|----------------|-------------|--------|
| HOD            | Al Ḩudaydah  | POINT(42.9511 14.8022)  | Yemen           | POINT(42.97109630194 14.7552534413725) | Hodeidah Int'l | 9           | mid    |


### `ST_DISJOINT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_disjoint.svg)

**Parameters**
<definitions>
  <definition term="geomA">
    Expression that is either a geometry (`geo_point`, `cartesian_point`, `geo_shape` or `cartesian_shape`) or a geo-grid value (`geohash`, `geotile`, `geohex`). If `null`, the function returns `null`.
  </definition>
  <definition term="geomB">
    Expression that is either a geometry (`geo_point`, `cartesian_point`, `geo_shape` or `cartesian_shape`) or a geo-grid value (`geohash`, `geotile`, `geohex`). If `null`, the function returns `null`. The second parameter must also have the same coordinate system as the first. This means it is not possible to combine `geo_*` and `cartesian_*` parameters.
  </definition>
</definitions>

**Description**
Returns whether the two geometries or geometry columns are disjoint. This is the inverse of the [ST_INTERSECTS](#esql-st_intersects) function. In mathematical terms: ST_Disjoint(A, B) ⇔ A ⋂ B = ∅
**Supported types**

| geomA           | geomB           | result  |
|-----------------|-----------------|---------|
| cartesian_point | cartesian_point | boolean |
| cartesian_point | cartesian_shape | boolean |
| cartesian_shape | cartesian_point | boolean |
| cartesian_shape | cartesian_shape | boolean |
| geo_point       | geo_point       | boolean |
| geo_point       | geo_shape       | boolean |
| geo_point       | geohash         | boolean |
| geo_point       | geohex          | boolean |
| geo_point       | geotile         | boolean |
| geo_shape       | geo_point       | boolean |
| geo_shape       | geo_shape       | boolean |
| geohash         | geo_point       | boolean |
| geohex          | geo_point       | boolean |
| geotile         | geo_point       | boolean |

**Example**
```esql
FROM airport_city_boundaries
| WHERE ST_DISJOINT(city_boundary, TO_GEOSHAPE("POLYGON((-10 -60, 120 -60, 120 60, -10 60, -10 -60))"))
| KEEP abbrev, airport, region, city, city_location
```


| abbrev:keyword | airport:text                 | region:text        | city:keyword       | city_location:geo_point  |
|----------------|------------------------------|--------------------|--------------------|--------------------------|
| ACA            | General Juan N Alvarez Int'l | Acapulco de Juárez | Acapulco de Juárez | POINT (-99.8825 16.8636) |


### `ST_CONTAINS`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_contains.svg)

**Parameters**
<definitions>
  <definition term="geomA">
    Expression of type `geo_point`, `cartesian_point`, `geo_shape` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
  <definition term="geomB">
    Expression of type `geo_point`, `cartesian_point`, `geo_shape` or `cartesian_shape`. If `null`, the function returns `null`. The second parameter must also have the same coordinate system as the first. This means it is not possible to combine `geo_*` and `cartesian_*` parameters.
  </definition>
</definitions>

**Description**
Returns whether the first geometry contains the second geometry. This is the inverse of the [ST_WITHIN](#esql-st_within) function.
**Supported types**

| geomA           | geomB           | result  |
|-----------------|-----------------|---------|
| cartesian_point | cartesian_point | boolean |
| cartesian_point | cartesian_shape | boolean |
| cartesian_shape | cartesian_point | boolean |
| cartesian_shape | cartesian_shape | boolean |
| geo_point       | geo_point       | boolean |
| geo_point       | geo_shape       | boolean |
| geo_shape       | geo_point       | boolean |
| geo_shape       | geo_shape       | boolean |

**Example**
```esql
FROM airport_city_boundaries
| WHERE ST_CONTAINS(city_boundary, TO_GEOSHAPE("POLYGON((109.35 18.3, 109.45 18.3, 109.45 18.4, 109.35 18.4, 109.35 18.3))"))
| KEEP abbrev, airport, region, city, city_location
```


| abbrev:keyword | airport:text        | region:text | city:keyword | city_location:geo_point |
|----------------|---------------------|-------------|--------------|-------------------------|
| SYX            | Sanya Phoenix Int'l | 天涯区         | Sanya        | POINT(109.5036 18.2533) |


### `ST_WITHIN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_within.svg)

**Parameters**
<definitions>
  <definition term="geomA">
    Expression of type `geo_point`, `cartesian_point`, `geo_shape` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
  <definition term="geomB">
    Expression of type `geo_point`, `cartesian_point`, `geo_shape` or `cartesian_shape`. If `null`, the function returns `null`. The second parameter must also have the same coordinate system as the first. This means it is not possible to combine `geo_*` and `cartesian_*` parameters.
  </definition>
</definitions>

**Description**
Returns whether the first geometry is within the second geometry. This is the inverse of the [ST_CONTAINS](#esql-st_contains) function.
**Supported types**

| geomA           | geomB           | result  |
|-----------------|-----------------|---------|
| cartesian_point | cartesian_point | boolean |
| cartesian_point | cartesian_shape | boolean |
| cartesian_shape | cartesian_point | boolean |
| cartesian_shape | cartesian_shape | boolean |
| geo_point       | geo_point       | boolean |
| geo_point       | geo_shape       | boolean |
| geo_shape       | geo_point       | boolean |
| geo_shape       | geo_shape       | boolean |

**Example**
```esql
FROM airport_city_boundaries
| WHERE ST_WITHIN(city_boundary, TO_GEOSHAPE("POLYGON((109.1 18.15, 109.6 18.15, 109.6 18.65, 109.1 18.65, 109.1 18.15))"))
| KEEP abbrev, airport, region, city, city_location
```


| abbrev:keyword | airport:text        | region:text | city:keyword | city_location:geo_point |
|----------------|---------------------|-------------|--------------|-------------------------|
| SYX            | Sanya Phoenix Int'l | 天涯区         | Sanya        | POINT(109.5036 18.2533) |


## Geometry functions


### `ST_X`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_x.svg)

**Parameters**
<definitions>
  <definition term="point">
    Expression of type `geo_point` or `cartesian_point`. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Extracts the `x` coordinate from the supplied point. If the point is of type `geo_point` this is equivalent to extracting the `longitude` value.
**Supported types**

| point           | result |
|-----------------|--------|
| cartesian_point | double |
| geo_point       | double |

**Example**
```esql
ROW point = TO_GEOPOINT("POINT(42.97109629958868 14.7552534006536)")
| EVAL x =  ST_X(point), y = ST_Y(point)
```


| point:geo_point                           | x:double          | y:double         |
|-------------------------------------------|-------------------|------------------|
| POINT(42.97109629958868 14.7552534006536) | 42.97109629958868 | 14.7552534006536 |


### `ST_Y`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_y.svg)

**Parameters**
<definitions>
  <definition term="point">
    Expression of type `geo_point` or `cartesian_point`. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Extracts the `y` coordinate from the supplied point. If the point is of type `geo_point` this is equivalent to extracting the `latitude` value.
**Supported types**

| point           | result |
|-----------------|--------|
| cartesian_point | double |
| geo_point       | double |

**Example**
```esql
ROW point = TO_GEOPOINT("POINT(42.97109629958868 14.7552534006536)")
| EVAL x =  ST_X(point), y = ST_Y(point)
```


| point:geo_point                           | x:double          | y:double         |
|-------------------------------------------|-------------------|------------------|
| POINT(42.97109629958868 14.7552534006536) | 42.97109629958868 | 14.7552534006536 |


### `ST_NPOINTS`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_npoints.svg)

**Parameters**
<definitions>
  <definition term="geometry">
    Expression of type `geo_point`, `geo_shape`, `cartesian_point` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Counts the number of points in the supplied geometry.
**Supported types**

| geometry        | result  |
|-----------------|---------|
| cartesian_point | integer |
| cartesian_shape | integer |
| geo_point       | integer |
| geo_shape       | integer |

**Example**
```esql
FROM airport_city_boundaries
| WHERE abbrev == "CPH"
| EVAL points = ST_NPOINTS(city_boundary)
| KEEP abbrev, airport, points
```


| abbrev:keyword | airport:text | points:integer |
|----------------|--------------|----------------|
| CPH            | Copenhagen   | 15             |


### `ST_SIMPLIFY`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Planned
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_simplify.svg)

**Parameters**
<definitions>
  <definition term="geometry">
    Expression of type `geo_point`, `geo_shape`, `cartesian_point` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
  <definition term="tolerance">
    Tolerance for the geometry simplification, in the units of the input SRS
  </definition>
</definitions>

**Description**
Simplifies the input geometry by applying the Douglas-Peucker algorithm with a specified tolerance. Vertices that fall within the tolerance distance from the simplified shape are removed. Note that the resulting geometry may be invalid, even if the original input was valid.
**Supported types**

| geometry        | tolerance | result          |
|-----------------|-----------|-----------------|
| cartesian_point | double    | cartesian_point |
| cartesian_shape | double    | cartesian_shape |
| geo_point       | double    | geo_point       |
| geo_shape       | double    | geo_shape       |

**Example**
```esql
ROW wkt = "POLYGON ((7.998 53.827, 9.470 53.068, 15.754 53.801, 16.523 57.160, 11.162 57.868, 8.064 57.445, 6.219 55.317, 7.998 53.827))"
| EVAL simplified = ST_SIMPLIFY(TO_GEOSHAPE(wkt), 0.7)
```


| wkt:keyword                                                                                                                   | simplified:geo_shape                                                                          |
|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| POLYGON ((7.998 53.827, 9.470 53.068, 15.754 53.801, 16.523 57.160, 11.162 57.868, 8.064 57.445, 6.219 55.317, 7.998 53.827)) | POLYGON ((9.47 53.068, 15.754 53.801, 16.523 57.16, 8.064 57.445, 6.219 55.317, 9.47 53.068)) |


## `ST_ENVELOPE`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_envelope.svg)

**Parameters**
<definitions>
  <definition term="geometry">
    Expression of type `geo_point`, `geo_shape`, `cartesian_point` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Determines the minimum bounding box of the supplied geometry.
**Supported types**

| geometry        | result          |
|-----------------|-----------------|
| cartesian_point | cartesian_shape |
| cartesian_shape | cartesian_shape |
| geo_point       | geo_shape       |
| geo_shape       | geo_shape       |

**Example**
```esql
FROM airport_city_boundaries
| WHERE abbrev == "CPH"
| EVAL envelope = ST_ENVELOPE(city_boundary)
| KEEP abbrev, airport, envelope
```


| abbrev:keyword | airport:text | envelope:geo_shape                      |
|----------------|--------------|-----------------------------------------|
| CPH            | Copenhagen   | BBOX(12.453, 12.6398, 55.7327, 55.6318) |


### `ST_XMAX`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_xmax.svg)

**Parameters**
<definitions>
  <definition term="point">
    Expression of type `geo_point`, `geo_shape`, `cartesian_point` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Extracts the maximum value of the `x` coordinates from the supplied geometry. If the geometry is of type `geo_point` or `geo_shape` this is equivalent to extracting the maximum `longitude` value.
**Supported types**

| point           | result |
|-----------------|--------|
| cartesian_point | double |
| cartesian_shape | double |
| geo_point       | double |
| geo_shape       | double |

**Example**
```esql
FROM airport_city_boundaries
| WHERE abbrev == "CPH"
| EVAL envelope = ST_ENVELOPE(city_boundary)
| EVAL xmin = ST_XMIN(envelope), xmax = ST_XMAX(envelope), ymin = ST_YMIN(envelope), ymax = ST_YMAX(envelope)
| KEEP abbrev, airport, xmin, xmax, ymin, ymax
```


| abbrev:keyword | airport:text | xmin:double | xmax:double | ymin:double | ymax:double |
|----------------|--------------|-------------|-------------|-------------|-------------|
| CPH            | Copenhagen   | 12.453      | 12.6398     | 55.6318     | 55.7327     |


### `ST_XMIN`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_xmin.svg)

**Parameters**
<definitions>
  <definition term="point">
    Expression of type `geo_point`, `geo_shape`, `cartesian_point` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Extracts the minimum value of the `x` coordinates from the supplied geometry. If the geometry is of type `geo_point` or `geo_shape` this is equivalent to extracting the minimum `longitude` value.
**Supported types**

| point           | result |
|-----------------|--------|
| cartesian_point | double |
| cartesian_shape | double |
| geo_point       | double |
| geo_shape       | double |

**Example**
```esql
FROM airport_city_boundaries
| WHERE abbrev == "CPH"
| EVAL envelope = ST_ENVELOPE(city_boundary)
| EVAL xmin = ST_XMIN(envelope), xmax = ST_XMAX(envelope), ymin = ST_YMIN(envelope), ymax = ST_YMAX(envelope)
| KEEP abbrev, airport, xmin, xmax, ymin, ymax
```


| abbrev:keyword | airport:text | xmin:double | xmax:double | ymin:double | ymax:double |
|----------------|--------------|-------------|-------------|-------------|-------------|
| CPH            | Copenhagen   | 12.453      | 12.6398     | 55.6318     | 55.7327     |


### `ST_YMAX`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_ymax.svg)

**Parameters**
<definitions>
  <definition term="point">
    Expression of type `geo_point`, `geo_shape`, `cartesian_point` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Extracts the maximum value of the `y` coordinates from the supplied geometry. If the geometry is of type `geo_point` or `geo_shape` this is equivalent to extracting the maximum `latitude` value.
**Supported types**

| point           | result |
|-----------------|--------|
| cartesian_point | double |
| cartesian_shape | double |
| geo_point       | double |
| geo_shape       | double |

**Example**
```esql
FROM airport_city_boundaries
| WHERE abbrev == "CPH"
| EVAL envelope = ST_ENVELOPE(city_boundary)
| EVAL xmin = ST_XMIN(envelope), xmax = ST_XMAX(envelope), ymin = ST_YMIN(envelope), ymax = ST_YMAX(envelope)
| KEEP abbrev, airport, xmin, xmax, ymin, ymax
```


| abbrev:keyword | airport:text | xmin:double | xmax:double | ymin:double | ymax:double |
|----------------|--------------|-------------|-------------|-------------|-------------|
| CPH            | Copenhagen   | 12.453      | 12.6398     | 55.6318     | 55.7327     |


### `ST_YMIN`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_ymin.svg)

**Parameters**
<definitions>
  <definition term="point">
    Expression of type `geo_point`, `geo_shape`, `cartesian_point` or `cartesian_shape`. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Extracts the minimum value of the `y` coordinates from the supplied geometry. If the geometry is of type `geo_point` or `geo_shape` this is equivalent to extracting the minimum `latitude` value.
**Supported types**

| point           | result |
|-----------------|--------|
| cartesian_point | double |
| cartesian_shape | double |
| geo_point       | double |
| geo_shape       | double |

**Example**
```esql
FROM airport_city_boundaries
| WHERE abbrev == "CPH"
| EVAL envelope = ST_ENVELOPE(city_boundary)
| EVAL xmin = ST_XMIN(envelope), xmax = ST_XMAX(envelope), ymin = ST_YMIN(envelope), ymax = ST_YMAX(envelope)
| KEEP abbrev, airport, xmin, xmax, ymin, ymax
```


| abbrev:keyword | airport:text | xmin:double | xmax:double | ymin:double | ymax:double |
|----------------|--------------|-------------|-------------|-------------|-------------|
| CPH            | Copenhagen   | 12.453      | 12.6398     | 55.6318     | 55.7327     |


## Grid encoding functions


### `ST_GEOTILE`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_geotile.svg)

**Parameters**
<definitions>
  <definition term="geometry">
    Expression of type `geo_point`. If `null`, the function returns `null`.
  </definition>
  <definition term="precision">
    Expression of type `integer`. If `null`, the function returns `null`. Valid values are between [0 and 29](https://wiki.openstreetmap.org/wiki/Zoom_levels).
  </definition>
  <definition term="bounds">
    Optional bounds to filter the grid tiles, a `geo_shape` of type `BBOX`. Use [`ST_ENVELOPE`](#esql-st_envelope) if the `geo_shape` is of any other type.
  </definition>
</definitions>

**Description**
Calculates the `geotile` of the supplied geo_point at the specified precision. The result is long encoded. Use [TO_STRING](#esql-to_string) to convert the result to a string, [TO_LONG](#esql-to_long) to convert it to a `long`, or [TO_GEOSHAPE](#esql-to_geoshape) to calculate the `geo_shape` bounding geometry.  These functions are related to the [`geo_grid` query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-geo-grid-query) and the [`geotile_grid` aggregation](https://www.elastic.co/docs/reference/aggregations/search-aggregations-bucket-geotilegrid-aggregation).
**Supported types**

| geometry  | precision | bounds    | result  |
|-----------|-----------|-----------|---------|
| geo_point | integer   | geo_shape | geotile |
| geo_point | integer   |           | geotile |

**Example**
```esql
FROM airports
| EVAL geotile = ST_GEOTILE(location, 2)
| STATS
    count = COUNT(geotile),
    centroid = ST_CENTROID_AGG(location)
      BY geotile
| EVAL geotileString = TO_STRING(geotile)
| SORT count DESC, geotileString ASC
| KEEP count, centroid, geotileString
```


| count:long | centroid:geo_point                              | geotileString:keyword |
|------------|-------------------------------------------------|-----------------------|
| 286        | POINT (39.31202001609169 35.149993664386415)    | 2/2/1                 |
| 197        | POINT (-55.387361375756825 31.952955322292855)  | 2/1/1                 |
| 136        | POINT (-110.97162496141048 36.87185255084734)   | 2/0/1                 |
| 106        | POINT (119.35907618669827 25.46263281488791)    | 2/3/1                 |
| 67         | POINT (-58.031108492373754 -22.624166105151065) | 2/1/2                 |
| 46         | POINT (142.95455511274707 -20.581492295427978)  | 2/3/2                 |
| 34         | POINT (31.38476753634784 -14.64374022804858)    | 2/2/2                 |
| 8          | POINT (-160.0723083713092 -19.124013530672528)  | 2/0/2                 |
| 6          | POINT (23.95813101902604 70.17537698848173)     | 2/2/0                 |
| 3          | POINT (-133.4001641627401 72.06833167467266)    | 2/0/0                 |
| 2          | POINT (-68.47209956031293 66.77569948369637)    | 2/1/0                 |


### `ST_GEOHEX`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_geohex.svg)

**Parameters**
<definitions>
  <definition term="geometry">
    Expression of type `geo_point`. If `null`, the function returns `null`.
  </definition>
  <definition term="precision">
    Expression of type `integer`. If `null`, the function returns `null`. Valid values are between [0 and 15](https://h3geo.org/docs/core-library/restable/).
  </definition>
  <definition term="bounds">
    Optional bounds to filter the grid tiles, a `geo_shape` of type `BBOX`. Use [`ST_ENVELOPE`](#esql-st_envelope) if the `geo_shape` is of any other type.
  </definition>
</definitions>

**Description**
Calculates the `geohex`, the H3 cell-id, of the supplied geo_point at the specified precision. The result is long encoded. Use [TO_STRING](#esql-to_string) to convert the result to a string, [TO_LONG](#esql-to_long) to convert it to a `long`, or [TO_GEOSHAPE](#esql-to_geoshape) to calculate the `geo_shape` bounding geometry.  These functions are related to the [`geo_grid` query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-geo-grid-query) and the [`geohex_grid` aggregation](https://www.elastic.co/docs/reference/aggregations/search-aggregations-bucket-geohexgrid-aggregation).
**Supported types**

| geometry  | precision | bounds    | result |
|-----------|-----------|-----------|--------|
| geo_point | integer   | geo_shape | geohex |
| geo_point | integer   |           | geohex |

**Example**
```esql
FROM airports
| EVAL geohex = ST_GEOHEX(location, 1)
| STATS
    count = COUNT(geohex),
    centroid = ST_CENTROID_AGG(location)
      BY geohex
| WHERE count >= 10
| EVAL geohexString = TO_STRING(geohex)
| KEEP count, centroid, geohexString
| SORT count DESC, geohexString ASC
```


| count:long | centroid:geo_point                             | geohexString:keyword |
|------------|------------------------------------------------|----------------------|
| 22         | POINT (7.250850197689777 48.21363834643059)    | 811fbffffffffff      |
| 18         | POINT (-80.64959161449224 40.04119813675061)   | 812abffffffffff      |
| 17         | POINT (-0.7606179875266903 52.86413913565304)  | 81197ffffffffff      |
| 13         | POINT (22.53157936179867 41.98255742864254)    | 811efffffffffff      |
| 13         | POINT (78.30096947387435 26.073904778951636)   | 813dbffffffffff      |
| 12         | POINT (-76.39781514415517 45.16300531569868)   | 812bbffffffffff      |
| 12         | POINT (-100.30120467301458 20.114154297625646) | 8149bffffffffff      |
| 11         | POINT (18.037187419831753 48.66540593306788)   | 811e3ffffffffff      |
| 11         | POINT (-83.42379064553164 33.18388901439241)   | 8144fffffffffff      |
| 11         | POINT (-99.4237939513881 27.100012352774765)   | 8148bffffffffff      |
| 10         | POINT (128.01009018346667 35.8699960866943)    | 8130fffffffffff      |


### `ST_GEOHASH`

<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/st_geohash.svg)

**Parameters**
<definitions>
  <definition term="geometry">
    Expression of type `geo_point`. If `null`, the function returns `null`.
  </definition>
  <definition term="precision">
    Expression of type `integer`. If `null`, the function returns `null`. Valid values are between [1 and 12](https://en.wikipedia.org/wiki/Geohash).
  </definition>
  <definition term="bounds">
    Optional bounds to filter the grid tiles, a `geo_shape` of type `BBOX`. Use [`ST_ENVELOPE`](#esql-st_envelope) if the `geo_shape` is of any other type.
  </definition>
</definitions>

**Description**
Calculates the `geohash` of the supplied geo_point at the specified precision. The result is long encoded. Use [TO_STRING](#esql-to_string) to convert the result to a string, [TO_LONG](#esql-to_long) to convert it to a `long`, or [TO_GEOSHAPE](#esql-to_geoshape) to calculate the `geo_shape` bounding geometry.  These functions are related to the [`geo_grid` query](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-geo-grid-query) and the [`geohash_grid` aggregation](https://www.elastic.co/docs/reference/aggregations/search-aggregations-bucket-geohashgrid-aggregation).
**Supported types**

| geometry  | precision | bounds    | result  |
|-----------|-----------|-----------|---------|
| geo_point | integer   | geo_shape | geohash |
| geo_point | integer   |           | geohash |

**Example**
```esql
FROM airports
| EVAL geohash = ST_GEOHASH(location, 1)
| STATS
    count = COUNT(geohash),
    centroid = ST_CENTROID_AGG(location)
      BY geohash
| WHERE count >= 10
| EVAL geohashString = TO_STRING(geohash)
| KEEP count, centroid, geohashString
| SORT count DESC, geohashString ASC
```


| count:long | centroid:geo_point                             | geohashString:keyword |
|------------|------------------------------------------------|-----------------------|
| 118        | POINT (-77.41857436454018 26.96522968734409)   | d                     |
| 96         | POINT (23.181679135886952 27.295384635654045)  | s                     |
| 94         | POINT (70.94076107503807 25.691916451026547)   | t                     |
| 90         | POINT (-104.3941700803116 30.811849871650338)  | 9                     |
| 89         | POINT (18.71573683606942 53.165169130707305)   | u                     |
| 85         | POINT (114.3722876966657 24.908398092505248)   | w                     |
| 51         | POINT (-61.44522591713159 -22.87209844956284)  | 6                     |
| 38         | POINT (-9.429514887252529 25.497624435045413)  | e                     |
| 34         | POINT (-111.8071846965262 52.464381378993174)  | c                     |
| 30         | POINT (28.7045472683385 -14.706001980230212)   | k                     |
| 28         | POINT (159.52750137208827 -25.555616633001982) | r                     |
| 22         | POINT (-4.410395708612421 54.90304926367985)   | g                     |
| 21         | POINT (-69.40534970590046 50.93379438189523)   | f                     |
| 17         | POINT (114.05526293222519 -10.898114638950895) | q                     |
| 16         | POINT (147.40052131412085 21.054660080408212)  | x                     |
| 13         | POINT (63.64716878519035 54.37333276101317)    | v                     |
| 12         | POINT (-39.53510569408536 -11.72166372067295)  | 7                     |﻿---
title: ES|QL TS command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/ts
---

# ES|QL TS command
<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

**Brief description**
The `TS` source command is similar to the [`FROM`](https://www.elastic.co/docs/reference/query-languages/esql/commands/from)
source command, with the following key differences:
- Targets only [time series indices](https://www.elastic.co/docs/manage-data/data-store/data-streams/time-series-data-stream-tsds)
- Enables the use of [time series aggregation functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions) inside the
  [STATS](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command

**Syntax**
```esql
TS index_pattern [METADATA fields]
```

**Parameters**
<definitions>
  <definition term="index_pattern">
    A list of indices, data streams or aliases. Supports wildcards and date math.
  </definition>
  <definition term="fields">
    A comma-separated list of [metadata fields](https://www.elastic.co/docs/reference/query-languages/esql/esql-metadata-fields) to retrieve.
  </definition>
</definitions>

**Description**
The `TS` source command enables time series semantics and adds support for
[time series aggregation functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions) to the `STATS` command, such as
[`AVG_OVER_TIME()`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-avg_over_time),
or [`RATE`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-rate).
These functions are implicitly evaluated per time series, then aggregated by group using a secondary aggregation
function. See the Examples section for a query that calculates the total rate of search requests per host and hour.
This paradigm—a pair of aggregation functions—is standard for time series
querying. For supported inner (time series) functions per
[metric type](https://www.elastic.co/docs/manage-data/data-store/data-streams/time-series-data-stream-tsds#time-series-metric), refer to
[ES|QL time series aggregation functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions). These functions also
apply to downsampled data, with the same semantics as for raw data.
<note>
  If a query is missing an inner (time series) aggregation function,
  [`LAST_OVER_TIME()`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-last_over_time)
  is assumed and used implicitly. For instance, two equivalent queries are shown in the Examples section that return the average of the last memory usage values per time series. To calculate the average memory usage across per-time-series averages, see the Examples section.
</note>

You can use [time series aggregation functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions)
directly in the `STATS` command (<applies-to>Elastic Stack: Planned</applies-to>). The output will contain one aggregate value per time series and time bucket (if specified). See the Examples section for examples.
You can also combine time series aggregation functions with regular [aggregation functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/aggregation-functions) such as `SUM()`, as outer aggregation functions. See the Examples section for examples.
However, using a time series aggregation function in combination with an inner time series function causes an error. See the Examples section for an invalid query example.
**Best practices**
- Avoid aggregating multiple metrics in the same query when those metrics have different dimensional cardinalities.
  For example, in `STATS max(rate(foo)) + rate(bar))`, if `foo` and `bar` don't share the same dimension values, the rate
  for one metric will be null for some dimension combinations. Because the + operator returns null when either input
  is null, the entire result becomes null for those dimensions. Additionally, queries that aggregate a single metric
  can filter out null values more efficiently.
- Use the `TS` command for aggregations on time series data, rather than `FROM`. The `FROM` command is still available
  (for example, for listing document contents), but it's not optimized for procesing time series data and may produce
  unexpected results.
- The `TS` command can't be combined with certain operations (such as
  [`FORK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fork)) before the `STATS` command is applied. Once `STATS` is
  applied, you can process the tabular output with any applicable ESQL operations.
- Add a time range filter on `@timestamp` to limit the data volume scanned and improve query performance.

**Examples**
Calculate the total rate of search requests (tracked by the `search_requests` counter) per host and hour. The `RATE()`
function is applied per time series in hourly buckets. These rates are summed for each
host and hourly bucket (since each host can map to multiple time series):
```esql
TS metrics
  | WHERE @timestamp >= now() - 1 hour
  | STATS SUM(RATE(search_requests)) BY TBUCKET(1 hour), host
```

The following two queries are equivalent, returning the average of the last memory usage values per time series. If a query is missing an inner (time series) aggregation function, `LAST_OVER_TIME()` is assumed and used implicitly:
```esql
TS metrics | STATS AVG(memory_usage)

TS metrics | STATS AVG(LAST_OVER_TIME(memory_usage))
```

Calculate the average memory usage across per-time-series averages:
```esql
TS metrics | STATS AVG(AVG_OVER_TIME(memory_usage))
```

Using a time series aggregation function directly (<applies-to>Elastic Stack: Planned</applies-to>):
```esql
TS metrics
| WHERE TRANGE(1 day)
| STATS RATE(search_requests) BY TBUCKET(1 hour)
```

Combining a time series aggregation function with a regular aggregation function:
```esql
TS metrics | STATS SUM(RATE(search_requests)) BY host
```

Combining a time series aggregation function with a regular aggregation function:
```esql
TS metrics
| WHERE @timestamp >= now() - 1 day
| STATS SUM(AVG_OVER_TIME(memory_usage)) BY host, TBUCKET(1 hour)
```

The following query is invalid because using a time series aggregation function in combination with an inner time series function causes an error:
```esql
TS metrics | STATS AVG_OVER_TIME(RATE(memory_usage))
```﻿---
title: ES|QL MV_EXPAND command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/mv_expand
---

# ES|QL MV_EXPAND command
<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview in 9.0+
</applies-to>

The `MV_EXPAND` processing command expands multivalued columns into one row per
value, duplicating other columns.
**Syntax**
```esql
MV_EXPAND column
```

**Parameters**
<definitions>
  <definition term="column">
    The multivalued column to expand.
  </definition>
</definitions>

<warning>
  The output rows produced by `MV_EXPAND` can be in any order and may not respect
  preceding `SORT`s. To guarantee a certain ordering, place a `SORT` after any
  `MV_EXPAND`s.
</warning>

**Example**
```esql
ROW a=[1,2,3], b="b", j=["a","b"]
| MV_EXPAND a
```


| a:integer | b:keyword | j:keyword  |
|-----------|-----------|------------|
| 1         | b         | ["a", "b"] |
| 2         | b         | ["a", "b"] |
| 3         | b         | ["a", "b"] |﻿---
title: ES|QL DROP command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/drop
---

# ES|QL DROP command
<applies-to>
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
</applies-to>

The `DROP` processing command removes one or more columns.
**Syntax**
```esql
DROP columns
```

**Parameters**
<definitions>
  <definition term="columns">
    A comma-separated list of columns to remove. Supports wildcards.
  </definition>
</definitions>

**Examples**
```esql
FROM employees
| DROP height
```

Rather than specify each column by name, you can use wildcards to drop all
columns with a name that matches a pattern:
```esql
FROM employees
| DROP height*
```﻿---
title: ES|QL grouping functions
description: The STATS command supports these grouping functions: The INLINE STATS command supports these grouping functions: BUCKET, TBUCKET. 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/grouping-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL grouping functions
The [`STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command supports these grouping functions:
- [`BUCKET`](#esql-bucket)
- [`TBUCKET`](#esql-tbucket)
- [`CATEGORIZE`](#esql-categorize)

The [`INLINE STATS`](https://www.elastic.co/docs/reference/query-languages/esql/commands/inlinestats-by) command supports these grouping functions:
- [`BUCKET`](#esql-bucket)
- [`TBUCKET`](#esql-tbucket)


## `BUCKET`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/bucket.svg)

**Parameters**
<definitions>
  <definition term="field">
    Numeric or date expression from which to derive buckets.
  </definition>
  <definition term="buckets">
    Target number of buckets, or desired bucket size if `from` and `to` parameters are omitted.
  </definition>
  <definition term="from">
    Start of the range. Can be a number, a date or a date expressed as a string.
  </definition>
  <definition term="to">
    End of the range. Can be a number, a date or a date expressed as a string.
  </definition>
</definitions>

**Description**
Creates groups of values - buckets - out of a datetime or numeric input. The size of the buckets can either be provided directly, or chosen based on a recommended count and values range.
**Supported types**

| field      | buckets       | from    | to      | result     |
|------------|---------------|---------|---------|------------|
| date       | date_period   |         |         | date       |
| date       | integer       | date    | date    | date       |
| date       | integer       | date    | keyword | date       |
| date       | integer       | date    | text    | date       |
| date       | integer       | keyword | date    | date       |
| date       | integer       | keyword | keyword | date       |
| date       | integer       | keyword | text    | date       |
| date       | integer       | text    | date    | date       |
| date       | integer       | text    | keyword | date       |
| date       | integer       | text    | text    | date       |
| date       | time_duration |         |         | date       |
| date_nanos | date_period   |         |         | date_nanos |
| date_nanos | integer       | date    | date    | date_nanos |
| date_nanos | integer       | date    | keyword | date_nanos |
| date_nanos | integer       | date    | text    | date_nanos |
| date_nanos | integer       | keyword | date    | date_nanos |
| date_nanos | integer       | keyword | keyword | date_nanos |
| date_nanos | integer       | keyword | text    | date_nanos |
| date_nanos | integer       | text    | date    | date_nanos |
| date_nanos | integer       | text    | keyword | date_nanos |
| date_nanos | integer       | text    | text    | date_nanos |
| date_nanos | time_duration |         |         | date_nanos |
| double     | double        |         |         | double     |
| double     | integer       | double  | double  | double     |
| double     | integer       | double  | integer | double     |
| double     | integer       | double  | long    | double     |
| double     | integer       | integer | double  | double     |
| double     | integer       | integer | integer | double     |
| double     | integer       | integer | long    | double     |
| double     | integer       | long    | double  | double     |
| double     | integer       | long    | integer | double     |
| double     | integer       | long    | long    | double     |
| double     | integer       |         |         | double     |
| double     | long          |         |         | double     |
| integer    | double        |         |         | double     |
| integer    | integer       | double  | double  | double     |
| integer    | integer       | double  | integer | double     |
| integer    | integer       | double  | long    | double     |
| integer    | integer       | integer | double  | double     |
| integer    | integer       | integer | integer | double     |
| integer    | integer       | integer | long    | double     |
| integer    | integer       | long    | double  | double     |
| integer    | integer       | long    | integer | double     |
| integer    | integer       | long    | long    | double     |
| integer    | integer       |         |         | double     |
| integer    | long          |         |         | double     |
| long       | double        |         |         | double     |
| long       | integer       | double  | double  | double     |
| long       | integer       | double  | integer | double     |
| long       | integer       | double  | long    | double     |
| long       | integer       | integer | double  | double     |
| long       | integer       | integer | integer | double     |
| long       | integer       | integer | long    | double     |
| long       | integer       | long    | double  | double     |
| long       | integer       | long    | integer | double     |
| long       | integer       | long    | long    | double     |
| long       | integer       |         |         | double     |
| long       | long          |         |         | double     |

**Examples**
`BUCKET` can work in two modes: one in which the size of the bucket is computed
based on a buckets count recommendation (four parameters) and a range, and
another in which the bucket size is provided directly (two parameters).
Using a target number of buckets, a start of a range, and an end of a range,
`BUCKET` picks an appropriate bucket size to generate the target number of buckets or fewer.
For example, asking for at most 20 buckets over a year results in monthly buckets:
```esql
FROM employees
| WHERE hire_date >= "1985-01-01T00:00:00Z" AND hire_date < "1986-01-01T00:00:00Z"
| STATS hire_date = MV_SORT(VALUES(hire_date)) BY month = BUCKET(hire_date, 20, "1985-01-01T00:00:00Z", "1986-01-01T00:00:00Z")
```


| hire_date:date                                                                 | month:date               |
|--------------------------------------------------------------------------------|--------------------------|
| [1985-02-18T00:00:00.000Z, 1985-02-24T00:00:00.000Z]                           | 1985-02-01T00:00:00.000Z |
| 1985-05-13T00:00:00.000Z                                                       | 1985-05-01T00:00:00.000Z |
| 1985-07-09T00:00:00.000Z                                                       | 1985-07-01T00:00:00.000Z |
| 1985-09-17T00:00:00.000Z                                                       | 1985-09-01T00:00:00.000Z |
| [1985-10-14T00:00:00.000Z, 1985-10-20T00:00:00.000Z]                           | 1985-10-01T00:00:00.000Z |
| [1985-11-19T00:00:00.000Z, 1985-11-20T00:00:00.000Z, 1985-11-21T00:00:00.000Z] | 1985-11-01T00:00:00.000Z |

The goal isn’t to provide **exactly** the target number of buckets,
it’s to pick a range that people are comfortable with that provides at most the target number of buckets.
Combine `BUCKET` with an [aggregation](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/aggregation-functions) to create a histogram:
```esql
FROM employees
| WHERE hire_date >= "1985-01-01T00:00:00Z" AND hire_date < "1986-01-01T00:00:00Z"
| STATS hires_per_month = COUNT(*) BY month = BUCKET(hire_date, 20, "1985-01-01T00:00:00Z", "1986-01-01T00:00:00Z")
| SORT month
```


| hires_per_month:long | month:date               |
|----------------------|--------------------------|
| 2                    | 1985-02-01T00:00:00.000Z |
| 1                    | 1985-05-01T00:00:00.000Z |
| 1                    | 1985-07-01T00:00:00.000Z |
| 1                    | 1985-09-01T00:00:00.000Z |
| 2                    | 1985-10-01T00:00:00.000Z |
| 4                    | 1985-11-01T00:00:00.000Z |

<note>
  `BUCKET` does not create buckets that don’t match any documents.
  That’s why this example is missing `1985-03-01` and other dates.
</note>

Asking for more buckets can result in a smaller range.
For example, asking for at most 100 buckets in a year results in weekly buckets:
```esql
FROM employees
| WHERE hire_date >= "1985-01-01T00:00:00Z" AND hire_date < "1986-01-01T00:00:00Z"
| STATS hires_per_week = COUNT(*) BY week = BUCKET(hire_date, 100, "1985-01-01T00:00:00Z", "1986-01-01T00:00:00Z")
```


| hires_per_week:long | week:date                |
|---------------------|--------------------------|
| 2                   | 1985-02-18T00:00:00.000Z |
| 1                   | 1985-05-13T00:00:00.000Z |
| 1                   | 1985-07-08T00:00:00.000Z |
| 1                   | 1985-09-16T00:00:00.000Z |
| 2                   | 1985-10-14T00:00:00.000Z |
| 4                   | 1985-11-18T00:00:00.000Z |

<note>
  `BUCKET` does not filter any rows. It only uses the provided range to pick a good bucket size.
  For rows with a value outside of the range, it returns a bucket value that corresponds to a bucket outside the range.
  Combine `BUCKET` with [`WHERE`](https://www.elastic.co/docs/reference/query-languages/esql/commands/where) to filter rows.
</note>

If the desired bucket size is known in advance, simply provide it as the second
argument, leaving the range out:
```esql
FROM employees
| WHERE hire_date >= "1985-01-01T00:00:00Z" AND hire_date < "1986-01-01T00:00:00Z"
| STATS hires_per_week = COUNT(*) BY week = BUCKET(hire_date, 1 week)
| SORT week
```


| hires_per_week:long | week:date                |
|---------------------|--------------------------|
| 2                   | 1985-02-18T00:00:00.000Z |
| 1                   | 1985-05-13T00:00:00.000Z |
| 1                   | 1985-07-08T00:00:00.000Z |
| 1                   | 1985-09-16T00:00:00.000Z |
| 2                   | 1985-10-14T00:00:00.000Z |
| 4                   | 1985-11-18T00:00:00.000Z |

<note>
  When providing the bucket size as the second parameter, it must be a time
  duration or date period. Also the reference is epoch, which starts at `0001-01-01T00:00:00Z`.
</note>

`BUCKET` can also operate on numeric fields. For example, to create a salary histogram:
```esql
FROM employees
| STATS COUNT(*) by bs = BUCKET(salary, 20, 25324, 74999)
| SORT bs
```


| COUNT(*):long | bs:double |
|---------------|-----------|
| 9             | 25000.0   |
| 9             | 30000.0   |
| 18            | 35000.0   |
| 11            | 40000.0   |
| 11            | 45000.0   |
| 10            | 50000.0   |
| 7             | 55000.0   |
| 9             | 60000.0   |
| 8             | 65000.0   |
| 8             | 70000.0   |

Unlike the earlier example that intentionally filters on a date range, you rarely want to filter on a numeric range.
You have to find the `min` and `max` separately. ES|QL doesn’t yet have an easy way to do that automatically.
The range can be omitted if the desired bucket size is known in advance. Simply
provide it as the second argument:
```esql
FROM employees
| WHERE hire_date >= "1985-01-01T00:00:00Z" AND hire_date < "1986-01-01T00:00:00Z"
| STATS c = COUNT(1) BY b = BUCKET(salary, 5000.)
| SORT b
```


| c:long | b:double |
|--------|----------|
| 1      | 25000.0  |
| 1      | 30000.0  |
| 1      | 40000.0  |
| 2      | 45000.0  |
| 2      | 50000.0  |
| 1      | 55000.0  |
| 1      | 60000.0  |
| 1      | 65000.0  |
| 1      | 70000.0  |

Create hourly buckets for the last 24 hours, and calculate the number of events per hour:
```esql
FROM sample_data
| WHERE @timestamp >= NOW() - 1 day and @timestamp < NOW()
| STATS COUNT(*) BY bucket = BUCKET(@timestamp, 25, NOW() - 1 day, NOW())
```


| COUNT(*):long | bucket:date |
|---------------|-------------|

Create monthly buckets for the year 1985, and calculate the average salary by hiring month
```esql
FROM employees
| WHERE hire_date >= "1985-01-01T00:00:00Z" AND hire_date < "1986-01-01T00:00:00Z"
| STATS AVG(salary) BY bucket = BUCKET(hire_date, 20, "1985-01-01T00:00:00Z", "1986-01-01T00:00:00Z")
```


| AVG(salary):double | bucket:date              |
|--------------------|--------------------------|
| 46305.0            | 1985-02-01T00:00:00.000Z |
| 44817.0            | 1985-05-01T00:00:00.000Z |
| 62405.0            | 1985-07-01T00:00:00.000Z |
| 49095.0            | 1985-09-01T00:00:00.000Z |
| 51532.0            | 1985-10-01T00:00:00.000Z |
| 54539.75           | 1985-11-01T00:00:00.000Z |

`BUCKET` may be used in both the aggregating and grouping part of the
[STATS ... BY ...](https://www.elastic.co/docs/reference/query-languages/esql/commands/stats-by) command provided that in the aggregating
part the function is referenced by an alias defined in the
grouping part, or that it is invoked with the exact same expression:
```esql
FROM employees
| STATS s1 = b1 + 1, s2 = BUCKET(salary / 1000 + 999, 50.) + 2 BY b1 = BUCKET(salary / 100 + 99, 50.), b2 = BUCKET(salary / 1000 + 999, 50.)
| SORT b1, b2
| KEEP s1, b1, s2, b2
```


| s1:double | b1:double | s2:double | b2:double |
|-----------|-----------|-----------|-----------|
| 351.0     | 350.0     | 1002.0    | 1000.0    |
| 401.0     | 400.0     | 1002.0    | 1000.0    |
| 451.0     | 450.0     | 1002.0    | 1000.0    |
| 501.0     | 500.0     | 1002.0    | 1000.0    |
| 551.0     | 550.0     | 1002.0    | 1000.0    |
| 601.0     | 600.0     | 1002.0    | 1000.0    |
| 601.0     | 600.0     | 1052.0    | 1050.0    |
| 651.0     | 650.0     | 1052.0    | 1050.0    |
| 701.0     | 700.0     | 1052.0    | 1050.0    |
| 751.0     | 750.0     | 1052.0    | 1050.0    |
| 801.0     | 800.0     | 1052.0    | 1050.0    |

Sometimes you need to change the start value of each bucket by a given duration (similar to date histogram
aggregation’s [`offset`](https://www.elastic.co/docs/reference/aggregations/search-aggregations-bucket-histogram-aggregation) parameter). To do so, you will need to
take into account how the language handles expressions within the `STATS` command: if these contain functions or
arithmetic operators, a virtual `EVAL` is inserted before and/or after the `STATS` command. Consequently, a double
compensation is needed to adjust the bucketed date value before the aggregation and then again after. For instance,
inserting a negative offset of `1 hour` to buckets of `1 year` looks like this:
```esql
FROM employees
| STATS dates = MV_SORT(VALUES(birth_date)) BY b = BUCKET(birth_date + 1 HOUR, 1 YEAR) - 1 HOUR
| EVAL d_count = MV_COUNT(dates)
```


| dates:date                                                                                               | b:date                   | d_count:integer |
|----------------------------------------------------------------------------------------------------------|--------------------------|-----------------|
| 1965-01-03T00:00:00.000Z                                                                                 | 1964-12-31T23:00:00.000Z | 1               |
| [1955-01-21T00:00:00.000Z, 1955-08-20T00:00:00.000Z, 1955-08-28T00:00:00.000Z, 1955-10-04T00:00:00.000Z] | 1954-12-31T23:00:00.000Z | 4               |
| [1957-04-04T00:00:00.000Z, 1957-05-23T00:00:00.000Z, 1957-05-25T00:00:00.000Z, 1957-12-03T00:00:00.000Z] | 1956-12-31T23:00:00.000Z | 4               |


## `TBUCKET`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/tbucket.svg)

**Parameters**
<definitions>
  <definition term="buckets">
    Desired bucket size.
  </definition>
</definitions>

**Description**
Creates groups of values - buckets - out of a @timestamp attribute. The size of the buckets must be provided directly.
**Supported types**

| buckets       | result     |
|---------------|------------|
| date_period   | date       |
| date_period   | date_nanos |
| time_duration | date       |
| time_duration | date_nanos |

**Examples**
Provide a bucket size as an argument.
```esql
FROM sample_data
| STATS min = MIN(@timestamp), max = MAX(@timestamp) BY bucket = TBUCKET(1 hour)
| SORT min
```


| min:datetime             | max:datetime             | bucket:datetime          |
|--------------------------|--------------------------|--------------------------|
| 2023-10-23T12:15:03.360Z | 2023-10-23T12:27:28.948Z | 2023-10-23T12:00:00.000Z |
| 2023-10-23T13:33:34.937Z | 2023-10-23T13:55:01.543Z | 2023-10-23T13:00:00.000Z |

<note>
  When providing the bucket size, it must be a time duration or date period.
  Also the reference is epoch, which starts at `0001-01-01T00:00:00Z`.
</note>

Provide a string representation of bucket size as an argument.
```esql
FROM sample_data
| STATS min = MIN(@timestamp), max = MAX(@timestamp) BY bucket = TBUCKET("1 hour")
| SORT min
```


| min:datetime             | max:datetime             | bucket:datetime          |
|--------------------------|--------------------------|--------------------------|
| 2023-10-23T12:15:03.360Z | 2023-10-23T12:27:28.948Z | 2023-10-23T12:00:00.000Z |
| 2023-10-23T13:33:34.937Z | 2023-10-23T13:55:01.543Z | 2023-10-23T13:00:00.000Z |

<note>
  When providing the bucket size, it can be a string representation of time duration or date period.
  For example, "1 hour". Also the reference is epoch, which starts at `0001-01-01T00:00:00Z`.
</note>

<note>
  The `CATEGORIZE` function requires a [platinum license](https://www.elastic.co/subscriptions).
</note>


## `CATEGORIZE`

<applies-to>
  - Elastic Stack: Generally available since 9.1
  - Elastic Stack: Preview in 9.0
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/categorize.svg)

**Parameters**
<definitions>
  <definition term="field">
    Expression to categorize
  </definition>
  <definition term="options">
    (Optional) Categorize additional options as [function named parameters](/docs/reference/query-languages/esql/esql-syntax#esql-function-named-params). <applies-to>Elastic Stack: Generally available since 9.2</applies-to>}
  </definition>
</definitions>

**Description**
Groups text messages into categories of similarly formatted text values.
`CATEGORIZE` has the following limitations:
- can’t be used within other expressions
- can’t be used more than once in the groupings
- can’t be used or referenced within aggregate functions and it has to be the first grouping

**Supported types**

| field   | options | result  |
|---------|---------|---------|
| keyword |         | keyword |
| text    |         | keyword |

**Supported function named parameters**
<definitions>
  <definition term="output_format">
    (keyword) The output format of the categories. Defaults to regex.
  </definition>
  <definition term="similarity_threshold">
    (integer) The minimum percentage of token weight that must match for text to be added to the category bucket. Must be between 1 and 100. The larger the value the narrower the categories. Larger values will increase memory usage and create narrower categories. Defaults to 70.
  </definition>
  <definition term="analyzer">
    (keyword) Analyzer used to convert the field into tokens for text categorization.
  </definition>
</definitions>

**Example**
This example categorizes server logs messages into categories and aggregates their counts.
```esql
FROM sample_data
| STATS count=COUNT() BY category=CATEGORIZE(message)
```


| count:long | category:keyword         |
|------------|--------------------------|
| 3          | .*?Connected.+?to.*?     |
| 3          | .*?Connection.+?error.*? |
| 1          | .*?Disconnected.*?       |﻿---
title: Join data from multiple indices with LOOKUP JOIN
description: The ES|QL LOOKUP JOIN processing command combines data from your ES|QL query results table with matching records from a specified lookup index. It adds...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-lookup-join
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available since 9.1, Preview in 9.0
---

# Join data from multiple indices with LOOKUP JOIN
The ES|QL [`LOOKUP JOIN`](https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join) processing command combines data from your ES|QL query results table with matching records from a specified lookup index. It adds fields from the lookup index as new columns to your results table based on matching values in the join field.
Teams often have data scattered across multiple indices – like logs, IPs, user IDs, hosts, employees etc. Without a direct way to enrich or correlate each event with reference data, root-cause analysis, security checks, and operational insights become time-consuming.
For example, you can use `LOOKUP JOIN` to:
- Retrieve environment or ownership details for each host to correlate your metrics data.
- Quickly see if any source IPs match known malicious addresses.
- Tag logs with the owning team or escalation info for faster triage and incident response.


## Compare with `ENRICH`

[`LOOKUP JOIN`](https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join) is similar to [`ENRICH`](https://www.elastic.co/docs/reference/query-languages/esql/commands/enrich) in the fact that they both help you join data together. You should use `LOOKUP JOIN` when:
- Your enrichment data changes frequently
- You want to avoid index-time processing
- You want SQL-like behavior, so that multiple matches result in multiple rows
- You need to match on any field in a lookup index
- You use document or field level security
- You want to restrict users to use only specific lookup indices
- You do not need to match using ranges or spatial relations


## Syntax reference

Refer to [`LOOKUP JOIN`](https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join) for the detailed syntax reference.

## How the command works

The `LOOKUP JOIN` command adds fields from the lookup index as new columns to your results table based on matching values in the join field.
The command requires two parameters:
- The name of the lookup index (which must have the `lookup` [`index.mode setting`](/docs/reference/elasticsearch/index-settings/index-modules#index-mode-setting))
- The join condition. Can be one of the following:
  - A single field name
- A comma-separated list of field names <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
- An expression with one or more join conditions linked by `AND`. <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
- An expression that includes [Full Text Functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/search-functions) and other Lucene pushable functions applied to fields from the lookup index <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>

```esql
LOOKUP JOIN <lookup_index> ON <field_name> 
LOOKUP JOIN <lookup_index> ON <field_name1>, <field_name2>, <field_name3> 
LOOKUP JOIN <lookup_index> ON <left_field1> >= <lookup_field1> AND <left_field2> == <lookup_field2> 
LOOKUP JOIN <lookup_index> ON MATCH(lookup_field, "search term") AND <left_field> == <lookup_field> 
```

![Illustration of the `LOOKUP JOIN` command, where the input table is joined with a lookup index to create an enriched output table.](https://www.elastic.co/docs/reference/query-languages/images/esql-lookup-join.png)

If you're familiar with SQL, `LOOKUP JOIN` has left-join behavior. This means that if no rows match in the lookup index, the incoming row is retained and `null`s are added. If many rows in the lookup index match, `LOOKUP JOIN` adds one row per match.

### Cross-cluster support

<applies-to>Elastic Stack: Generally available since 9.2</applies-to> Remote lookup joins are supported in [cross-cluster queries](https://www.elastic.co/docs/reference/query-languages/esql/esql-cross-clusters). The lookup index must exist on _all_ remote clusters being queried, because each cluster uses its local lookup index data. This follows the same pattern as [remote mode Enrich](/docs/reference/query-languages/esql/esql-cross-clusters#esql-enrich-remote).
```esql
FROM log-cluster-*:logs-* | LOOKUP JOIN hosts ON source.ip
```


## Example

You can run this example for yourself if you'd like to see how it works, by setting up the indices and adding sample data.

### Sample data

<dropdown title="Expand for setup instructions">
  **Set up indices**First let's create two indices with mappings: `threat_list` and `firewall_logs`.
  ```json

  {
    "settings": {
      "index.mode": "lookup" <1>
    },
    "mappings": {
      "properties": {
        "source.ip": { "type": "ip" },
        "threat_level": { "type": "keyword" },
        "threat_type": { "type": "keyword" },
        "last_updated": { "type": "date" }
      }
    }
  }
  ```

  ```json

  {
    "mappings": {
      "properties": {
        "timestamp": { "type": "date" },
        "source.ip": { "type": "ip" },
        "destination.ip": { "type": "ip" },
        "action": { "type": "keyword" },
        "bytes_transferred": { "type": "long" }
      }
    }
  }
  ```
  **Add sample data**Next, let's add some sample data to both indices. The `threat_list` index contains known malicious IPs, while the `firewall_logs` index contains logs of network traffic.
  ```json

  {"index":{}}
  {"source.ip":"203.0.113.5","threat_level":"high","threat_type":"C2_SERVER","last_updated":"2025-04-22"}
  {"index":{}}
  {"source.ip":"198.51.100.2","threat_level":"medium","threat_type":"SCANNER","last_updated":"2025-04-23"}
  ```

  ```json

  {"index":{}}
  {"timestamp":"2025-04-23T10:00:01Z","source.ip":"192.0.2.1","destination.ip":"10.0.0.100","action":"allow","bytes_transferred":1024}
  {"index":{}}
  {"timestamp":"2025-04-23T10:00:05Z","source.ip":"203.0.113.5","destination.ip":"10.0.0.55","action":"allow","bytes_transferred":2048}
  {"index":{}}
  {"timestamp":"2025-04-23T10:00:08Z","source.ip":"198.51.100.2","destination.ip":"10.0.0.200","action":"block","bytes_transferred":0}
  {"index":{}}
  {"timestamp":"2025-04-23T10:00:15Z","source.ip":"203.0.113.5","destination.ip":"10.0.0.44","action":"allow","bytes_transferred":4096}
  {"index":{}}
  {"timestamp":"2025-04-23T10:00:30Z","source.ip":"192.0.2.1","destination.ip":"10.0.0.100","action":"allow","bytes_transferred":512}
  ```
</dropdown>


### Query the data

```esql
FROM firewall_logs
| LOOKUP JOIN threat_list ON source.ip
| WHERE threat_level IS NOT NULL
| SORT timestamp
| KEEP source.ip, action, threat_type, threat_level
| LIMIT 10
```


### Response

A successful query will output a table. In this example, you can see that the `source.ip` field from the `firewall_logs` index is matched with the `source.ip` field in the `threat_list` index, and the corresponding `threat_level` and `threat_type` fields are added to the output.

| source.ip    | action | threat_type | threat_level |
|--------------|--------|-------------|--------------|
| 203.0.113.5  | allow  | C2_SERVER   | high         |
| 198.51.100.2 | block  | SCANNER     | medium       |
| 203.0.113.5  | allow  | C2_SERVER   | high         |


### Additional examples

Refer to the examples section of the [`LOOKUP JOIN`](https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join) command reference for more examples.

## Prerequisites


### Index configuration

Indices used for lookups must be configured with the [`lookup` index mode](/docs/reference/elasticsearch/index-settings/index-modules#index-mode-setting).

### Data type compatibility

Join keys must have compatible data types between the source and lookup indices. Types within the same compatibility group can be joined together:

| Compatibility group    | Types                                                                               | Notes                                                                            |
|------------------------|-------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| **Numeric family**     | `byte`, `short`, `integer`, `long`, `half_float`, `float`, `scaled_float`, `double` | All compatible                                                                   |
| **Keyword family**     | `keyword`, `text.keyword`                                                           | Text fields only as join key on left-hand side and must have `.keyword` subfield |
| **Date (Exact)**       | `date`                                                                              | Must match exactly                                                               |
| **Date Nanos (Exact)** | `date_nanos`                                                                        | Must match exactly                                                               |
| **Boolean**            | `boolean`                                                                           | Must match exactly                                                               |

<tip>
  To obtain a join key with a compatible type, use a [conversion function](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions) if needed.
</tip>


### Unsupported Types

In addition to the [ES|QL unsupported field types](/docs/reference/query-languages/esql/limitations#_unsupported_types), `LOOKUP JOIN` does not support:
- `VERSION`
- `UNSIGNED_LONG`
- Spatial types like `GEO_POINT`, `GEO_SHAPE`
- Temporal intervals like `DURATION`, `PERIOD`

<note>
  For a complete list of all types supported in `LOOKUP JOIN`, refer to the [`LOOKUP JOIN` supported types table](https://www.elastic.co/docs/reference/query-languages/esql/commands/lookup-join).
</note>


## Usage notes

This section covers important details about `LOOKUP JOIN` that impact query behavior and results. Review these details to ensure your queries work as expected and to troubleshoot unexpected results.

### Handling name collisions

When fields from the lookup index match existing column names, the new columns override the existing ones.
Before the `LOOKUP JOIN` command, preserve columns by either:
- Using `RENAME` to assign non-conflicting names
- Using `EVAL` to create new columns with different names


### Sorting behavior

The output rows produced by `LOOKUP JOIN` can be in any order and may not
respect preceding `SORT`s. To guarantee a certain ordering, place a `SORT` after
any `LOOKUP JOIN`s.

## Limitations

The following are the current limitations with `LOOKUP JOIN`:
- Indices in [`lookup` mode](/docs/reference/elasticsearch/index-settings/index-modules#index-mode-setting) are always single-sharded.
- Cross cluster search is unsupported in versions prior to `9.2.0`. Both source and lookup indices must be local for these versions.
- Currently, only matching on equality is supported.
- In Stack versions `9.0-9.1`,`LOOKUP JOIN` can only use a single match field and a single index. Wildcards are not supported.
  - Aliases, datemath, and datastreams are supported, as long as the index pattern matches a single concrete index <applies-to>Elastic Stack: Generally available since 9.1</applies-to>.
- The name of the match field in `LOOKUP JOIN lu_idx ON match_field` must match an existing field in the query. This may require `RENAME`s or `EVAL`s to achieve.
- The query will circuit break if there are too many matching documents in the lookup index, or if the documents are too large. More precisely, `LOOKUP JOIN` works in batches of, normally, about 10,000 rows; a large amount of heap space is needed if the matching documents from the lookup index for a batch are multiple megabytes or larger. This is roughly the same as for `ENRICH`.
- Cross-cluster `LOOKUP JOIN` can not be used after aggregations (`STATS`), `SORT` and `LIMIT` commands, and coordinator-side `ENRICH` commands.﻿---
title: ES|QL functions and operators
description: ES|QL provides a comprehensive set of functions and operators for working with data. The reference documentation is divided into the following categories:...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-functions-operators
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL functions and operators
ES|QL provides a comprehensive set of functions and operators for working with data. The reference documentation is divided into the following categories:

## Functions overview

<dropdown title="Aggregate functions">
  - [`ABSENT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-absent) <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
  - [`AVG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-avg)
  - [`COUNT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-count)
  - [`COUNT_DISTINCT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-count_distinct)
  - [`MAX`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-max)
  - [`MEDIAN`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-median)
  - [`MEDIAN_ABSOLUTE_DEVIATION`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-median_absolute_deviation)
  - [`MIN`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-min)
  - [`PERCENTILE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-percentile)
  - [`PRESENT`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-present) <applies-to>Elastic Stack: Generally available since 9.2</applies-to>
  - [`SAMPLE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-sample)
  - [`ST_CENTROID_AGG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-st_centroid_agg) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_EXTENT_AGG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-st_extent_agg) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`STD_DEV`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-std_dev)
  - [`SUM`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-sum)
  - [`TOP`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-top)
  - [`VALUES`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-values) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`VARIANCE`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-variance)
  - [`WEIGHTED_AVG`](/docs/reference/query-languages/esql/functions-operators/aggregation-functions#esql-weighted_avg)
</dropdown>

<dropdown title="Time-series aggregate functions">
  - [`ABSENT_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-absent_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`AVG_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-avg_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`COUNT_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-count_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`COUNT_DISTINCT_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-count_distinct_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`DELTA`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-delta) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`DERIV`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-deriv) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`FIRST_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-first_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`IDELTA`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-idelta) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`INCREASE`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-increase) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`IRATE`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-irate) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`LAST_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-last_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`MAX_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-max_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`MIN_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-min_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`PERCENTILE_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-percentile_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`PRESENT_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-present_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`RATE`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-rate) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`STDDEV_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-stddev_over_time) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`SUM_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-sum_over_time) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`VARIANCE_OVER_TIME`](/docs/reference/query-languages/esql/functions-operators/time-series-aggregation-functions#esql-variance_over_time) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
</dropdown>

<dropdown title="Grouping functions">
  - [`BUCKET`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-bucket)
  - [`TBUCKET`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-tbucket)
  - [`CATEGORIZE`](/docs/reference/query-languages/esql/functions-operators/grouping-functions#esql-categorize)
</dropdown>

<dropdown title="Conditional functions and expressions">
  - [`CASE`](/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions#esql-case)
  - [`COALESCE`](/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions#esql-coalesce)
  - [`GREATEST`](/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions#esql-greatest)
  - [`LEAST`](/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions#esql-least)
  - [`CLAMP`](/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions#esql-clamp) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`CLAMP_MIN`](/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions#esql-clamp_min) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`CLAMP_MAX`](/docs/reference/query-languages/esql/functions-operators/conditional-functions-and-expressions#esql-clamp_max) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
</dropdown>

<dropdown title="Date and time functions">
  - [`DATE_DIFF`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-date_diff)
  - [`DATE_EXTRACT`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-date_extract)
  - [`DATE_FORMAT`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-date_format)
  - [`DATE_PARSE`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-date_parse)
  - [`DATE_TRUNC`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-date_trunc)
  - [`DAY_NAME`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-day_name)
  - [`MONTH_NAME`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-month_name)
  - [`NOW`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-now)
  - [`TRANGE`](/docs/reference/query-languages/esql/functions-operators/date-time-functions#esql-trange)
</dropdown>

<dropdown title="IP functions">
  - [`CIDR_MATCH`](/docs/reference/query-languages/esql/functions-operators/ip-functions#esql-cidr_match)
  - [`IP_PREFIX`](/docs/reference/query-languages/esql/functions-operators/ip-functions#esql-ip_prefix)
</dropdown>

<dropdown title="Math functions">
  - [`ABS`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-abs)
  - [`ACOS`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-acos)
  - [`ASIN`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-asin)
  - [`ATAN`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-atan)
  - [`ATAN2`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-atan2)
  - [`CBRT`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-cbrt)
  - [`CEIL`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-ceil)
  - [`COPY_SIGN`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-copy_sign)
  - [`COS`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-cos)
  - [`COSH`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-cosh)
  - [`E`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-e)
  - [`EXP`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-exp)
  - [`FLOOR`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-floor)
  - [`HYPOT`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-hypot)
  - [`LOG`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-log)
  - [`LOG10`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-log10)
  - [`PI`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-pi)
  - [`POW`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-pow)
  - [`ROUND`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-round)
  - [`ROUND_TO`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-round_to)
  - [`SCALB`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-scalb)
  - [`SIGNUM`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-signum)
  - [`SIN`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-sin)
  - [`SINH`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-sinh)
  - [`SQRT`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-sqrt)
  - [`TAN`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-tan)
  - [`TANH`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-tanh)
  - [`TAU`](/docs/reference/query-languages/esql/functions-operators/math-functions#esql-tau)
</dropdown>

<dropdown title="Search functions">
  - [`DECAY`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-decay) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`KQL`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-kql)
  - [`MATCH`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match)
  - [`MATCH_PHRASE`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-match_phrase)
  - [`QSTR`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-qstr)
  - [`SCORE`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-score) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>

  - [`TOP_SNIPPETS`](/docs/reference/query-languages/esql/functions-operators/search-functions#esql-top_snippets) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
</dropdown>

<dropdown title="Spatial functions">
  - Geospatial predicates
    - [`ST_DISTANCE`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_distance)
  - [`ST_INTERSECTS`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_intersects)
  - [`ST_DISJOINT`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_disjoint)
  - [`ST_CONTAINS`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_contains)
  - [`ST_WITHIN`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_within)
  - Geometry functions
    - [`ST_X`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_x)
  - [`ST_Y`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_y)
  - [`ST_NPOINTS`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_npoints) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_SIMPLIFY`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_simplify) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_ENVELOPE`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_envelope) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
    - [`ST_XMAX`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_xmax) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_XMIN`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_xmin) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_YMAX`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_ymax) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_YMIN`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_ymin) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - Grid encoding functions
    - [`ST_GEOTILE`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_geotile) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_GEOHEX`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_geohex) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`ST_GEOHASH`](/docs/reference/query-languages/esql/functions-operators/spatial-functions#esql-st_geohash) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
</dropdown>

<dropdown title="String functions">
  - [`BIT_LENGTH`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-bit_length)
  - [`BYTE_LENGTH`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-byte_length)
  - [`CHUNK`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-chunk)
  - [`CONCAT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-concat)
  - [`CONTAINS`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-contains)
  - [`ENDS_WITH`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-ends_with)
  - [`FROM_BASE64`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-from_base64)
  - [`HASH`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-hash)
  - [`LEFT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-left)
  - [`LENGTH`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-length)
  - [`LOCATE`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-locate)
  - [`LTRIM`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-ltrim)
  - [`MD5`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-md5)
  - [`REPEAT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-repeat)
  - [`REPLACE`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-replace)
  - [`REVERSE`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-reverse)
  - [`RIGHT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-right)
  - [`RTRIM`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-rtrim)
  - [`SHA1`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-sha1)
  - [`SHA256`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-sha256)
  - [`SPACE`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-space)
  - [`SPLIT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-split)
  - [`STARTS_WITH`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-starts_with)
  - [`SUBSTRING`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-substring)
  - [`TO_BASE64`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-to_base64)
  - [`TO_LOWER`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-to_lower)
  - [`TO_UPPER`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-to_upper)
  - [`TRIM`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-trim)
  - [`URL_ENCODE`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-url_encode)
  - [`URL_ENCODE_COMPONENT`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-url_encode_component)
  - [`URL_DECODE`](/docs/reference/query-languages/esql/functions-operators/string-functions#esql-url_decode)
</dropdown>

<dropdown title="Type conversion functions">
  - [`TO_AGGREGATE_METRIC_DOUBLE`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_aggregate_metric_double) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`TO_BOOLEAN`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_boolean)
  - [`TO_CARTESIANPOINT`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_cartesianpoint)
  - [`TO_CARTESIANSHAPE`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_cartesianshape)
  - [`TO_DATEPERIOD`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_dateperiod)
  - [`TO_DATETIME`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_datetime)
  - [`TO_DATE_NANOS`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_date_nanos)
  - [`TO_DEGREES`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_degrees)
  - [`TO_DENSE_VECTOR`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_dense_vector) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`TO_DOUBLE`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_double)
  - [`TO_GEOHASH`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_geohash) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`TO_GEOHEX`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_geohex) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`TO_GEOPOINT`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_geopoint)
  - [`TO_GEOSHAPE`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_geoshape)
  - [`TO_GEOTILE`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_geotile) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`TO_INTEGER`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_integer)
  - [`TO_IP`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_ip)
  - [`TO_LONG`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_long)
  - [`TO_RADIANS`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_radians)
  - [`TO_STRING`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_string)
  - [`TO_TIMEDURATION`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_timeduration)
  - [`TO_UNSIGNED_LONG`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_unsigned_long) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`TO_VERSION`](/docs/reference/query-languages/esql/functions-operators/type-conversion-functions#esql-to_version)
</dropdown>

<dropdown title="Dense vector functions">
  - [`KNN`](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-knn) <applies-to>Elastic Stack: Preview since 9.2</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`TEXT_EMBEDDING`](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-text_embedding) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`V_COSINE`](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-v_cosine) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`V_DOT_PRODUCT`](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-v_dot_product) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`V_HAMMING`](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-v_hamming) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`V_L1_NORM`](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-v_l1_norm) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`V_L2_NORM`](/docs/reference/query-languages/esql/functions-operators/dense-vector-functions#esql-v_l2_norm) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
</dropdown>

<dropdown title="Multi value functions">
  - [`MV_APPEND`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_append)
  - [`MV_AVG`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_avg)
  - [`MV_CONCAT`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_concat)
  - [`MV_CONTAINS`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_contains) <applies-to>Elastic Stack: Preview in 9.0+</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`MV_COUNT`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_count)
  - [`MV_DEDUPE`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_dedupe)
  - [`MV_FIRST`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_first)
  - [`MV_INTERSECTION`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_intersection) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`MV_LAST`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_last)
  - [`MV_MAX`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_max)
  - [`MV_MEDIAN`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_median)
  - [`MV_MEDIAN_ABSOLUTE_DEVIATION`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_median_absolute_deviation)
  - [`MV_MIN`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_min)
  - [`MV_PERCENTILE`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_percentile)
  - [`MV_PSERIES_WEIGHTED_SUM`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_pseries_weighted_sum)
  - [`MV_SORT`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_sort)
  - [`MV_SLICE`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_slice)
  - [`MV_SUM`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_sum)
  - [`MV_UNION`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_union) <applies-to>Elastic Stack: Planned</applies-to> <applies-to>Elastic Cloud Serverless: Preview</applies-to>
  - [`MV_ZIP`](/docs/reference/query-languages/esql/functions-operators/mv-functions#esql-mv_zip)
</dropdown>


## Operators overview

<dropdown title="Operators">
  - [Binary operators](/docs/reference/query-languages/esql/functions-operators/operators#esql-binary-operators)
  - [Unary operators](/docs/reference/query-languages/esql/functions-operators/operators#esql-unary-operators)
  - [Logical operators](/docs/reference/query-languages/esql/functions-operators/operators#esql-logical-operators)
  - [suffix operators](/docs/reference/query-languages/esql/functions-operators/operators#esql-suffix-operators)
  - [infix operators](/docs/reference/query-languages/esql/functions-operators/operators#esql-infix-operators)
</dropdown>﻿---
title: Extract data from unstructured text with DISSECT and GROK
description: Your data may contain unstructured strings that you want to structure. This makes it easier to analyze the data. For example, log messages may contain...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-process-data-with-dissect-grok
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Extract data from unstructured text with DISSECT and GROK
Your data may contain unstructured strings that you want to structure. This makes it easier to analyze the data. For example, log messages may contain IP addresses that you want to extract so you can find the most active IP addresses.
![unstructured data](https://www.elastic.co/docs/reference/query-languages/images/unstructured-data.png)

Elasticsearch can structure your data at index time or query time. At index time, you can use the [Dissect](https://www.elastic.co/docs/reference/enrich-processor/dissect-processor) and [Grok](https://www.elastic.co/docs/reference/enrich-processor/grok-processor) ingest processors, or the Logstash [Dissect](https://www.elastic.co/docs/reference/logstash/plugins/plugins-filters-dissect) and [Grok](https://www.elastic.co/docs/reference/logstash/plugins/plugins-filters-grok) filters. At query time, you can use the ES|QL [`DISSECT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/dissect) and [`GROK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/grok) commands.

## `DISSECT` or `GROK`? Or both?

`DISSECT` works by breaking up a string using a delimiter-based pattern. `GROK` works similarly, but uses regular expressions. This makes `GROK` more powerful, but generally also slower. `DISSECT` works well when data is reliably repeated. `GROK` is a better choice when you really need the power of regular expressions, for example when the structure of your text varies from row to row.
You can use both `DISSECT` and `GROK` for hybrid use cases. For example when a section of the line is reliably repeated, but the entire line is not. `DISSECT` can deconstruct the section of the line that is repeated. `GROK` can process the remaining field values using regular expressions.

## Process data with `DISSECT`

The [`DISSECT`](https://www.elastic.co/docs/reference/query-languages/esql/commands/dissect) processing command matches a string against a delimiter-based pattern, and extracts the specified keys as columns.
For example, the following pattern:
```txt
%{clientip} [%{@timestamp}] %{status}
```

matches a log line of this format:
```txt
1.2.3.4 [2023-01-23T12:15:00.000Z] Connected
```

and results in adding the following columns to the input table:

| clientip:keyword | @timestamp:keyword       | status:keyword |
|------------------|--------------------------|----------------|
| 1.2.3.4          | 2023-01-23T12:15:00.000Z | Connected      |


### Dissect patterns

A dissect pattern is defined by the parts of the string that will be discarded. In the previous example, the first part to be discarded is a single space. Dissect finds this space, then assigns the value of `clientip` everything up until that space. Next, dissect matches the `[` and then `]` and then assigns `@timestamp` to everything in-between `[` and `]`. Paying special attention to the parts of the string to discard will help build successful dissect patterns.
An empty key (`%{}`) or [named skip key](#esql-named-skip-key) can be used to match values, but exclude the value from the output.
All matched values are output as keyword string data types. Use the [Type conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions) to convert to another data type.
Dissect also supports [key modifiers](#esql-dissect-key-modifiers) that can change dissect’s default behavior. For example, you can instruct dissect to ignore certain fields, append fields, skip over padding, etc.

### Terminology

<definitions>
  <definition term="dissect pattern">
    the set of fields and delimiters describing the textual format. Also known as a dissection. The dissection is described using a set of `%{}` sections: `%{{a}} - %{{b}} - %{{c}}`
  </definition>
  <definition term="field">
    the text from `%{` to `}` inclusive.
  </definition>
  <definition term="delimiter">
    the text between `}` and the next `%{` characters. Any set of characters other than `%{`, `'not }'`, or `}` is a delimiter.
  </definition>
  <definition term="key">
    the text between the `%{` and `}`, exclusive of the `?`, `+`, `&` prefixes and the ordinal suffix.
  </definition>
</definitions>

Examples:
- `%{?aaa}` - the key is `aaa`
- `%{+bbb/3}` - the key is `bbb`
- `%{&ccc}` - the key is `ccc`


### Examples

The following example parses a string that contains a timestamp, some text, and an IP address:
```esql
ROW a = "2023-01-23T12:15:00.000Z - some text - 127.0.0.1"
| DISSECT a """%{date} - %{msg} - %{ip}"""
| KEEP date, msg, ip
```


| date:keyword             | msg:keyword | ip:keyword |
|--------------------------|-------------|------------|
| 2023-01-23T12:15:00.000Z | some text   | 127.0.0.1  |

By default, `DISSECT` outputs keyword string columns. To convert to another type, use [Type conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions):
```esql
ROW a = "2023-01-23T12:15:00.000Z - some text - 127.0.0.1"
| DISSECT a """%{date} - %{msg} - %{ip}"""
| KEEP date, msg, ip
| EVAL date = TO_DATETIME(date)
```


| msg:keyword | ip:keyword | date:date                |
|-------------|------------|--------------------------|
| some text   | 127.0.0.1  | 2023-01-23T12:15:00.000Z |


### Dissect key modifiers

Key modifiers can change the default behavior for dissection. Key modifiers may be found on the left or right of the `%{{keyname}}` always inside the `%{` and `}`. For example `%{+keyname ->}` has the append and right padding modifiers.


| Modifier      | Name               | Position       | Example                       | Description                                                   | Details                                           |
|---------------|--------------------|----------------|-------------------------------|---------------------------------------------------------------|---------------------------------------------------|
| `->`          | Skip right padding | (far) right    | `%{keyname1->}`               | Skips any repeated characters to the right                    | [link](#esql-dissect-modifier-skip-right-padding) |
| `+`           | Append             | left           | `%{+keyname} %{+keyname}`     | Appends two or more fields together                           | [link](#esql-append-modifier)                     |
| `+` with `/n` | Append with order  | left and right | `%{+keyname/2} %{+keyname/1}` | Appends two or more fields together in the order specified    | [link](#esql-append-order-modifier)               |
| `?`           | Named skip key     | left           | `%{?ignoreme}`                | Skips the matched value in the output. Same behavior as `%{}` | [link](#esql-named-skip-key)                      |


#### Right padding modifier (`->`)

The algorithm that performs the dissection is very strict in that it requires all characters in the pattern to match the source string. For example, the pattern `%{{fookey}} %{{barkey}}` (1 space), will match the string "foo bar" (1 space), but will not match the string "foo  bar" (2 spaces) since the pattern has only 1 space and the source string has 2 spaces.
The right padding modifier helps with this case. Adding the right padding modifier to the pattern `%{fookey->} %{{barkey}}`, It will now will match "foo bar" (1 space) and "foo  bar" (2 spaces) and even "foo          bar" (10 spaces).
Use the right padding modifier to allow for repetition of the characters after a `%{keyname->}`.
The right padding modifier may be placed on any key with any other modifiers. It should always be the furthest right modifier. For example: `%{+keyname/1->}` and `%{->}`
For example:
```esql
ROW message="1998-08-10T17:15:42          WARN"
| DISSECT message """%{ts->} %{level}"""
```


| message:keyword                   | ts:keyword          | level:keyword |
|-----------------------------------|---------------------|---------------|
| 1998-08-10T17:15:42          WARN | 1998-08-10T17:15:42 | WARN          |

The right padding modifier may be used with an empty key to help skip unwanted data. For example, the same input string, but wrapped with brackets requires the use of an empty right padded key to achieve the same result.
For example:
```esql
ROW message="[1998-08-10T17:15:42]          [WARN]"
| DISSECT message """[%{ts}]%{->}[%{level}]"""
```


| message:keyword                           | ts:keyword          | level:keyword |
|-------------------------------------------|---------------------|---------------|
| ["[1998-08-10T17:15:42]          [WARN]"] | 1998-08-10T17:15:42 | WARN          |


#### Append modifier (`+`)

Dissect supports appending two or more results together for the output. Values are appended left to right. An append separator can be specified. In this example the append_separator is defined as a space.
```esql
ROW message="john jacob jingleheimer schmidt"
| DISSECT message """%{+name} %{+name} %{+name} %{+name}""" APPEND_SEPARATOR=" "
```


| message:keyword                 | name:keyword                    |
|---------------------------------|---------------------------------|
| john jacob jingleheimer schmidt | john jacob jingleheimer schmidt |


#### Append with order modifier (`+` and `/n`)

Dissect supports appending two or more results together for the output. Values are appended based on the order defined (`/n`). An append separator can be specified. In this example the append_separator is defined as a comma.
```esql
ROW message="john jacob jingleheimer schmidt"
| DISSECT message """%{+name/2} %{+name/4} %{+name/3} %{+name/1}""" APPEND_SEPARATOR=","
```


| message:keyword                 | name:keyword                    |
|---------------------------------|---------------------------------|
| john jacob jingleheimer schmidt | schmidt,john,jingleheimer,jacob |


#### Named skip key (`?`)

Dissect supports ignoring matches in the final result. This can be done with an empty key `%{}`, but for readability it may be desired to give that empty key a name.
This can be done with a named skip key using the `{?name}` syntax. In the following query, `ident` and `auth` are not added to the output table:
```esql
ROW message="1.2.3.4 - - 30/Apr/1998:22:00:52 +0000"
| DISSECT message """%{clientip} %{?ident} %{?auth} %{@timestamp}"""
```


| message:keyword                        | clientip:keyword | @timestamp:keyword         |
|----------------------------------------|------------------|----------------------------|
| 1.2.3.4 - - 30/Apr/1998:22:00:52 +0000 | 1.2.3.4          | 30/Apr/1998:22:00:52 +0000 |


### Limitations

The `DISSECT` command does not support reference keys.

## Process data with `GROK`

The [`GROK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/grok) processing command matches a string against a pattern based on regular expressions, and extracts the specified keys as columns.
For example, the following pattern:
```txt
%{IP:ip} \[%{TIMESTAMP_ISO8601:@timestamp}\] %{GREEDYDATA:status}
```

matches a log line of this format:
```txt
1.2.3.4 [2023-01-23T12:15:00.000Z] Connected
```

Putting it together as an ES|QL query:
```esql
ROW a = "1.2.3.4 [2023-01-23T12:15:00.000Z] Connected"
| GROK a """%{IP:ip} \[%{TIMESTAMP_ISO8601:@timestamp}\] %{GREEDYDATA:status}"""
```

`GROK` adds the following columns to the input table:

| @timestamp:keyword       | ip:keyword | status:keyword |
|--------------------------|------------|----------------|
| 2023-01-23T12:15:00.000Z | 1.2.3.4    | Connected      |

<note>
  Special regex characters in grok patterns, like `[` and `]` need to be escaped with a `\`. For example, in the earlier pattern:
  ```txt
  %{IP:ip} \[%{TIMESTAMP_ISO8601:@timestamp}\] %{GREEDYDATA:status}
  ```
  In ES|QL queries, when using single quotes for strings, the backslash character itself is a special character that needs to be escaped with another `\`. For this example, the corresponding ES|QL query becomes:
  ```esql
  ROW a = "1.2.3.4 [2023-01-23T12:15:00.000Z] Connected"
  | GROK a "%{IP:ip} \\[%{TIMESTAMP_ISO8601:@timestamp}\\] %{GREEDYDATA:status}"
  ```
  For this reason, in general it is more convenient to use triple quotes `"""` for GROK patterns, that do not require escaping for backslash.
  ```esql
  ROW a = "1.2.3.4 [2023-01-23T12:15:00.000Z] Connected"
  | GROK a """%{IP:ip} \[%{TIMESTAMP_ISO8601:@timestamp}\] %{GREEDYDATA:status}"""
  ```
</note>


### Grok patterns

The syntax for a grok pattern is `%{SYNTAX:SEMANTIC}`
The `SYNTAX` is the name of the pattern that matches your text. For example, `3.44` is matched by the `NUMBER` pattern and `55.3.244.1` is matched by the `IP` pattern. The syntax is how you match.
The `SEMANTIC` is the identifier you give to the piece of text being matched. For example, `3.44` could be the duration of an event, so you could call it simply `duration`. Further, a string `55.3.244.1` might identify the `client` making a request.
By default, matched values are output as keyword string data types. To convert a semantic’s data type, suffix it with the target data type. For example `%{NUMBER:num:int}`, which converts the `num` semantic from a string to an integer. Currently the only supported conversions are `int` and `float`. For other types, use the [Type conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions).
For an overview of the available patterns, refer to [GitHub](https://github.com/elastic/elasticsearch//blob/master/libs/grok/src/main/resources/patterns). You can also retrieve a list of all patterns using a [REST API](/docs/reference/enrich-processor/grok-processor#grok-processor-rest-get).

### Regular expressions

Grok is based on regular expressions. Any regular expressions are valid in grok as well. Grok uses the Oniguruma regular expression library. Refer to [the Oniguruma GitHub repository](https://github.com/kkos/oniguruma/blob/master/doc/RE) for the full supported regexp syntax.

### Custom patterns

If grok doesn’t have a pattern you need, you can use the Oniguruma syntax for named capture which lets you match a piece of text and save it as a column:
```txt
(?<field_name>the pattern here)
```

For example, postfix logs have a `queue id` that is a 10 or 11-character hexadecimal value. This can be captured to a column named `queue_id` with:
```txt
(?<queue_id>[0-9A-F]{10,11})
```


### Examples

The following example parses a string that contains a timestamp, an IP address, an email address, and a number:
```esql
ROW a = "2023-01-23T12:15:00.000Z 127.0.0.1 some.email@foo.com 42"
| GROK a """%{TIMESTAMP_ISO8601:date} %{IP:ip} %{EMAILADDRESS:email} %{NUMBER:num}"""
| KEEP date, ip, email, num
```


| date:keyword             | ip:keyword | email:keyword        | num:keyword |
|--------------------------|------------|----------------------|-------------|
| 2023-01-23T12:15:00.000Z | 127.0.0.1  | `some.email@foo.com` | 42          |

By default, `GROK` outputs keyword string columns. `int` and `float` types can be converted by appending `:type` to the semantics in the pattern. For example `{NUMBER:num:int}`:
```esql
ROW a = "2023-01-23T12:15:00.000Z 127.0.0.1 some.email@foo.com 42"
| GROK a """%{TIMESTAMP_ISO8601:date} %{IP:ip} %{EMAILADDRESS:email} %{NUMBER:num:int}"""
| KEEP date, ip, email, num
```


| date:keyword             | ip:keyword | email:keyword        | num:integer |
|--------------------------|------------|----------------------|-------------|
| 2023-01-23T12:15:00.000Z | 127.0.0.1  | `some.email@foo.com` | 42          |

For other type conversions, use [Type conversion functions](https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/type-conversion-functions):
```esql
ROW a = "2023-01-23T12:15:00.000Z 127.0.0.1 some.email@foo.com 42"
| GROK a """%{TIMESTAMP_ISO8601:date} %{IP:ip} %{EMAILADDRESS:email} %{NUMBER:num:int}"""
| KEEP date, ip, email, num
| EVAL date = TO_DATETIME(date)
```


| ip:keyword | email:keyword        | num:integer | date:date                |
|------------|----------------------|-------------|--------------------------|
| 127.0.0.1  | `some.email@foo.com` | 42          | 2023-01-23T12:15:00.000Z |

If a field name is used more than once, `GROK` creates a multi-valued column:
```esql
FROM addresses
| KEEP city.name, zip_code
| GROK zip_code """%{WORD:zip_parts} %{WORD:zip_parts}"""
```


| city.name:keyword | zip_code:keyword | zip_parts:keyword |
|-------------------|------------------|-------------------|
| Amsterdam         | 1016 ED          | ["1016", "ED"]    |
| San Francisco     | CA 94108         | ["CA", "94108"]   |
| Tokyo             | 100-7014         | null              |


### Grok debugger

To write and debug grok patterns, you can use the [Grok Debugger](https://www.elastic.co/docs/explore-analyze/query-filter/tools/grok-debugger). It provides a UI for testing patterns against sample data. Under the covers, it uses the same engine as the `GROK` command.

### Limitations

The `GROK` command does not support configuring [custom patterns](/docs/reference/enrich-processor/grok-processor#custom-patterns), or [multiple patterns](/docs/reference/enrich-processor/grok-processor#trace-match). The `GROK` command is not subject to [Grok watchdog settings](/docs/reference/enrich-processor/grok-processor#grok-watchdog).﻿---
title: ES|QL mathematical functions
description: ES|QL supports these mathematical functions: 
url: https://www.elastic.co/docs/reference/query-languages/esql/functions-operators/math-functions
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# ES|QL mathematical functions
ES|QL supports these mathematical functions:
- [`ABS`](#esql-abs)
- [`ACOS`](#esql-acos)
- [`ASIN`](#esql-asin)
- [`ATAN`](#esql-atan)
- [`ATAN2`](#esql-atan2)
- [`CBRT`](#esql-cbrt)
- [`CEIL`](#esql-ceil)
- [`COPY_SIGN`](#esql-copy_sign)
- [`COS`](#esql-cos)
- [`COSH`](#esql-cosh)
- [`E`](#esql-e)
- [`EXP`](#esql-exp)
- [`FLOOR`](#esql-floor)
- [`HYPOT`](#esql-hypot)
- [`LOG`](#esql-log)
- [`LOG10`](#esql-log10)
- [`PI`](#esql-pi)
- [`POW`](#esql-pow)
- [`ROUND`](#esql-round)
- [`ROUND_TO`](#esql-round_to)
- [`SCALB`](#esql-scalb)
- [`SIGNUM`](#esql-signum)
- [`SIN`](#esql-sin)
- [`SINH`](#esql-sinh)
- [`SQRT`](#esql-sqrt)
- [`TAN`](#esql-tan)
- [`TANH`](#esql-tanh)
- [`TAU`](#esql-tau)


## `ABS`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/abs.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the absolute value.
**Supported types**

| number        | result        |
|---------------|---------------|
| double        | double        |
| integer       | integer       |
| long          | long          |
| unsigned_long | unsigned_long |

**Examples**
```esql
ROW number = -1.0
| EVAL abs_number = ABS(number)
```


| number:double | abs_number:double |
|---------------|-------------------|
| -1.0          | 1.0               |

```esql
FROM employees
| KEEP first_name, last_name, height
| EVAL abs_height = ABS(0.0 - height)
```


| first_name:keyword | last_name:keyword | height:double | abs_height:double |
|--------------------|-------------------|---------------|-------------------|
| Alejandro          | McAlpine          | 1.48          | 1.48              |
| Amabile            | Gomatam           | 2.09          | 2.09              |
| Anneke             | Preusig           | 1.56          | 1.56              |


## `ACOS`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/acos.svg)

**Parameters**
<definitions>
  <definition term="number">
    Number between -1 and 1. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [arccosine](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) of `n` as an angle, expressed in radians.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=.9
| EVAL acos=ACOS(a)
```


| a:double | acos:double         |
|----------|---------------------|
| .9       | 0.45102681179626236 |


## `ASIN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/asin.svg)

**Parameters**
<definitions>
  <definition term="number">
    Number between -1 and 1. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [arcsine](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) of the input numeric expression as an angle, expressed in radians.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=.9
| EVAL asin=ASIN(a)
```


| a:double | asin:double        |
|----------|--------------------|
| .9       | 1.1197695149986342 |


## `ATAN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/atan.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [arctangent](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) of the input numeric expression as an angle, expressed in radians.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=12.9
| EVAL atan=ATAN(a)
```


| a:double | atan:double        |
|----------|--------------------|
| 12.9     | 1.4934316673669235 |


## `ATAN2`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/atan2.svg)

**Parameters**
<definitions>
  <definition term="y_coordinate">
    y coordinate. If `null`, the function returns `null`.
  </definition>
  <definition term="x_coordinate">
    x coordinate. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
The [angle](https://en.wikipedia.org/wiki/Atan2) between the positive x-axis and the ray from the origin to the point (x , y) in the Cartesian plane, expressed in radians.
**Supported types**

| y_coordinate  | x_coordinate  | result |
|---------------|---------------|--------|
| double        | double        | double |
| double        | integer       | double |
| double        | long          | double |
| double        | unsigned_long | double |
| integer       | double        | double |
| integer       | integer       | double |
| integer       | long          | double |
| integer       | unsigned_long | double |
| long          | double        | double |
| long          | integer       | double |
| long          | long          | double |
| long          | unsigned_long | double |
| unsigned_long | double        | double |
| unsigned_long | integer       | double |
| unsigned_long | long          | double |
| unsigned_long | unsigned_long | double |

**Example**
```esql
ROW y=12.9, x=.6
| EVAL atan2=ATAN2(y, x)
```


| y:double | x:double | atan2:double       |
|----------|----------|--------------------|
| 12.9     | 0.6      | 1.5243181954438936 |


## `CBRT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/cbrt.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the cube root of a number. The input can be any numeric value, the return value is always a double. Cube roots of infinities are null.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW d = 1000.0
| EVAL c = CBRT(d)
```


| d: double | c:double |
|-----------|----------|
| 1000.0    | 10.0     |


## `CEIL`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/ceil.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Round a number up to the nearest integer.
<note>
  This is a noop for `long` (including unsigned) and `integer`. For `double` this picks the closest `double` value to the integer similar to [Math.ceil](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Math.html#ceil(double)).
</note>

**Supported types**

| number        | result        |
|---------------|---------------|
| double        | double        |
| integer       | integer       |
| long          | long          |
| unsigned_long | unsigned_long |

**Example**
```esql
ROW a=1.8
| EVAL a=CEIL(a)
```


| a:double |
|----------|
| 2        |


## `COPY_SIGN`

<applies-to>
  - Elastic Stack: Generally available since 9.1
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/copy_sign.svg)

**Parameters**
<definitions>
  <definition term="magnitude">
    The expression providing the magnitude of the result. Must be a numeric type.
  </definition>
  <definition term="sign">
    The expression providing the sign of the result. Must be a numeric type.
  </definition>
</definitions>

**Description**
Returns a value with the magnitude of the first argument and the sign of the second argument. This function is similar to Java's Math.copySign(double magnitude, double sign) which is similar to `copysign` from [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754).
**Supported types**

| magnitude | sign    | result  |
|-----------|---------|---------|
| double    | double  | double  |
| double    | integer | double  |
| double    | long    | double  |
| integer   | double  | integer |
| integer   | integer | integer |
| integer   | long    | integer |
| long      | double  | long    |
| long      | integer | long    |
| long      | long    | long    |

**Example**
```esql
FROM employees
| EVAL cs1 = COPY_SIGN(salary, LEAST(salary_change))
```


| emp_no:integer | salary:integer | salary_change:double | cs1:integer |
|----------------|----------------|----------------------|-------------|
| 10001          | 57305          | 1.19                 | 57305       |
| 10002          | 56371          | [-7.23, 11.17]       | -56371      |
| 10003          | 61805          | [12.82, 14.68]       | 61805       |


## `COS`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/cos.svg)

**Parameters**
<definitions>
  <definition term="angle">
    An angle, in radians. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [cosine](https://en.wikipedia.org/wiki/Sine_and_cosine) of an angle.
**Supported types**

| angle         | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=1.8
| EVAL cos=COS(a)
```


| a:double | cos:double          |
|----------|---------------------|
| 1.8      | -0.2272020946930871 |


## `COSH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/cosh.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [hyperbolic cosine](https://en.wikipedia.org/wiki/Hyperbolic_functions) of a number.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=1.8
| EVAL cosh=COSH(a)
```


| a:double | cosh:double        |
|----------|--------------------|
| 1.8      | 3.1074731763172667 |


## `E`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/e.svg)

**Parameters**
**Description**
Returns [Euler’s number](https://en.wikipedia.org/wiki/E_(mathematical_constant)).
**Supported types**

| result |
|--------|
| double |

**Example**
```esql
ROW E()
```


| E():double        |
|-------------------|
| 2.718281828459045 |


## `EXP`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/exp.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the value of e raised to the power of the given number.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW d = 5.0
| EVAL s = EXP(d)
```


| d: double | s:double            |
|-----------|---------------------|
| 5.0       | 148.413159102576603 |


## `FLOOR`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/floor.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Round a number down to the nearest integer.
<note>
  This is a noop for `long` (including unsigned) and `integer`.
  For `double` this picks the closest `double` value to the integer
  similar to [Math.floor](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Math.html#floor(double)).
</note>

**Supported types**

| number        | result        |
|---------------|---------------|
| double        | double        |
| integer       | integer       |
| long          | long          |
| unsigned_long | unsigned_long |

**Example**
```esql
ROW a=1.8
| EVAL a=FLOOR(a)
```


| a:double |
|----------|
| 1        |


## `HYPOT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/hypot.svg)

**Parameters**
<definitions>
  <definition term="number1">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
  <definition term="number2">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the hypotenuse of two numbers. The input can be any numeric values, the return value is always a double. Hypotenuses of infinities are null.
**Supported types**

| number1       | number2       | result |
|---------------|---------------|--------|
| double        | double        | double |
| double        | integer       | double |
| double        | long          | double |
| double        | unsigned_long | double |
| integer       | double        | double |
| integer       | integer       | double |
| integer       | long          | double |
| integer       | unsigned_long | double |
| long          | double        | double |
| long          | integer       | double |
| long          | long          | double |
| long          | unsigned_long | double |
| unsigned_long | double        | double |
| unsigned_long | integer       | double |
| unsigned_long | long          | double |
| unsigned_long | unsigned_long | double |

**Example**
```esql
ROW a = 3.0, b = 4.0
| EVAL c = HYPOT(a, b)
```


| a:double | b:double | c:double |
|----------|----------|----------|
| 3.0      | 4.0      | 5.0      |


## `LOG`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/log.svg)

**Parameters**
<definitions>
  <definition term="base">
    Base of logarithm. If `null`, the function returns `null`. If not provided, this function returns the natural logarithm (base e) of a value.
  </definition>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the logarithm of a value to a base. The input can be any numeric value, the return value is always a double.  Logs of zero, negative numbers, and base of one return `null` as well as a warning.
**Supported types**

| base          | number        | result |
|---------------|---------------|--------|
| double        | double        | double |
| double        | integer       | double |
| double        | long          | double |
| double        | unsigned_long | double |
| integer       | double        | double |
| integer       | integer       | double |
| integer       | long          | double |
| integer       | unsigned_long | double |
| long          | double        | double |
| long          | integer       | double |
| long          | long          | double |
| long          | unsigned_long | double |
| unsigned_long | double        | double |
| unsigned_long | integer       | double |
| unsigned_long | long          | double |
| unsigned_long | unsigned_long | double |
|               | double        | double |
|               | integer       | double |
|               | long          | double |
|               | unsigned_long | double |

**Examples**
```esql
ROW base = 2.0, value = 8.0
| EVAL s = LOG(base, value)
```


| base: double | value: double | s:double |
|--------------|---------------|----------|
| 2.0          | 8.0           | 3.0      |

```esql
ROW value = 100
| EVAL s = LOG(value);
```


| value: integer | s:double          |
|----------------|-------------------|
| 100            | 4.605170185988092 |


## `LOG10`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/log10.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the logarithm of a value to base 10. The input can be any numeric value, the return value is always a double.  Logs of 0 and negative numbers return `null` as well as a warning.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW d = 1000.0
| EVAL s = LOG10(d)
```


| d: double | s:double |
|-----------|----------|
| 1000.0    | 3.0      |


## `PI`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/pi.svg)

**Parameters**
**Description**
Returns [Pi](https://en.wikipedia.org/wiki/Pi), the ratio of a circle’s circumference to its diameter.
**Supported types**

| result |
|--------|
| double |

**Example**
```esql
ROW PI()
```


| PI():double       |
|-------------------|
| 3.141592653589793 |


## `POW`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/pow.svg)

**Parameters**
<definitions>
  <definition term="base">
    Numeric expression for the base. If `null`, the function returns `null`.
  </definition>
  <definition term="exponent">
    Numeric expression for the exponent. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the value of `base` raised to the power of `exponent`.
<note>
  It is still possible to overflow a double result here; in that case, null will be returned.
</note>

**Supported types**

| base          | exponent      | result |
|---------------|---------------|--------|
| double        | double        | double |
| double        | integer       | double |
| double        | long          | double |
| double        | unsigned_long | double |
| integer       | double        | double |
| integer       | integer       | double |
| integer       | long          | double |
| integer       | unsigned_long | double |
| long          | double        | double |
| long          | integer       | double |
| long          | long          | double |
| long          | unsigned_long | double |
| unsigned_long | double        | double |
| unsigned_long | integer       | double |
| unsigned_long | long          | double |
| unsigned_long | unsigned_long | double |

**Examples**
```esql
ROW base = 2.0, exponent = 2
| EVAL result = POW(base, exponent)
```


| base:double | exponent:integer | result:double |
|-------------|------------------|---------------|
| 2.0         | 2                | 4.0           |

The exponent can be a fraction, which is similar to performing a root.
For example, the exponent of `0.5` will give the square root of the base:
```esql
ROW base = 4, exponent = 0.5
| EVAL s = POW(base, exponent)
```


| base:integer | exponent:double | s:double |
|--------------|-----------------|----------|
| 4            | 0.5             | 2.0      |


## `ROUND`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/round.svg)

**Parameters**
<definitions>
  <definition term="number">
    The numeric value to round. If `null`, the function returns `null`.
  </definition>
  <definition term="decimals">
    The number of decimal places to round to. Defaults to 0. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Rounds a number to the specified number of decimal places. Defaults to 0, which returns the nearest integer. If the precision is a negative number, rounds to the number of digits left of the decimal point.
**Supported types**

| number        | decimals | result        |
|---------------|----------|---------------|
| double        | integer  | double        |
| double        | long     | double        |
| double        |          | double        |
| integer       | integer  | integer       |
| integer       | long     | integer       |
| integer       |          | integer       |
| long          | integer  | long          |
| long          | long     | long          |
| long          |          | long          |
| unsigned_long | integer  | unsigned_long |
| unsigned_long | long     | unsigned_long |
| unsigned_long |          | unsigned_long |

**Example**
```esql
FROM employees
| KEEP first_name, last_name, height
| EVAL height_ft = ROUND(height * 3.281, 1)
```


| first_name:keyword | last_name:keyword | height:double | height_ft:double |
|--------------------|-------------------|---------------|------------------|
| Arumugam           | Ossenbruggen      | 2.1           | 6.9              |
| Kwee               | Schusler          | 2.1           | 6.9              |
| Saniya             | Kalloufi          | 2.1           | 6.9              |


## `ROUND_TO`

<applies-to>
  - Elastic Stack: Preview since 9.1
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/round_to.svg)

**Parameters**
<definitions>
  <definition term="field">
    The numeric value to round. If `null`, the function returns `null`.
  </definition>
  <definition term="points">
    Remaining rounding points. Must be constants.
  </definition>
</definitions>

**Description**
Rounds down to one of a list of fixed points.
**Supported types**

| field      | points     | result     |
|------------|------------|------------|
| date       | date       | date       |
| date_nanos | date_nanos | date_nanos |
| double     | double     | double     |
| double     | integer    | double     |
| double     | long       | double     |
| integer    | double     | double     |
| integer    | integer    | integer    |
| integer    | long       | long       |
| long       | double     | double     |
| long       | integer    | long       |
| long       | long       | long       |

**Example**
```esql
FROM employees
| STATS COUNT(*) BY birth_window=ROUND_TO(
    birth_date,
    "1900-01-01T00:00:00Z"::DATETIME,
    "1950-01-01T00:00:00Z"::DATETIME,
    "1955-01-01T00:00:00Z"::DATETIME,
    "1960-01-01T00:00:00Z"::DATETIME,
    "1965-01-01T00:00:00Z"::DATETIME,
    "1970-01-01T00:00:00Z"::DATETIME,
    "1975-01-01T00:00:00Z"::DATETIME
)
| SORT birth_window ASC
```


| COUNT(*):long | birth_window:datetime |
|---------------|-----------------------|
| 27            | 1950-01-01T00:00:00Z  |
| 29            | 1955-01-01T00:00:00Z  |
| 33            | 1960-01-01T00:00:00Z  |
| 1             | 1965-01-01T00:00:00Z  |
| 10            | null                  |


## `SCALB`

<applies-to>
  - Elastic Stack: Generally available since 9.1
</applies-to>

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/scalb.svg)

**Parameters**
<definitions>
  <definition term="d">
    Numeric expression for the multiplier. If `null`, the function returns `null`.
  </definition>
  <definition term="scaleFactor">
    Numeric expression for the scale factor. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the result of `d * 2 ^ scaleFactor`, Similar to Java's `scalb` function. Result is rounded as if performed by a single correctly rounded floating-point multiply to a member of the double value set.
**Supported types**

| d             | scaleFactor | result |
|---------------|-------------|--------|
| double        | integer     | double |
| double        | long        | double |
| integer       | integer     | double |
| integer       | long        | double |
| long          | integer     | double |
| long          | long        | double |
| unsigned_long | integer     | double |
| unsigned_long | long        | double |

**Example**
```esql
row x = 3.0, y = 10 | eval z = scalb(x, y)
```


| x:double | y:integer | z:double |
|----------|-----------|----------|
| 3.0      | 10        | 3072.0   |


## `SIGNUM`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/signum.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the sign of the given number. It returns `-1` for negative numbers, `0` for `0` and `1` for positive numbers.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW d = 100.0
| EVAL s = SIGNUM(d)
```


| d: double | s:double |
|-----------|----------|
| 100       | 1.0      |


## `SIN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/sin.svg)

**Parameters**
<definitions>
  <definition term="angle">
    An angle, in radians. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [sine](https://en.wikipedia.org/wiki/Sine_and_cosine) of an angle.
**Supported types**

| angle         | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=1.8
| EVAL sin=SIN(a)
```


| a:double | sin:double         |
|----------|--------------------|
| 1.8      | 0.9738476308781951 |


## `SINH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/sinh.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [hyperbolic sine](https://en.wikipedia.org/wiki/Hyperbolic_functions) of a number.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=1.8
| EVAL sinh=SINH(a)
```


| a:double | sinh:double      |
|----------|------------------|
| 1.8      | 2.94217428809568 |


## `SQRT`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/sqrt.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the square root of a number. The input can be any numeric value, the return value is always a double. Square roots of negative numbers and infinities are null.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW d = 100.0
| EVAL s = SQRT(d)
```


| d: double | s:double |
|-----------|----------|
| 100.0     | 10.0     |


## `TAN`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/tan.svg)

**Parameters**
<definitions>
  <definition term="angle">
    An angle, in radians. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [tangent](https://en.wikipedia.org/wiki/Sine_and_cosine) of an angle.
**Supported types**

| angle         | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=1.8
| EVAL tan=TAN(a)
```


| a:double | tan:double         |
|----------|--------------------|
| 1.8      | -4.286261674628062 |


## `TANH`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/tanh.svg)

**Parameters**
<definitions>
  <definition term="number">
    Numeric expression. If `null`, the function returns `null`.
  </definition>
</definitions>

**Description**
Returns the [hyperbolic tangent](https://en.wikipedia.org/wiki/Hyperbolic_functions) of a number.
**Supported types**

| number        | result |
|---------------|--------|
| double        | double |
| integer       | double |
| long          | double |
| unsigned_long | double |

**Example**
```esql
ROW a=1.8
| EVAL tanh=TANH(a)
```


| a:double | tanh:double        |
|----------|--------------------|
| 1.8      | 0.9468060128462683 |


## `TAU`

**Syntax**
![Embedded](https://www.elastic.co/docs/reference/query-languages/esql/images/functions/tau.svg)

**Parameters**
**Description**
Returns the [ratio](https://tauday.com/tau-manifesto) of a circle’s circumference to its radius.
**Supported types**

| result |
|--------|
| double |

**Example**
```esql
ROW TAU()
```


| TAU():double      |
|-------------------|
| 6.283185307179586 |﻿---
title: ES|QL FUSE command
description: 
url: https://www.elastic.co/docs/reference/query-languages/esql/commands/fuse
---

# ES|QL FUSE command
<applies-to>
  - Elastic Cloud Serverless: Preview
  - Elastic Stack: Preview since 9.2
</applies-to>

The `FUSE` [processing command](https://www.elastic.co/docs/reference/query-languages/esql/commands/processing-commands) merges rows from multiple result sets and assigns
new relevance scores.
`FUSE` enables [hybrid search](/docs/reference/query-languages/esql/esql-search-tutorial#perform-hybrid-search) to combine and score results from multiple queries, together with the [`FORK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fork) command.
`FUSE` works by:
1. Merging rows with matching `<key_columns>` values
2. Assigning new relevance scores using the specified `<fuse_method>` algorithm
   and the values from the `<group_column>` and `<score_column>`

<tip>
  `FUSE` is for search use cases: it merges ranked result sets and computes relevance.
  Learn more about [how search works in ES|QL](https://www.elastic.co/docs/solutions/search/esql-for-search#how-search-works-in-esql).
</tip>


## Syntax

Use default parameters:
```esql
FUSE
```

Specify custom parameters:
```esql
FUSE <fuse_method> SCORE BY <score_column> GROUP BY <group_column> KEY BY <key_columns> WITH <options>
```


## Parameters

<definitions>
  <definition term="fuse_method">
    Defaults to `RRF`. Can be one of `RRF` (for [Reciprocal Rank Fusion](https://cormack.uwaterloo.ca/cormacksigir09-rrf.pdf)) or `LINEAR` (for linear combination of scores).
    Designates which method to use to assign new relevance scores.
  </definition>
  <definition term="options">
    Options for the `fuse_method`.
  </definition>
</definitions>

<tab-set>
  <tab-item title="RRF">
    When `fuse_method` is `RRF`, `options` supports the following parameters:
    <definitions>
      <definition term="rank_constant">
        Defaults to `60`. Represents the `rank_constant` used in the RRF formula.
      </definition>
      <definition term="weights">
        Defaults to `{}`. Allows you to set different weights for RRF scores based on `group_column` values. Refer to the [Set custom weights](#set-custom-weights) example.
      </definition>
    </definitions>
  </tab-item>

  <tab-item title="LINEAR">
    When `fuse_method` is `LINEAR`, `options` supports the following parameters:
    <definitions>
      <definition term="normalizer">
        Defaults to `none`. Can be one of `none` or `minmax`. Specifies which score normalization method to apply.
      </definition>
      <definition term="weights">
        Defaults to `{}`. Allows you to different weights for scores based on `group_column` values. Refer to the [Set custom weights](#set-custom-weights) example.
      </definition>
    </definitions>
  </tab-item>
</tab-set>

<definitions>
  <definition term="score_column">
    Defaults to `_score`. Designates which column to use to retrieve the relevance scores of the input row
    and where to output the new relevance scores of the merged rows.
  </definition>
  <definition term="group_column">
    Defaults to `_fork`. Designates which column represents the result set.
  </definition>
  <definition term="key_columns">
    Defaults to `_id, _index`. Rows with matching `key_columns` values are merged.
  </definition>
</definitions>


## Examples


### Use RRF

In the following example, we use the [`FORK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fork) command to run two different queries: a lexical and a semantic query.
We then use `FUSE` to merge the results (applies `RRF` by default):
```esql
FROM books METADATA _id, _index, _score 
| FORK (WHERE title:"Shakespeare" | SORT _score DESC) 
       (WHERE semantic_title:"Shakespeare" | SORT _score DESC) 
| FUSE 
```


### Use linear combination

`FUSE` can also use linear score combination:
```esql
FROM books METADATA _id, _index, _score 
| FORK (WHERE title:"Shakespeare" | SORT _score DESC) 
       (WHERE semantic_title:"Shakespeare" | SORT _score DESC) 
| FUSE LINEAR 
```


### Normalize scores

When combining results from semantic and lexical queries through linear combination, we recommend first normalizing the scores from each result set.
The following example uses `minmax` score normalization.
This means the scores normalize and assign values between 0 and 1, before combining the rows:
```esql
FROM books METADATA _id, _index, _score
| FORK (WHERE title:"Shakespeare" | SORT _score DESC) 
       (WHERE semantic_title:"Shakespeare" | SORT _score DESC) 
| FUSE LINEAR WITH { "normalizer": "minmax" } 
```


### Set custom weights

`FUSE` allows you to specify different weights to scores, based on the `_fork` column values, enabling you to control the relative importance of each query branch in the final results.
```esql
FROM books METADATA _id, _index, _score
| FORK (WHERE title:"Shakespeare" | SORT _score DESC) 
       (WHERE semantic_title:"Shakespeare" | SORT _score DESC) 
| FUSE LINEAR WITH { "weights": { "fork1": 0.7, "fork2": 0.3 }, "normalizer": "minmax" } 
```


## Limitations

These limitations can be present either when:
- `FUSE` is not combined with [`FORK`](https://www.elastic.co/docs/reference/query-languages/esql/commands/fork)
- `FUSE` doesn't use the default  [metadata](https://www.elastic.co/docs/reference/query-languages/esql/esql-metadata-fields) columns `_id`, `_index`, `_score` and `_fork`
  1. `FUSE` assumes that `key_columns` are single valued. When `key_columns` are multivalued, `FUSE` can produce unreliable relevance scores.
2. `FUSE` automatically assigns a score value of `NULL` if the `<score_column>` or `<group_column>` are multivalued.
3. `FUSE` assumes that the combination of `key_columns` and `group_column` is unique. If not, `FUSE` can produce unreliable relevance scores.﻿---
title: Use cases for ES|QL
description: These pages detail how to use ES|QL for search and cybersecurity use cases: ES|QL for search: Learn how to use ES|QL for lexical (keyword) search, relevance...
url: https://www.elastic.co/docs/reference/query-languages/esql/esql-use-cases
applies_to:
  - Elastic Cloud Serverless: Generally available
  - Elastic Stack: Generally available in 9.0+
---

# Use cases for ES|QL
These pages detail how to use ES|QL for search and cybersecurity use cases:
- [ES|QL for search](https://www.elastic.co/docs/solutions/search/esql-for-search): Learn how to use ES|QL for lexical (keyword) search, relevance scoring, semantic and hybrid search, semantic reranking, and more.
- [ES|QL for security](https://www.elastic.co/docs/solutions/security/esql-for-security): Learn how to use ES|QL for threat hunting, timeline investigation, detection rules, and migrating Splunk queries.