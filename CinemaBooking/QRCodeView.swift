//
//  QRCodeView.swift
//  CinemaBooking
//
//  Created by 騎呢怪 on 13/5/2024.
//

import SwiftUI

struct QRCodeView: View {
    
    var selectedSeats : Set<String>
    var selectedMovie: String
    var bookingName: String
    var selectedDate: Date
    
    init(selectedSeats: Set<String>, selectedMovie: String, bookingName: String, selectedDate: Date) {
        self.selectedSeats = selectedSeats
        self.selectedMovie = selectedMovie
        self.bookingName = bookingName
        self.selectedDate = selectedDate
    }
    
    var body: some View {
        Text("Payment Successful")
            .font(.title)
            .bold()
        
        Spacer()
        
        //Generate the QRcode image with Name, Date, Movie and Seats
        QRCode(url: "Customer Name: \(bookingName)\nSelected Date: \(selectedDate)\nSelected Movie: \(selectedMovie)\nSelected Seats: \(selectedSeats.sorted().joined(separator: ", "))")
            .padding()
        
        Text("Please show this QR code to staff when entering cinema to get your ticket")
            .padding()
            .bold()
        
        Spacer()
        
        // Navigation link to go to ContentView
        NavigationLink(destination: ContentView()
            .navigationBarBackButtonHidden(true),
                       label: { Text("Home")
                .font(.title)
        }
        )
    }
}

#Preview {
    QRCodeView(selectedSeats: ["A1","A2"], selectedMovie: "Dune", bookingName: "David", selectedDate: Date())
}
