//
//  MyTabBarView.swift
//  DMDMD
//
//  Created by qianfeng on 16/9/1.
//  Copyright © 2016年 chenxiang. All rights reserved.
//

/*
 使用：
    self.automaticallyAdjustsScrollViewInsets=false
 
    let myTabBarV=MyTabBarView.init(frame: CGRectMake(0, 22, SCREEN_WIDTH, SCREEN_HEIGHT-22), vcArr: vcArr)
    self.view.addSubview(myTabBarV)
 
 
 当前button处于左右边界时滚动topSV
 
 button总长度小于屏幕宽时，平分屏幕。          滚动bodySV时，line跟随滚动。
 button总长度大于屏幕宽时，按内容设button宽。  滚动bodySV时，line不跟随滚动。
 */

import UIKit

@objc protocol MyTabBarDelegate:NSObjectProtocol {
    // 选中某页调用
    @objc optional func selectedWithIndex(index:Int)
}

class MyTabBarView: UIView {
    
    weak var myDelegate:MyTabBarDelegate?       // delegate
    
    let lineBigButtonLeft:CGFloat=3               // line 左边超出button(在button总长度>屏幕宽时有效，<时规定了固定大小)
    let lineH:CGFloat=2.3                         // line 高
    let tabHeight:CGFloat=40                      // tabBar 高
    let tabButtonFontSize:CGFloat=15              // tabBar button字体大小
    let tabMargin:CGFloat=38                      // tabBar 左右边距
    var tabBgColor=UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)                     // tabBar bgColor
    var tabButtonTitleColorNormal:UIColor=UIColor.white      // tabBar button标题颜色(normal)
    var tabButtonTitleColorSelected:UIColor=UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1)     // tabBar button标题颜色(selected)
    var lineColor:UIColor=UIColor.clear//init(red: 0, green: 120.0/255, blue: 255.0/255, alpha: 1) // line color
    
    var tabRedDotArr:NSMutableArray=NSMutableArray()    // 红点Arr(用于隐藏、显示)
    var tabButtonArr:NSMutableArray=NSMutableArray()    // buttonArr
    var currentTabSelected:Int=0                        // 当前 选中
    var isUseDragging:Bool=false                        // 是否 是手指触摸滚动（用于立刻更新、滚动结束再更新）
    var isLess=false                                    // 是否 所有button长度少于屏幕宽（用于规定button大小、滚动topSV）
    
    var time:TimeInterval=1.2                         // 当前button处于边界时topSV滚动时间
    var currentTopLeft:CGFloat=0        // 用于判断是否处于边界
    var currentTopRight:CGFloat=0       // 用于判断是否处于边界
    
    var vcArr:NSArray!                  // [子控制器]
    var tabView:UIScrollView!           // topSV
    lazy var bodySV:UIScrollView={      // bodySV
        //0, self.tabHeight, self.frame.size.width, self.frame.size.height-self.tabHeight0
        let bodyScrollView=UIScrollView.init(frame: CGRect.init(x: 0, y: self.tabHeight, width: self.frame.size.width, height: self.frame.size.height - self.tabHeight))
        bodyScrollView.delegate=self
        bodyScrollView.isPagingEnabled=true
        bodyScrollView.bounces=true
        bodyScrollView.showsHorizontalScrollIndicator=true
        bodyScrollView.autoresizingMask=[.flexibleHeight, .flexibleBottomMargin,.flexibleWidth]
        self.addSubview(bodyScrollView)
        
        return bodyScrollView
    }()
    lazy var updateButton:((_ x:Int)->())={    // 更新选中button的颜色，并记录当前下标
        (self.tabButtonArr[self.currentTabSelected] as! UIButton).isSelected=false
        (self.tabButtonArr[$0] as! UIButton).isSelected=true
        self.currentTabSelected=$0
    }
    func updateUI(normal:UIColor,select:UIColor,line:UIColor) {
        self.tabButtonTitleColorNormal = normal
        self.tabButtonTitleColorSelected = select
        self.lineColor = line
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(frame: CGRect,vcArr:NSArray,dele:MyTabBarDelegate?) {
        self.init(frame:frame)
        
        self.vcArr=vcArr
        self.myDelegate=dele
        createUI()
    }
    
    
    // UI
    func createUI(){
        
        // topSV  (0, 0, self.frame.width, self.tabHeight)
        self.tabView=UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.tabHeight))
        self.tabView.showsHorizontalScrollIndicator=false
        self.tabView.backgroundColor=self.tabBgColor
        self.addSubview(tabView)
        //
        
        var widthL:CGFloat=self.tabMargin    // 记录每个button距屏幕的左边距
        for i in 0..<vcArr.count{
            // itemButton       （topSV） (1000, frame.size.height-self.lineH)
            let itemButton=UIButton.init()
            let itemButtonWidth=((vcArr[i] as AnyObject).title!! as String).boundingRect(with: CGSize.init(width: 1000, height: frame.size.height - self.lineH), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: self.tabButtonFontSize)], context: nil).width+5
            //Make(widthL, 0, itemButtonWidth, self.tabHeight)

            itemButton.frame=CGRect.init(x: widthL, y: 0, width: itemButtonWidth, height: self.tabHeight)
            itemButton.tag=300+i
            itemButton.titleLabel?.baselineAdjustment = .alignCenters       // ?
            itemButton.titleLabel?.font=UIFont.systemFont(ofSize: self.tabButtonFontSize)
            itemButton.setTitle((vcArr[i] as AnyObject).title, for: .normal)
            itemButton.setTitleColor(self.tabButtonTitleColorNormal, for: .normal)
            itemButton.setTitleColor(self.tabButtonTitleColorSelected, for: .selected)
            itemButton.addTarget(self, action: #selector(self.handleTabButton(button:)), for: .touchUpInside)
            self.tabView.addSubview(itemButton)
            self.tabButtonArr.add(itemButton)
            
            // 小红点             （topSV） Make(itemButton.frame.size.width/2+3, itemButton.frame.size.height/2, 8, 8))
            let aRedDotView=UIView.init(frame:CGRect.init(x: itemButton.frame.size.width/2+3, y: itemButton.frame.size.height/2, width: 8, height: 8))
            aRedDotView.backgroundColor=UIColor.red
            aRedDotView.layer.cornerRadius=aRedDotView.frame.width/2
            aRedDotView.layer.masksToBounds=true
            aRedDotView.isHidden=true
            itemButton.addSubview(aRedDotView)
            self.tabRedDotArr.add(aRedDotView)
            
            // line             （topSV） (itemButton.frame.origin.x-lineBigButtonLeft, itemButton.frame.height-lineH, itemButtonWidth+lineBigButtonLeft*2, lineH)
            if i==0{
                let lineView=UIView.init(frame: CGRect.init(x: itemButton.frame.origin.x - lineBigButtonLeft, y: itemButton.frame.height - lineH, width: itemButtonWidth + lineBigButtonLeft*2, height: lineH))
                lineView.tag=100
                lineView.backgroundColor=self.lineColor
                self.tabView.addSubview(lineView)
                
                // 默认选中button ， 当前选中下标
                itemButton.isSelected=true
                self.currentTabSelected=0
            }
            // 更新左边距
            widthL+=(itemButtonWidth+self.tabMargin)
            
            
            //                  （bodySV）
            self.bodySV.addSubview((vcArr[i] as AnyObject).view)
        }
        
        //                      （topSV）
        if widthL<self.frame.width{         // 不用滚动，总长度少于屏幕宽，重新更新button的宽
        
            self.isLess=true
            for i in 0..<self.tabButtonArr.count{
                let button=self.tabButtonArr[i] as! UIButton
                
                button.frame.size.width=self.frame.width/CGFloat(self.tabButtonArr.count)
                button.frame.origin.x=button.frame.width*CGFloat(i)
            }
            
            let lineView=self.tabView.viewWithTag(100)!
            lineView.frame.origin.x=(self.tabButtonArr[0] as! UIButton).frame.origin.x
            lineView.frame.size.width=(self.tabButtonArr[0] as! UIButton).frame.width
        }else{
            //Make(widthL, self.tabView.frame.height)
            self.tabView.contentSize=CGSize.init(width: widthL, height: self.tabView.frame.height)
        }
        
        //                      （bodySV） Make(self.frame.width*CGFloat(vcArr.count), self.tabHeight)
        self.bodySV.contentSize=CGSize.init(width: self.frame.width * CGFloat(self.vcArr.count), height: self.tabHeight)
        for i in 0..<vcArr.count{
            //Make(self.bodySV.frame.width*CGFloat(i), 0, self.bodySV.frame.width, self.bodySV.frame.height)
            ((vcArr[i] as AnyObject).view as UIView).frame=CGRect.init(x: self.bodySV.frame.width*CGFloat(i), y: 0, width: self.bodySV.frame.width, height: self.bodySV.frame.height)
            if i==0{    // 立即刷新第一页（使用了VC的view，会走viewDidLoad，此时tableView的mj_head才有值）
                self.myDelegate?.selectedWithIndex?(index: 0)
            }
        }
    }
 
    // 点击 标题button
    func handleTabButton(button:UIButton){
        isUseDragging=false
        self.selectTabWithIndex(index: button.tag-300, isAnimate: true)
    }
    
    // 改变 项
    func selectTabWithIndex(index:Int,isAnimate:Bool){
        
        if !isUseDragging{  // 点击时立刻更新button
            updateButton(index)
        }
    
        // 当前button
        let button=self.tabButtonArr[index] as! UIButton
        // 更新line的位置
        weak var weakSelf=self
        UIView.animate(withDuration: 0.35, animations: {
            
            // line位置
            let lineView=self.viewWithTag(100)!
            var frame=lineView.frame
            if weakSelf!.isLess{    // 
                frame.origin.x=button.frame.origin.x
                frame.size.width=button.frame.width
            }else{
                frame.origin.x=button.frame.origin.x-weakSelf!.lineBigButtonLeft
                frame.size.width=button.frame.width+weakSelf!.lineBigButtonLeft*2
            }
            lineView.frame=frame
        }){ (finished) in
            if weakSelf!.isUseDragging && !weakSelf!.isLess{
                weakSelf!.updateButton(index)
            }
        }

        // 是点击                      （要滑动bodySV）
        if !isUseDragging{
            // 滚动bodySV Make(CGFloat(index)*self.frame.width, 0)
            UIView.animate(withDuration: 1.5, animations: { 
                self.bodySV.setContentOffset(CGPoint.init(x: CGFloat(index)*self.frame.width, y: 0), animated: isAnimate)
            })
        }
        
        // button总长度大于屏幕宽       （要在button处于边界的时候，滚动topSV）
        if !isLess{
            
            let maxX=self.tabView.contentSize.width            // contentSize宽度
            let button=self.tabButtonArr[index] as! UIButton   // 当前button
            if button.frame.maxX>(self.frame.width+currentTopLeft){     // 右边界在屏幕外（往右）
            
                if maxX-button.frame.minX<self.frame.width{ // 不够 完整左移 Make(maxX-self.frame.width, 0)
                    UIView.animate(withDuration: self.time, animations: {
                        self.tabView.contentOffset=CGPoint.init(x: maxX-self.frame.width, y: 0)   // 偏移量
                    })
                    // 更新left
                    currentTopLeft=maxX-self.frame.width    // 就是偏移量
                    currentTopRight=maxX                    // 就是偏移量+屏幕宽
                }else{                                      // 够 Make(button.frame.minX, 0)
                    UIView.animate(withDuration: self.time, animations: {
                        self.tabView.contentOffset=CGPoint.init(x: button.frame.minX, y: 0)
                    })
                    // 更新left
                    currentTopLeft = button.frame.origin.x
                    currentTopRight = currentTopLeft+self.frame.width
                }
            }
            if button.frame.minX<(currentTopRight-self.frame.width){      // 左边界在屏幕外（往左）
                
                if button.frame.maxX-0<self.frame.width {    // 不够 Make(0, 0)
                    UIView.animate(withDuration: self.time, animations: {
                        self.tabView.contentOffset=CGPoint.init(x: 0, y: 0)
                    })
                    currentTopLeft=0
                    currentTopRight=currentTopLeft+self.frame.width
                }else{      //  Make(button.frame.maxX-self.frame.width, 0)
                    UIView.animate(withDuration: self.time, animations: {
                        self.tabView.contentOffset=CGPoint.init(x: button.frame.maxX-self.frame.width, y: 0)
                    })
                    currentTopLeft=button.frame.maxX-self.frame.width
                    currentTopRight=currentTopLeft+self.frame.width
                }
            }
        }

        // 隐藏小红点（查阅了，所以隐藏）
        self.hideTabRedDot(index: index)
        
        // 调用delegate的 选中某项并滚动完毕后调用
        self.myDelegate?.selectedWithIndex?(index: index)
    }

    
    // 显示小红点
    func showTabRedDot(index:Int){
        (self.tabRedDotArr[index] as! UIView).isHidden=false
    }
    // 隐藏小红点
    func hideTabRedDot(index:Int){
        (self.tabRedDotArr[index] as! UIView).isHidden=true
    }
}


extension MyTabBarView:UIScrollViewDelegate{

    // 滚动完毕后调用，设置偏移量不调用（只有手拖动后）
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView==self.bodySV{     // 防止滚动topSV时也调用
            self.isUseDragging=true
            self.selectTabWithIndex(index: Int(scrollView.contentOffset.x/self.bounds.size.width), isAnimate: true)
        }
    }
    
    // 滚动时调用（连续触发）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView==self.bodySV && isUseDragging{        // 是滑动
            if scrollView.contentOffset.x>0 && scrollView.contentOffset.x<CGFloat(self.tabButtonArr.count-1)*self.frame.width{    // 最左边< _ <最右边
                if self.isLess{     // 只在 button总长度小于屏幕宽时
                    // line位置
                    let lineView=self.viewWithTag(100)!
                    var frame=lineView.frame
                    frame.origin.x=scrollView.contentOffset.x/CGFloat(self.tabButtonArr.count)
                    lineView.frame=frame
                    
                    // 更新button标题
                    let x=lineView.frame.midX<self.frame.width/CGFloat(self.tabButtonArr.count) ? 0 : (lineView.frame.midX<self.frame.width/CGFloat(self.tabButtonArr.count)*2 ? 1: 2)
                    updateButton(x)
                }
            }
        }
    }
}
