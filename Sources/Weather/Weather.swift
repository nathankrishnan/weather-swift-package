import Foundation
import SwiftyJSON

public struct Weather {
    public let city: String
    private let baseURL = URL(string: "https://www.metaweather.com/api/location/")
    private let dispatchGroup = DispatchGroup()
   
    
    public init(forCity city: String) {
        self.city = city
    }
    
    public func fetchJSON(path: String, completion: @escaping (Result<JSON, Error>) -> Void) {
        enum fetchJSONError: Error {
            case invalidURL
            case missingData
        }
        
        guard let url = URL(string: path, relativeTo: baseURL) else {
            completion(.failure(fetchJSONError.invalidURL))
            return
        }
                
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(fetchJSONError.missingData))
                return
            }
            
            do {
                let jsonResult = try JSON(data: data)
                completion(.success(jsonResult))
            } catch {
                completion(.failure(error))
            }

        }
        
        dataTask.resume()
    }
    
    func getLocationId() throws -> Int? {
        var locationId: Int?
        var fetchError: Error?
        
        dispatchGroup.enter()
        fetchJSON(path: "search/?query=\(self.city)") { result in
            switch result {
            case .success(let json):
                locationId = json[0]["woeid"].int
                dispatchGroup.leave()
            case .failure(let error):
                print("Request failed with error: \(error)")
                locationId = nil
                fetchError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.wait()
        if let fetchError = fetchError {
            throw fetchError
        }
        return locationId
    }
    
    func getWeatherInfo() throws -> JSON? {
        let weatherInfo: [String: String]?
        var fetchError: Error?
        var output: JSON?
        
        guard let locationId = try getLocationId() else {
            output = nil
            return output
        }
        
        dispatchGroup.enter()
        fetchJSON(path: "\(locationId)") { result in
            switch result {
            case .success(let json):
                output = json
                dispatchGroup.leave()
            case .failure(let error):
                fetchError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.wait()
        if let fetchError = fetchError {
            throw fetchError
        }
        return output
    }
    
    private func convertCelToFar(celsiusTemp: Int) {
        
    }
    
    public func getCurrentConditions() {
        
    }
}
