//
//  MuseumView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 01.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct MuseumView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 35) {
                    MuseumInfoView()
                    
                    MuseumObjectsView()
                    
                    MuseumCollectionsView()
                    
                    Spacer()
                }
                .padding(.horizontal)
                .navigationBarTitle("Deutsches Technikmuseum")
            }
        }
    }
}

struct MuseumView_Previews: PreviewProvider {
    static var previews: some View {
        MuseumView()
    }
}

let screenSize: CGRect = UIScreen.main.bounds

struct MuseumObjectsView: View {
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                HStack(alignment: .lastTextBaseline) {
                    Text("Objects")
                        .foregroundColor(Color.black.opacity(0.8))
                        .font(.system(size: 25))
                        .bold()
                    
                    Text("3925")
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Spacer()
                
                NavigationLink(destination: Text("All objects")) {
                    Text("All")
                        .foregroundColor(Color.black.opacity(0.8))
                        .bold()
                }
            }
            
            HStack(spacing: 12) {
                NavigationLink(destination: Text("Object 1")) {
                    Image("object-1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 150)
                        .cornerRadius(10)
                        .clipped()
                }
                .buttonStyle(PlainButtonStyle())
                
                HStack(spacing: 12) {
                    VStack(spacing: 12) {
                        NavigationLink(destination: Text("Object 2")) {
                            Image("object-2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .cornerRadius(10)
                                .clipped()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        
                        NavigationLink(destination: Text("Object 3")) {
                            Image("object-3")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .cornerRadius(10)
                                .clipped()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    VStack(spacing: 12) {
                        NavigationLink(destination: Text("Object 4")) {
                            Image("object-4")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .cornerRadius(10)
                                .clipped()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: Text("Object 5")) {
                            Image("object-5")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .cornerRadius(10)
                                .clipped()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(height: 150)
        }
    }
}

struct MuseumInfoView: View {
    var body: some View {
        VStack {
            Text("Berlin, Germany")
                .foregroundColor(Color.black.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Image("museum-photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screenSize.width - 32, height: 220)
                .cornerRadius(10)
                .clipped()
        }
    }
}

struct MuseumCollectionItemView: View {
    let collection: MuseumCollection
    
    var body: some View {
        VStack {
            Image(collection.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 150)
                .cornerRadius(10)
            
            Text(collection.title)
                .foregroundColor(Color.black.opacity(0.8))
                .bold()
                .lineLimit(1)
                .frame(maxWidth: 250, alignment: .leading)
        }
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}


struct MuseumCollection: Identifiable {
    var id = UUID()
    var title: String
    var image: String
}

let collections = [
    MuseumCollection(title: "AEG Produktsammlung", image: "collection-1-cover"),
    MuseumCollection(title: "Historisches Archiv", image: "collection-2-cover"),
    MuseumCollection(title: "Druck und Papier", image: "collection-3-cover"),
    MuseumCollection(title: "Handwerk und Produktion", image: "collection-4-cover"),
]

struct MuseumCollectionsView: View {
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                Text("Collections")
                    .foregroundColor(Color.black.opacity(0.8))
                    .font(.system(size: 25))
                    .bold()
                
                Text("9")
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(collections) { collection in
                        NavigationLink(destination: Text("Collection \(collection.id)")) {
                            MuseumCollectionItemView(collection: collection)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}
