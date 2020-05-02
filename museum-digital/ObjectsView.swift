//
//  ObjectsView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 02.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct ObjectsView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(objects) { object in
                    NavigationLink(destination: Text("Object")) {
                        SingleObjectView(object: object)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
            }
            .offset(y: 15)
            .navigationBarTitle("Objects")
        }
        
    }
}

struct ObjectsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ObjectsView()
        }
    }
}

struct SingleObjectView: View {
    var object: MuseumObject
    
    var body: some View {
        VStack(spacing: 0) {
            Image(object.image)
                .resizable()
                .clipped()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: screenSize.width - 32)
            
            Text(object.title)
                .font(.system(size: 20))
                .bold()
                .padding(20)
                .foregroundColor(Color.black.opacity(0.8))
                .lineLimit(1)
                .frame(maxWidth: screenSize.width - 32, alignment: .leading)
                .background(Color.black.opacity(0.1))
        }
        .cornerRadius(12)
    }
}
