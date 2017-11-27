//
//  BabyOnBoardTests.swift
//  BabyOnBoardTests
//
//  Created by Felipe César Silveira de Assis on 31/08/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import XCTest
import OHHTTPStubs
import SwifterSwift

@testable import BabyOnBoard

class BabyOnBoardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testTemperature() {
      // Arrange
      // Setup network stubs
      let testHost = "0.0.0.0"

      let stubbedJSON = [
        "id": 300,
        "temperature": "38.9",
        "date": "2017-11-24",
        "time": "19:46:39.395240"
        ]
        as [String : AnyObject]

      //check again the path format!
      stub(condition:isHost(testHost) && isMethodGET() || isMethodPOST()) { request in
        print("inside STUB \(request)")
        return OHHTTPStubsResponse(
          jsonObject: stubbedJSON,
          statusCode: 200,
          headers: .none
        )
      }

      let expectation = self.expectation(description: "calls the callback with a resource object")

      let success = { (result:AnyObject) -> Void in
        let json = result as? Dictionary<String, AnyObject> ?? [:]
        expectation.fulfill()
        XCTAssertEqual(json.jsonString(), stubbedJSON.jsonString());
      }

      let error = { (result:NSError) -> Void in
        print("ERROR - \(result)")
        XCTAssertTrue(false)
      }

      // Setup system under test
      ApiConnector.temperature(success:success,failure:error)
      self.waitForExpectations(timeout: 10.0, handler: .none)
    }

  func testHeartbeats() {
    // Arrange
    // Setup network stubs
    let testHost = "0.0.0.0"

    let stubbedJSON = [
      "id": 254,
      "beats": 67,
      "date": "2017-11-10",
      "time": "15:41:29.357777"
      ]
      as [String : Any]

    //check again the path format!
    stub(condition:isHost(testHost) && isMethodGET() || isMethodPOST()) { request in
      print("inside STUB \(request)")
      return OHHTTPStubsResponse(
        jsonObject: stubbedJSON,
        statusCode: 200,
        headers: .none
      )
    }

    let expectation = self.expectation(description: "calls the callback with a resource object")

    let success = { (result:AnyObject) -> Void in
      let json = result as? Dictionary<String, AnyObject> ?? [:]
      expectation.fulfill()
      XCTAssertEqual(json.jsonString(), stubbedJSON.jsonString());
    }

    let error = { (result:NSError) -> Void in
      print("ERROR - \(result)")
      XCTAssertTrue(false)
    }

    // Setup system under test
    ApiConnector.heartbeat(success:success,failure:error)

    self.waitForExpectations(timeout: 10.0, handler: .none)
  }

  func testBreathing() {
    // Arrange
    // Setup network stubs
    let testHost = "0.0.0.0"

    let stubbedJSON = [
      "id": 254,
      "is_breathing": true,
      "date": "2017-11-10",
      "time": "15:41:29.359052"
      ]
      as [String : Any]

    //check again the path format!
    stub(condition:isHost(testHost) && isMethodGET() || isMethodPOST()) { request in
      print("inside STUB \(request)")
      return OHHTTPStubsResponse(
        jsonObject: stubbedJSON,
        statusCode: 200,
        headers: .none
      )
    }

    let expectation = self.expectation(description: "calls the callback with a resource object")

    let success = { (result:AnyObject) -> Void in
      let json = result as? Dictionary<String, AnyObject> ?? [:]
      expectation.fulfill()
      XCTAssertEqual(json.jsonString(), stubbedJSON.jsonString());
    }

    let error = { (result:NSError) -> Void in
      print("ERROR - \(result)")
      XCTAssertTrue(false)
    }

    // Setup system under test
    ApiConnector.breathing(success:success,failure:error)

    self.waitForExpectations(timeout: 10.0, handler: .none)
  }

  func testNoise() {
    // Arrange
    // Setup network stubs
    let testHost = "0.0.0.0"

    let stubbedJSON = [
      "is_crying": false
      ]
      as [String : Any]

    //check again the path format!
    stub(condition:isHost(testHost) && isMethodGET() || isMethodPOST()) { request in
      print("inside STUB \(request)")
      return OHHTTPStubsResponse(
        jsonObject: stubbedJSON,
        statusCode: 200,
        headers: .none
      )
    }

    let expectation = self.expectation(description: "calls the callback with a resource object")

    let success = { (result:AnyObject) -> Void in
      let json = result as? Dictionary<String, AnyObject> ?? [:]
      expectation.fulfill()
      XCTAssertEqual(json.jsonString(), stubbedJSON.jsonString());
    }

    let error = { (result:NSError) -> Void in
      print("ERROR - \(result)")
      XCTAssertTrue(false)
    }

    // Setup system under test
    ApiConnector.noise(success:success,failure:error)

    self.waitForExpectations(timeout: 10.0, handler: .none)
  }
    
}
