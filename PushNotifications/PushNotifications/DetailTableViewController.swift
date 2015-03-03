//
//  DetailViewController.swift
//  PushNotifications
//
//  Created by Bobby Towers on 3/2/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

/*

We need a user and message model

User
- objectId
- username

Message
- objectId
- content (text of the message sent)
- date (when message was sent) - createdAt
- senderId (objectId of user who sent message)
- receiverId (objectId of user the message was sent to)
- participants (array of user objectIds)

*/

import UIKit

class DetailTableViewController: UITableViewController, UITextFieldDelegate {

    var user: PFUser!
    var messages: [PFObject] = []

    let messageField = UITextField(frame: CGRectMake(0, 0, 100, 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let user = PFUser()
//        user.username = "Bobby"
//        user.email = "swagLord@what.com"
//        user.password = "moneyswag"
//        user.signUp()
        
        // run request to grab all messages for the user
        
        let messageQuery = PFQuery(className: "Messages")
        
        messageQuery.whereKey("participants", containsAllObjectsInArray: [user.objectId, PFUser.currentUser().objectId])
        
        messageQuery.findObjectsInBackgroundWithBlock { (messages, error) -> Void in
            
            if messages.count > 0 {
                self.messages = messages as [PFObject]
            }
            
            self.tableView.reloadData()
        }

        let width = navigationController!.toolbar.frame.width
        
        messageField.delegate = self
        messageField.frame = CGRectMake(5, 5, width - 85, 34)
        messageField.borderStyle = UITextBorderStyle.RoundedRect
        navigationController?.toolbar.addSubview(messageField)
        
        // Adds a cool little blue box on tool bar
//        let box = UIView(frame: CGRectMake(0, 0, 20, 20))
//        box.backgroundColor = UIColor.blueColor()
//        
//        navigationController?.toolbar.addSubview(box)
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        var message = PFObject(className: "Messages")
        
        message["content"] = messageField.text
        message["senderId"] = PFUser.currentUser().objectId
        message["receiverId"] = user.objectId
        message["participants"] = [PFUser.currentUser().objectId, user.objectId]
        
        message.saveInBackground()
        messages.append(message)
        tableView.reloadData()
        
        var deviceQuery = PFInstallation.query()
        
        deviceQuery.whereKey("userId", equalTo: user.objectId)
        
        var push = PFPush()
        push.setMessage(messageField.text)
        push.setQuery(deviceQuery)
        push.sendPush(nil)
    
        messageField.text = ""
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as UITableViewCell
        
        let message = messages[indexPath.row]
        
        // text label will be the message content
        // detail label will be the username & time
        
        cell.textLabel?.text = message["content"] as? String
        cell.detailTextLabel?.text = message["senderId"] as? String
        
        return cell
    }
    
}

