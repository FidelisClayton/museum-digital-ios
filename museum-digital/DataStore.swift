//
//  DataStore.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 03.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import Combine

class DataStore: ObservableObject {
    private var api: Api
    
    @Published var subsetsIds: [String] = []
    @Published var subsetsById: [String:Subset] = [:]
    @Published var subsets: [Subset] = []
    
    @Published var institutionsIds: [Int] = []
    @Published var institutionsById: [Int:Institution] = [:]
    @Published var institutionsBySubset: [String:[Int]] = [:]
    
    @Published var loadings: [String:Bool] = [:]
    
    init () {
        self.api = Api()
    }
    
    func getSubsets() {
        self.loadings["subsets"] = true
        
        self.api.getSubsets { (subsets) in
            self.subsets = subsets
//            let subsetsIds = subsets.map { $0.id }
//
//            self.subsetsIds = subsetsIds
//            self.subsetsById = Dictionary(uniqueKeysWithValues: subsets.map { ($0.id, $0) })
//
//            self.loadings["subsets"] = false
//
//
//            print(">>>>>>>>")
//            print(subsets.map {$0.id})
        }
    }
    
    func getInstitutions(subsetId: String) {
        self.loadings["institutions/\(subsetId)"] = true
        
        self.api.getInstitutions(subsetId: subsetId) { (institutions) in
            let institutionsIds = institutions.map { $0.id }
            
            self.institutionsIds = institutionsIds
            self.institutionsBySubset[subsetId] = institutionsIds
            self.institutionsById = Dictionary(uniqueKeysWithValues: institutions.map { ($0.id, $0) })
            
            self.loadings["institutions/\(subsetId)"] = false
        }
    }
}
