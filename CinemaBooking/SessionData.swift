//
//  SessionData.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import Foundation

struct MovieInfo: Hashable, Identifiable {
    
    let title: String
    let posterURL: String
    let id : Int
    
}

// this class allows for the retrieval of movie titles and poster image URLs from the MovieGlu API
class SessionData: ObservableObject {
    
    @Published var movies : [MovieInfo] = []
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
            
            // add HTTP headers, as required by the API
            urlRequest.addValue("UTS_2", forHTTPHeaderField: "client")
            urlRequest.addValue("D5e9SkbW9e8AdprYDYWhr55i39rKNwAFff8RIkw2", forHTTPHeaderField: "x-api-key")
            urlRequest.addValue("Basic VVRTXzJfWFg6OGo1WUphZm96aU50", forHTTPHeaderField: "authorization")
            urlRequest.addValue("XX", forHTTPHeaderField: "territory")
            urlRequest.addValue("v200", forHTTPHeaderField: "api-version")
            urlRequest.addValue("-22.0;14.0", forHTTPHeaderField: "geolocation")
            urlRequest.addValue(Date().ISO8601Format(), forHTTPHeaderField: "device-datetime")
            
            // perform the URL request
            let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                // get the film title, id and poster image URL from the response
                if let safeData = data {
                    guard !safeData.isEmpty else { return }
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: safeData, options: [])
                        if let jsonDict = jsonObject as? [String: Any] {
                            if let films = jsonDict["films"] as? Array<Any> {
                                for film in films {
                                    if let filmDict = film as? [String: Any] {
                                        if let filmName = filmDict["film_name"] as? String {
                                            if let filmId = filmDict["film_id"] as? Int {
                                                if let imagesDict = filmDict["images"] as? [String: Any] {
                                                    if let posterDict = imagesDict["poster"] as? [String: Any] {
                                                        if let oneDict = posterDict["1"] as? [String: Any] {
                                                            if let mediumDict = oneDict["medium"] as? [String:Any] {
                                                                if let imageURL = mediumDict["film_image"] as? String {
                                                                    DispatchQueue.main.async {
                                                                        self.movies.append(MovieInfo(title:filmName, posterURL: imageURL, id: filmId))
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
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
    
