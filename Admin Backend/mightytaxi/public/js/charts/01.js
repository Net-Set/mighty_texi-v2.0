(function(jQuery) {

    "use strict";

    function apexChartUpdate(chart, detail) {
        let color = getComputedStyle(document.documentElement).getPropertyValue('--dark');
        if (detail.dark) {
          color = getComputedStyle(document.documentElement).getPropertyValue('--white');
        }
      console.log(chart,detail)
        chart.updateOptions({
          chart: {
            foreColor: color
          }
        })
    }

    if (jQuery("#chart-01").length) {
        var options = {
          series: [{
            name: 'Successful deals',
            data: [60, 30, 60, 30, 60, 30, 60]
          }, {
            name: 'Failed deals',
            data: [30, 60, 30, 60, 30, 60, 30]
          }],
          colors: ["#4788ff", "#f75676"],
          chart: {
            height: 370,
            type: 'line',
            zoom: {
              enabled: false
            },
            sparkline: {
              enabled: false,
            }
          },
          dataLabels: {
            enabled: false
          },
          stroke: {
            curve: 'smooth',
            width: 3
          },
          title: {
            text: '',
            align: 'left'
          },
          grid: {
            row: {
              colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
              opacity: 0
            },
          },
          xaxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            labels: {
                 minHeight: 22,
                maxHeight: 35,
             }
          },
          yaxis: {
            labels: {
                offsetY: 0,
                minWidth: 15,
                maxWidth: 15,
              }
           },
           legend: {
            position: 'top',
            horizontalAlign: 'left',
            offsetX: -33
          }
        };
      
        var chart = new ApexCharts(document.querySelector("#chart-01"), options);
        chart.render();
        const body = document.querySelector('body')
        if (body.classList.contains('dark')) {
          apexChartUpdate(chart, {
            dark: true
          })
        }
      
        document.addEventListener('ChangeColorMode', function (e) {
          apexChartUpdate(chart, e.detail)
        })
      
      }

    if (jQuery("#dash-chart-03").length) {
        const options = {
          series: [{
            name: 'Revenue',
            data: [76, 85, 101, 98, 87, 105, 91]
          }, {
              name: 'Net Profit',
              data: [44, 55, 57, 56, 61, 58, 63]
            }],
          chart: {
            type: 'bar',
            height: 260
          },
          colors: ['#4788ff', '#37d5f2'],
          plotOptions: {
            bar: {
              horizontal: false,
              // columnWidth: '45%',
              borderRadius: 4,
            },
          },
          dataLabels: {
            enabled: false
          },
          legend: {
            show: false
          },
          stroke: {
            show: true,
            width: 2,
            colors: ['transparent']
          },
          xaxis: {
            categories: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            labels:{
              minHeight: 30,
              maxHeight: 30,
            }
          },
          yaxis: {
            title: {
              
            },
            labels: {
              offsetY: 0,
              minWidth: 15,
              maxWidth: 15,
            }
          },
          fill: {
            opacity: 1
          },
          tooltip: {
            y: {
              formatter: function (val) {
                return "$ " + val + " thousands"
              }
            }
          }
        };
      
        const chart = new ApexCharts(document.querySelector("#dash-chart-03"), options);
        chart.render();
        const body = document.querySelector('body')
        if (body.classList.contains('dark')) {
          apexChartUpdate(chart, {
            dark: true
          })
        }
      
        document.addEventListener('ChangeColorMode', function (e) {
          apexChartUpdate(chart, e.detail)
        })
      }

      if (jQuery("#dash-chart-02").length) {
        const options = {
          series: [
            {
              name: 'Like',
              data: [50, 25, 10, 70, 25, 30, 25]
            },
            {
              name: 'Comments',
              data: [50, 25, 10, 70, 25, 30, 25]
            },
            {
              name: 'Share',
              data: [60, 44, 20, 35, 22, 22, 10]
            }
          ],
          colors: ['#37d5f2', '#4788ff', '#4fd69c'],
          chart: {
            type: 'bar',
            height: 275,
            stacked: true,
            zoom: {
              enabled: true
            }
          },
          options: {
            legend: {
              markers: {
                radius: 12,
              }
            }
          },
          
          responsive: [{
            breakpoint: 480,
            options: {
              legend: {
                position: 'bottom',
                offsetX: -10,
                offsetY: 0,
               
              }
            }
          }],
          plotOptions: {
            bar: {
              horizontal: false,
              // columnWidth: '45%',
              borderRadius: 4,
            },
          },
          xaxis: {
            type: 'category',
            categories: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
            labels: {
                minHeight: 22,
                maxHeight: 40,
             }
          },
          yaxis: {
            labels: {
                // offsetX: -17,
                offsetY: 0,
                minWidth: 20,
                maxWidth: 20,
              }
           },
          legend: {
            position: 'bottom',
            offsetX: 0,
            offsetY: 8
      
          },
          fill: {
            opacity: 1
          },
          dataLabels: {
            enabled: false
          }
        };
        const chart = new ApexCharts(document.querySelector("#dash-chart-02"), options);
        chart.render();
        const body = document.querySelector('body')
        if (body.classList.contains('dark')) {
          apexChartUpdate(chart, {
            dark: true
          })
        }
      
        document.addEventListener('ChangeColorMode', function (e) {
          apexChartUpdate(chart, e.detail)
        })
      }
})(jQuery)