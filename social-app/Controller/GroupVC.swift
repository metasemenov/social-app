//
//  SecondViewController.swift
//  social-app
//
//  Created by Admin on 17.10.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var groupsArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (returnedGroupsArray) in
                self.groupsArray = returnedGroupsArray
                self.tableView.reloadData()
            }
        }
    }
    
    

}

extension GroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else { return UITableViewCell() }
        let group = groupsArray[indexPath.row]
        cell.configureCell(title: group.groupTitle, description: group.groupDescription, memberCount: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else { return }
        groupFeedVC.initData(forGroup: groupsArray[indexPath.row])
        presentDetail(groupFeedVC)
        
    }
}

