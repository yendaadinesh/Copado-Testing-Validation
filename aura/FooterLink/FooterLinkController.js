/**
 * Created by Leonid Bartenev
 */
({
    onClick: function (component) {
        var link = component.get('v.page');
        if(link){
            link = '/' + link + '?ret=' + communityService.createRetString();
        }else{
            link = component.get('v.link');
        }
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            url: link
        });
        urlEvent.fire();
    }
})