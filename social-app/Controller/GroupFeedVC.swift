//
//  GroupFeedVC.swift
//  social-app
//
//  Created by Admin on 01.12.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTxtField: InsertTextField!
    
    //Variables
    var group: Group?
    var groupMessages = [Message]()
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmailFor(group: group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
    }


    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if messageTxtField.text != "" {
            messageTxtField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTxtField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key, sendComplete: { (success) in
                if success {
                    self.messageTxtField.text = ""
                    self.messageTxtField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            })
        }
    }
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUserName(forUID: message.senderId) { (email) in
            cell.configureCell(profileImg: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
    }
}
