//
//  SeatSelectionView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct SeatSelectionView: View {
    
    let numberOfRows = 5
    let seatsPerRow = 8
    
    let rowLetters = ["A", "B", "C", "D", "E"]
    
    var bookedSeats : Set<String>
    
    @State var selectedSeats : Set<String> = []
    
    var numberOfSeatsInBooking: Int
    var bookingName: String
    var selectedMovie: String
    var selectedNumberOfSeats: Int
    
    init(numberOfSeats: Int, bookingName: String, selectedMovie: String) {
        
        self.numberOfSeatsInBooking = numberOfSeats
        self.bookingName = bookingName
        self.selectedMovie = selectedMovie
        self.selectedNumberOfSeats = numberOfSeats
        
        bookedSeats = BookedSeats().bookedSeats[selectedMovie] ?? []
        
    }
    
    var body: some View {
        
            VStack {
                
                Text("Select Seats")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Selected Movie:")
                Text(selectedMovie)
                    // .padding(.bottom)
                
                Text("Number of seats to select:")
                Text(String(numberOfSeatsInBooking))
                    .padding(.bottom)
            
                Grid {
                    ForEach(rowLetters, id: \.self) { letter in
                        GridRow {
                            ForEach(1...seatsPerRow, id: \.self) {
                                num in SeatView(seatNumber: "\(letter)\(num)", 
                                                isAvailable: !bookedSeats.contains("\(letter)\(num)"),
                                            isSelected: selectedSeats.contains("\(letter)\(num)"))
                                    .onTapGesture {
                                        if !bookedSeats.contains("\(letter)\(num)") {
                                            if selectedSeats.contains("\(letter)\(num)") {
                                                selectedSeats.remove("\(letter)\(num)")
                                            } else {
                                                selectedSeats.insert("\(letter)\(num)")
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                
                Text("Selected Seats: \(selectedSeats.sorted().joined(separator:", "))")
                    .padding()
                
                
                Spacer()
                
                NavigationLink(destination: PaymentView(selectedSeats: selectedSeats, selectedMovie: selectedMovie),
                                label: { Text("Go to Payment")
                                        .font(.title3)
                                }
                )
                .padding()
                .disabled(selectedSeats.count != selectedNumberOfSeats)
            }
            
    }
}

#Preview {
    SeatSelectionView(numberOfSeats: 3, bookingName: "David", selectedMovie: "Dune")
}
