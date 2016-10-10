//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Abowd, Jonathan on 10/10/16.
//  Copyright © 2016 Abowd, Jonathan. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!

    @IBOutlet weak var messageParentView: UIView!
    @IBOutlet weak var remindImage: UIImageView!
    @IBOutlet weak var archiveImage: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!

    var ogMessageX: CGFloat!
    var messageX: CGFloat!
    
    var ogRemindX: CGFloat!
    var remindX: CGFloat!
    
    var ogArchiveX: CGFloat!
    var archiveX: CGFloat!
    
    var ogMainViewX: CGFloat!
    var mainViewX: CGFloat!
    
    let animationDuration: Double! = 0.25
    let mainViewOffset: CGFloat! = 290
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.contentSize.height = feedImage.frame.origin.y + feedImage.frame.height
        
        ogMessageX = messageImage.frame.origin.x
        ogRemindX = remindImage.frame.origin.x
        ogArchiveX = archiveImage.frame.origin.x
        ogMainViewX = mainView.frame.origin.x
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func panOnMessage(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: messageImage).x
        let rightOffset: CGFloat! = -70
        let farRightOffset: CGFloat! = -200
        
        let leftOffset: CGFloat! = 70
        let farLeftOffset: CGFloat! = 200
        
        print("message pan \(translation)")
        
        if sender.state == .began {
            messageX = messageImage.frame.origin.x
            remindX = remindImage.frame.origin.x
            archiveX = archiveImage.frame.origin.x
            
            remindImage.alpha = 0
            archiveImage.alpha = 0
            
        } else if sender.state == .changed {
            messageImage.frame.origin.x = messageX + translation
            
            UIView.animate(withDuration: self.animationDuration, animations: {
                if translation < farRightOffset {
                    self.messageParentView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                    self.remindImage.frame.origin.x = self.remindX + translation - rightOffset
                    self.remindImage.image! = #imageLiteral(resourceName: "list_icon")
                } else if translation < rightOffset {
                    self.messageParentView.backgroundColor = #colorLiteral(red: 1, green: 0.8627450466, blue: 0.1411764026, alpha: 1)
                    self.remindImage.frame.origin.x = self.remindX + translation - rightOffset
                    self.remindImage.image! = #imageLiteral(resourceName: "later_icon")
                    self.remindImage.alpha = 1
                } else if translation < leftOffset {
                    self.messageParentView.backgroundColor = #colorLiteral(red: 0.7882353663, green: 0.8078430891, blue: 0.8235294223, alpha: 1)
                    self.remindImage.frame.origin.x = self.ogRemindX
                    self.archiveImage.frame.origin.x = self.ogArchiveX
                } else if translation < farLeftOffset {
                    self.messageParentView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    self.archiveImage.frame.origin.x = self.archiveX + translation - leftOffset
                    self.archiveImage.image = #imageLiteral(resourceName: "archive_icon")
                    self.archiveImage.alpha = 1
                } else if translation > farLeftOffset {
                    self.messageParentView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                    self.archiveImage.frame.origin.x = self.archiveX + translation - leftOffset
                    self.archiveImage.image = #imageLiteral(resourceName: "delete_icon")
                }
                }, completion: { (Bool) in
                }
            )
            
        } else if sender.state == .ended {
            UIView.animate(withDuration: self.animationDuration, animations: {
                
                if translation < farRightOffset {
                    self.messageImage.frame.origin.x = self.messageImage.frame.width * -1
                    self.archiveImage.isHidden = true
                    self.remindImage.frame.origin.x = self.messageImage.frame.width * -1
                } else if translation < rightOffset {
                    self.messageImage.frame.origin.x = self.messageImage.frame.width * -1
                    self.archiveImage.isHidden = true
                    self.remindImage.frame.origin.x = self.messageImage.frame.width * -1
                } else if translation < leftOffset {
                    self.messageImage.frame.origin.x = self.ogMessageX
                    self.remindImage.frame.origin.x = self.ogRemindX
                    self.archiveImage.frame.origin.x = self.ogArchiveX
                } else if translation < farLeftOffset {
                    self.messageImage.frame.origin.x = self.messageImage.frame.width
                    self.remindImage.isHidden = true
                    self.archiveImage.frame.origin.x = self.messageImage.frame.width
                } else if translation > farLeftOffset {
                    self.messageImage.frame.origin.x = self.messageImage.frame.width
                    self.remindImage.isHidden = true
                    self.archiveImage.frame.origin.x = self.messageImage.frame.width
                }
                }, completion: { (Bool) in
                    UIView.animate(withDuration: self.animationDuration, animations: {
                        if translation < farRightOffset {
                            
                            print("show list")
                            self.listImage.alpha = 1
                            
                        } else if translation < rightOffset {
                            
                            print("show reschedule")
                            self.rescheduleImage.alpha = 1
                            
                        } else if translation < leftOffset {
                        } else if translation < farLeftOffset {
                            self.messageParentView.frame.origin.y -= self.messageParentView.frame.height
                            self.feedImage.frame.origin.y -= self.messageParentView.frame.height
                        } else if translation > farLeftOffset {
                            self.messageParentView.frame.origin.y -= self.messageParentView.frame.height
                            self.feedImage.frame.origin.y -= self.messageParentView.frame.height
                        }
                        }, completion: {(Bool) in
                            if translation > leftOffset {
                                self.messageParentView.isHidden = true
                            }
                        }
                    )
                }
            )
        }
        
    }
    
    
    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.listImage.alpha = 0
            self.rescheduleImage.alpha = 0
        }) { (Bool) in
            if self.messageImage.frame.origin.x != self.ogMessageX {
                UIView.animate(withDuration: self.animationDuration, animations: {
                    self.messageParentView.frame.origin.y -= self.messageParentView.frame.height
                    self.feedImage.frame.origin.y -= self.messageParentView.frame.height
                    }, completion: {(Bool) in
                        self.messageParentView.isHidden = true
                    }
                )
            }
        }
        
        if mainView.frame.origin.x != 0 {
            animateMenu(open: true)
        }
    }
    
    
    
    @IBAction func tapMenu(_ sender: UIButton) {
        if self.mainView.frame.origin.x == 0 {
            animateMenu(open: true)
        } else {
            animateMenu(open: false)
        }
    }
    
    
    
    
    func animateMenu(open: Bool){
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            if open {
                self.mainView.frame.origin.x = self.mainViewOffset
            } else {
                self.mainView.frame.origin.x = 0
            }
            
        }) { (Bool) in
        }
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
