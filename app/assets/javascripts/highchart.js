function initChart(data) {
  Highcharts.setOptions({
    global: {
      timezone: "Europe/Oslo"
    }
  });
  $('.chart-field').highcharts({
    title: '1231231',
    credits: {
        enabled: true
    },
    xAxis: {
      categories: data.keys
    },
    legend: false,
    yAxis: {
      min:0,
      tickAmount: 6,
      title: false,
      height: '100%',
    },
    plotOptions: {
      line: {
          dataLabels: {
              enabled: true
          },
          enableMouseTracking: false
      }
    },
    series: [{
      data: data.values,
    }]
  });
}

function initBarChartYear(data) {
  Highcharts.setOptions({
    global: {
      timezone: "Europe/Oslo"
    }
  });
  $('.bar-chart-field').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: 'Score statistic'
    },
    xAxis: {
      categories: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Number of score'
      },
      stackLabels: {
        enabled: true,
        style: {
          fontWeight: 'bold',
          color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
        }
      }
    },
    legend: {
      align: 'right',
      x: -30,
      verticalAlign: 'top',
      y: 25,
      floating: true,
      backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
      borderColor: '#CCC',
      borderWidth: 1,
      shadow: false
    },
    tooltip: {
      headerFormat: '<b>{point.x}</b><br/>',
      pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
    },
    plotOptions: {
      column: {
        stacking: 'normal',
        dataLabels: {
          enabled: true,
          color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
        }
      }
    },
    series: [{
      name: '0-10',
      data: [data["1"][0], data["2"][0], data["3"][0], data["4"][0], data["5"][0], data["6"][0], data["7"][0], data["8"][0], data["9"][0], data["10"][0], data["11"][0], data["12"][0]]
    }, {
      name: '11-15',
      data: [data["1"][1], data["2"][1], data["3"][1], data["4"][1], data["5"][1], data["6"][1], data["7"][1], data["8"][1], data["9"][1], data["10"][1], data["11"][1], data["12"][1]]
    }, {
      name: '15-20',
      data: [data["1"][2], data["2"][2], data["3"][2], data["4"][2], data["5"][2], data["6"][2], data["7"][2], data["8"][2], data["9"][2], data["10"][2], data["11"][2], data["12"][2]]
    }]
  });
};

function initBarChartMonth(data) {
  Highcharts.setOptions({
    global: {
      timezone: "Europe/Oslo"
    }
  });
  $('.bar-chart-field').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: 'Score statistic'
    },
    xAxis: {
      categories: Object.keys(data)
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Number of score'
      },
      stackLabels: {
        enabled: true,
        style: {
          fontWeight: 'bold',
          color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
        }
      }
    },
    legend: {
      align: 'right',
      x: -30,
      verticalAlign: 'top',
      y: 25,
      floating: true,
      backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
      borderColor: '#CCC',
      borderWidth: 1,
      shadow: false
    },
    tooltip: {
      headerFormat: '<b>{point.x}</b><br/>',
      pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
    },
    plotOptions: {
      column: {
        stacking: 'normal',
        dataLabels: {
          enabled: true,
          color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
        }
      }
    },
    series: [{
      name: '0-10',
      data: [data[Object.keys(data)[0]][0], data[Object.keys(data)[1]][0], data[Object.keys(data)[2]][0], data[Object.keys(data)[3]][0], data[Object.keys(data)[4]][0]]
    }, {
      name: '11-15',
      data: [data[Object.keys(data)[0]][1], data[Object.keys(data)[1]][1], data[Object.keys(data)[2]][1], data[Object.keys(data)[3]][1], data[Object.keys(data)[4]][1]]
    }, {
      name: '15-20',
      data: [data[Object.keys(data)[0]][2], data[Object.keys(data)[1]][2], data[Object.keys(data)[2]][2], data[Object.keys(data)[3]][2], data[Object.keys(data)[4]][2]]
    }]
  });
}

function initCustomBarChart(data) {
  Highcharts.setOptions({
    global: {
      timezone: "Europe/Oslo"
    }
  });
  $('.bar-chart-field').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: 'Score statistic'
    },
    xAxis: {
      categories: Object.keys(data)
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Number of score'
      },
      stackLabels: {
        enabled: true,
        style: {
          fontWeight: 'bold',
          color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
        }
      }
    },
    legend: {
      align: 'right',
      x: -30,
      verticalAlign: 'top',
      y: 25,
      floating: true,
      backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
      borderColor: '#CCC',
      borderWidth: 1,
      shadow: false
    },
    tooltip: {
      headerFormat: '<b>{point.x}</b><br/>',
      pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
    },
    plotOptions: {
      column: {
        stacking: 'normal',
        dataLabels: {
          enabled: true,
          color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
        }
      }
    },
    series: [
      {name: "0-10", data: Object.values(data).map((e) => e[0])},
      {name: "11-15", data: Object.values(data).map((e) => e[1])},
      {name: "15-20", data: Object.values(data).map((e) => e[2])}
    ]
  });
}

function createScoreChart(){
  var url = $('#main-content').attr('data-url');
  var option = $('.custom-select select').val();

  if($('body').find('.bar-chart-field')[0] != null ) {
    $.ajax({
      type: "GET",
      url: `${url}/tests_chart.json`,
      dataType: "json",
      data: {
        option: option
      }
    })
    .done(function(data1){
      if(option == "0")
        initBarChartYear(data1);
      else if (option == "1")
        initBarChartMonth(data1);
      else if (option == "3")
        initCustomBarChart(data1);
    })
  }
}

$(document).ready(function() {
  var url = $('#main-content').attr('data-url');

  if($('body').find('.chart-field')[0] != null){
    $.ajax({
      type: "GET",
      url: `${url}/users_chart.json`,
      dataType: "json"
    })
    .done(function(data){
      initChart(data);
    });

    createScoreChart();
  }

  $('body').on('click', '#apply-filter', function(){
    if($('#fixed-options').val() == "1" || $('#fixed-options').val() == "0"){
      createScoreChart();
    } else {
      var start = $('#start_time').val();
      var end = $('#end_time').val()
      var stepType = $('#step-type').val();
      var option = $('#fixed-options').val()
      $.ajax({
        type: "GET",
        url: `${url}/tests_chart.json`,
        dataType: "json",
        data: {
          start: start,
          end: end,
          step_type: stepType,
          option: option
        }
      })
      .done(function(data){
        initCustomBarChart(data);
      })
    }
  });

  $('body').on('change', '#fixed-options', function(){
    if($(this).val() == "3"){
      $('.custom-filter-field').removeClass('hidden');
    } else
      $('.custom-filter-field').addClass('hidden');
  })
});
