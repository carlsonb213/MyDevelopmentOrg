({
    packItem: function(component, event, helper) {
        var item = component.get("v.item");
        console.log("Item Before: " + JSON.stringify(item));
//        item.Name = 'NewItem';
//        item.Quantity__c = 20;
//        item.Price__c = 200;
        item.Packed__c = true;
//        component.set("v.item", item);     // update our message
        component.set("v.item.Packed__c", true);
        console.log("Item After: " + JSON.stringify(item));
        var btnClicked = event.getSource();         // the button
        console.log("packItem Button Disabled : "); // + btnClicked.disabled);
        btnClicked.set("v.disabled", true);
//        console.log("packItem Button Disabled : " + btnClicked.disabled);
    }
})