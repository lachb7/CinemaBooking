//
//  SeatSelectionView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct SeatSelectionView: View {
    
    let seatsPerRow = 8
    
    let rowLetters = ["A", "B", "C", "D", "E"]
    
    var bookedSeats : Set<String>
    
    @State var selectedSeats : Set<String> = []
    
    var numberOfSeatsInBooking: Int
    var bookingName: String
    var selectedMovie: String
    var selectedNumberOfSeats: Int
    var selectedDate: Date
    
    init(numberOfSeats: Int, bookingName: String, selectedMovie: String, selectedDate: Date) {
        
        self.numberOfSeatsInBooking = numberOfSeats
        self.bookingName = bookingName
        self.selectedMovie = selectedMovie
        self.selectedNumberOfSeats = numberOfSeats
        self.selectedDate = selectedDate
        
        let dateShort : String = selectedDate.formatted(.iso8601.year().month().day().dateSeparator(.dash))
        
        bookedSeats = BookedSeats().bookedSeats[dateShort]?[selectedMovie] ?? []
        
    }
    
    var body: some View {
        
            VStack {
                
                Text("Select Seats")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Selected Movie:")
                Text(selectedMovie)
                    .padding(.bottom)
                
                Text("Selected Date:")
                Text(selectedDate, style: .date)
                    .padding(.bottom)
                
                Text("Customer Name:")
                Text(bookingName)
                    .padding(.bottom)
                
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
                
                NavigationLink(destination: PaymentView(selectedSeats: selectedSeats, selectedMovie: selectedMovie, bookingName: bookingName, selectedDate: selectedDate), label: { Text("Go to Payment")
                        .font(.title3)
                }
                )
                .padding()
                .disabled(selectedSeats.count != selectedNumberOfSeats)
            }
            
    }
}

#Preview {
    SeatSelectionView(numberOfSeats: 3, bookingName: "David", selectedMovie: "Dune", selectedDate: Date())
}
