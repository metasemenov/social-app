//
//  CreateGroupsVC.swift
//  social-app
//
//  Created by Admin on 28.11.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var titleTxtField: InsertTextField!
    @IBOutlet weak var descriptionTxtField: InsertTextField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailSearchTxtField: InsertTextField!
    
    //Variables
    var emailArray = [String]()
    var chosenUersArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTxtField.delegate = self
        emailSearchTxtField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChange() {
        if emailSearchTxtField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTxtField.text!, handler: { (filteredArray) in
                self.emailArray = filteredArray
                self.tableView.reloadData()
            })
        }
    }

    @IBAction func doneBtnWasPressed(_ sender: Any) {
        if titleTxtField.text != "" && descriptionTxtField.text != "" {
            DataService.instance.getIds(forUsernaes: chosenUersArray, handler: { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(withTitle: self.titleTxtField.text!, andDescription: self.descriptionTxtField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Fail creating group")
                    }
                })
            })
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        
        let profileImg = UIImage(named: "defaultProfileImage")
        if chosenUersArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImg: profileImg!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImg: profileImg!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUersArray.contains(cell.emailLbl.text!) {
            chosenUersArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenUersArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUersArray = chosenUersArray.filter({ $0 != cell.emailLbl.text! })
            if chosenUersArray.count >= 1 {
                groupMemberLbl.text = chosenUersArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC: UITextFieldDelegate {
    
}
