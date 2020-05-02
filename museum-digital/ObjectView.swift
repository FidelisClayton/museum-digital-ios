//
//  ObjectView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 02.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct ObjectView: View {
    var object: MuseumObject
    @State var detailsCardState = CGSize.zero
    @State var detailsCardShow: Bool = false
    
    func onDragChanged (value: DragGesture.Value) {
        self.detailsCardState = value.translation
        
        if self.detailsCardShow && value.translation.height < 0 {
            self.detailsCardState.height = 0
        }
    }
    
    func onDragEnded (value: DragGesture.Value) {
        if self.detailsCardState.height > 50 {
            self.detailsCardShow = false
        }
        
        if self.detailsCardState.height < -50 {
            self.detailsCardShow = true
        }
        
        self.detailsCardState = .zero
    }
    
    var body: some View {
        ZStack {
            Image(object.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screenSize.width, maxHeight: .infinity)
                .opacity(0.8)
                .blur(radius: detailsCardShow ? 0 : 5)
                .animation(Animation.easeInOut)
                .onTapGesture {
                    if (self.detailsCardShow) {
                        self.detailsCardShow.toggle()
                        self.detailsCardState = .zero
                    }
            }
            
            
            Image(object.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            ObjectInfoView(object: object, onDragChange: onDragChanged, onDragEnded: onDragEnded)
                .offset(y: detailsCardShow ? 80 : screenSize.height - 250)
                .offset(y: detailsCardState.height)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct ObjectView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectView(object: objects[0])
    }
}

struct ObjectInfoView: View {
    var object: MuseumObject
    var onDragChange: (_ value: DragGesture.Value) -> Void
    var onDragEnded: (_ value: DragGesture.Value) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                VStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 30, height: 4, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.2))
                }
                .frame(maxWidth: .infinity)
                .offset(y: -10)
                
                Text(object.title)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3)
            }
            .padding(.top, 25)
            .frame(height: 160)
            .gesture(
                DragGesture()
                    .onChanged(self.onDragChange)
                    .onEnded(self.onDragEnded)
            )
            
            
            ScrollView {
                ObjectInfoDetailItem(label: "Created by", value: "Allgemeine Elektricitäts-Gesellschaft (AEG)")
                    .background(Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9568627451, alpha: 1)))
                    .cornerRadius(12)
                
                HStack(spacing: 0) {
                    ObjectInfoDetailItem(label: "Period", value: "1901 - 1960")
                    ObjectInfoDetailItem(label: "Material/Technique", value: "Messing, Holz")
                }
                
                ObjectInfoDetailItem(label: "Dimensions", value: "Ø Höhe: 210 x 220 mm; Masse: 1,34 kg")
                    .background(Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9568627451, alpha: 1)))
                    .cornerRadius(12)
                
                ObjectInfoDetailItem(label: "Description", value: "Beschreibung für Elektrische Kaffee- und Teemaschine AEG folgt.")
                
                ObjectInfoMuseumDetail(name: "Deutsches Technikmuseum", image: "museum-photo")
            }
            
            Spacer()
        }
        .padding(.bottom, 25)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: screenSize.height - 150)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct ObjectInfoDetailItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            VStack(spacing: 5) {
                Text(label.uppercased())
                    .font(.caption)
                    .bold()
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(value)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
    }
}

struct ObjectInfoMuseumDetail: View {
    let name: String
    let image: String
    
    var body: some View {
        ZStack {
            ObjectInfoDetailItem(label: "Museum", value: name)
                .background(Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9568627451, alpha: 1)))
                .cornerRadius(12)
            
            HStack {
                Spacer()
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                    .offset(x: -10)
            }
        }
    }
}
