/****************************************************************
 * @Creator: Jeremiah Dohn
 * @Created Date: 2016-07-31
 * @Last Modifier: Jeremiah Dohn
 * @Last Modified Date: 2016-07-31
 * 
 * @Description: This is a flow plugin for accessing the random number generator in apex.
 * 
 * @Inputs: Modulous - optional - if provided this will return a value based on the modulous of the
 * 								  random number generated.
 * 
 * **************************************************************/
global class randomNumberGeneratorFlow implements Process.Plugin{
    
    global Process.PluginResult invoke(Process.PluginRequest request){
        
        Map<String,Double> result = new Map<String,Double>();
        
        Double modulous = (Double) request.inputParameters.get('Modulus');
         
        Double randomNumber = math.random();
        
        if(modulous != null){
            Double modulousNumber = math.mod(math.round(randomNumber*1000), (Integer)modulous);
            result.put('Result', modulousNumber);
        } else{
            result.put('Result', randomNumber*1000);
        }
        
        return new Process.PluginResult(result); 
       
    }
    
    global process.PluginDescribeResult describe() {
        Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
        result.Name = 'Random Number Generator';
        result.Tag = 'Random Number Generator';
        
        // Set description
        result.Description ='This plugin will generate a random number.  If a modulous is specified it will return the random number with the input modulous.';

        // Set input parameters
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter>();
        result.inputParameters.add(new Process.PluginDescribeResult.inputParameter('Modulus', Process.PluginDescribeResult.ParameterType.Double, false));
        
        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter>(); 
        result.outputParameters.add(new Process.PluginDescribeResult.outputParameter('Result', Process.PluginDescribeResult.ParameterType.Double));

        return result;
        
    }
    

}