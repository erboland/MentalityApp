//
//  GameViewController.swift
//  Mentality
//
//  Created by Ербол Каршыга on 8/1/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var problemTextLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
var timer = NSTimer()
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var level :Int!
    var rightNumber: Int!
    var leftNumber: Int!
    var diapasone : Int!
    var points = 0
    var operatorArray : [Character] = ["+"]
    var randomOperation : Int!
    var operation : Int!
    
    @IBOutlet weak var solutionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        super.viewDidLoad()
        let background = CAGradientLayer().turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        self.progressBar.transform = CGAffineTransformScale(progressBar.transform, 1, 20)
        self.progressBar.setProgress(0, animated: true)
            
        solutionTextField.becomeFirstResponder()
        self.solutionTextField.keyboardType = UIKeyboardType.NumberPad
        
        levelCheck()
        print (level)
        addDoneButtonOnKeyboard()
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    var counter:Double = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 60.0
            let animated = counter != 0
            progressBar.setProgress(fractionalProgress, animated: animated)
        }
    }
    @IBAction func startCount(sender: UIButton) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: #selector(GameViewController.updateCounter), userInfo: nil, repeats: true)
        submitButton.setTitle("", forState: .Normal)
        submitButton.userInteractionEnabled = false
        submitButton.alpha = 0
        goButton.alpha = 1
        generateMultiples()
        }
    func updateCounter () {
        counter += 0.01
        if counter >= 60 {
            timer.invalidate()
            counter = 0
            performSegueWithIdentifier("scoreSegue", sender: nil)
        }
    }
    
    @IBAction func goButton(sender: UIButton) {
        guard let answer = Int(solutionTextField.text!) else {
            alertController("No answer!", message: "Please print your answer before pressing Submit button", isBackButton: true, isReturnButton: false)
            return
        }
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(solutionTextField.center.x - 10, solutionTextField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(solutionTextField.center.x + 10, solutionTextField.center.y))
    let mathExpression = NSExpression(format: self.problemTextLabel.text!)
    let mathValue = mathExpression.expressionValueWithObject(nil, context: nil) as! Int
       if answer == mathValue {
            self.points = self.points + 1
            self.solutionTextField.text = ""
            self.generateMultiples()
        } else {
            self.solutionTextField.text = ""
            solutionTextField.layer.addAnimation(animation, forKey: "position")
        }
        
    }
    func generateRandomNumber() -> Int {
        return Int(arc4random_uniform(UInt32(diapasone)))+1
    }
    func generateIndexOperation () -> Int {
        let randomOperation = Int(arc4random_uniform(UInt32(operatorArray.count)))
        return randomOperation
        }
    func generateStringOperation () -> Character {
        let stringOperation = operatorArray [generateIndexOperation()]
        print (operatorArray)
        print (stringOperation)
        return stringOperation
    }
    func generateMultiples() {
        
        rightNumber = generateRandomNumber()
        leftNumber = generateRandomNumber()
        if leftNumber > rightNumber {
            self.problemTextLabel.text = "\(leftNumber)\(generateStringOperation())\(rightNumber)"
        } else {
            self.problemTextLabel.text = "\(rightNumber)\(generateStringOperation())\(leftNumber)"
        }
        if leftNumber%rightNumber == 0 {
            self.problemTextLabel.text = "\(leftNumber)/\(rightNumber)"
        }
        
        
    }
    func alertController(title:String, message: String, isBackButton: Bool, isReturnButton: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let backButton = UIAlertAction(title:"Try again", style: UIAlertActionStyle.Default, handler: nil)
        let returnButton = UIAlertAction(title: "Yes", style: .Default) { (UIAlertAction) in
            self.performSegueWithIdentifier("returnSegue", sender: self)
        }
        if isBackButton == true {alertController.addAction(backButton)}
        if isReturnButton == true {alertController.addAction(returnButton)}
        

        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func levelCheck () {
        switch level {
    case 1 :
        diapasone = 10
    case 2:
        diapasone = 20
        operatorArray.append("-")
        case 3...9:
            diapasone = level*10
            operatorArray.append("-")
            operatorArray.append("*")
            
    default :
        diapasone = 100
    }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "scoreSegue" {
        let destVC = segue.destinationViewController as! ResulViewController
        destVC.score = points
        destVC.level = level
        }
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(GameViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.solutionTextField.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        guard let answer = Int(solutionTextField.text!) else {
            alertController("No answer!", message: "Please print your answer before pressing Submit button", isBackButton: true, isReturnButton: false)
            return
        }
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(solutionTextField.center.x - 10, solutionTextField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(solutionTextField.center.x + 10, solutionTextField.center.y))
        let mathExpression = NSExpression(format: self.problemTextLabel.text!)
        let mathValue = mathExpression.expressionValueWithObject(nil, context: nil) as! Int
        if answer == mathValue {
            self.points = self.points + 1
            self.solutionTextField.text = ""
            self.generateMultiples()
        } else {
            self.solutionTextField.text = ""
            solutionTextField.layer.addAnimation(animation, forKey: "position")
        }
        

    }
    
    @IBAction func returnButtonPressed(sender: UIButton) {
        alertController("Are you sure?", message: "Do you really want to give up?", isBackButton: false, isReturnButton: true)
    }

   

}
