//
//  BookedSeats.swift
//  CinemaBooking
//
//  Created by user245437 on 5/6/24.
//

import Foundation

class BookedSeats {
        
    var bookedSeats : [String: Set<String>] = [:]
    
    init() {
        
        readBookedSeatsFromFile()
        
    }

    func addBookedSeats(addedSeats: Set<String>, movie: String) {
        
        if bookedSeats[movie] == nil {
            bookedSeats[movie] = addedSeats
        } else {
            bookedSeats[movie]?.formUnion(addedSeats)
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
            bookedSeats = try decoder.decode([String: Set<String>].self, from: jsonData)
        } catch {
            print(error)
        }
        
    }
    
}


