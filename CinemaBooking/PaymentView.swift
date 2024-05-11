//
//  PaymentView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct PaymentView: View {
    
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""
    @State private var paymentMade: Bool = false
    
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
        TextField("Card Number", text: $cardNumber)
            .padding()
                    
        TextField("Expiry Date", text: $expiryDate)
            .padding()
                    
        TextField("CVV", text: $cvv)
            .padding()
        if (!paymentMade) {
            Button(action: {
                
                BookedSeats().addBookedSeats(addedSeats: selectedSeats, movie: selectedMovie)
                paymentMade = true
                
            }) { Text("Make Payment")
                .padding()
                .disabled(cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty)}
            
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
