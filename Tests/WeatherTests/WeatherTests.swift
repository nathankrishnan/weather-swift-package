import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    let weather = Weather(forCity: "seattle")
        
    func testGetLocationId() throws {
        let expectation = expectation(description: "Get Location Id")
        
        if let result = try weather.getLocationId() {
            print("Location Id: \(result)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
