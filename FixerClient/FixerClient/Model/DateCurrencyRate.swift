//
//  DateCurrencyRate.swift
//  currTV
//
//  Created by Admin on 05/11/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

enum RateCode:String{
    case EUR = "EUR"
    case USD = "USD"
    case AUD = "AUD"
    case BGN = "BGN"
    case BRL = "BRL"
    case CAD = "CAD"
    case CHF = "CHF"
    case CNY = "CNY"
    case CZK = "CZK"
    case DKK = "DKK"
    case GBP = "GBP"
    case HKD = "HKD"
    case HRK = "HRK"
    case HUF = "HUF"
    case IDR = "IDR"
    case ILS = "ILS"
    case INR = "INR"
    case JPY = "JPY"
    case KRW = "KRW"
    case MXN = "MXN"
    case MYR = "MYR"
    case NOK = "NOK"
    case NZD = "NZD"
    case PHP = "PHP"
    case PLN = "PLN"
    case RON = "RON"
    case RUB = "RUB"
    case SEK = "SEK"
    case SGD = "SGD"
    case THB = "THB"
    case TRY = "TRY"
    case ZAR = "ZAR"
}


struct DateCurrencyRate {
    let base : String
    let date : Date
    var rates:[RateCode:NSNumber] = [:]
    
    
    init?(dictionary:Any){
        
        guard let dicJSON:[String:AnyObject] = dictionary as? [String:AnyObject],
            let base:String = dicJSON["base"] as! String?,
            base.characters.count == 3,
            let dateStr:String = dicJSON["date"] as! String?,
            let dicRates:[String:AnyObject] = dicJSON["rates"] as? [String:AnyObject] else {return nil}
        
        self.base = base
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateStr){
            self.date = date
        }else{
            return nil
        }
        
        for (rateCode, rateValue) in dicRates {
            if let code:RateCode = RateCode(rawValue:rateCode),
                let rate:NSNumber =  rateValue as? NSNumber{
                rates[code] = rate as NSNumber?
            }else{
                return nil
            }
            
        }
        
    }
}
