//
//  VedioPlayController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/19.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class VedioPlayController: AVPlayerViewController {

    var ID = 0
    var type = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        //self.loadData1()
    }
    func loadData() {
        let urlStr = String.init(format: "http://mapiv2.yinyuetai.com/video/play.json?id=%ld&type=%ld", ID,type)
        BaseRequest.getWithURK(url: urlStr, para: nil) { (data, error) in
            if error == nil {
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
//                let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//                print(obj!)
                let data = dic["data"] as! NSDictionary
                let vurl = data["url"] as? String
                if vurl == nil {
                    let acon = UIAlertController.init(title: "⚠️", message: "服务器故障，请稍后再试", preferredStyle: .alert)
                    let ac1 = UIAlertAction.init(title: "是", style: .default, handler: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    acon.addAction(ac1)
                    self.present(acon, animated: true, completion: nil)
                } else {
                    self.VedioPlay(url: vurl!)
                }
            }
        }
        
        
    }
    
    //2713250
    func loadData1() {
        let urlStr = String.init(format: "http://mapiv2.yinyuetai.com/video/play.json?id=2713250&type=1")
        BaseRequest.getWithURK(url: urlStr, para: nil) { (data, error) in
            if error == nil {
                
                let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
                print(obj!)
                
            }
        }
    }
    func VedioPlay(url:String) {
        
        self.player = AVPlayer.init(url: URL.init(string: url)!)
        self.player?.play()
    
    }

}
