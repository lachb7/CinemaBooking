//
//  TicketsView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct TicketsView: View {
    
    @State var bookingName: String = ""
    @State var numberOfSeats: Double = 1
    
    var selectedMovie: String
    
    init(selectedMovie: String) {
        
        self.selectedMovie = selectedMovie
        
    }

    
    var body: some View {
        
            VStack {
                
                Text("Tickets")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Selected Movie:")
                Text(selectedMovie)
                    .padding(.bottom)
            
                Text("Enter Booking Name")
                TextField("Enter Booking Name", text: $bookingName)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                
                
                Text("Number of Seats")
                Slider(value: $numberOfSeats,in: 1...10, step: 1)
                Text("\(Int(numberOfSeats))")
                
                NavigationLink(destination: SeatSelectionView(numberOfSeats: Int(numberOfSeats), bookingName: bookingName, selectedMovie: selectedMovie),
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
    TicketsView(selectedMovie: "Godzilla x Kong")
}
