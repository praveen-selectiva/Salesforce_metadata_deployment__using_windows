public class lsitOfMap {
    
    public static List<Map<String,String>> listOfMap = new List<Map<String,String>>();
    
    public static void methodMap(){
        //List<String> listOfString = new List<String>();
        
        Map<String,String> mapOfString = new Map<String,String>();
        
        mapOfString.put('key','value');
        mapOfString.put('ke1','value1');
        mapOfString.put('ke2','value2');
        mapOfString.put('ke3','value3');
        
        listOfMap.add(mapOfString);
        
        
        //1.list
        //2.map
        //3.String,String
		/*        
        {
            'projectName'='project01',
            'resourceName'='resource01',
            'timeCardName'='timeCard01'    
        }
        {
            'projectName'='project02',
            'resourceName'='resource02',
            'timeCardName'='timeCard02'    
        }
        {
            'projectName'='project03',
            'resourceName'='resource03',
            'timeCardName'='timeCard03'    
        }
		*/
    }
}