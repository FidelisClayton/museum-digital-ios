//
//  CollectionView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 02.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                NavigationLink(destination: ObjectsView()) {
                    HStack {
                        Image("object-1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(10)
                        
                        VStack() {
                            Image("object-2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 70)
                                .clipped()
                                .cornerRadius(10)
                            
                            HStack {
                                Image("object-3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                ZStack(alignment: .center) {
                                     Image("object-4")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .blur(radius: 2)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .clipped()
                                        .opacity(0.3)
                                    
                                    Text("+ \n 7000")
                                        .foregroundColor(Color.white)
                                        .font(.callout)
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .background(Color.black)
                                .cornerRadius(10)
                            }
                            .frame(minHeight: 0, maxHeight: .infinity)
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                }
                .buttonStyle(PlainButtonStyle())
                
                Text("""
            Die AEG war einer der weltweit bedeutendsten Technologiekonzerne, der von 1883 bis Mitte der 1950er Jahre seinen Hauptsitz in Berlin hatte und diesen aufgrund der politischen Entwicklungen nach Westdeutschland verlegte. Das Deutsche Technikmuseum in Berlin konnte 1997 das gesamte Archiv sowie die Produktsammlung der AEG erwerben. \n
            Die Produktsammlung umfasst über 3500 Objekte aus der gesamten Herstellungspalette des Konzerns. Zu dem Bestand gehören auch die die Erzeugnisse zahlreicher Tochterunternehmen wie Telefunken, Olympia, Kabelwerke Oberspree (KWO). \n
            Erstmals wird in diesem Online-Bestand die direkte Verknüpfung von dreidimensionalen Sammlungsobjekten und zugehörigen Archivalien hergestellt. Die Objekte finden Sie in museum-digital auch in den jeweiligen Fachsammlungen wie "Kommunikation und Medien" oder "Druck und Papier". Die Archivalien finden Sie auch im Bereich Historisches Archiv unter AEG-Archiv.
            """
                )
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                NavigationLink(destination: MuseumView()) {
                    ObjectInfoMuseumDetail(name: "Deutsches Technikmuseum", image: "museum-photo")
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Collection 123")
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CollectionView()
        }
    }
}
