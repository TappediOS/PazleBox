//
//  ExEnum.swift
//  PazleBox
//
//  Created by jun on 2019/03/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

extension UserDefaults {
   
   func setEnum<T: RawRepresentable>(_ value: T?, forKey key: String) where T.RawValue == String {
      if let value = value {
         set(value.rawValue, forKey: key)
      } else {
         removeObject(forKey: key)
      }
   }
   
   func getEnum<T: RawRepresentable>(forKey key: String) -> T? where T.RawValue == String {
      if let string = string(forKey: key) {
         return T(rawValue: string)
      }
      return nil
   }
}
