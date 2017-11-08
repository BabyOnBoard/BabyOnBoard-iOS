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

  private static let apiUrl = "https://192.168.0.1/api/v1"

  private static let temperatureEndpoint = "/temperature/"

  private static let heartbeatEndpoint = "/heartbeat/"

  private static let breathingEndpoint = "/breathing/"

  private static let movementEndpoint = "/movementEndpoint/"


  static func currentTemperature(userInfo: Dictionary <String,Any>,
                         success: @escaping (AnyObject) -> Void = {_ in },
                         failure: @escaping (NSError) -> Void = {_ in }) -> Void{
    let params: Parameters = userInfo
    let url = apiUrl + temperatureEndpoint
    ApiConnector.alamofirePOST(url: url,
                        parameters: params,
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
