//
//  KolodaViewController.swift
//  Mentality
//
//  Created by Ербол Каршыга on 8/9/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit


class KolodaViewController: UIViewController {
    lazy var cards: [UIView] = []
    var draggable_view: CGDraggableView!
    var fractionalProgress : Float! = 0
    var fileName = String()
    
    
    @IBOutlet weak var lessonsProgress: UIProgressView!
    
    var counter:Float = 0 {
        didSet {
            fractionalProgress = counter / Float(cards.count)
            let animated = counter != 0
            lessonsProgress.setProgress(fractionalProgress, animated: animated)
            if fractionalProgress == 1 {
                cards = []
                viewNumber = 0
                counter = 0
                lessonsProgress.setProgress(0, animated: true)
                performSegueWithIdentifier("finishedSegue", sender: nil)
                
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let background = CAGradientLayer().turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        func readFile()  {
            let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
            let content: String = try! String.init(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            NSFileManager.defaultManager().createFileAtPath("Your/Path", contents: nil, attributes: nil)
            let cards: [String] = content.componentsSeparatedByString("#######").reverse()
            for card in cards {
                loadDraggableView(card)
                }
        }
        readFile()
        
    }
    
    

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loadDraggableView(text: String) {
        draggable_view = CGDraggableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width * 0.7 , UIScreen.mainScreen().bounds.height * 0.6))
        draggable_view.center.y = UIScreen.mainScreen().bounds.height/2
        draggable_view.center.x = UIScreen.mainScreen().bounds.width/2
        draggable_view.layer.cornerRadius = 20
        draggable_view.layer.masksToBounds = true
        draggable_view.del = self
        self.view.addSubview(draggable_view)
        cards.append(draggable_view)
        let text_field = UITextView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width * 0.7, draggable_view.frame.size.height))
        text_field.backgroundColor = UIColor.clearColor()
        draggable_view.addSubview(text_field)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [NSParagraphStyleAttributeName : style]
        text_field.attributedText = NSAttributedString(string: text, attributes:attributes)
        text_field.textColor = UIColor.blackColor()
        text_field.font = UIFont(name: "Helvetica", size: 19)
        
        var topCorrect = (text_field.bounds.size.height - text_field.contentSize.height * text_field.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        text_field.contentInset.top = topCorrect
        text_field.textAlignment = .Justified
        text_field.userInteractionEnabled = false
    }
    

}


extension KolodaViewController: SendNumberDelegate{
    func sendNumber(num: Float) {
        counter = num
    }
}