//
//  BookedSeats.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import Foundation

class BookedSeats {
        
    var bookedSeats : [String : [String: Set<String>]] = [:]
    
    init() {
        
        readBookedSeatsFromFile()
        
    }

    func addBookedSeats(addedSeats: Set<String>, movie: String, date: Date) {
        
        let dateShort : String = date.formatted(.iso8601.year().month().day().dateSeparator(.dash))
        
        print(dateShort)
        print(addedSeats)
        
        if bookedSeats[dateShort] == nil {
            bookedSeats[dateShort] = [ movie: addedSeats ]
        } else if bookedSeats[dateShort]?[movie] == nil {
            bookedSeats[dateShort]?[movie] = addedSeats
        } else {
            bookedSeats[dateShort]?[movie]?.formUnion(addedSeats)
        }
    
        writeBookedSeatsToJsonFile()

    }
    
    
    // this function writes the booked seats set to the JSON file
    func writeBookedSeatsToJsonFile() {
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(bookedSeats)
            let fileURL = URL.documentsDirectory.appending(path: "seats.json")
            try jsonData.write(to: fileURL)
        } catch {
            print(error)
        }
        
    }
    
    // this function reads booked seats set from the JSON file
    func readBookedSeatsFromFile() {
        
        let decoder = JSONDecoder()
        
        do {
            let fileURL = URL.documentsDirectory.appending(path: "seats.json")
            let jsonData = try Data(contentsOf: fileURL)
            bookedSeats = try decoder.decode([String: [String: Set<String>]].self, from: jsonData)
        } catch {
            print(error)
        }
        
    }
    
}


