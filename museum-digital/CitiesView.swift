//
//  CitiesView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 02.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI
import QGrid

struct CitiesView: View {
    @State var subsets: [Subset] = [exampleSubset, exampleSubset]
    @State var institutionsBySubset: [String:[Institution]] = [:]
    @State var selectedSubsetId: String? = nil
    @State var previousSelectedSubsetId: String? = nil // it will be used to set the ZIndex for this subset card.
    @State var loadings: [String:Bool] = [:]
    
    func onGetInstitutions (subsetId: String, institutions: [Institution]) {
        self.institutionsBySubset[subsetId] = institutions
    }
    
    func onSubsetTap (subset: Subset) {
        if self.selectedSubsetId != nil {
            self.selectedSubsetId = nil
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.selectedSubsetId == nil {
                    self.previousSelectedSubsetId = nil
                }
            }
        } else {
            self.selectedSubsetId = subset.id
            self.previousSelectedSubsetId = subset.id
            
            if self.institutionsBySubset[subset.id] == nil {
                self.loadings[subset.id] = true
            }
            
            Api().getInstitutions(subsetId: subset.id) { institutions in
                self.onGetInstitutions(subsetId: subset.id, institutions: institutions)
                self.loadings[subset.id] = false
            }
        }
    }
    
    func getSubsetInstitutions (subsetId: String) -> [Institution] {
        let institutions = self.institutionsBySubset[subsetId]
        
        if institutions != nil {
            return institutions!
        } else {
            return []
        }
    }
    
    func getCardZIndex (subsetId: String) -> Double {
        if self.previousSelectedSubsetId == subsetId {
            return 1
        } else {
            return 0
        }
    }
    
    func getSubsetLoading (subsetId: String) -> Bool {
        let subsetLoading = self.loadings[subsetId]
        
        if subsetLoading == nil {
            return false
        } else {
            return subsetLoading!
        }
    }
    
    func canShowFullscreen (subsetId: String) -> Bool {
        let subsetLoading = self.getSubsetLoading(subsetId: subsetId)
        let isSelected = self.selectedSubsetId == subsetId
        
        return !subsetLoading && isSelected
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .lastTextBaseline, spacing: 20) {
                Text("Cities")
                    .font(.largeTitle)
                    .bold()
                
                Text("Special")
                    .font(.system(size: 25))
                    .bold()
                    .opacity(0.4)
            
                Spacer()
            }
            .padding(.leading, 30)
            
            VStack(spacing: 30) {
                ForEach(subsets) { subset in
                    GeometryReader { geometry in
                        CityCardView(
                            subset: subset,
                            height: 250,
                            isLoading: self.getSubsetLoading(subsetId: subset.id),
                            institutions: self.getSubsetInstitutions(subsetId: subset.id),
                            canShowFullScreen: self.canShowFullscreen(subsetId: subset.id),
                            selectedSubsetId: self.$selectedSubsetId
                        )
                            .offset(x: self.canShowFullscreen(subsetId: subset.id) ? -geometry.frame(in: .global).minX : 0)
                            .offset(y: self.canShowFullscreen(subsetId: subset.id) ? -geometry.frame(in: .global).minY : 0)
                            .animation(.easeInOut)
                    }
                    .frame(width: screenSize.width - 60, height: 250)
                    .zIndex(self.getCardZIndex(subsetId: subset.id))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.onSubsetTap(subset: subset)
                    }
                }
            }
            .frame(width: screenSize.width)
        }
        .padding(.top, 90)
        .edgesIgnoringSafeArea(.top)
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

struct CityCardView: View {
    var subset: Subset
    var height: CGFloat
    var isLoading: Bool
    var institutions: [Institution]
    var canShowFullScreen: Bool
    
    @State var canShowInstitutions: Bool = false
    @Binding var selectedSubsetId: String?
    
    var body: some View {
        let currentWidth = canShowFullScreen ? screenSize.width : screenSize.width - 60
        let currentHeight = canShowFullScreen ? screenSize.height : height
        
        return ZStack {
            Image(subset.image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: currentWidth, height: currentHeight)
                .clipped()
                .opacity(isLoading ? 0.4 : 1)
            
            ZStack {
                Spacer()
                
                if canShowFullScreen {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(institutions.indices, id: \.self) { index in
                                GeometryReader { geometry in
                                    NavigationLink(destination: MuseumView()) {
                                        MuseumCardView(image: self.institutions[index].image, name: self.institutions[index].name)
                                    }
                                    .opacity(self.canShowInstitutions ? 1 : 0)
                                    .animation(
                                        Animation
                                            .easeInOut(duration: self.canShowInstitutions ? 0.6 : 0) // disable animation when is not selected, this way we instantly hide the element
                                            .delay(self.canShowInstitutions ? 0.2 + Double(Float(index) * 0.2) : 0)
                                    )
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
                    .offset(y: 150)
                    .onAppear {
                        // Trigger the institutions animation.
                        self.canShowInstitutions = true
                    }
                    .onDisappear {
                        self.canShowInstitutions = false
                    }
                }
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            Text(subset.name.uppercased())
                                .font(.body)
                                .foregroundColor(Color.white)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("300 museums".uppercased())
                                .font(.caption)
                                .foregroundColor(Color.white.opacity(0.8))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .opacity(canShowFullScreen ? 0 : 1)
                        .animation(Animation.easeInOut(duration: 0.2))
                        
                        if canShowFullScreen {
                            FullSizeCityName(subset: subset)
                        }
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
                    .opacity(isLoading ? 0.4 : 1)
                }
            }
            
            if isLoading {
                ActivityIndicator()
                    .foregroundColor(Color.white)
                    .frame(width: 30, height: 30)
            }
        }
        .animation(Animation.default)
        .frame(width: currentWidth, height: currentHeight)
        .background(Color.black)
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1), radius: 20, x: 0, y: 20)
    }
}

struct FullSizeCityName: View {
    var subset: Subset
    @State var show: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(subset.name.uppercased())
                .font(.system(size: 50))
                .foregroundColor(Color.white)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("300 museums".uppercased())
                .foregroundColor(Color.white.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .opacity(show ? 1 : 0)
        .animation(Animation.easeInOut(duration: 0.2))
        .offset(x: 10, y: -40)
        .onAppear {
            self.show = true
        }
    }
}
