//
//  PaymentView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct PaymentView: View {
    
    @State var paymentMade: Bool = false
    
    var selectedSeats : Set<String>
    var selectedMovie: String
    
    init(selectedSeats: Set<String>, selectedMovie: String) {
        
        self.selectedSeats = selectedSeats
        self.selectedMovie = selectedMovie
        
    }
    
    
    var body: some View {
        Text("Payment")
            .font(.title)
        Spacer()
        
        Text("Selected Movie:")
        Text(selectedMovie)
            .padding(.bottom)
        Text("Selected Seats:")
        Text(selectedSeats.sorted().joined(separator: ", "))
            .padding(.bottom)
        
        if (!paymentMade) {
            Button(action: {
                
                BookedSeats().addBookedSeats(addedSeats: selectedSeats, movie: selectedMovie)
                paymentMade = true
                
            }) { Text("Make Payment") }
            
        } else {
            
            Text("Payment Successful")
            
        }
        
        Spacer()
        
        // navigation link to go back to the home screen
        NavigationLink(destination: ContentView()
                                    .navigationBarBackButtonHidden(true)
                                ,
                       label: { Text("Home")
                                .font(.title)
                                }
                       )
        
    }
}

#Preview {
    PaymentView(selectedSeats: ["A1","A2"], selectedMovie: "Dune")
}
