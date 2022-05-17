//
//  APIRequest.swift
//  ProjectSetUp
//
//  Created by PSSPL on 17/05/22.
//

import Foundation
import UIKit
import Alamofire

class APIRequestCall: NSObject {
    
    func checkInterNetConnection() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    
    func getRequest<T:Decodable>(strEndPoint:String,success successData: @escaping ((T) -> Void),error errorData : @escaping ((String) -> Void)) {
        let apiURl = APIURl + strEndPoint
        if !checkInterNetConnection() {
            errorData(AlertMessage.checkInterNetConnection.alertMessage())
        }
        Alamofire.request(apiURl, method: .get).responseJSON { response in
            switch response.result
            {
            case .success(_):
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: response.data!)
                    successData(jsonData)
                }
                catch {
                    errorData(AlertMessage.jsonIssue.alertMessage())
                }
                break
            case .failure(let error):
                errorData(error.localizedDescription)
                break
               
            }
        }
    }
    
    func postRequest<T:Decodable>(strEndPoint:String,parameters:[String:Any],success successData: @escaping ((T) -> Void),error errorData : @escaping ((String) -> Void)) {
        let apiURl = APIURl + strEndPoint
        if !checkInterNetConnection() {
            errorData(AlertMessage.checkInterNetConnection.alertMessage())
        }
        Alamofire.request(apiURl, method: .post, parameters: parameters).responseJSON { response in
            switch response.result
            {
            case .success(_):
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: response.data!)
                    successData(jsonData)
                }
                catch {
                    errorData(AlertMessage.jsonIssue.alertMessage())
                }
                break
            case .failure(let error):
                errorData(error.localizedDescription)
                break
               
            }
        }
    }
    
    func callsendImageAPI(param:[String: Any],arrImage:[UIImage],arrImageName:[String],imageKey:String,URlName:String,controller:UIViewController,error errorData : @escaping ((String) -> Void),success successData:@escaping((String) -> Void)) {
        
        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in param {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
//                if key == "img" {
//                    let image:UIImage = value as! UIImage
//                    guard let imgData = image.jpegData(compressionQuality: 1) else { return }
//                    multipartFormData.append(imgData, withName: imageKey, fileName: "" + ".jpeg", mimeType: "image/jpeg")
//                }
            }
            
            for i in 0...arrImage.count - 1 {
                let img = arrImage[i]
                let nameOfImage = arrImageName[i]
                guard let imgData = img.jpegData(compressionQuality: 1) else { return }
                multipartFormData.append(imgData, withName: imageKey, fileName: nameOfImage + ".jpeg", mimeType: "image/jpeg")
            }
            
//            for img in arrImage {
//                guard let imgData = img.jpegData(compressionQuality: 1) else { return }
//                multipartFormData.append(imgData, withName: imageKey, fileName: "" + ".jpeg", mimeType: "image/jpeg")
//            }
            
        },usingThreshold: UInt64.init(),
                         to: URL.init(string: URlName)!,
                         method: .post,
                         headers: headers, encodingCompletion: {(result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    successData("\(progress.estimatedTimeRemaining ?? 0.0)")
                    //print("Uploading")
                })
                break
            case .failure(let encodingError):
                print("err is \(encodingError)")
                errorData(encodingError.localizedDescription)
                break
            }
        })
    }
            
//            .response{ response in
//            if((response.error != nil)){
//                do{
//                    if let jsonData = response.data{
//                        let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
//                        print(parsedData)
//
//                        let status = parsedData[Message.Status] as? NSInteger ?? 0
//
//                        if (status == 1){
//                            if let jsonArray = parsedData["data"] as? [[String: Any]] {
//                                withblock(jsonArray as AnyObject)
//                            }
//
//                        }else if (status == 2){
//                            print("error message")
//                        }else{
//                            print("error message")
//                        }
//                    }
//                }catch{
//                    print("error message")
//                }
//            }else{
//                 print(response.error!.localizedDescription)
//            }
//        }
//    }
    
        
//    func upload(image: Data,imageName:String ,to url: Alamofire.URLRequestConvertible, params: [String: Any],error errorData : @escaping ((String) -> Void),success successData:@escaping((String) -> Void)) {
//        Alamofire.upload(multipartFormData: { multiPart in
//            for (key, value) in params {
//                if let temp = value as? String {
//                    multiPart.append(temp.data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? Int {
//                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? NSArray {
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
//                        } else
//                        if let num = element as? Int {
//                            let value = "\(num)"
//                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//            }
//            multiPart.append(image, withName: imageName, fileName: imageName + ".png", mimeType: "image/png")
//        }, with: url, encodingCompletion: {(result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (progress) in
//                    successData("\(progress.estimatedTimeRemaining ?? 0.0)")
//                  //print("Uploading")
//                })
//                break
//            case .failure(let encodingError):
//                print("err is \(encodingError)")
//                errorData(encodingError.localizedDescription)
//                break
//                }
//            })
////        .uploadProgress(queue: .main, closure: { progress in
////            //Current upload progress of file
////            print("Upload Progress: \(progress.fractionCompleted)")
////        })
////        .responseJSON(completionHandler: { data in
////            //Do what ever you want to do with response
////        })
//    }
}

