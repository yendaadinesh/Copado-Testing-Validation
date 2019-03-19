/**
 * Created by Leonid Bartenev
 */
({
    rerender: function (component, helper) {
        this.superRerender();

        if (!component.get('v.scriptsLoaded') || component.get('v.chartRendered')) {
            return;
        }

        //make sure threshold isn't a string
        component.get('v.thresholdValue', parseInt(component.get('v.thresholdValue'),10));
        var containerWidth = component.find('chartContainer').getElement().clientWidth;
        component.set('v.containerWidth', containerWidth);

        var chartDiv = component.find('chart').getElement();
        chartDiv.innerHTML = '';
        helper.drawChart(component, helper);
        if(component.get('v.data')){
            component.find('mainSpinner').hide();
        }else{
            component.find('mainSpinner').show()
        }
    },
    unrender: function(component) {
        this.superUnrender();

        window.removeEventListener('resize', component.resize);
    }
})