public class dataClass {
    public static void classMethod(){
        //loading Project and Timecard data into List
        List<Project__c> pjData = [SELECT Id, Name, (SELECT Id, Name FROM TimeCards__r ) FROM Project__c];
        
        //fetching Project data
        for(Project__c obj : pjData){
            system.debug(obj);
            
            //fetching TimeCard data
            for(sobject obj1 : obj.TimeCards__r){
                system.debug(obj1);
            }
        }
    }
}