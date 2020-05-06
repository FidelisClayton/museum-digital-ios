//
//  Subset.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 03.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct Subset: Decodable, Identifiable {
    let id: String
    var name: String
    var institutions: Int
    var image: String
}

let exampleSubset: Subset = Subset(id: "berlin", name: "Berlin", institutions: 20, image: "berlin-cover")
