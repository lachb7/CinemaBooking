//
//  SessionData.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import Foundation

class SessionData: ObservableObject {
    
    @Published var movies : [String] = []
    let urlSession: URLSession
    let baseApiURL = "https://api-gate2.movieglu.com/cinemaShowTimes/?cinema_id=8842&date="
    
    init() {
        urlSession = URLSession(configuration: .default)
    }
        
    func getMoviesForDate(date: Date) {
                
        var urlRequest: URLRequest

        let apiURL = "\(baseApiURL)\(date.formatted(.iso8601.year().month().day().dateSeparator(.dash)))"
        
        movies = []
        
        if let url = URL(string: apiURL) {
            
            urlRequest = URLRequest(url: url)
            urlRequest.addValue("UTS_2", forHTTPHeaderField: "client")
            urlRequest.addValue("D5e9SkbW9e8AdprYDYWhr55i39rKNwAFff8RIkw2", forHTTPHeaderField: "x-api-key")
            urlRequest.addValue("Basic VVRTXzJfWFg6OGo1WUphZm96aU50", forHTTPHeaderField: "authorization")
            urlRequest.addValue("XX", forHTTPHeaderField: "territory")
            urlRequest.addValue("v200", forHTTPHeaderField: "api-version")
            urlRequest.addValue("-22.0;14.0", forHTTPHeaderField: "geolocation")
            urlRequest.addValue(Date().ISO8601Format(), forHTTPHeaderField: "device-datetime")
            
            let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let safeData = data {
                    guard !safeData.isEmpty else { return }
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: safeData, options: [])
                        if let json_dict = jsonObject as? [String: Any] {
                            if let films = json_dict["films"] as? Array<Any> {
                                for film in films {
                                    if let film_dict = film as? [String: Any] {
                                        if let film_name = film_dict["film_name"] as? String {
                                            DispatchQueue.main.async  {
                                                self.movies.append(film_name)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
            task.resume()
        }
    }
}
    
