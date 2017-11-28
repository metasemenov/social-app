//
//  FirstViewController.swift
//  social-app
//
//  Created by Admin on 17.10.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }



}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }
            let image = UIImage(named: "defaultProfileImage")
            let message = self.messageArray[indexPath.row]
        DataService.instance.getUserName(forUID: message.senderId) { (returnedUserName) in
             cell.configureCell(profileImg: image!, email: returnedUserName, content: message.content)
        }
       
            return cell
        }
    }


