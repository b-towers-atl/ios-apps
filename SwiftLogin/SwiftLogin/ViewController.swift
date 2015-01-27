//
//  ViewController.swift
//  SwiftLogin
//
//  Created by Bobby Towers on 1/26/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var emailField: UITextField!
    
    @IBAction func createAccountButton(sender: AnyObject) {
        
        resultLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        if usernameField.text.isEmpty == false && passwordField.text.isEmpty == false && emailField.text.isEmpty == false {
            
            if countElements(usernameField.text) >= 6 && countElements(usernameField.text) <= 20 {
                
                if countElements(passwordField.text) >= 8 && countElements(passwordField.text) <= 24 {
                    
                    var emailString = emailField.text
                    
                    if emailString.rangeOfString("@") != nil && emailString.rangeOfString(".") != nil {
                        
                        var userQuery = PFUser.query()
                        
                        userQuery.whereKey("username", equalTo: usernameField.text)
                        
                        userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                            
                            if objects.count > 0 {
                                
                                self.login()
                                
                                self.resultLabel.text = "Logged in."
                                
                            } else {
                                
                                self.signUp()
                                
                                self.resultLabel.text = "Account created. Authentication sent."
                                
                            }
                            
                        })
                        
//                        signUp()
                        
                    } else {
                        
                        resultLabel.text = "Please enter a valid email address."
                        
                    }
                    
                } else {
                    
                    if countElements(passwordField.text) < 8 {
                        
                        resultLabel.text = "Invalid password. \nMust be greater than 8 characters."
                        
                    } else {
                        
                        resultLabel.text = "Invalid username. \nMust be less than 24 characters."
                    }
                    
                }
                
            } else {
            
                if countElements(usernameField.text) < 6 {
                    

                    resultLabel.text = "Invalid username. \nMust be greater than 6 characters."
                    
                } else {
                
                    resultLabel.text = "Invalid username. \nMust be shorter than 20 characters."
                    
                }
                
            }
            
        } else {
            
            var alertViewController = UIAlertController(title: "Submission Error", message: "All fields must be filled in.", preferredStyle: UIAlertControllerStyle.Alert)
            
            var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
            resultLabel.text = "All fields must be filled in"
            
        }
        
    }
    
    func login() {
        
        PFUser.logInWithUsernameInBackground(usernameField.text, password:passwordField.text) {
            
            (user: PFUser!, error: NSError!) -> Void in
            
            if user != nil {
                
                // Do stuff after successful login.
                
                println("logged in as \(user)")
            
            } else {
                
                // The login failed. Check error to see why.
            
            }
            
        }
        
    }
    
    func signUp() {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
        // other fields can be set just like with PFObject
        
        // .signUpInBackgroundWithBlock is the method { the block is a parameter }
        // you can only remove the () if the method has ONLY a block parameter
        // signUpInBackgroundWithBlock first jumps to Parse, which is run in a side thread
        // then it jumps back to the main thread by jumping back to the block
        
        user.signUpInBackgroundWithBlock() {
            (succeeded: Bool!, error: NSError!) -> Void in // in just says when we are going to start the closure/block
            
            if error == nil {
                
                println(user)
                // Hooray! Let them use the app now.
                
                // we will use self is closures/blocks
                self.usernameField.text = ""
                self.passwordField.text = ""
                self.emailField.text = ""
                
            } else {
                
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
                
            }
            
        } // end scope of the closure
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
// in button action {}

var fieldValues: [String] = [usernameField.text, passwordField.text, emailField.text]

if find(fieldValues, "") != nil {
    
    // all fields are not filled in
    var alertViewController = UIAlertController(title: "Submission Error", message: "All fields must be filled in.", preferredStyle: UIAlertControllerStyle.Alert)

    
    // this Objective-C class method returns an object, it automatically alloc and inits
    // class denotes an object, as well as the pointer
    // UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    // in swift, class methods start with class(method)
    var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)

    alertViewController.addAction(defaultAction)

    presentViewController(alertViewController, animated: true, completion: nil)

} else {

    // all fields are filled in

}
*/
