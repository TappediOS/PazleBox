//
//  ButtonColorManager.swift
//  PazleBox
//
//  Created by jun on 2019/05/30.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import FlatUIKit



class ButtonColorManager {
   
   
   
   public func GetButtonFlatColor(RemoConButtonColorValue: String) -> UIColor {
      
      switch RemoConButtonColorValue {
      case "FlatRed":
         return UIColor.flatRed()
      case "FlatOrange":
         return UIColor.flatOrange()
      case "FlatYellor":
         return UIColor.flatYellow()
      case "FlatSand":
         return UIColor.flatSand()
      case "FlatNavyBlue":
         return UIColor.flatNavyBlue()
      case "FlatBlack":
         return UIColor.flatBlack()
      case "FlatMagenta":
         return UIColor.flatMagenta()
      case "FlatTeal":
         return UIColor.flatTeal()
      case "FlatSkyBlue":
         return UIColor.flatSkyBlue()
      case "FlatGreen":
         return UIColor.flatGreen()
      case "FlatMint":
         return UIColor.flatMint()
      case "FlatWhite":
         return UIColor.flatWhite()
      case "FlatGray":
         return UIColor.flatGray()
      case "FlatForestGreen":
         return UIColor.flatForestGreen()
      case "FlatPurple":
         return UIColor.flatPurple()
      case "FlatBrown":
         return UIColor.flatBrown()
      case "FlatPlum":
         return UIColor.flatPlum()
      case "FlatWatermelon":
         return UIColor.flatWatermelon()
      case "FlatLime":
         return UIColor.flatLime()
      case "FlatPink":
         return UIColor.flatPink()
      case "FlatMaroon":
         return UIColor.flatMaroon()
      case "FlatCoffee":
         return UIColor.flatCoffee()
      case "FlatPowerBlue":
         return UIColor.flatPowderBlue()
      case "FlatBlue":
         return UIColor.flatBlue()
      default:
         return UIColor.flatMint()
      }
   }
   
   
   public func GetButtonFlatShadowColor(RemoConButtonColorValue: String) -> UIColor {
      
      switch RemoConButtonColorValue {
      case "FlatRed":
         return UIColor.flatRedColorDark()
      case "FlatOrange":
         return UIColor.flatOrangeColorDark()
      case "FlatYellor":
         return UIColor.flatYellowColorDark()
      case "FlatSand":
         return UIColor.flatSandColorDark()
      case "FlatNavyBlue":
         return UIColor.flatNavyBlueColorDark()
      case "FlatBlack":
         return UIColor.flatBlackColorDark()
      case "FlatMagenta":
         return UIColor.flatMagentaColorDark()
      case "FlatTeal":
         return UIColor.flatTealColorDark()
      case "FlatSkyBlue":
         return UIColor.flatSkyBlueColorDark()
      case "FlatGreen":
         return UIColor.flatGreenColorDark()
      case "FlatMint":
         return UIColor.flatMintColorDark()
      case "FlatWhite":
         return UIColor.flatWhiteColorDark()
      case "FlatGray":
         return UIColor.flatGrayColorDark()
      case "FlatForestGreen":
         return UIColor.flatForestGreenColorDark()
      case "FlatPurple":
         return UIColor.flatPurpleColorDark()
      case "FlatBrown":
         return UIColor.flatBrownColorDark()
      case "FlatPlum":
         return UIColor.flatPlumColorDark()
      case "FlatWatermelon":
         return UIColor.flatWatermelonColorDark()
      case "FlatLime":
         return UIColor.flatLimeColorDark()
      case "FlatPink":
         return UIColor.flatPinkColorDark()
      case "FlatMaroon":
         return UIColor.flatMaroonColorDark()
      case "FlatCoffee":
         return UIColor.flatCoffeeColorDark()
      case "FlatPowerBlue":
         return UIColor.flatPowderBlueColorDark()
      case "FlatBlue":
         return UIColor.flatBlueColorDark()
      default:
         print("\n\n------------スペルどっか間違ってんぞ！--------\n\n")
         return UIColor.flatMintColorDark()
      }
   }
}
