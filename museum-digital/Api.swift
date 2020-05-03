//
//  Api.swift
//  museum-digital
//
//  Created by Clayton Fidelis on 03.05.20.
//  Copyright © 2020 Clayton Fidelis. All rights reserved.
//

import SwiftUI

struct Api {
    func getSubsets(onSuccess: @escaping ([Subset]) -> ()) {
        guard let url = URL(string: "http://localhost:3000/subsets") else {
            print("Invalid URL")
            
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Subset].self, from: data) {
                    DispatchQueue.main.async {
                        onSuccess(decodedResponse)
                    }
                }
            }
        }.resume()
    }
    
    func getInstitutions(subsetId: String, onSuccess: @escaping ([Institution]) -> ()) {
        guard let url = URL(string: "http://localhost:3000/subsets/\(subsetId)/institutions") else {
            print("Invalid URL")
            
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Institution].self, from: data) {
                    DispatchQueue.main.async {
                        onSuccess(decodedResponse)
                    }
                }
            }
        }.resume()
    }
}
