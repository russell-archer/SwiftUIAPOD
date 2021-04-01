//
//  NetworkHelper.swift
//  SwiftUIAPOD
//
//  Created by Russell Archer on 25/03/2021.
//

import Foundation

struct NetworkHelper {

    /// Requests APOD image data from the NASA APOD API.
    /// Note that if `count` is > 1 the value of `date` is ignored and `count` random APOD images are requested.
    /// - Parameters:
    ///   - date: The date ("YYYY-MM-DD", e.g. "2021-03-24") of the requested image data. Defaults to nil, meaning today's APOD.
    ///   - count: The number of requested images. Defaults to 1, meaning today's APOD.
    ///   - handler: A closure that will be called when the image data becomes available.
    static func requestApodData(date: String? = nil,
                                count: Int = 1,
                                handler: @escaping ((Result<[ApodModel]?, NetworkingHelperError>) -> Void)) {
                
        let url = NetworkHelper.buildQuery(date: date, count: count)
        guard url != nil else {
            print("Can't build query: bad params")
            DispatchQueue.main.async { handler(.failure(.badParams)) }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!) { (json, response, error) in
            
            guard json != nil else {
                print("No data returned in server response")
                DispatchQueue.main.async { handler(.failure(.noData)) }
                return
            }
            
            // Check the response from the server (200 == OK)
            let httpResponse = response as! HTTPURLResponse
            guard httpResponse.statusCode == 200 else {
                print("Bad HTTP response status code: \(httpResponse.statusCode)")
                DispatchQueue.main.async { handler(.failure(.badResponse)) }
                return
            }
            
            // JSONEncoder and JSONDecoder allow you to easily encode/decode Codable structs/classes
            let decoder = JSONDecoder()

            if count == 1 {
                let apodData = try? decoder.decode(ApodModel.self, from: json!)
                guard apodData != nil else {
                    DispatchQueue.main.async { handler(.failure(.cantDecode)) }
                    return
                }
                
                DispatchQueue.main.async { handler(.success([apodData!])) }
                
            } else {
                let apodData = try? decoder.decode([ApodModel].self, from: json!)
                guard apodData != nil else {
                    DispatchQueue.main.async { handler(.failure(.cantDecode)) }
                    return
                }

                DispatchQueue.main.async { handler(.success(apodData!)) }
            }
        }
        
        task.resume()
    }
    
    private static func buildQuery(date: String?, count: Int) -> URL? {
        // Build the request URL
        // Examples:
        //  * https://api.nasa.gov/planetary/apod?api_key=Q43WCsMxZ9Eb05BXRgcvzmrIXrXgANqKOSjhWYWp
        //  * https://api.nasa.gov/planetary/apod?api_key=Q43WCsMxZ9Eb05BXRgcvzmrIXrXgANqKOSjhWYWp&count=5
        //  * https://api.nasa.gov/planetary/apod?api_key=Q43WCsMxZ9Eb05BXRgcvzmrIXrXgANqKOSjhWYWp&date=2021-01-03
        
        var request = URLComponents()
        request.scheme = "https"
        request.host = "api.nasa.gov"
        request.path = "/planetary/apod"
        request.queryItems = [URLQueryItem(name: "api_key", value: "Q43WCsMxZ9Eb05BXRgcvzmrIXrXgANqKOSjhWYWp")]
        
        if count > 1 {
            request.queryItems!.append(URLQueryItem(name: "count", value: String(count)))
        } else if date != nil {
            request.queryItems!.append(URLQueryItem(name: "date", value: date!))
        }
        
        return request.url
    }
}

enum NetworkingHelperError: Error {
    case noError        // No current error
    case badParams      // Can't make a valid URL using the supplied parameters
    case badResponse    // Server returned an error
    case noData         // No data returned by APOD API
    case cantDecode     // Unable to decode the JSON returned by APOD API
    
    func description() -> String {
        switch self {
            case .noError:      return "No Error"
            case .badParams:    return "Can't make a valid URL using the supplied parameters"
            case .badResponse:  return "Server returned an error"
            case .noData:       return "No data returned by APOD API"
            case .cantDecode:   return "Not Decodable (JSON couldn't be parsed)"
        }
    }
}
