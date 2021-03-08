//
//  CollectionView.swift
//  NetworkApp
//
//  Created by Sergey Basin on 10.11.2020.
//  Copyright © 2020 Sergey Basin. All rights reserved.
//

import UIKit

class CollectionView: UICollectionViewController {
    
    var tasks = [Task]()
    var selectedIndex: Int = 0
    let testUrl = "https://jsonplaceholder.typicode.com/users/1/todos"

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskClass.getData(testUrl: testUrl) { (tempArray) in
            DispatchQueue.main.async {
                self.tasks = tempArray
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func refreshCells(_ sender: Any) {
        collectionView.reloadData()
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tasks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! UserCell
        let task = tasks[indexPath.item]
        cell.configure(with: task)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: "fromCellSegue", sender: nil)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.editedTask = tasks[selectedIndex]
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        let detailVC = unwindSegue.source as! DetailViewController
        tasks[selectedIndex] = detailVC.editedTask
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
