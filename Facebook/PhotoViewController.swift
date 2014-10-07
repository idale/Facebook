//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Ida Leung on 10/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var photoScroll: UIScrollView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var imageControls: UIImageView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var viewBackground: UIView!
    
    var image: UIImage!
    var offset: CGFloat!
    var originalOrigin: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageView.hidden = true
        imageView.image = self.image
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.center = view.center
        
        photoScroll.delegate = self
        photoScroll.contentSize = CGSize(width: 320, height: 600)
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        offset = 0
        
    }

    @IBAction func onTapDone(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidAppear(animated: Bool) {
        imageView.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(sender: UIScrollView!) {
        offset = photoScroll.contentOffset.y
        photoScroll.backgroundColor = UIColor(white: 0, alpha: ((100-abs(offset))/100))
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        originalOrigin = imageView.frame.origin
        
        doneButton.hidden = true
        imageControls.hidden = true
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            if (abs(offset) > 100) {
                dismissViewControllerAnimated(true, completion: nil)
            }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        doneButton.hidden = false
        imageControls.hidden = false
    }
    

}
