//
//  UserCell.swift
//  NetworkApp
//
//  Created by Sergey Basin on 10.11.2020.
//  Copyright © 2020 Sergey Basin. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet var numberOfTaskLabel: UILabel!
    @IBOutlet var desriptionOfLabel: UILabel!
    @IBOutlet var taskStateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with task: Task) {
        
        self.numberOfTaskLabel.text = "Task #\(task.id)"
        self.desriptionOfLabel.text = task.title
        self.taskStateLabel.text = task.completed ? "✅" : "❌"
        
    }
}
