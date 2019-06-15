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
   var Cherry: AVAudioPlayer! = nil
   
   var Breakfast: AVAudioPlayer! = nil
   var Hight_Tech: AVAudioPlayer! = nil
   var Morning: AVAudioPlayer! = nil
   var Tokino: AVAudioPlayer! = nil
   var Yukimasu: AVAudioPlayer! = nil
   var Yurufuwa: AVAudioPlayer! = nil
   
   let SoundVolume: Float = 0.2
   
   var isPlayHomeBGM = false
   
   init() {
      
      InitCherry()
      InitBreak()
      InitHight_Tech()
      InitMorning()
      InitTokino()
      InitYukimasu()
      InitYurufuwa()
      
      let soundFilePath = Bundle.main.path(forResource: "cherry", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         Cherry = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Katchインスタンス作成失敗") }
      
      Cherry.prepareToPlay()
      Cherry.numberOfLoops = -1
  
   }
   
   public func PlaySounds() {
      Yurufuwa.stop()
      Yurufuwa.currentTime = 0
      Yurufuwa.volume = SoundVolume
      Yurufuwa.play()
   }
   
   public func StopSound() {
      self.Cherry.stop()
   }
   
   public func PlayGameBGM() {
      Yurufuwa.stop()
      Yurufuwa.currentTime = 0
      Yurufuwa.volume = SoundVolume
      Yurufuwa.play()
      fade(player: Yurufuwa, fromVolume: 0, toVolume: SoundVolume, overTime: 5)
   }
   
   public func StopGameBGM() {
      Yurufuwa.stop()
      Yurufuwa.currentTime = 0
   }
   
   public func StopGameBGMSlow() {
      Yurufuwa.volume = SoundVolume / 1.5
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
         self.Yurufuwa.volume = self.Yurufuwa.volume / 2
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            self.Yurufuwa.volume = 0
            self.Yurufuwa.stop()
            self.Yurufuwa.currentTime = 0
         }
      }
   }
   
   public func PlayHomeBGM() {
      Hight_Tech.stop()
      Hight_Tech.currentTime = 0
      Hight_Tech.volume = SoundVolume
      Hight_Tech.play()
      isPlayHomeBGM = true
   }
   
   public func StopHomeBGM() {
      Hight_Tech.stop()
      Hight_Tech.currentTime = 0
      isPlayHomeBGM = false
   }
   
   public func StopHomeBGMSlow() {
      Hight_Tech.volume = SoundVolume / 1.5
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
         print("半分！")
         self.Hight_Tech.volume = self.Hight_Tech.volume / 2
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("半分！")
            self.Hight_Tech.volume = 0
            self.Hight_Tech.stop()
            self.Hight_Tech.currentTime = 0
            self.isPlayHomeBGM = false
         }
      }
   }
   
   public func fade(player: AVAudioPlayer,
             fromVolume startVolume : Float,
             toVolume endVolume : Float,
             overTime time : TimeInterval) {
      
      let stepsPerSecond = 100
      // Update the volume every 1/100 of a second
      let fadeSteps = Int(time * TimeInterval(stepsPerSecond))
      // Work out how much time each step will take
      let timePerStep = TimeInterval(1.0 / Double(stepsPerSecond))
      
      player.volume = startVolume;
      
      // Schedule a number of volume changes
      for step in 0...fadeSteps {
         
         let delayInSeconds : TimeInterval = TimeInterval(step) * timePerStep
         let deadline = DispatchTime.now() + delayInSeconds
         
         DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
            let fraction = (Float(step) / Float(fadeSteps))
            player.volume = startVolume + (endVolume - startVolume) * fraction
         })
         
      }
   }
   
   public func ChangeHomeBGMVolume(ChangeVolumeFacter: Float) {
      Hight_Tech.volume = Hight_Tech.volume * ChangeVolumeFacter
   }
   
   public func ResetHomeBGMVolume() {
      Hight_Tech.volume = SoundVolume
   }
   
   public func isPlayingHomeBGM() -> Bool {
      return self.isPlayHomeBGM
   }
   
}










extension BGM {
   
   private func InitCherry(){
      let soundFilePath = Bundle.main.path(forResource: "cherry", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         Cherry = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Breakfastインスタンス作成失敗") }
      
      Cherry.prepareToPlay()
      Cherry.numberOfLoops = -1
      Cherry.volume = SoundVolume
   }
   
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
