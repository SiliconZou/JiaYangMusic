//
//  MainViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/14.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBar.selectionIndicatorImage = UIImage.init(named: "AD_RSS_ClickBtn_sel")
        
        let greenc = UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1)
        let home = UINavigationController.init(rootViewController: HomeViewController())
        home.tabBarItem = UITabBarItem.init(title: "首页", image: UIImage.init(named: "tabbar_home~iphone")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: "tabbar_home_sel~iphone")?.withRenderingMode(.alwaysOriginal))
        home.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:greenc], for: .selected)
        home.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 11.7)], for: .normal)
        home.navigationBar.barTintColor = UIColor.black
        
        let nav = UINavigationController.init(rootViewController: NavViewController())
        nav.tabBarItem = UITabBarItem.init(title: "导航", image: UIImage.init(named: "tabbar_channel~iphone")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: "tabbar_channel_sel~iphone")?.withRenderingMode(.alwaysOriginal))
        nav.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:greenc], for: .selected)
        nav.navigationBar.barTintColor = UIColor.black
        nav.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 11.7)], for: .normal)
        
        let vb = UINavigationController.init(rootViewController: VBViewController())
        vb.tabBarItem = UITabBarItem.init(title: "V榜", image: UIImage.init(named: "tabbar_vchart~iphone")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: "tabbar_vchart_sel~iphone")?.withRenderingMode(.alwaysOriginal))
        vb.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:greenc], for: .selected)
        vb.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 11.7)], for: .normal)
        vb.navigationBar.barTintColor = UIColor.black
        
        let focus = UINavigationController.init(rootViewController: FocusViewController())
        focus.tabBarItem = UITabBarItem.init(title: "订阅", image: UIImage.init(named: "tabbar_rss~iphone")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: "tabbar_rss_sel~iphone")?.withRenderingMode(.alwaysOriginal))
        focus.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:greenc], for: .selected)
        focus.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 11.7)], for: .normal)
        focus.navigationBar.barTintColor = UIColor.black
        
        let mine = UINavigationController.init(rootViewController: MineViewController())
        mine.tabBarItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "tabbar_mine~iphone")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: "tabbar_mine_sel~iphone")?.withRenderingMode(.alwaysOriginal))
        mine.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:greenc], for: .selected)
        mine.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 11.7)], for: .normal)
        mine.navigationBar.barTintColor = UIColor.black
        
        self.tabBar.barTintColor = UIColor.black
        self.viewControllers = [home,nav,vb,focus]
        

        
    }
    
}
