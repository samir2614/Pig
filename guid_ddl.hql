create external table sourcedata.dc_activity_32_v2(
 user_id string
,guid string 
,other string
)
row format delimited
fields terminated by ','
stored as textfile
location '/tmp/guid32'
