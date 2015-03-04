//
//  ViewController.swift
//  AVFoundationChapter1
//
//  Created by PanaCloud on 03/03/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate{
    
    var speechController=SpeechController()
    var speechStrings:[String]=[]
    
    

    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chatTableView.delegate=self
        chatTableView.dataSource=self
        
       
       
        
        chatTableView.contentInset=UIEdgeInsetsMake(20.0, 0.0, 20.0, 0.0)
        self.speechController.synthesizer.delegate=self
        
         speechController.beginConversation()
        
        
        
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.speechStrings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row % 2 == 0){
        var cell:YouCell=chatTableView.dequeueReusableCellWithIdentifier("YouCell", forIndexPath: indexPath) as YouCell
            cell.messageLabel.text=self.speechStrings[indexPath.row]
        return cell
        }
        else{
        var cell:AVFCell=chatTableView.dequeueReusableCellWithIdentifier("AVFCell", forIndexPath: indexPath) as AVFCell
        cell.messageLabel.text=self.speechStrings[indexPath.row]
        return cell
        }
        
    
        
    }
    
    
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        self.speechStrings.append(utterance.speechString)
        self.chatTableView.reloadData()
        var indexPath=NSIndexPath(forRow: self.speechStrings.count-1, inSection: 0)
        self.chatTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    
    
    

    
    
    
    

}

