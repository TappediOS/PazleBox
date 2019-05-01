//
//  HardStageClearInfomation.swift
//  PazleBox
//
//  Created by jun on 2019/05/01.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import RealmSwift

class HardStageClearInfomation: Object{
   
   @objc dynamic var StageNum: Int = 0
   @objc dynamic var Clear: Bool = false
   @objc dynamic var CountOfUsedHint: Int = 2
   
}
