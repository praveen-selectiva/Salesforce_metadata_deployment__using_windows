public class QuoteLineItemHandler {
    public void beforeInsert(List<QuoteLineItem> quoteLineItems){
        QuoteLineItemAction a = new QuoteLineItemAction();
        a.insertQuoteLineItem(quoteLineItems);
    }
}