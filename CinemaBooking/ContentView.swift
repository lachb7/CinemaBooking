//
//  ContentView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
        
            VStack {
                
                Text("Cinema Booking")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Select Movie")
                    .font(.title2)
                Divider()
                
                NavigationLink(destination: TicketsView(selectedMovie: "Godzilla x Kong"),
                               label: { Text("Godzilla x Kong")
                        .font(.title3)
                                    }
                )
                .padding()
                
                NavigationLink(destination: TicketsView(selectedMovie: "Dune"),
                                label: { Text("Dune")
                                        .font(.title3)
                                }
                )
                .padding()
                
                NavigationLink(destination: TicketsView(selectedMovie: "Ghostbusters"),
                                label: { Text("Ghostbusters")
                                        .font(.title3)
                                }
                )
                .padding()
                
                Spacer()
                
            }
            
        }
        .navigationViewStyle(.stack)
        
    
    }
}

#Preview {
    ContentView()
}
