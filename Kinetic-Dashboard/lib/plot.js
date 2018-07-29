Highcharts.chart('pie', {
    chart: {
        plotBackgroundColor: 'black',
        backgroundColor: 'black',
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: 'Percent of Cars Available'
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                }
            }
        }
    },
    series: [{
        name: 'Cars',
        colorByPoint: true,
        data: [{
            name: 'Out of Order',
            y: 4.85
        }, {
            name: 'In Use',
            y: 78.41
        }, {
            name: 'Available',
            y: 16.74,
            sliced: true,
            selected: true
        }
        ]
    }]
});



Highcharts.chart('line', {
    chart: {
        plotBackgroundColor: 'black',
        backgroundColor: 'black',
        plotBorderWidth: null,
        plotShadow: false
    },

    title: {
        text: 'Traffic Flow in a Day'
    },

    yAxis: {
        title: {
            text: 'Number of Cars'
        }
    },

    xAxis: {
        title: {
            text: 'Time in a Day'
        }
    },

    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle'
    },

    plotOptions: {
        series: {
            label: {
                connectorAllowed: false
            },
            pointStart: 0
        }
    },

    series: [{
        name: 'Car',
        data: [43, 52, 57, 69, 47, 137, 354, 439, 525, 471, 496, 470, 435, 409, 337, 354, 439, 525, 571, 696, 470, 319, 237, 154],
        color: 'Orange'
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }

});