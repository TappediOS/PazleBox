//
//  Sound.swift
//  PazleBox
//
//  Created by jun on 2019/03/28.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import AVFoundation


class BGM {
   
   //効果音素材：ポケットサウンド – https://pocket-se.info/
   var audioPlayer1: AVAudioPlayer! = nil
   
   var Breakfast: AVAudioPlayer! = nil
   var Hight_Tech: AVAudioPlayer! = nil
   var Morning: AVAudioPlayer! = nil
   var Tokino: AVAudioPlayer! = nil
   var Yukimasu: AVAudioPlayer! = nil
   var Yurufuwa: AVAudioPlayer! = nil
   
   let SoundVolume: Float = 0.2
   
   
   init() {
      
      InitBreak()
      InitHight_Tech()
      InitMorning()
      InitTokino()
      InitYukimasu()
      InitYurufuwa()
      
      let soundFilePath = Bundle.main.path(forResource: "cherry", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         audioPlayer1 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Katchインスタンス作成失敗") }
      
      audioPlayer1.prepareToPlay()
      audioPlayer1.numberOfLoops = -1
  
   }
   
   public func PlaySounds() {
      Yurufuwa.stop()
      Yurufuwa.currentTime = 0
      Yurufuwa.volume = SoundVolume
      Yurufuwa.play()
   }
   
   public func StopSound() {
      self.audioPlayer1.stop()
   }
   
   public func PlayHomeBGM() {
      Hight_Tech.stop()
      Hight_Tech.currentTime = 0
      Hight_Tech.volume = SoundVolume
      Hight_Tech.play()
   }
   
   public func StopHomeBGM() {
      Hight_Tech.stop()
      Hight_Tech.currentTime = 0
   }
   
   public func StopHomeBGMSlow() {
      Hight_Tech.volume = SoundVolume / 1.5
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
         self.Hight_Tech.volume = self.Hight_Tech.volume / 2
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            self.Hight_Tech.volume = 0
            self.Hight_Tech.stop()
            self.Hight_Tech.currentTime = 0
         }
      }
   }
   
}

extension BGM {
   
   private func InitBreak(){
      let soundFilePath = Bundle.main.path(forResource: "Breakfast", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         Breakfast = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Breakfastインスタンス作成失敗") }
      
      Breakfast.prepareToPlay()
      Breakfast.numberOfLoops = -1
      Breakfast.volume = SoundVolume
   }
   
   private func InitHight_Tech(){
      let soundFilePath = Bundle.main.path(forResource: "Hight_Tech", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         Hight_Tech = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Hight_Techインスタンス作成失敗") }
      
      Hight_Tech.prepareToPlay()
      Hight_Tech.numberOfLoops = -1
      Hight_Tech.volume = SoundVolume
      
   }
   private func InitMorning(){
      let soundFilePath = Bundle.main.path(forResource: "Morning", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         Morning = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Morningインスタンス作成失敗") }
      
      Morning.prepareToPlay()
      Morning.numberOfLoops = -1
      Morning.volume = SoundVolume
   }
   
   private func InitTokino(){
      let soundFilePath = Bundle.main.path(forResource: "Tokino", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         Tokino = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Tokinoインスタンス作成失敗") }
      
      Tokino.prepareToPlay()
      Tokino.numberOfLoops = -1
      Tokino.volume = SoundVolume
   }
   
   private func InitYukimasu(){
      let soundFilePath = Bundle.main.path(forResource: "Yukimasu", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         Yukimasu = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Yukimasuインスタンス作成失敗") }
      
      Yukimasu.prepareToPlay()
      Yukimasu.numberOfLoops = -1
      Yukimasu.volume = SoundVolume
   }
   
   private func InitYurufuwa(){
      let soundFilePath = Bundle.main.path(forResource: "Yurufuwa", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         Yurufuwa = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Breakfastインスタンス作成失敗") }
      
      Yurufuwa.prepareToPlay()
      Yurufuwa.numberOfLoops = -1
      Yurufuwa.volume = SoundVolume
   }
   
}
