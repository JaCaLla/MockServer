var express = require('express')
var fs = require('fs');
var http = require('http');

var app = express()

var httpServer = http.createServer(app);

var port  = process.env.PORT || 3080;

var validDateCurrencyRate = {
     base: 'EUR',
    date: '2016-11-04',
    rates: {
        AUD: 1.4438,
        BGN: 1.9558,
        BRL: 3.5996,
        CAD: 1.4901,
        CHF: 1.0774,
        CNY: 7.4955,
        CZK: 27.021,
        DKK: 7.4412,
        GBP: 0.88808,
        HKD: 8.6034,
        HRK: 7.5135,
        HUF: 306.13,
        IDR: 14519.46,
        ILS: 4.2197,
        INR: 74.0395,
        JPY: 114.24,
        KRW: 1269.41,
        MXN: 21.2285,
        MYR: 4.6661,
        NOK: 9.1098,
        NZD: 1.5169,
        PHP: 53.837,
        PLN: 4.3188,
        RON: 4.4995,
        RUB: 71.0672,
        SEK: 9.963,
        SGD: 1.5357,
        THB: 38.803,
        TRY: 3.493,
        USD: 1.1093,
        ZAR: 15.0121
    }
}

var invalidRateFormat = {
     base: 'EUR',
    date: '2016-11-04',
    rates: {
        AUD: '1.4438'
    }
}

app.get('/latest', function(req,res){
    var base = req.query.base;
    var param = req.query.param
    
    if(param === "FORCE_BUSINESS_ERROR"){
        res.end(JSON.stringify(invalidRateFormat));
    }else if(param == "FORCE_SERVER_ERROR"){
        res.status(404);
        res.end()
    }else{
        res.end(JSON.stringify(validDateCurrencyRate));
    }



});

httpServer.listen(port);


