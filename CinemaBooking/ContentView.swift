//
//  ContentView.swift
//  CinemaBooking
//
//  Created by David Bramston, UTS
//

import SwiftUI

// the first view for the app which allows the user to select a date, and select a movie from a list
struct ContentView: View {

    // variable used for retrieving movie list and poster URLs
    @StateObject var sessionData = SessionData()
    
    @State var date = Date()
    let dateRange = Date.now...Date.now.addingTimeInterval(14 * 24 * 60 * 60)  // 14 days
    
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
                
                // list of the movie title and poster images
                List(sessionData.movies) { movieInfo in
                    
                    NavigationLink(destination: TicketsView(selectedMovie: movieInfo.title, selectedDate: date),
                                   label: {
                        HStack {
                            AsyncImage(url: URL(string: movieInfo.posterURL)) { poster in
                                poster.resizable()
                                    .frame(maxWidth: 66, maxHeight: 100)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(movieInfo.title)
                        }
                    }
                    )
                }
                                    
                Spacer()
                
            }
            
        }
        .navigationViewStyle(.stack)
        
    
    }
}

#Preview {
    ContentView()
}
