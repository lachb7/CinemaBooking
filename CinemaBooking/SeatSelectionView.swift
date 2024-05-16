//
//  SeatSelectionView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

// this view shows the cinema seats and allows the user to select seats
struct SeatSelectionView: View {
    
    let numSeatsPerRow = 10
    let rowLettersArr = Array("ABCDEFG")  // array of letters used for seat rows
    
    var bookedSeats : Set<String>  // set of seats already booked
    @State var selectedSeats : Set<String> = []  // set of seats selected in current booking
    
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
        
        // retrieve the seats already booked for the selected date and movie
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
            
                // grid for showing the seats
                Grid {
                    ForEach(rowLettersArr, id: \.self) { letter in
                        GridRow {
                            ForEach(1...numSeatsPerRow, id: \.self) { num in
                                let seatNum = "\(letter)\(num)"
                                SeatView(seatNumber: seatNum,
                                                isAvailable: !bookedSeats.contains(seatNum),
                                            isSelected: selectedSeats.contains(seatNum))
                                    .onTapGesture {
                                        // if seat already booked then tap gesture does nothing
                                        if !bookedSeats.contains(seatNum) {
                                            // tapping on seat will toggle the seat selection by removing/inserting seat in selectedSeats set
                                            if selectedSeats.contains(seatNum) {
                                                selectedSeats.remove(seatNum)
                                            } else {
                                                selectedSeats.insert(seatNum)
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
                
                // navigation link to go to payment view - disabled if number of selected seats is not equal to the number of seats for the booking
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
