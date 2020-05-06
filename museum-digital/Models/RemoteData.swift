//
//  RemoteData.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 03.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

enum RemoteDataStatus {
    case success
    case error
    case loading
}

struct RemoteData<DataType> {
    var data: DataType?
    var status: RemoteDataStatus
}
