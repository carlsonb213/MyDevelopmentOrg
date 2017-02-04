/****************************************************************
 * @Creator: Jeremiah Dohn
 * @Created Date: 2016-07-31
 * @Last Modifier: Jeremiah Dohn
 * @Last Modified Date: 2016-07-31
 * 
 * @Description: This is the test for the randomNumberGeneratorFlow apex class.
 * 
 * **************************************************************/
@isTest(seeAllData=false)
private class randomNumberGeneratorFlowTest {
	
    // Generate random number without modulus
    static testMethod void generateRandomNumber(){
        
        randomNumberGeneratorFlow rngf = new randomNumberGeneratorFlow();
        
        Map<String, Object> inputParams = new Map<String, Object>();
       
        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult result;
        result = rngf.invoke(request);
        
        Double randomValue = (Double)result.outputParameters.get('Result');
        system.debug('Random value returned is: ' + randomValue);
        system.assertNotEquals(null, randomValue);
    }
    
    // Generate random number with modulus
    static testMethod void generateRandomNumberWithModulus(){
        
        randomNumberGeneratorFlow rngf = new randomNumberGeneratorFlow();
        
        Map<String, Object> inputParams = new Map<String, Object>();
        inputParams.put('Modulus', 1);
       
        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult result;
        result = rngf.invoke(request);
        
        Double randomValue = (Double)result.outputParameters.get('Result');
        system.debug('Random value returned is: ' + randomValue);
        system.assertNotEquals(null, randomValue);
        system.assertEquals(0, randomValue);
    }
    
    // Tests the describe method
    static testMethod void describeTest() {

        randomNumberGeneratorFlow rngf = new randomNumberGeneratorFlow();
        Process.PluginDescribeResult result =  rngf.describe();
		
		// Assert there is 1 input     
        System.AssertEquals(result.inputParameters.size(), 1);
        
        // Assert that there is one output
        system.assertEquals(result.outputParameters.size(), 1);

	}
}