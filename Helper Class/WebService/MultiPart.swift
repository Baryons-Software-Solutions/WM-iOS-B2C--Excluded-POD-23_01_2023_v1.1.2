//
//  MultiPart.swift
//  Order_Now_GIT
//
//  Created by Mac on 11/06/20.
//  Updated by Avinash on 11/03/22
//  Copyright © 2020 Mac. All rights reserved.
//

// This MultiPart class used for post adding some details and invoke the API's
import UIKit
import MobileCoreServices

let multiPartFieldName = "fieldName"
let multiPartPathURLs = "pathURL"


class MultiPart: NSObject {
    var session: URLSession?
    //This method is used for invoking the Web service URL
    func callPostWebService1<T : Decodable>(_ url_String: String, parameters: [String: Any]?, filePathArr arrFilePath: [[String:Any]]?, model : T.Type, completion: @escaping (_ success: Bool, _ object: AnyObject?)->()) {
        if isNoLoader == false {
            showLoader()
        }
        let boundary = generateBoundaryString()
        // configure the request
        let request = NSMutableURLRequest(url: URL(string: url_String)!)
        request.httpMethod = "POST"
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
            
        }
        // set content type
        let contentType = "multipart/form-data; boundary=\(boundary)"
        //        request.setValue("asdkjfklaj;fl;afnsvjafds", forHTTPHeaderField: "Authorization")
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        // create body
        let httpBody: Data? = createBody1(withBoundary: boundary, parameters: parameters, paths: arrFilePath)
        session = URLSession.shared
        
        let task = session?.uploadTask(with: request as URLRequest, from: httpBody, completionHandler: {(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void in
            hideLoader()
            if error != nil {
                
                print("error = \(error ?? 0 as! Error)")
                DispatchQueue.main.async(execute: {() -> Void in
                    completion( false , error as AnyObject)
                })
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print(convertedJsonIntoDict)
                    }
                    let dictResponse = try decoder.decode(model, from: data )
                    mainThread {
                        completion(true,dictResponse as AnyObject)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                    
                    do {
                        let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )
                        
                        let strStatus = dictResponse.success
                        mainThread {
                            // success = true = 1,  success = false = 0.
                            if strStatus == "1" {
                                completion(true,data as AnyObject)
                            }
                            else{
                                //completion(false, dictResponse.message as AnyObject)
                                UIApplication.topViewController()?.showCustomAlert(message: dictResponse.message,isSuccessResponse: false)
                                //                                      UIApplication.topViewController()?.view.makeToast(dictResponse.message)
                            }
                        }
                    } catch let error as NSError {
                        completion(false, error as AnyObject)
                    }
                }
            }
        })
        task?.resume()
    }
    func createBody1(withBoundary boundary: String, parameters: [String: Any]?, paths: [[String:Any]]?) -> Data {
        var httpBody = Data()
        
        // add params (all params are strings)
        if let parameters = parameters {
            for (parameterKey, parameterValue) in parameters {
                httpBody.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                httpBody.append("Content-Disposition: form-data; name=\"\(parameterKey)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                httpBody.append("\(parameterValue)\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        
        // add File data
        if let paths = paths {
            for pathDic in paths {
                for path: String in pathDic[multiPartPathURLs] as! [String] {
                    let filename: String = URL(fileURLWithPath: path).lastPathComponent
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path))
                        
                        let mimetype: String = mimeType(forPath: path)
                        httpBody.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                        httpBody.append("Content-Disposition: form-data; name=\"\(pathDic[multiPartFieldName] ?? "")\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
                        httpBody.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
                        httpBody.append(data)
                        httpBody.append("\r\n".data(using: String.Encoding.utf8)!)
                    } catch {
                        print("Unable to load data: \(error)")
                    }
                }
            }
        }
        httpBody.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        return httpBody
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    func mimeType(forPath path: String) -> String {
        // get a mime type for an extension using MobileCoreServices.framework
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}

