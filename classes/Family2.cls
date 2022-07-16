//optimized code

// make data as list of map with account id and contact and then use that data get result as (accountID(indal,uday)) i.e. id of perticular family
// and its related contact and ut should be dynamic

public class Family2 {
    public static list<map<string,string>> mapContact(){
        list<map<string,string>> listOfMap = new list<map<string,string>>();        
        map<string,string> getData = new map<string,string>{'Account Id'=>'0015j00000UnTByAAN','fName'=>'Vijay','lName'=>'Yadav','email'=>'vijay@gmail.com'};
            listOfMap.add(getData);
        getData = new map<string,string>{'Account Id'=>'0015j00000UnTByAAN','fName'=>'Ajay','lName'=>'Yadav','email'=>'ajay@gmail.com'};
            listOfMap.add(getData);
        getData = new map<string,string>{'Account Id'=>'0015j00000UnTBy','fName'=>'Surendra','lName'=>'Patel','email'=>'surendra@gmail.com'};
            listOfMap.add(getData);
        getData = new map<string,string>{'Account Id'=>'0015j00000UnTBy','fName'=>'Yuvan','lName'=>'Patel','email'=>'yuvan@gmail.com'};
            listOfMap.add(getData);
        getData = new map<string,string>{'Account Id'=>'0015j00000UnT','fName'=>'Indal','lName'=>'Singh','email'=>'indal@gmail.com'};
            listOfMap.add(getData);
        getData = new map<string,string>{'Account Id'=>'0015j00000UnT','fName'=>'Uday','lName'=>'Singh','email'=>'uday@gmail.com'};
            listOfMap.add(getData);
        getData = new map<string,string>{'Account Id'=>'0015j000ACBD','fName'=>'aditya','lName'=>'Kushre','email'=>'aditya@gmail.com'};
            listOfMap.add(getData);
        system.debug(listOfMap);
        return listOfMap;
    }
    
    
    
    public static  void getContactByAccountId(){
        list<map<string,string>> sourceContactList= mapContact(); 
        //  map<account ID ,list<map<fname, indal>>>  esa kuch data chahiye)
        map<string ,list<map<string,string>>> mapOfData = new  map<string ,list<map<string,string>>>();
        string tempAccId = '';
        map<string,string> tempMap = new  map<string,string>() ;
        list<map<string,string>> tempList = new  list<map<string,string>>();
        for(map<string,string> mapOfString : sourceContactList ){
            tempAccId =  mapOfString.get('Account Id');
            tempMap = mapOfString;
            if(mapOfData.get(tempAccId) == null){
                mapOfData.put(tempAccId,new list<map<string,string>>());  
            }
            tempList = mapOfData.get(tempAccId);
            //system.debug('tempList => '+tempList);
            tempList.add(tempMap);
            //system.debug('tempList.add => '+tempList);
            mapOfData.put(tempAccId,tempList);                        
        }       
        system.debug('mapOfData:: ' +mapOfData );
    }
   
}