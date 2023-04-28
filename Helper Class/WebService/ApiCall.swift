//
//  ApiCall.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
//  Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

// This APICall class used for invoking all the API's

import Foundation
class APICall: NSObject {
    
    let constValueField = "application/json"
    let constHeaderField = "Content-Type"
    let bearer = "Bearer "
    func postA<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true , isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod3(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "POST", model: model , isLoader : isLoader , isErrorToast : isErrorToast , completion: completion)
        
    }
    // This method is used invoking API  for String AnyObjects
    func requestMethod3<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: NSString, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = method as String
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue(bearer + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
            
        }
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            hideLoader()
            
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                //                Utility().hideLoader()
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(ChangeStatusResponseModel.self, from: data )
                let strStatus = dictResponse.success
                
                //let strStatus = dictResponse.status!
                
                // "1" is used for  If success response is true
                if strStatus == "1" {
                    let dictResponsee = try decoder.decode(model, from: data )
                    mainThread {
                        completion(true,dictResponsee as AnyObject)
                    }
                }
                else{
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                        if isErrorToast {
                            showToast(message: dictResponse.message )
                            //   UIApplication.topViewController()?.view.makeToast(dictResponse.message)
                        }
                    }
                }
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    // This method is used for invoking the post API's calling
    func post(apiUrl : String, requestPARAMS: String, isTimeOut: Bool, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isNoLoader == false{
            showLoader()
        }
        requestMethod(apiUrl: apiUrl, params: requestPARAMS , isTimeOut : isTimeOut, method: "POST", completion: completion)
    }
    // This method is used for not displaying the loader
    func postNoLoader(apiUrl : String, requestPARAMS: String, isTimeOut: Bool, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        hideLoader()
        requestMethod(apiUrl: apiUrl, params: requestPARAMS , isTimeOut : isTimeOut, method: "POST", completion: completion)
    }
    
    // This function is used for invoking the post method  API's calling without loader
    func post1(apiUrl : String, requestPARAMS: String, isLoader : Bool = true , isTimeOut: Bool, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod1(apiUrl: apiUrl, params: requestPARAMS , isLoader : isLoader, isTimeOut : isTimeOut, method: "POST", completion: completion)
    }
    // This function is used for invoking the put method  API's calling
    func put(apiUrl : String, requestPARAMS: String, isTimeOut: Bool, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isNoLoader == false{
            showLoader()
        }
        requestMethod(apiUrl: apiUrl, params: requestPARAMS , isTimeOut : isTimeOut, method: "PUT", completion: completion)
    }
    // This function is used for invoking the get method  API's calling
    func get(apiUrl : String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isNoLoader == false{
            showLoader()
        }
        
        requestGetMethod(apiUrl: apiUrl, method: "GET", completion: completion)
    }
    
    // This function is used for invoking the delete method  API's calling
    func Delete(apiUrl : String,tag : Int, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isNoLoader == false{
            showLoader()
        }
        
        requestDeleteMethod(apiUrl: apiUrl, method: "DELETE", tag : tag , completion: completion)
    }
    
    //This method is used for invoking the API call
    func requestMethod1(apiUrl : String, params: String,isLoader : Bool = true, isTimeOut : Bool, method: NSString, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        if isLoader {
            showLoader()
        }
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = method as String
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue(bearer + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
            
        }
        request.httpBody = params.data(using: String.Encoding.utf8);
        let str = String(decoding: request.httpBody!, as: UTF8.self)
        print("requestMethod1 API Name:: \n \(apiUrl)")
        print("BODY \n \(str)")
        print("HEADERS \n \(request.allHTTPHeaderFields)")
        
        
        var sessionConfig = URLSession()
        let session = URLSessionConfiguration.default
        if isTimeOut == true {
            session.timeoutIntervalForRequest = 60.0
            session.timeoutIntervalForResource = 60.0
            sessionConfig = URLSession(configuration: session)
        } else {
            sessionConfig = URLSession(configuration: URLSessionConfiguration.default)
            
        }
        
        let task: URLSessionDataTask = sessionConfig.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                hideLoader()
                let str = Constants.AlertMessage.msgSlowNetworkConnection
                // isWSCall = true
                completion(false, str as AnyObject)
                return
            }
            
            hideLoader()
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )
                
                let strStatus = dictResponse.success
                // "1" is used for  If success response is true
                if strStatus == "1" {
                    completion(true,data as AnyObject)
                    // "0" is used for  If success response is false
                } else if strStatus == "0" {
                    completion(true,data as AnyObject)
                    DispatchQueue.main.async {
                        UIApplication.topViewController()?.showToast(message: dictResponse.message)
                    }
                    // "101" is used for kFirebaseCoreErrorDomain eeror
                } else if strStatus == "101" {
                    completion(true,data as AnyObject)
                    //"999" is used for unsupportedType
                } else  if strStatus == "999" {
                    completion(true,data as AnyObject)
                } else  {
                    completion(false, dictResponse.message as AnyObject)
                    UIApplication.topViewController()?.showToast(message: dictResponse.message)
                    
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, nil)
            }
        })
        task.resume()
    }
    
    // In this method are used for generate the token
    func  getTokenValue() -> String {
        var token = ""
        // This "false" is used for Guest flow, and "true" is used for normal flow
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            token = ""
        }else{
            token = (USERDEFAULTS.getDataForKey(.accessToken) as! String)
        }
        return token
    }
    //This method is used for invoking the API call
    func requestMethod(apiUrl : String, params: String, isTimeOut : Bool, method: NSString, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = method as String
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue(bearer + getTokenValue(), forHTTPHeaderField: "Authorization")
            
        }
        request.httpBody = params.data(using: String.Encoding.utf8);
        let str = String(decoding: request.httpBody!, as: UTF8.self)
        print("requestMethod API Name:: \n \(apiUrl)")
        print("BODY \n \(str)")
        print("HEADERS \n \(request.allHTTPHeaderFields)")
        
        var sessionConfig = URLSession()
        let session = URLSessionConfiguration.default
        if isTimeOut == true {
            session.timeoutIntervalForRequest = 60.0
            session.timeoutIntervalForResource = 60.0
            sessionConfig = URLSession(configuration: session)
        } else {
            sessionConfig = URLSession(configuration: URLSessionConfiguration.default)
        }
        
        let task: URLSessionDataTask = sessionConfig.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                hideLoader()
                let str = Constants.AlertMessage.msgSlowNetworkConnection
                // isWSCall = true
                completion(false, str as AnyObject)
                return
            }
            
            hideLoader()
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )
                
                let strStatus = dictResponse.success
                
                // "1" is used for  If success response is true
                if strStatus == "1" {
                    completion(true,data as AnyObject)
                    // "0" is used for  If success response is false
                } else if strStatus == "0" {
                    completion(true,data as AnyObject)
                    DispatchQueue.main.async {
                        //  self.showCustomAlert(message: dictResponse.message,isSuccessResponse: false)
                        if dictResponse.message != "Outlet not found."{
                            
                            //   UIApplication.topViewController()?.showCustomAlert(message: dictResponse.message,isSuccessResponse: false)
                        }
                    }
                    // "101" is used for kFirebaseCoreErrorDomain eeror
                } else if strStatus == "101" {
                    completion(true,data as AnyObject)
                    //"999" is used for unsupportedType
                } else  if strStatus == "999" {
                    completion(true,data as AnyObject)
                } else  {
                    completion(false, dictResponse.message as AnyObject)
                    UIApplication.topViewController()?.showToast(message: dictResponse.message)
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, nil)
            }
        })
        task.resume()
    }
    //This method is used for request post method.
    func requestMethodPost(apiUrl : String, params: [String : Any], isTimeOut : Bool, method: NSString, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = method as String
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue(bearer + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
            
        }
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        var sessionConfig = URLSession()
        let session = URLSessionConfiguration.default
        if isTimeOut == true {
            session.timeoutIntervalForRequest = 60.0
            session.timeoutIntervalForResource = 60.0
            sessionConfig = URLSession(configuration: session)
        } else {
            sessionConfig = URLSession(configuration: URLSessionConfiguration.default)
            
        }
        
        let task: URLSessionDataTask = sessionConfig.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                hideLoader()
                let str = Constants.AlertMessage.msgSlowNetworkConnection
                // isWSCall = true
                completion(false, str as AnyObject)
                return
            }
            
            hideLoader()
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )
                
                let strStatus = dictResponse.success
                // "1" is used for  If success response is true
                if strStatus == "1" {
                    completion(true,data as AnyObject)
                    // "0" is used for  If success response is false
                } else if strStatus == "0" {
                    completion(true,data as AnyObject)
                    // "101" is used for kFirebaseCoreErrorDomain eeror
                } else if strStatus == "101" {
                    completion(true,data as AnyObject)
                    //"999" is used for unsupportedType
                } else  if strStatus == "999" {
                    completion(true,data as AnyObject)
                } else  {
                    completion(false, dictResponse.message as AnyObject)
                    UIApplication.topViewController()?.showToast(message: dictResponse.message)
                    
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, nil)
            }
        })
        task.resume()
    }
    // This method is used for request get method.
    func requestGetMethod(apiUrl : String, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = method as String
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            //  request.setValue(bearer + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
            request.setValue(bearer + getTokenValue(), forHTTPHeaderField: "Authorization")
        }
        print("requestGetMethod API Name:: \n \(apiUrl)")
        print("HEADERS:: \n \(request.allHTTPHeaderFields)")
        
        var sessionConfig = URLSession()
        let session = URLSessionConfiguration.default
        
        sessionConfig = URLSession(configuration: URLSessionConfiguration.default)
        
        let task: URLSessionDataTask = sessionConfig.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                hideLoader()
                let str = Constants.AlertMessage.msgSlowNetworkConnection
                // isWSCall = true
                completion(false, str as AnyObject)
                return
            }
            
            hideLoader()
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )
                
                let strStatus = dictResponse.success
                
                // "1" is used for  If success response is true
                if strStatus == "1" {
                    completion(true,data as AnyObject)
                    // "0" is used for  If success response is false
                } else if strStatus == "0" {
                    completion(true,data as AnyObject)
                    // "101" is used for kFirebaseCoreErrorDomain eeror
                } else if strStatus == "101" {
                    completion(true,data as AnyObject)
                    //"999" is used for unsupportedType
                } else  if strStatus == "999" {
                    completion(true,data as AnyObject)
                } else  {
                    completion(false, dictResponse.message as AnyObject)
                    UIApplication.topViewController()?.showToast(message: dictResponse.message)
                    
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, nil)
            }
        })
        task.resume()
        
    }
    
    //This method is used for request delete method.
    func requestDeleteMethod(apiUrl : String, method: String,tag: Int, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = method
        request.addValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            hideLoader()
            
            // Check for error
            if error != nil{
                return
            }
            
            // Print out response string
            _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            // print("responseString = \(responseString)")
            
            do {
                if tag == 0 {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    {
                        completion(true, convertedJsonIntoDict)
                    }
                    else{
                        completion(false, nil)
                    }}
                else
                {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
                    {
                        completion(true, convertedJsonIntoDict)
                    }
                    else{
                        completion(false, nil)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
}

