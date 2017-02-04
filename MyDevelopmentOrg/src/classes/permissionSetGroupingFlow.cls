/****************************************************************
 * @Creator: Jeremiah Dohn
 * @Created Date: 2016-07-31
 * @Last Modifier: Jeremiah Dohn
 * @Last Modified Date: 2016-07-31
 * 
 * @Description: This is a flow plugin for accessing the random number generator in apex.
 * 
 * @Inputs: Permission Set Grouping Name - this is the grouping of permission sets to retrieve
 * 
 * @Outputs: Result - this is the result of the retrieval
 * 
 * **************************************************************/
global class permissionSetGroupingFlow implements Process.Plugin{
    
    global Process.PluginResult invoke(Process.PluginRequest request){
        
        Map<String,String> result = new Map<String,String>();
        
        String psgn = (String) request.inputParameters.get('Permission Set Grouping Name');
        
        Set<String> psSet = new Set<String>();
        String resultValue = '';
        
        // Get a list of the permission set developer names and then retrieve the permission sets
        for(Permission_Set__c ps : [SELECT Permission_Set_Developer_Name__c FROM Permission_Set__c
                                    WHERE Permission_Set_Grouping__r.Name = :psgn]){
            psSet.add(ps.Permission_Set_Developer_Name__c);                             
       	}
        
        List<PermissionSet> psList = new List<PermissionSet>([SELECT Id FROM PermissionSet
                                                              WHERE Name IN :psSet]);
        for(integer i = 0; i < psList.size(); i++){
            if(i < psList.size() - 1){
                resultValue += psList[i].Id + ',';  
            } else {
                resultValue += psList[i].Id;  
            }               
        }
		
        if(resultValue != ''){
            result.put('Result', resultValue);
        }
        
        return new Process.PluginResult(result); 
       
    }
    
    global process.PluginDescribeResult describe() {
        Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
        result.Name = 'Permission Set Grouping';
        result.Tag = 'Permission Set Grouping';
        
        // Set description
        result.Description ='This plugin will retrieve the permission set grouping child items and return the IDs for usage in flow.';

        // Set input parameters
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter>();
        result.inputParameters.add(new Process.PluginDescribeResult.inputParameter('Permission Set Grouping Name', Process.PluginDescribeResult.ParameterType.String, true));
        
        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter>(); 
        result.outputParameters.add(new Process.PluginDescribeResult.outputParameter('Result', Process.PluginDescribeResult.ParameterType.String));

        return result;
        
    }
    

}