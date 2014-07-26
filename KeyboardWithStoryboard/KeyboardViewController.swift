//
//  KeyboardViewController.swift
//  KeyboardWithStoryboard
//
//  Created by Grady Zhuo on 2014/7/25.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var isLetterUpper:Bool = true
    var documentProxy:UITextDocumentProxy{
        return super.textDocumentProxy as UITextDocumentProxy
    }
    
    @IBOutlet var letterButtons: [UIButton] = []
    @IBOutlet var specialButtons: [UIButton] = []
    @IBOutlet var spaceButtons:[UIButton] = []
    
    var lock = false
    var shouldStop:Bool = true
    
    @IBAction func breakLongPressed(sender: AnyObject) {
        
//        
//        var gesture:UILongPressGestureRecognizer = sender as UILongPressGestureRecognizer
//        
//        switch gesture.state{
//        case .Began:
//            self.shouldStop = false
//            lock = false
//            break
//        case .Ended:
//            self.shouldStop = true
//            break
//        default:
//            break
//        }
//        
//
//        
//        
    }
    
    @IBAction func shiftPressed(sender: AnyObject) {
        
        for button:UIButton in self.letterButtons{
            var title = button.titleForState(UIControlState.Normal)
            if self.isLetterUpper{
                title = title.lowercaseString
            }else{
                title = title.uppercaseString
            }
            
            button.setTitle(title, forState: UIControlState.Normal)
        }
        
        self.isLetterUpper = !self.isLetterUpper
    }
    
    @IBAction func nextPressed(sender: AnyObject) {
        self.advanceToNextInputMode()
    }
    
    @IBAction func spacePressed(sender: AnyObject) {
        self.documentProxy.insertText(" ")
    }
    
    @IBAction func closePressed(sender: AnyObject) {
        self.dismissKeyboard()
    }
    @IBAction func breakPressed(sender: AnyObject) {
        self.documentProxy.deleteBackward()
        
    }
    
    func letterPressed(sender:AnyObject){
        var letterButton:UIButton = sender as UIButton
        self.documentProxy.insertText(letterButton.titleForState(.Normal))
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        println(self.view.window)
        
        self.setupKeyboard()
        
    }
    
    func setupKeyboard(){
        
        var textColor:UIColor
        var bgColor:UIColor
        
        var specialTextColor:UIColor
        var specialBgColor:UIColor
        
        var spaceTextColor:UIColor
        var spaceBgColor:UIColor
        
        if self.documentProxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
            bgColor = UIColor(white: 0.5, alpha: 0.9)
            
            specialTextColor = UIColor.blackColor()
            specialBgColor = UIColor(white: 0.8, alpha: 0.8)
            
            spaceTextColor = UIColor.blackColor()
            spaceBgColor = UIColor.whiteColor()
            
        } else {
            textColor = UIColor.blackColor()
            bgColor = UIColor(white: 1, alpha: 0.9)
            
            specialTextColor = UIColor.whiteColor()
            specialBgColor = UIColor(white: 0.3, alpha: 0.8)
            
            spaceTextColor = UIColor.whiteColor()
            spaceBgColor = UIColor.blackColor()
        }
        
        
        
        for button:UIButton in self.letterButtons{
            button.layer.cornerRadius = 4.0;
            button.addTarget(self, action: "letterPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitleColor(textColor, forState: .Normal)
            button.backgroundColor = bgColor
        }
        
        
        for button:UIButton in self.specialButtons{
            button.layer.cornerRadius = 4.0;
            button.setTitleColor(specialTextColor, forState: .Normal)
            button.backgroundColor = specialBgColor
        }
        
        for button:UIButton in self.spaceButtons{
            button.layer.cornerRadius = 4.0;
            button.setTitleColor(spaceTextColor, forState: .Normal)
            button.backgroundColor = spaceBgColor
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.

    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        
        
        UIView.animateWithDuration(0.2){ (Void)->Void in
            self.setupKeyboard()
        }
        
        

        
    }
    
    
    

}

