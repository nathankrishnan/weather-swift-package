import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    let weather = Weather(forCity: "San Francisco")
    
    func testCreateWeatherInstance() throws {
        let expectation = expectation(description: "Create a Weather instance")
        let weather = Weather(forCity: "New York")
        
        print("URL ENCODED NAME: \(weather.city)")
        XCTAssertTrue((type(of: weather.city)) == String.self)
        if let condition = weather.condition, let temp = weather.temperature {
            print("TEMP: \(temp)")
            print("CONDITION: \(condition)")
            
            XCTAssertTrue((type(of: temp)) == String.self)
            XCTAssertTrue((type(of: condition)) == String.self)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetLocationId() throws {
        let expectation = expectation(description: "Get Location Id")
        
        if let id = try weather.getLocationId() {
            print("URL ENCODED NAME: \(weather.city)")
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
