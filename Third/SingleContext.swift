//
//  SingleContext.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class SingleContext: NSObject {
    
    static let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
}
