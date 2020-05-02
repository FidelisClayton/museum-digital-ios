//
//  CitiesView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 02.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct CitiesView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                VStack(spacing: 16) {
                    Text("States")
                        .foregroundColor(Color.black.opacity(0.8))
                        .font(.system(size: 25))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(cities) { city in
                                NavigationLink(destination: CityView(city: city)) {
                                    CityCardView(city: city, height: 300)
                                }
                            }
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    Text("Special")
                        .foregroundColor(Color.black.opacity(0.8))
                        .font(.system(size: 25))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(cities) { city in
                                NavigationLink(destination: CityView(city: city)) {
                                    CityCardView(city: city, height: 220)
                                }
                            }
                        }
                    }
                    
                }
                
                Spacer()
            }
        }
        .padding(.leading, 16)
        .navigationBarTitle("Digital Museum")
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CitiesView()
        }
    }
}

struct City: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var image: String
}

let cities = [
    City(name: "Berlin", image: "berlin-cover"),
    City(name: "Bayern", image: "bayern-cover"),
    City(name: "Baden-Württemberg", image: "baden-wurttemberg-cover"),
    City(name: "Saxony-Anhalt", image: "saxony-anhalt-cover"),
    City(name: "Saxony", image: "saxony-cover"),
    City(name: "Brandenburg", image: "brandenburg-cover"),
    City(name: "Rhineland", image: "mainz-cover"),
]

struct CityCardView: View {
    var city: City
    var height: CGFloat
    
    var body: some View {
        ZStack {
            Image(city.image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: height)
                .clipped()
            
            VStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Text(city.name.uppercased())
                        .font(.body)
                        .foregroundColor(Color.white)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("300 museums".uppercased())
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .frame(height: 180)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0), Color.black]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .frame(width: 200, height: height)
        .cornerRadius(12)
    }
}
