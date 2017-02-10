({
    createItem: function(component, item) {
        var theItems = component.get("v.items");
 
        // Copy the camping list item  to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        var newItem = JSON.parse(JSON.stringify(item));
        console.log("I'm in campingHeaderHelper.js.createItem(console, item)");
        console.log("item:" + JSON.stringify(item));
 
        console.log("Items before 'create': " + JSON.stringify(theItems));
        theItems.push(newItem);
        component.set("v.items", theItems);
        console.log("Items after 'create': " + JSON.stringify(theItems));
    }
})