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
    private let testUrl = "https://jsonplaceholder.typicode.com/users/1/todos"
    var tasks = [Task]()
    
    func getData() {
        guard let url = URL(string: testUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    self.tasks = try JSONDecoder().decode([Task].self, from: data)
                } catch let someError {
                    print(someError)
                }
            }
        }.resume()
    }
    
    init() {
        getData()
    }
}
