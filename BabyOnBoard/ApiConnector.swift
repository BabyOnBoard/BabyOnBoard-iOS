//
//  ApiConnector.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 08/11/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit
import Alamofire
//import SwifterSwift

class ApiConnector{

  //TODO: make an inputable address here!!
  private static let apiUrl = "http://192.168.0.154:8000/api/v1"

  private static let temperatureEndpoint = "/temperature/"

  private static let heartbeatEndpoint = "/heartbeat/"

  private static let breathingEndpoint = "/breathing/"

  private static let movementEndpoint = "/movementEndpoint/"


  static func temperature(year:Int = 0, month:Int = 0, day:Int = 0,
                          success: @escaping (AnyObject) -> Void = {_ in },
                                 failure: @escaping (NSError) -> Void = {_ in }) -> Void{
//    let params: Parameters = userInfo
    var url = apiUrl + temperatureEndpoint

    if year != 0 {
      url = url + year.description
    }
    if month != 0{
      url = url + "/" + String(format: "%02d", month)
    }
    if day != 0{
      url = url + "/" + String(format: "%02d", day)
    }

    ApiConnector.alamofireGET(url: url,
                        successCallback: success,
                        failureCallBack: failure)

  }
}


extension ApiConnector {

  internal static func alamofireGET(url: String,
                                    successCallback:@escaping (AnyObject) -> Void = {_ in } ,
                                    failureCallBack: @escaping (NSError) -> Void = {_ in } ) -> Void {
    Alamofire.request(url,
                      method:.get,
                      encoding: JSONEncoding.default)
      .validate(statusCode: 200..<300)
      .responseJSON { response in

        switch response.result{
        case .success:
          if let JSON = response.result.value as AnyObject?{
            successCallback(JSON)
          }
          break
        case .failure(let error):
          failureCallBack(error as NSError)
          break
        }
    }
  }


  internal static func alamofirePOST(url: String,
                                     parameters:Parameters,
                                     successCallback:@escaping (AnyObject) -> Void = {_ in } ,
                                     failureCallBack: @escaping (NSError) -> Void = {_ in } ) -> Void {
      Alamofire.request(url,
                      method:.post,
                      parameters: parameters,
                      encoding: JSONEncoding.default)
      .validate(statusCode: 200..<300)
      .responseJSON { response in

        switch response.result{
        case .success:
          if let JSON = response.result.value as AnyObject?{
            successCallback(JSON)
          }
          break
        case .failure(let error):
          failureCallBack(error as NSError)
          break
        }
    }
  }

  internal static func alamofireDELETE(url: String,
                                       successCallback:@escaping (AnyObject) -> Void = {_ in } ,
                                       failureCallBack: @escaping (NSError) -> Void = {_ in } ) -> Void {


    Alamofire.request(url,
                      method:.delete,
                      encoding: JSONEncoding.default)
      .validate(statusCode: 200..<300)
      .responseJSON { response in

        switch response.result{
        case .success:
          if let JSON = response.result.value as AnyObject?{
            successCallback(JSON)
          }
          break
        case .failure(let error):
          failureCallBack(error as NSError)
          break
        }
    }
  }

}
