//
//  FixerService.swift
//  FixerClient
//
//  Created by Admin on 08/11/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

//
//  CurrencyService.swift
//  currTV
//
//  Created by Admin on 05/11/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import Alamofire

class FixerService {
    static let sharedInstance = FixerService()
    
    var baseURL:String{
        get{
            if let _ = ProcessInfo().environment["LOCAL_MOCK_SERVER"]{
                return "http://localhost:3080"
            } else{
                return "https://api.fixer.io"
            }
        }
    }
    
    private init() {}
    
    public func latest(base :String ,
                       parameterWithDefault: String? = nil,
                       success succeed : @escaping ((DateCurrencyRate) -> ()),
                       serverFailure serverFail : @escaping ((NSError) -> ()),
                       businessFailure businessFail : @escaping ((NSError) -> ())){
        
        var parameters: Parameters = ["base": "USD"]
        if let _ = ProcessInfo().environment["LOCAL_MOCK_SERVER"],
            let param:String = parameterWithDefault {
            parameters["param"]=param
        }
        
        Alamofire.request(self.baseURL + "/latest",parameters:parameters).validate(statusCode: 200..<401).responseJSON { response in
            
            switch response.result {
            case .success:
                if let dateCurrencyRate:DateCurrencyRate = DateCurrencyRate(dictionary: response.result.value){
                    succeed(dateCurrencyRate)
                }else{
                    businessFail(NSError())
                }
            case .failure(let error):
                serverFail(error as NSError)
            }
        }
    }
    
}

