/****************************************************************
 * @Creator: Jeremiah Dohn
 * @Created Date: 2016-07-31
 * @Last Modifier: Jeremiah Dohn
 * @Last Modified Date: 2016-07-31
 * 
 * @Description: This is the test for the permissionSetGroupingFlow apex class
 * 
 * **************************************************************/
@isTest(seeAllData=false)
private class PermissionSetGroupingFlowTest {
    
    @testSetup 
    static void testSetup(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User();
        u.Alias = 'sysAdmin'; 
        u.Email='sysAdmin@psgfTest.com';
        u.EmailEncodingKey = 'UTF-8';
        u.LastName = 'Test';
        u.FirstName = 'User';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName='sysAdmin@psgfTest.com';
        
        List<PermissionSet> psList = new List<PermissionSet>();
        PermissionSet ps = new PermissionSet(Name='PermissionSetGroupingFlowTest', Label='PermissionSetGroupingFlowTest');
        PermissionSet ps1 = new PermissionSet(Name='PermissionSetGroupingFlowTest1', Label='PermissionSetGroupingFlowTest1');
        
        psList.add(ps);
        psList.add(ps1);
        
        insert psList;
        
        // Run as system admin to avoid mixed DML
        system.runAs(u){
            
            // Create permission set grouping and child records
            // 1 - psg = multiple permission set groupings
            // 2 - psg1 = one permission set grouping

            List<Permission_Set_Grouping__c> psgList = new List<Permission_Set_Grouping__c>();
            
            Permission_Set_Grouping__c psg = new Permission_Set_Grouping__c();
            psg.Name = 'PermissionSetGroupingFlowTest1';
            psgList.add(psg);
            
            Permission_Set_Grouping__c psg1 = new Permission_Set_Grouping__c();
            psg1.Name = 'PermissionSetGroupingFlowTest2';
            psgList.add(psg1);
            
            insert psgList;
            
            // Add multiple permission set children to ensure all lines are covered
            List<Permission_Set__c> pscList = new List<Permission_Set__c>();
            
            Permission_Set__c psc = new Permission_Set__c();
            psc.Permission_Set_Developer_Name__c = 'PermissionSetGroupingFlowTest';
            psc.Permission_Set_Grouping__c = psg.Id;
            pscList.add(psc);
            
            Permission_Set__c psc1 = new Permission_Set__c();
            psc1.Permission_Set_Developer_Name__c = 'PermissionSetGroupingFlowTest1';
            psc1.Permission_Set_Grouping__c = psg.Id;
            pscList.add(psc1);
            
            // This is for retrieving one permission set test case
            Permission_Set__c psc2 = new Permission_Set__c();
            psc2.Permission_Set_Developer_Name__c = 'PermissionSetGroupingFlowTest';
            psc2.Permission_Set_Grouping__c = psg1.Id;
            pscList.add(psc2);
            
            insert pscList;
            
        }
        
    }
	
	// Get multiple permission sets back with the flow
    static testMethod void getMultPermissionSet(){
        
        test.startTest();
        
        permissionSetGroupingFlow psgf = new permissionSetGroupingFlow();
        
        Map<String, Object> inputParams = new Map<String, Object>();
        inputParams.put('Permission Set Grouping Name', 'PermissionSetGroupingFlowTest1');
       
        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult result;
        result = psgf.invoke(request);
        
        test.stopTest();
        
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'PermissionSetGroupingFlowTest'];
        PermissionSet ps1 = [SELECT Id FROM PermissionSet WHERE Name = 'PermissionSetGroupingFlowTest1'];
        
        String permissionSetValue = (String)result.outputParameters.get('Result');
        system.assertNotEquals(null, permissionSetValue);
        
        String psConcat = ps.Id + ',' + ps1.Id;
        
        system.assertEquals(psConcat, permissionSetValue);
    }
    
    // Get a permission set back with the flow
    static testMethod void getPermissionSet(){
        
        test.startTest();
        
        permissionSetGroupingFlow psgf = new permissionSetGroupingFlow();
        
        Map<String, Object> inputParams = new Map<String, Object>();
        inputParams.put('Permission Set Grouping Name', 'PermissionSetGroupingFlowTest2');
       
        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult result;
        result = psgf.invoke(request);
        
        test.stopTest();
        
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'PermissionSetGroupingFlowTest'];
        
        String permissionSetValue = (String)result.outputParameters.get('Result');
        system.assertNotEquals(null, permissionSetValue);
        system.assertEquals(ps.Id, permissionSetValue);
    }
    
    // Get no permission set back with the flow
    static testMethod void getNoPermissionSet(){
        
        test.startTest();
        
        permissionSetGroupingFlow psgf = new permissionSetGroupingFlow();
        
        Map<String, Object> inputParams = new Map<String, Object>();
        inputParams.put('Permission Set Grouping Name', 'PermissionSetGroupingFlowTestNoExist');
       
        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult result;
        result = psgf.invoke(request);
        
        test.stopTest();
        
        String permissionSetValue = (String)result.outputParameters.get('Result');
        system.assertEquals(null, permissionSetValue);

    }
    
    // Tests the describe method
    static testMethod void describeTest() {

        permissionSetGroupingFlow psgf = new permissionSetGroupingFlow();
        Process.PluginDescribeResult result =  psgf.describe();
		
		// Assert there is 1 input     
        System.AssertEquals(result.inputParameters.size(), 1);
        
        // Assert that there is one output
        system.assertEquals(result.outputParameters.size(), 1);

	}
}