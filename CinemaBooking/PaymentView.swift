//
//  PaymentView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI
import UIKit

struct PaymentView: View {
    
    @State private var cardNumber: String = ""
    @State private var selectedMonthIndex = 0
    @State private var selectedYearIndex = 0
    @State private var months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"]  //Array for expiryDate: Month
    @State private var years = Array(2024...2034).map { String($0) }    //Array for expiryDate: Year
    @State private var cvv: String = ""
    @State private var paymentMade: Bool = false
    @State private var isPaymentConfirmed: Bool = false
    
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
        Text("Payment")
            .font(.title)
            .bold()
        
        Spacer()
        
        Text("Customer Name:")
            .bold()
        Text(bookingName)
            .padding(.bottom)
        Text("Selected Date:")
            .bold()
        Text(selectedDate, style: .date)
            .padding(.bottom)
        Text("Selected Movie:")
            .bold()
        Text(selectedMovie)
            .padding(.bottom)
        Text("Selected Seats:")
            .bold()
        Text(selectedSeats.sorted().joined(separator: ", "))
            .padding(.bottom)
        
        TextField("Card Number", text: $cardNumber)
            .padding()
            .keyboardType(.numberPad)
        
        Text("Expiry Date")
        HStack {
            //Pick the Month
            Picker(selection: $selectedMonthIndex, label: Text("Month")) {
                ForEach(0..<months.count) { index in
                    Text(months[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            //Pick the Year
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
                BookedSeats().addBookedSeats(addedSeats: selectedSeats, movie: selectedMovie, date: selectedDate)
                paymentMade = true
            }) { Text("Make Payment")
                    .padding()
                //Card Number need to be 16-digit and CVV need to be 3-digit
                .disabled(cardNumber.count != 16 || cvv.count != 3)}
            
        } else {
            Text("Payment Successful")
                .padding()
        }
        
        Spacer()
        
        // Navigation link to go to QRCodeView
        NavigationLink(destination: QRCodeView(selectedSeats: selectedSeats, selectedMovie: selectedMovie, bookingName: bookingName, selectedDate: selectedDate)
            .navigationBarBackButtonHidden(true),
                       //Go to QRCodeView if only paymentMade = true
                       isActive: .constant(paymentMade)
        ) {
            EmptyView()
        }
        .hidden()// Hide the navigation link
    }
}


#Preview {
    PaymentView(selectedSeats: ["A1","A2"], selectedMovie: "Dune", bookingName: "David", selectedDate: Date())
}
