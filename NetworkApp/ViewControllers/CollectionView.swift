//
//  CollectionView.swift
//  NetworkApp
//
//  Created by Sergey Basin on 10.11.2020.
//  Copyright © 2020 Sergey Basin. All rights reserved.
//

import UIKit

class CollectionView: UICollectionViewController {
    
    var tasksList = TaskClass()
    var selectedIndex: Int = 0
    var selectedNumber: Int!
    var selectedTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.reloadData()
    }
    
    @IBAction func refreshCells(_ sender: Any) {
        collectionView.reloadData()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tasksList.tasks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! UserCell
        let task = tasksList.tasks[indexPath.item]
        cell.configure(with: task)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        selectedNumber = tasksList.tasks[selectedIndex].id
        selectedTitle = tasksList.tasks[selectedIndex].title
        performSegue(withIdentifier: "fromCellSegue", sender: nil)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.numberOfSelectedTask = tasksList.tasks[selectedIndex].id
        detailVC.titleOfSelectedTask = tasksList.tasks[selectedIndex].title
        detailVC.taskStatus = tasksList.tasks[selectedIndex].completed
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        let detailVC = unwindSegue.source as! DetailViewController
        tasksList.tasks[selectedIndex].id = detailVC.numberOfSelectedTask
        tasksList.tasks[selectedIndex].title = detailVC.titleOfSelectedTask
        tasksList.tasks[selectedIndex].completed = detailVC.taskStatus
        collectionView.reloadData()
    }

}

extension CollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
