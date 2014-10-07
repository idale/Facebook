//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var isPresenting: Bool = true
    var tapImageSegue: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }

    //TAP GESTURE FOR IMAGE
    @IBAction func onPhotoTap(gestureRecognizer: UITapGestureRecognizer) {
        tapImageSegue = gestureRecognizer.view as UIImageView!
        performSegueWithIdentifier("PhotoSegue", sender: self)
    }

    
    //SEGUE
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        destinationViewController.image = self.tapImageSegue.image
        
        //setting up transition
        var destinationVC = segue.destinationViewController as UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
        
        
        //var destinationViewController = segue.destinationViewController as PhotoViewController
        //destinationViewController.image = self.tapImageSegue.image
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! { isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        var window = UIApplication.sharedApplication().keyWindow
        var frame = window.convertRect(tapImageSegue.frame, fromView: scrollView)
        var copyFeedImage = UIImageView(frame: frame)
        
        if (isPresenting) {

            
            copyFeedImage.image = tapImageSegue.image
            copyFeedImage.clipsToBounds = true
            copyFeedImage.contentMode = UIViewContentMode.ScaleAspectFill
            
            window.addSubview(copyFeedImage)
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            if let vc = toViewController as? PhotoViewController { vc.imageView.hidden = true }
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                copyFeedImage.frame.size.width = 320
                copyFeedImage.frame.size.height = 320 * (copyFeedImage.image!.size.height / copyFeedImage.image!.size.width)
                copyFeedImage.center.x = 320 / 2
                copyFeedImage.center.y = 568 / 2
                toViewController.view.alpha = 1
                
                }, completion: { (finished: Bool) -> Void in
                    copyFeedImage.removeFromSuperview()
                    if let vc = toViewController as? PhotoViewController { vc.imageView.hidden = false }
                    transitionContext.completeTransition(true)
            })

        } else {
            
            copyFeedImage.image = tapImageSegue.image
            copyFeedImage.contentMode = UIViewContentMode.ScaleAspectFill
            copyFeedImage.clipsToBounds = true
            copyFeedImage.frame.size.width = 320
            copyFeedImage.frame.size.height = 320 * (copyFeedImage.image!.size.height / copyFeedImage.image!.size.width)
            copyFeedImage.center.x = 320 / 2
            copyFeedImage.center.y = 568 / 2
            
            window.addSubview(copyFeedImage)
            
            toViewController.view.alpha = 0
            fromViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                toViewController.view.alpha = 1
                copyFeedImage.frame = window.convertRect(self.tapImageSegue.frame, fromView: self.scrollView)
                
                }, completion: { (finished: Bool) -> Void in
                    
                    copyFeedImage.removeFromSuperview()
                    transitionContext.completeTransition(true)

            })
    }

}
}
