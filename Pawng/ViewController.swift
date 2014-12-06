//
//  ViewController.swift
//  Pawng
//
//  Created by Brian Doore on 11/23/14.
//  Copyright (c) 2014 Brian Doore. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate, UIGestureRecognizerDelegate {
    
    var animator: UIDynamicAnimator!
    //var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    var ballProperties : UIDynamicItemBehavior!
    var paddleProperties : UIDynamicItemBehavior!
    
    var pusher : UIPushBehavior!
    
    var viewFrame : CGRect!
    
    var maxX : CGFloat!
    var maxY : CGFloat!
    
    var square : UIView!
    var UserPaddle : UIView!
    var AIPaddle : UIView!
    
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var UserScore: UILabel!
    @IBOutlet weak var AIScoreLabel: UILabel!
    
//    @IBOutlet weak var UserPaddle: UIView?
    
//    @IBOutlet weak var UserPaddleYConstraint: NSLayoutConstraint!
    
    override func loadView() {
        
        super.loadView()
        UserPaddle = UIView()
        
        
        
        view.addSubview(UserPaddle!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.panRecognizer.delegate = self
//        self.swipeRecognizer.direction
        self.view.addGestureRecognizer(self.panRecognizer)
        
//        self.swipeRecognizer.numberOfTouchesRequired = 1;
        
        
        
        viewFrame = self.view.bounds
        
        maxX = viewFrame.maxX
        maxY = viewFrame.maxY
        
            
        square = UIView(frame: CGRect(x: (maxX/2), y: 25, width: 25, height: 25))
        square.backgroundColor = UIColor.grayColor()
        view.addSubview(square)
        
//        UserPaddle = UIView(frame: CGRect(x: 30, y: maxY/2-50, width: 10, height: 100))
        

        
        AIPaddle = UIView(frame: CGRect(x: maxX-30, y: maxY/2-50, width: 10, height: 100))
        AIPaddle.backgroundColor = UIColor.redColor()
        view.addSubview(AIPaddle)
        
        animator = UIDynamicAnimator(referenceView: view)
        //gravity = UIGravityBehavior(items: [square])
        //animator.addBehavior(gravity)
        
        
        ballProperties = UIDynamicItemBehavior(items: [square])
        ballProperties.allowsRotation = false
        
        animator.addBehavior(ballProperties)

        ballProperties.elasticity = 1.0
        ballProperties.friction = 0.0
        ballProperties.resistance = 0.0
        
        

        
        
//        animator.addBehavior(ballProperties)
//        animator.addBehavior(paddleProperties)


        
        
        pusher = UIPushBehavior(items: [square], mode: UIPushBehaviorMode.Instantaneous)
        pusher.pushDirection = CGVectorMake(0.25, 0.125)
        pusher.active = true
        
        animator.addBehavior(pusher)
        
        
        
        

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if (UserPaddle.frame.size.width == 0){
            UserPaddle.frame = CGRect(x: 30, y: maxY/2-50, width: 10, height: 100)
            UserPaddle!.backgroundColor = UIColor.blueColor()
        }

        
        paddleProperties = UIDynamicItemBehavior(items: [UserPaddle,AIPaddle])
        paddleProperties.allowsRotation = false
        paddleProperties!.density = 9999.0
        
        animator.addBehavior(paddleProperties)
        
        collision = UICollisionBehavior(items: [square,UserPaddle,AIPaddle])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        
        collision.action = {
            //            println("Hey collisions")
            //            println("\(NSStringFromCGAffineTransform(square.transform)) \(NSStringFromCGPoint(square.center))")
            
            if(self.square.frame.minX <= 10 || self.square.frame.maxX >= self.maxX-10){
                //                println("\(self.square.center)")
                
            }
            
            
        }
        
        collision.collisionDelegate = self
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        
//        println("item 1 =\(item1) , item2 = \(item2)")

        
    }
    
    @IBAction func didPanOnView(sender: UIPanGestureRecognizer) {
        
//        var offset : CGPoint = sender.translationInView(self.view)
//        self.UserPaddleYConstraint.constant += offset.y
//        println("y constraint constant \(self.UserPaddleYConstraint.constant)")
//        self.view.layoutIfNeeded()
        
//        var constraints : [NSLayoutConstraint] = UserPaddle.constraints() as [NSLayoutConstraint]
//        
//        for constraint : NSLayoutConstraint in constraints{
//            
//            if (constraint.firstAttribute == NSLayoutAttribute.CenterY){
//                println("hello")
//            }
//        }
        
        
        
        var offset : CGPoint = sender.translationInView(self.view)
        var originPoint : CGPoint = UserPaddle!.frame.origin
        var newPoint : CGPoint = CGPointMake(UserPaddle!.frame.origin.x, originPoint.y + offset.y)
        
        var potentialNewFrame : CGRect = CGRectMake(20, newPoint.y, CGRectGetWidth(UserPaddle!.frame), CGRectGetHeight(UserPaddle!.frame))
        
        if (CGRectContainsRect(self.view.frame, potentialNewFrame)) {
            
            self.UserPaddle!.frame = potentialNewFrame;
            println( "new point y \(newPoint.y)")
        
        }
        
        
//        var velocity : CGPoint = sender.translationInView(self.view)
//        var frame : CGRect = self.userPaddle.frame
//        var frameOrigin : CGFloat = frame.origin.y + velocity.y
////        frameOrigin = min(frameOrigin, self.viewFrame.size.height - frame.size.height)
////        frameOrigin = max(frameOrigin, 0)
//
////        self.userPaddle.center = velocity
//        self.userPaddle.center = CGPointMake(self.userPaddle.center.x, self.userPaddle.center.y + velocity.y)
////            self.userPaddle.frame = CGRectMake(frame.origin.x, frame.origin.y + velocity.y, frame.size.width, frame.size.height)
//        println("\(self.userPaddle.center.x) \(self.userPaddle.center.y + velocity.y)")
//        sender.setTranslation(CGPointMake(0, 0), inView: self.view)
    }


    
    
//    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
//        
//    }
    
    
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }



}


