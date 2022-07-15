public class findNickName {
	
    public static void main(){
        map<string,list<string>> data = new map<string,list<string>>();
        data.put('Bhanu',new list<string>{'Bhanu Bhaiya' , 'The bearded Man', 'Bhopali'});
        data.put('Sachin',new list<string>{'Master Blaster' , 'Mumbai','Opener', 'Legend'});
        data.put('Samyak',new list<string>{'Jeetu Bhaiya', 'Bhopali'});
        data.put('Rashi',new list<string>{'Loader', 'Bhopali'});
        data.put('Suyog',new list<string>{'Mahakal', 'Bhole Baba'});
         
        list<list<string>> result = new list<list<string>>();
        list<string> keySet = new list<string>(data.keySet());
        for(string key : keySet){
            List<String> tempList = data.get(key);
            //system.debug('key1 => '+key);
            //system.debug('tempList =>'+ tempList);
            for(String val : tempList){
                //system.debug('val =>'+val);
                for(integer i = 0; i<keySet.size(); i++){
                    //system.debug(data.get(keySet[i]).contains(val));
                    if(key != keySet[i]){
                        if(data.get(keySet[i]).contains(val)){
                            
                                if(result.size() != 0){
                                    for(list<string> check : result){
                                        if(!check.contains(key) && !check.contains(keySet[i]) ){
                                            result.add(new list<string>{key,keySet[i]});
                                            system.debug('Both '+key+ ' and ' +keySet[i]+' have same nick name..!');    
                                        }    
                                    }
                                    
                                } else{
                                    result.add(new list<string>{key,keySet[i]});
                                    system.debug('Both '+key+ ' and ' +keySet[i]+' have same nick name..!'); 
                                }
                            
                        }
                    }
                }
            }
        }
        system.debug('set => '+result);
    }
    
}