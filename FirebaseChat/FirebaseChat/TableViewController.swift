//
//  TableViewController.swift
//  FirebaseChat
//
//  Created by Bobby Towers on 3/12/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

let firebaseRef = Firebase(url:"https://jo-chat.firebaseio.com/")


class TableViewController: UITableViewController {

    
    @IBOutlet weak var messageField: UITextField!
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        var dateRounded = Int(NSDate().timeIntervalSince1970)
        
        println(dateRounded)
        
        firebaseRef.childByAppendingPath("messages").childByAppendingPath("\(dateRounded)_Swagarino").setValue(["name":"Captain Crunch", "message":messageField.text])
        
        messageField.text = ""
    }
    
    var messages: [[String:AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Web sockets are like phone conversations
        // It is waiting for events to be passed, and it's an ongoing conversation
        // As opposed to an email-like conversation
        
        // Creating the observer in the viewDidLoad 
        // Almost exactly like a notification center/observer
        // Setting it up, runs itself when a new message comes in
        
        firebaseRef.childByAppendingPath("messages").observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            println("\(snapshot.key) -> \(snapshot.value)")
            
            self.messages.insert(snapshot.value as [String:AnyObject], atIndex: 0)
//            self.messages.append(snapshot.value as [String:AnyObject])
            
            self.tableView.reloadData()
        })
        
//        firebaseRef.setValue("Swagarino Cappuccino")
        
        
        
        
/*
        let block: (snapshot: FDataSnapshot!) -> Void = {
            snapshot in
            
            println("\(snapshot.key) -> \(snapshot.value)")
            
            self.messages.insert(snapshot.value as [String:AnyObject], atIndex: 0)
            
            self.tableView.reloadData()
            
        }
        
        
        firebaseRef.childByAppendingPath("messages").observeEventType(.ChildChanged, withBlock: block)
        firebaseRef.childByAppendingPath("messages").observeEventType(.ChildAdded, withBlock: block)
        firebaseRef.childByAppendingPath("messages").observeEventType(.ChildRemoved, withBlock: block)
*/
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return messages.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as UITableViewCell

        let message = messages[indexPath.row]
        
        println(message)
        
        cell.textLabel?.text = message["name"] as? String
        cell.detailTextLabel?.text = message["message"] as? String
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
