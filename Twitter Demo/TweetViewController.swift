//
//  TweetViewController.swift
//  Twitter Demo
//
//  Created by David Yuan on 2/26/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweetslist: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
       TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
        self.tweetslist=tweets
       // print(tweets.count)
       // print(self.tweetslist.count)
        self.tableView.reloadData()

        for tweet in tweets{
          //  self.tweetslist.append(tweet)
        }
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
       // print(tweetslist.count)
               // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.tweetslist == nil{
           // print("nil")
            return 0
            
        }
        /* if searchController.isActive && searchController.searchBar.text != "" {
         return filteredbusinesses.count
         }*/
        print("not nil")
        return self.tweetslist.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell", for: indexPath) as! TwitterCell
        
        let tweet = self.tweetslist[indexPath.row]
        print(tweet.text!)
        cell.contentText.text=tweet.text!
        let time1 = Double((tweet.timestamp?.timeIntervalSinceNow.description)!)
        
        cell.timeLabel.text = String(Int(time1! * -1 / 60))
          cell.timeLabel.text?.append("h")
        cell.profileImage.setImageWith((tweet.user?.profileURL)!)
        cell.nameLabel.text=tweet.user?.name
        cell.name2Label.text="@\(tweet.user!.screenname!)"
        cell.profileImage.layer.cornerRadius = 5
        cell.profileImage.clipsToBounds = true
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
