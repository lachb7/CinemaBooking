//
//  ContentView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

struct ContentView: View {

    @StateObject var sessionData = SessionData()
    
    @State var date = Date()
    let dateRange = Date.now...Date.now.addingTimeInterval(14 * 24 * 60 * 60)  // 14 days
    
    //var sessionData = SessionData()
    
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
        
            VStack {
                
                Text("Cinema Booking")
                    .font(.largeTitle)
                
                Spacer()
                

                DatePicker(
                    "Select Date:",
                    selection: $date,
                    in: dateRange,
                    displayedComponents: [.date]
                )
                    .frame(width:250)
                    .padding()
                    .onChange(of: date) {
                        sessionData.getMoviesForDate(date: date)
                    }
                    .onAppear() {
                        sessionData.getMoviesForDate(date: date)
                    }
                
                Text("Select Movie")
                    .font(.title2)
                Divider()
                
                ForEach(sessionData.movies, id: \.self) {
                    movie_title in 
                    
                    NavigationLink(destination: TicketsView(selectedMovie: movie_title, selectedDate: date),
                                                   label: { Text(movie_title)
                      //                      .font(.title3)
                                                        }
                                    )
                    
                    
                    //Text(movie_title)
                }
                
                
                
                
//                NavigationLink(destination: TicketsView(selectedMovie: "Godzilla x Kong"),
//                               label: { Text("Godzilla x Kong")
//                        .font(.title3)
//                                    }
//                )
//                .padding()
//                
//                NavigationLink(destination: TicketsView(selectedMovie: "Dune"),
//                                label: { Text("Dune")
//                                        .font(.title3)
//                                }
//                )
//                .padding()
//                
//                NavigationLink(destination: TicketsView(selectedMovie: "Ghostbusters"),
//                                label: { Text("Ghostbusters")
//                                        .font(.title3)
//                                }
//                )
//                .padding()
                
                Spacer()
                
            }
            
        }
        .navigationViewStyle(.stack)
        
    
    }
}

#Preview {
    ContentView()
}
