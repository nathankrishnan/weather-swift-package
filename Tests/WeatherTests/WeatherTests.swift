import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    let weather = Weather(forCity: "seattle")

    func testGetLocationId() throws {
        let expectation = expectation(description: "Get Location Id")
        
        if let id = try weather.getLocationId() {
            print("LOCATION ID: \(id)")
            
            XCTAssertTrue((type(of: id)) == Int.self)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetCurrentConditions() throws {
        let expectation = expectation(description: "Get Current Weather Conditions")
        
        if let result = try weather.getCurrentConditions() {
            let temp = result["temperature"]!
            let condition = result["condition"]!
            
            print("TEMP: \(temp)")
            print("CONDITION: \(condition)")
            
            XCTAssertTrue((type(of: temp)) == String.self)
            XCTAssertTrue((type(of: condition)) == String.self)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
