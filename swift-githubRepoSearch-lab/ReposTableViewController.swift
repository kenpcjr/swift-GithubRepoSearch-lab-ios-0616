//
//  ReposTableViewController.swift
//  swift-githubRepoSearch-lab
//
//  Created by Haaris Muneer on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        
        store.getRepositoriesWithCompletion {
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.tableView.reloadData()
            })
        }
        
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.repositories.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)
        
        let repository:GithubRepository = self.store.repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let repository = self.store.repositories[indexPath.row]
        
        self.store.toggleStarStatusForRepository(repository) { starred in
            
            print("Finished Toggle")
            
            if starred == true {
                
                let alert = UIAlertController.init(title: "Toggle Complete", message: "You just starred \(repository.fullName)", preferredStyle: .Alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                alert.accessibilityLabel = "You just starred \(repository.fullName)"
                
            } else {
                
                let alert = UIAlertController.init(title: "Toggle Complete", message: "You just unstarred \(repository.fullName)", preferredStyle: .Alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                alert.accessibilityLabel = "You just unstarred \(repository.fullName)"
                
                
            }
            
        }
        
    }
    
    
}
