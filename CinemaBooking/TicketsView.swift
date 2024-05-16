//
//  TicketsView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

// this view allows the user to input basic information about the cinema booking such as date, customer name, and number of seats
struct TicketsView: View {
    
    @State var bookingName: String = ""
    @State var numberOfSeats: Double = 1
    
    var selectedMovie: String
    var selectedDate: Date
    
    init(selectedMovie: String, selectedDate: Date) {
        
        self.selectedMovie = selectedMovie
        self.selectedDate = selectedDate
        
    }

    
    var body: some View {
        
            VStack {
                
                Text("Tickets")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Selected Movie:")
                Text(selectedMovie)
                    .padding(.bottom)
            
                Text("Selected Date:")
                Text(selectedDate.formatted(date: .long, time: .omitted))
                    .padding(.bottom)
                
                Text("Enter Booking Name")
                TextField("Enter Booking Name", text: $bookingName)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                
                
                Text("Number of Seats")
                Slider(value: $numberOfSeats,in: 1...10, step: 1)
                Text("\(Int(numberOfSeats))")
                
                NavigationLink(destination: SeatSelectionView(numberOfSeats: Int(numberOfSeats), bookingName: bookingName, selectedMovie: selectedMovie, selectedDate: selectedDate),
                                label: { Text("Select Seats")
                                        .font(.title3)
                                }
                )
                .padding()
                .disabled(bookingName.isEmpty)
                
                Spacer()
                
            }
            
        }
        
}

#Preview {
    TicketsView(selectedMovie: "Godzilla x Kong", selectedDate: Date())
}
