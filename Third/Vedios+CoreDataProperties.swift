//
//  Vedios+CoreDataProperties.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import Foundation
import CoreData


extension Vedios {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vedios> {
        return NSFetchRequest<Vedios>(entityName: "Vedios");
    }

    @NSManaged public var iD: Int32
    @NSManaged public var img: NSData?
    @NSManaged public var title: String?
    @NSManaged public var name: String?

}
