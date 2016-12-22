//
//  PicModel.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/18.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class PicModel: NSObject {

    var videoId:Int?
    var posterPic:String?
    var title:String?
    var artistName:String?
    var dataTypeUrl:String?
    
}

class ContentModel:NSObject {
    var title:String?
    var artistName:String?
    var artistId:Int?
    var totalView:Int?
    var videoId:Int?
    var posterPic:String?
}

class SectionModel: NSObject {
    var enTitle:String?
    var title:String?
}

class HYueModel:NSObject {
    var nickName:String?
    var smallAvatar:String?
    var desc:String?
    var playListId:Int?
    var posterPic:String?
    var title:String?
    var totalView:Int?
    var totalFavorite:Int?
    var totalVideo:Int?
}

class NYirenModel:NSObject {
    var artistImg:String?
    var enname:String?
    var groupImg:String?
    var groupType:String?
    var name:String?
    var videoCount:Int?
    var subCount:Int?
    var artistId:Int?
}

class VBMVModel: NSObject {
    var albumImg:String?
    var artistName:String?
    var posterPic:String?
    var title:String?
    var videoId:Int?
    var number:Int?
    var score:String?
    var trendScore:String?
    var up:Bool?
}

class VBZhuanjiModel: NSObject {
    var artistName:String?
    var posterPic:String?
    var rank:Int?
    var title:String?
    var url:String?
}

class VBChinaModel: NSObject {
    var videoId:Int?
    var title:String?
    var posterPic:String?
    var score:String?
    var number:Int?
    var artistName:String?
    
    var prePosition:Int?
    var historyCount:Int?
    var bestPosition:Int?
}

class FHomeModel: NSObject {
    var artistId:Int?
    var name:String?
    var smallAvatar:String?
    var subCount:Int?
    var videoCount:Int?
}

class FCHomeModel: NSObject {
    var title:String?
    var videoId:Int?
    var totalView:Int?
    var posterPic:String?
    var artistName:String?
}

class YiInfoModel:NSObject {
    var aliasName:String? //别名
    var artistId:Int?
    var artistName:String? //姓名
    var brokerageFirm:String? //经济公司
    var debutTime:String? //出道时间
    var masterWork:String? //代表作品
    var nationality:String? //国际
    var otherInfo:String? //艺人简介
}

class YiMVModel: NSObject {
    var name:String? //组标题
    var posterPic:String?
    var regdate:String?
    var title:String?
    var artistName:String?
    var videoId:Int?
    var totalView:Int?
}
