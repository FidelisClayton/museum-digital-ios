//
//  CityView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 01.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct CityView: View {
    var subset: Subset
    
    @State var institutions: [Institution] = []
    @State var hasLoaded = false
    
    var body: some View {
        return ZStack {
            BackgroundImageView(image: subset.image)
                .opacity(hasLoaded ? 1 : 0)
                .transition(.opacity)
                .animation(Animation.easeInOut(duration: 1).delay(0.1))
            
            VStack {
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(institutions.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                NavigationLink(destination: MuseumView()) {
                                    MuseumCardView(image: self.institutions[index].image, name: self.institutions[index].name)
                                        .opacity(self.hasLoaded ? 1 : 0)
                                        .transition(.opacity)
                                        .animation(
                                            Animation
                                                .easeInOut(duration:0.6)
                                                .delay(0.5 + Double(Float(index) * 0.2))
                                    )
                                }
                                .rotation3DEffect(
                                    Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20),
                                    axis: (x: 0, y: 10, z: 0)
                                )
                            }
                            .frame(width: 290, height: 210)
                        }
                    }
                    .frame(height: 210)
                    .padding(.leading, 30)
                    .padding(.trailing, 50)
                }
                .frame(height: 210)
                .offset(x: 0, y: 150)
                
                Spacer()
                
                CityNameView(loaded: hasLoaded, city: subset.name, institutions: subset.institutions)
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.vertical)
        .onAppear {
            Api().getInstitutions(subsetId: self.subset.id) { (institutions) in
                self.institutions = institutions
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.hasLoaded = true
                }
            }
        }
    }
    
    
}

struct MuseumCardView: View {
    var image: String
    var name: String
    
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                KFImage(URL(string: image)!)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 80, alignment: .trailing)
                    .cornerRadius(16)
                
                Spacer()
            }
            .offset(y: -40)
            
            VStack(alignment: .leading) {
                Spacer()
                
                Text(name)
                    .foregroundColor(Color.black.opacity(0.8))
                    .font(.title)
                    .bold()
                    .lineLimit(2)
                    .frame(width: 280, alignment: .leading)
            }
        }
        .frame(width: 280, height: 170)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        
    }
}

struct CityNameView: View {
    var loaded: Bool
    var city: String
    var institutions: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(city)
                .font(.system(size: 50))
                .bold()
                .foregroundColor(Color.white.opacity(0.9))
                .opacity(loaded ? 1 : 0)
                .transition(.opacity)
                .animation(Animation.easeInOut(duration: 0.6).delay(0.2))
            
            Text("\(institutions) museums")
                .foregroundColor(Color.white.opacity(0.7))
                .opacity(loaded ? 1 : 0)
                .transition(.opacity)
                .animation(Animation.easeInOut(duration: 0.6).delay(0.25))
        }
        .frame(maxWidth: .infinity, alignment: .bottomLeading)
        .padding(.top, 40)
        .padding(.bottom, 60)
        .padding(.leading, 30)
        .background(
            LinearGradient(
                gradient:
                Gradient(
                    colors: [Color.black.opacity(0), Color.black.opacity(0.6), Color.black.opacity(0.8), Color.black.opacity(0.9)]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

struct BackgroundImageView: View {
    var image: String
    
    var body: some View {
        GeometryReader { geometry in
            Image(self.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .opacity(0.6)
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CityView(subset: exampleSubset)
        }
    }
}
