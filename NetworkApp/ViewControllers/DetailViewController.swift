//
//  DetailViewController.swift
//  NetworkApp
//
//  Created by Sergey Basin on 10.11.2020.
//  Copyright © 2020 Sergey Basin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var numberOfTaskTextField: UITextField!
    @IBOutlet var titleOfTaskTextField: UITextField!
    @IBOutlet var taskStatusToggle: UISwitch!
    
    var numberOfSelectedTask: Int!
    var titleOfSelectedTask: String!
    var taskStatus: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        numberOfTaskTextField.text = String(numberOfSelectedTask)
        titleOfTaskTextField.text = titleOfSelectedTask
        taskStatusToggle.isOn = taskStatus
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        
        numberOfSelectedTask = Int(numberOfTaskTextField.text!)
        titleOfSelectedTask = titleOfTaskTextField.text!
        self.performSegue(withIdentifier: "backToList", sender: self)
        
        
    }
    
    @IBAction func toggleStatusOfTask(_ sender: Any) {
        taskStatus = taskStatusToggle.isOn
    }
    
    func showAlert(message: String, alertTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ou!", style: .cancel))
        present(alert, animated: true)
    }

}

extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
