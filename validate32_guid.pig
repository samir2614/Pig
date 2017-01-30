SET job.name 'Update DoubleClick NA Event ID Lookup Table';

act_load         =   LOAD '$SRC_TBL' USING $HCATLOADER_LIB;

fil         =   FILTER act_load BY  TRIM(user_id) != '0'
                                AND TRIM(user_id) != ''
                                AND TRIM(guid)  != '0'
                                AND TRIM(guid) != ''
                                AND UPPER(TRIM(guid)) != 'NULL'
                                AND UPPER(TRIM(guid)) != '[ADOBE ID/WCD GUID]'
				-- AND INDEXOF(UPPER(guid), 'ADOBE') < 0                               
				AND (int)SIZE((INDEXOF(guid, '@') > -1 ? SUBSTRING (guid, 0, INDEXOF(guid, '@',0)) : guid)) == 24  ;

							
proj        =   FOREACH fil GENERATE    
                                    user_id
                                   ,(INDEXOF(guid, '@') > -1 ? SUBSTRING(guid, 0, INDEXOF(guid, '@',0)) : guid) as guid;

-- dump proj;
proj_dist = DISTINCT proj PARALLEL 12 ; 

STORE proj_dist INTO '$TGT_TBL' USING $HBASE_STORAGE('cf1:guid');
