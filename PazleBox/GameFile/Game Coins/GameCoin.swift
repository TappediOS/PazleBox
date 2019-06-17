//
//  GameCoin.swift
//  PazleBox
//
//  Created by jun on 2019/06/17.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

class GameCoins {
   
   var UsersCoins: Int?
   let userDefault = UserDefaults.standard
   let userDefaultCoinKey = "UsersCoins"
   
   init() {
      userDefault.register(defaults: [userDefaultCoinKey: 0])
      UsersCoins = userDefault.integer(forKey: userDefaultCoinKey)
      print("Class初期化時のユーザの所持コイン数 -> \(String(describing: UsersCoins))")
   }
   
   public func SpendCoin(SpendCoinValue: Int) {
      print("現在の所持コインは\(String(describing: UsersCoins))です")
      print("ユーザが買いたいアイテムの値段は\(String(describing: SpendCoinValue))です")
      
      UsersCoins! -= UsersCoins! - SpendCoinValue
      print("支払い後の金額は\(String(describing: UsersCoins))です")
      userDefault.set(UsersCoins!, forKey: userDefaultCoinKey)
      
   }
   
   public func EarnCoin(EarnCoinValue: Int){
      print("現在の所持コインは\(String(describing: UsersCoins))です")
      print("ユーザがもうけたコインの金額は\(String(describing: EarnCoinValue))です")
      
      UsersCoins! += UsersCoins! - EarnCoinValue
      print("計算後の金額は\(String(describing: UsersCoins))です")
      userDefault.set(UsersCoins!, forKey: userDefaultCoinKey)
   }
   
   public func EarnCoinWithRewardAD(EarnCoinValue: Int) {
      print("現在の所持コインは\(String(describing: UsersCoins))です")
      print("ユーザがもうけたコインの金額は\(String(describing: EarnCoinValue))です")
      
      UsersCoins! += UsersCoins! - EarnCoinValue
      print("計算後の金額は\(String(describing: UsersCoins))です")
      userDefault.set(UsersCoins!, forKey: userDefaultCoinKey)
   }
   
   public func EarnCoinWithIAP(EarnCoinValue: Int) {
      print("現在の所持コインは\(String(describing: UsersCoins))です")
      print("ユーザがもうけたコインの金額は\(String(describing: EarnCoinValue))です")
      
      UsersCoins! += UsersCoins! - EarnCoinValue
      print("計算後の金額は\(String(describing: UsersCoins))です")
      userDefault.set(UsersCoins!, forKey: userDefaultCoinKey)
   }
   
   public func CanYoubuyItemUsingSpentMomey(ValueUserWantTobuy: Int) -> Bool {
      print("現在の所持コインは\(String(describing: UsersCoins))です")
      print("ユーザが解体アイテムの値段は\(String(describing: ValueUserWantTobuy))です")
      if let Coin = UsersCoins {
         if Coin >= ValueUserWantTobuy {
            print("買えます")
            return true
         }else{
            print("変えません")
            return false
         }
      }else{
         fatalError("Coinにnil入ってまっせ")
      }
   }
   
   public func HowMatchDoYouHameCoins() -> Int {
      print("現在の所持コインは\(String(describing: UsersCoins))です")
      if let Coin = UsersCoins {
         return Coin
      }else{
         fatalError("Coinにnil入ってまっせ")
      }
   }
   
}
