# How to load hive data to pig using Hcatalog with param and Dry run option

Dry Run 
-----------------------------------------------------------------------------------
$> pig -F -useHCatalog -m ./validate32_param.param  -r validate32_guid.pig
 
Dry run completed. Substituted pig script is at validate32_guid.pig.substituted
------------------------------------------------------------------------------
$> cat validate32_guid.pig.substituted

$> pig -F -useHCatalog -m ./validate32_param.param  validate32_guid.pig
