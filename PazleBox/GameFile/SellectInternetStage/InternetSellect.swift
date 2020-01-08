//
//  InternetSellect.swift
//  PazleBox
//
//  Created by jun on 2019/12/14.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import ChameleonFramework
import FlatUIKit
import Firebase
import TapticEngine

@IBDesignable
class InterNetSellect: UIView {

   var CellNum: Int = 0

   //Numがついてる方には，実際の数値を代入する。
   @IBOutlet weak var DateLabel: UILabel!
   @IBOutlet weak var CreateUserLabel: UILabel!
   @IBOutlet weak var StageImageView: UIImageView!
   @IBOutlet weak var RatedLabel: UILabel!
   @IBOutlet weak var RatedNumLabel: UILabel!
   @IBOutlet weak var PlayCountLabel: UILabel!
   @IBOutlet weak var PlayCountNumLabel: UILabel!
   @IBOutlet weak var PlayButton: UIButton!
   @IBOutlet weak var CloseButton: UIButton!
   
   
   let StageImageViewShadow = CGSize(width: 0.3, height: 1.75)
   let StageImageViewShadowColor = UIColor.black.cgColor
   let StageImageViewShadowOpacity: Float = 0.6
   let StageImageViewCornerRadius: CGFloat = 7
   
   var isLockedPlayAndCloseButton = false
   
   var db: Firestore!
   
   init(frame: CGRect, Image: UIImage, CellNum: Int, PlayCount: Int, ReviewAve: CGFloat, addDate: String, addUserUID: String) {
      super.init(frame: frame)
      
      if #available(iOS 13.0, *) {
         self.overrideUserInterfaceStyle = .light
      }
      
      self.CellNum = CellNum
      
      SetUpFireStoreSetting()
      LoadNib()
      InitView()
      GetCreateUserName(addUserUID)
      InitRatedLabel()
      InitPlayCountLabel()
      InitRatedNumLabel(ReviewAve)
      InitPlayCountNumLabel(PlayCount)
      InitDateLabel(addDate)
      InitPlayButton()
      InitCloseButton()
      InitImageView(Image: Image)
   }
   
   override func awakeFromNib() {
      
   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
   }
   
   private func LoadNib() {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: "InterNetSellect", bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
      view.frame = self.bounds
      addSubview(view)
   }
   
   private func InitView() {
      self.layer.shadowOffset = CGSize(width: 10, height: 10)
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOpacity = 0.7
      self.layer.cornerRadius = 5
   }
   
   private func GetCreateUserName(_ addUserUID: String) {
      db.collection("users").document(addUserUID).getDocument { (document, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
         }
         
         if let document = document, document.exists {
            if let userName = document.data()?["name"] as? String {
               self.InitCreateUserLabel(userName: userName)
            }
         } else {
            print("Document does not exist")
            
         }
         print("ユーザネームの取得完了")
      }
   }
   
   private func InitCreateUserLabel(userName: String) {
      let Creator = NSLocalizedString("Creator", comment: "")
      self.CreateUserLabel.text = Creator + ": " + userName
   }
   
   private func InitRatedLabel() {
      let Star = "⭐️"
      let Rating = NSLocalizedString("Rating", comment: "")
      let Text = Star + " " + Rating + " " + Star
      self.RatedLabel.text = Text
      self.RatedLabel.adjustsFontSizeToFitWidth = true
   }
   
   private func InitPlayCountLabel() {
      let Pice = "🧩"
      let PlayCount = NSLocalizedString("PlayCount", comment: "")
      let Text = Pice + " " + PlayCount + " " + Pice
      self.PlayCountLabel.text = Text
      self.PlayCountLabel.adjustsFontSizeToFitWidth = true
   }
   
   private func InitRatedNumLabel(_ RatedNum: CGFloat) {
      let point2 = floor(Double(RatedNum) * 100) / 100
      self.RatedNumLabel.text = String(point2) + " / 5"
   }
   
   private func InitPlayCountNumLabel(_ PlayCount: Int) {
      self.PlayCountNumLabel.text = String(PlayCount)
   }
   
   //TODO:- yymmddが他の言語で正しく表示されるかを確認すること
   private func InitDateLabel(_ addDate: String) {
      let CreateDay = NSLocalizedString("CreatedDate", comment: "")
      self.DateLabel.text = CreateDay + addDate
   }
     
   private func InitPlayButton() {
      let title = NSLocalizedString("Play", comment: "")
      PlayButton.setTitle(title, for: .normal)
      PlayButton.titleLabel?.adjustsFontSizeToFitWidth = true
      PlayButton.titleLabel?.adjustsFontForContentSizeCategory = true
      PlayButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
   }
     
   
   private func InitCloseButton() {
      let title = NSLocalizedString("Close", comment: "")
      CloseButton.setTitle(title, for: .normal)
      CloseButton.titleLabel?.adjustsFontSizeToFitWidth = true
      CloseButton.titleLabel?.adjustsFontForContentSizeCategory = true
      CloseButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      CloseButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      CloseButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
   }
     
   private func InitImageView(Image: UIImage) {
      StageImageView.image = Image
      StageImageView.layer.shadowOffset = StageImageViewShadow
      StageImageView.layer.shadowColor = StageImageViewShadowColor
      StageImageView.layer.shadowOpacity = StageImageViewShadowOpacity
      StageImageView.layer.cornerRadius = StageImageViewCornerRadius
   }
   
  
   @IBAction func TapPlayButton(_ sender: Any) {
      print("Tap Internet PlayButton")
      
      guard isLockedPlayAndCloseButton == false else {
         Play3DtouchLight()
         print("プレイボタンはロックされています。")
         return
      }
      
      isLockedPlayAndCloseButton = true
      
      let SentObject: [String : Int] = ["CellNum": CellNum]
      NotificationCenter.default.post(name: .TapPlayButton, object: nil, userInfo: SentObject)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.27) {
         self.removeFromSuperview()
      }
   }
   
   @IBAction func TapCloseButton(_ sender: Any) {
      guard isLockedPlayAndCloseButton == false else {
         Play3DtouchLight()
         print("各ボタンはロックされています。")
         return
      }
      print("Tap CloseButton")
      self.removeFromSuperview()
      Play3DtouchLight()
      NotificationCenter.default.post(name: .TapCloseButton, object: nil)
   }
   // viewの枠線の色
   @IBInspectable var borderColor: UIColor = UIColor.clear {
       didSet {
         self.layer.borderColor = borderColor.cgColor
       }
   }

   // viewの枠線の太さ
   @IBInspectable var borderWidth: CGFloat = 0 {
       didSet {
           self.layer.borderWidth = borderWidth
       }
   }
   
   // viewの角丸
   @IBInspectable var cornerRadius: CGFloat = 0 {
       didSet {
           self.layer.cornerRadius = cornerRadius
           self.layer.masksToBounds = true
       }
   }
   
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      LoadNib()
   }
}
