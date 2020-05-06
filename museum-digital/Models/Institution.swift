//
//  Institution.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 03.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct Institution: Decodable, Identifiable, Equatable, Hashable {
    var id: Int
    var name: String
    var description: String
    var image: String
    var subsetId: String
}
