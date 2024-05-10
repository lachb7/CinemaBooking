//
//  SeatView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct SeatView: View {
    
    var seatNumber : String
    var isAvailable: Bool = true
    var isSelected: Bool = false
    
    init(seatNumber: String, isAvailable: Bool, isSelected: Bool) {
        
        self.seatNumber = seatNumber
        self.isAvailable = isAvailable
        self.isSelected = isSelected
        
    }
    
    var body: some View {
        
        Text(seatNumber)
            .font(.caption)
            .foregroundStyle(Color.white)
            .background(
                RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                    .fill(isAvailable ? (isSelected ? .red : .yellow) : .gray)
                    .frame(width: 30, height: 30)
        )
            .padding(10)
    }
}

#Preview {
    SeatView(seatNumber: "A1", isAvailable: true, isSelected: false)
}
