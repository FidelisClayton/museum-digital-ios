//
//  CitiesView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 02.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct CitiesView: View {
    @State var subsets: [Subset] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                VStack(spacing: 16) {
                    Text("Subsets")
                        .foregroundColor(Color.black.opacity(0.8))
                        .font(.system(size: 25))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(self.subsets) { subset in
                                    NavigationLink(destination: CityView(subset: subset)) {
                                        CityCardView(city: subset, height: 300)
                                    }
                                }
                            }
                            .frame(height: 300)
                        }
                }
                
                Spacer()
            }
        }
        .padding(.leading, 16)
        .navigationBarTitle("Digital Museum")
        .onAppear {
            Api().getSubsets { (subsets) in
                self.subsets = subsets
            }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CitiesView()
        }
    }
}





//let cities = [
//    City(name: "Berlin", image: "berlin-cover"),
//    City(name: "Bayern", image: "bayern-cover"),
//    City(name: "Baden-Württemberg", image: "baden-wurttemberg-cover"),
//    City(name: "Saxony-Anhalt", image: "saxony-anhalt-cover"),
//    City(name: "Saxony", image: "saxony-cover"),
//    City(name: "Brandenburg", image: "brandenburg-cover"),
//    City(name: "Rhineland", image: "mainz-cover"),
//]

struct CityCardView: View {
    var city: Subset
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
