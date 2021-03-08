//
//  Model.swift
//  NetworkApp
//
//  Created by Sergey Basin on 10.11.2020.
//  Copyright © 2020 Sergey Basin. All rights reserved.
//

import Foundation

struct Task: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

class TaskClass {
    
    static func getData(testUrl: String, completion: @escaping ([Task]) -> ()) {
        guard let url = URL(string: testUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data else {
                completion([])
                return}
            
            guard let task = try? JSONDecoder().decode([Task].self, from: data) else {
                completion([])
                return}
            
            completion(task)

        }.resume()
    }

}
