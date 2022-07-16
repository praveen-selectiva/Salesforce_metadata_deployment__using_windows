public class QuoteLineItemAction {
    public void insertQuoteLineItem(List<QuoteLineItem> quoteLineItems){
        Set<String> quoteIds = new Set<String>();
        Map<String,Object> quoteMap = new Map<String,Object>();
        for(QuoteLineItem quoteLineItem:quoteLineItems) {
            quoteIds.add(quoteLineItem.QuoteId);
        }
        List<QuoteLineItem> oldItems = [Select Id, QuoteId, Product2Id FROM QuoteLineItem where QuoteId IN: quoteIds];
        if(oldItems.size() > 0) {
            for(String quoteId:quoteIds) {
                Map<String,Object> oldItemMap = new Map<String,Object>();
                List<Map<String,Object>> listOfData = new  List<Map<String,Object>>();
                for(QuoteLineItem quoteLineItem : oldItems) {
                    if(quoteMap.containsKey(quoteLineItem.QuoteId)) {
                        List<Map<String,Object>> data=new List<Map<String,Object>>();
                        data = (List<Map<String,Object>>) quoteMap.get(quoteLineItem.QuoteId);
                        oldItemMap = new Map<String,Object>();
                        oldItemMap.put(quoteLineItem.Product2Id,quoteLineItem);
                        data.add(oldItemMap);
                        quoteMap.put(quoteId,data);
                    } else {
                        oldItemMap = new Map<String,Object>();
                        oldItemMap.put(quoteLineItem.Product2Id,quoteLineItem);
                        listOfData = new  List<Map<String,Object>>();
                        listOfData.add(oldItemMap);
                        quoteMap.put(quoteId,listOfData);
                    }
                }
                
            } 
        }
        List<Map<String,Object>> obj = new List<Map<String,Object>>();            
        for(Integer j=0; j< quoteLineItems.size();j++){
            obj = new List<Map<String,Object>>();    
            obj = (List<Map<String,Object>>)quoteMap.get(quoteLineItems[j].QuoteId);
            if(obj != null) {
                for(Integer i =0; i< obj.size(); i ++) {
                    if(obj[i].containsKey(quoteLineItems[j].Product2Id)) {
                        quoteLineItems[j].addError(System.Label.SPA_Line_Item_Duplicate);
                    } 
                }
                
            }
        }
    }
}