/**
 * Created by Leonid Bartenev
 */
({
    doInit: function (component, event, helper) {
        if (!helper.itemsMap) helper.initItemsMap();
    },

    doChangeItemsList: function (component, event, helper) {
        try{
            var userMode = component.get('v.mode');
            var menuItems = helper.itemsMap[userMode];
            component.set('v.menuItems', menuItems);
            component.set('v.scrollRequired', false);
            component.set('v.scrollDirection', 'left');
            var scrollEnableCheckHandler = $A.getCallback(function () {
                var navMenuCmp = component.getConcreteComponent().find('navMenu');
                if(navMenuCmp){
                    var navMenu = navMenuCmp.getElement();
                    component.set('v.scrollRequired', navMenu.scrollWidth > navMenu.clientWidth);
                }
            });
            setTimeout(scrollEnableCheckHandler, 300);
            window.addEventListener('resize',scrollEnableCheckHandler);
        }catch(e){
            console.error(e);
        }
    },  

    doCurrentPageChange: function (component, event, helper) {
        try{
            var menuItems = component.get('v.menuItems');
            var currentPageName = communityService.getPageName();
            helper.updateDocumentTitle(component, currentPageName);
            //document.title = $A.get('$Label.c.RH_Window_Title');
            component.set('v.currentPage', currentPageName);
        }catch (e) {
            console.error(e);
        }
    },

    onClick : function(component, event, helper) {
        var pageName = event.currentTarget.dataset.pageName;
        helper.updateDocumentTitle(component, pageName);
        communityService.navigateToPage(pageName);
    },

    doScroll: function (component, event, helper) {
        var direction = component.get('v.scrollDirection');
        var navMenuCmp = component.getConcreteComponent().find('navMenu');
        if(navMenuCmp){
            var navMenu = navMenuCmp.getElement();
            var navMenuWidth = navMenu.getBoundingClientRect().width;
            debugger;
            if(direction === 'right'){
                component.set('v.scrollDirection', 'left');
                navMenu.scrollLeft = 0;
            }else{
                navMenu.scrollLeft = 3000;
                component.set('v.scrollDirection', 'right');
            }
        }
    }


})