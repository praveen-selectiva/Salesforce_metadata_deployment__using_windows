trigger QuoteLineItemTrigger on QuoteLineItem (before insert) {
    QuoteLineItemHandler qlih = new QuoteLineItemHandler();
    if(Trigger.isInsert){
        qlih.beforeInsert(Trigger.new); 
    }
}