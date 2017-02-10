({
	clickCreateItem : function(component, event, helper) {
        // Simplistic error checking
        var validItem = true;
        var blankItem = { 'sobjectType': 'Camping_Item__c', 
                               'Name': '', 
                               'Packed__c': false, 
                               'Price__c': 0, 
                               'Quantity__c': 0}

        // Name must not be blank
        var nameField = component.find("itemname");
        var itemname = nameField.get("v.value");

        if ($A.util.isEmpty(itemname)){
            validItem = false;
            nameField.set("v.errors", [{message:"Camping Item name can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
        
        // Quantity cannot be null
        nameField = component.find("quantity");
        itemname = nameField.get("v.value");
        if ($A.util.isEmpty(itemname)){
            validItem = false;
            nameField.set("v.errors", [{message:"Quantity can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
        
        // Price cannot be null
        nameField = component.find("price");
        itemname = nameField.get("v.value");
        if ($A.util.isEmpty(itemname)){
            validItem = false;
            nameField.set("v.errors", [{message:"Price can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }

        // If we pass error checking, do some real work
        if(validItem){
            // Create the new item
            var newItem = component.get("v.newItem");
            console.log("Create item: " + JSON.stringify(newItem));
            // helper.createItem(component, newItem);
            // Start 
        var theItems = component.get("v.items");
 
        // Copy the camping list item  to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        newItem = JSON.parse(JSON.stringify(newItem));
        console.log("item:" + JSON.stringify(newItem));
 
        console.log("Items before 'create': " + JSON.stringify(theItems));
        theItems.push(newItem);
        component.set("v.items", theItems);
        console.log("Items after 'create': " + JSON.stringify(theItems));
        component.set("v.newItem", blankItem);

            // End
        }
		
	}
})