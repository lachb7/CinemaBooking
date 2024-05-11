//
//  PaymentView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct PaymentView: View {
    
    @State private var cardNumber: String = ""
    //@State private var expiryDate: String = ""
    //@State private var expiryDate = Date()
    @State private var selectedMonthIndex = 0
    @State private var selectedYearIndex = 0
    @State private var months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"]
    @State private var years = Array(2024...2034).map { String($0) }
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
            .keyboardType(.numberPad)
        
        //TextField("Expiry Date", text: $expiryDate)
        /*DatePicker(
            "Expiry Date",
            selection: $expiryDate,
            displayedComponents: [.date]
        )
        .padding()*/
        Text("Expiry Date")
        HStack {
            Picker(selection: $selectedMonthIndex, label: Text("Month")) {
                ForEach(0..<months.count) { index in
                    Text(months[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Picker(selection: $selectedYearIndex, label: Text("Year")) {
                ForEach(0..<years.count) { index in
                    Text(years[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding()
        
        TextField("CVV", text: $cvv)
            .padding()
        
        if (!paymentMade) {
            Button(action: {
                
                BookedSeats().addBookedSeats(addedSeats: selectedSeats, movie: selectedMovie)
                paymentMade = true
                
            }) { Text("Make Payment")
                .padding()
                .disabled(cardNumber.count != 16 || cvv.count != 3)}
            
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
