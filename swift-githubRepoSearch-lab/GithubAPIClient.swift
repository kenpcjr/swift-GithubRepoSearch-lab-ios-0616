//
//  GithubAPIClient.swift
//  swift-githubRepoSearch-lab
//
//  Created by Haaris Muneer on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GithubAPIClient {
    
    static let githubURL = "https://api.github.com/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
    
    
    
    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
        
        Alamofire.request(.GET, githubURL).responseJSON { response in
            
            if let json = response.result.value{
                
                let repoArray = json as! NSArray
            
                completion(repoArray)
                
            }
            
            
        }
        
    }
    
    class func checkIfRepositoryIsStarred(fullName: String, completion:(Bool) -> ()) {
        
        let gitStarredURL = "https://api.github.com/user/starred/\(fullName)"
        

        Alamofire.request(.GET, gitStarredURL, encoding: .JSON, headers: ["Authorization" : " token \(Secrets.token)"]).responseJSON { response in
        
            print("did we get as far as checking")
            
            print("Response.response: \(response.response)")
            print("Response.Data \(response.data)")
            
            if let response = response.response {
                
                print("isStarred Says: \(response.statusCode)")
                
                if response.statusCode == 204 {
                    
                    completion(true)
                    
                } else if response.statusCode == 404 {
                    
                    completion(false)
                }
            }
        }
    }
    
  
    
    class func starRepository(fullName: String, completion:() -> ()) {
        
        let gitStarredURL = "https://api.github.com/user/starred/\(fullName)"
        
        Alamofire.request(.PUT, gitStarredURL, encoding: .JSON, headers: ["Authorization" : " token \(Secrets.token)"]).responseJSON { response in
            
            if let response = response.response {
                
                print("star method found \(response)")
                
                if response.statusCode == 204 {
                    
                    completion()
                    
                }
            }
            
        }
    }
    
    
 
    
    class func unstarRepository(fullName: String, completion:() -> ()) {
        
        let gitStarredURL = "https://api.github.com/user/starred/\(fullName)"
        
        Alamofire.request(.DELETE, gitStarredURL, encoding: .JSON, headers: ["Authorization" : " token \(Secrets.token)"]).responseJSON { response in
            
            if let response = response.response {
                
                print("unstar method found \(response)")
                
                if response.statusCode == 204 {
                    
                    completion()
                    
                }
            }
            
        }
    }
    
    
}
