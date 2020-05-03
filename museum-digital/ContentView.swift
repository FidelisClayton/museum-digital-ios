//
//  ContentView.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 01.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var hasLoaded = false
    
    var body: some View {
        NavigationView {
            CitiesView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CitiesView()
        }
    }
}
