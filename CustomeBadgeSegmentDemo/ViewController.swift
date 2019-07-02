//
//  ViewController.swift
//  CustomeBadgeSegmentDemo
//
//  Created by tezwez on 2019/7/2.
//  Copyright © 2019 tezwez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segment: IWBadgeSegment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let segment = IWBadgeSegment.init(frame: CGRect.init(x: 16, y: 50, width: UIScreen.main.bounds.size.width-16*2, height: 44), segmentTitles: ["西瓜"])
        segment.badges?[0] = 8
        self.view.addSubview(segment)
        segment.addTarget(self, action: #selector(segmentAction), for: UIControl.Event.valueChanged)
        
        
        let segment1 = IWBadgeSegment.init(frame: CGRect.init(x: 16, y: 50+50, width: UIScreen.main.bounds.size.width-16*2, height: 44), segmentTitles: ["西瓜","冬瓜","南瓜","北瓜"])
        self.view.addSubview(segment1)
        segment1.badges?[2] = 10
        segment1.tintColor = UIColor.init(red: 0.3, green: 0.8, blue: 0.1, alpha: 1)
        segment1.selectedTitleColor = UIColor.red
        segment1.normalTitleColor = UIColor.darkGray
        segment1.addTarget(self, action: #selector(segmentAction), for: UIControl.Event.valueChanged)
        
        self.segment.segmentTitles = ["西瓜","冬瓜","南瓜","北瓜","冬瓜","南瓜","北瓜","冬瓜","南瓜"]
        self.segment.badges?[0] = 22
    }
    
    @objc func segmentAction(sg: IWBadgeSegment){
        print(sg.currentIndex)
    }

    @IBAction func segmentXibAction(_ sender: IWBadgeSegment) {
        print(sender.currentIndex)
    }
    
}

