//
//  Sound.swift
//  PazleBox
//
//  Created by jun on 2019/03/28.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import AVFoundation


class GameSounds {
   
   var audioPlayer1: AVAudioPlayer! = nil
   var audioPlayer2: AVAudioPlayer! = nil
   var audioPlayer3: AVAudioPlayer! = nil
   var audioPlayer4: AVAudioPlayer! = nil
   var audioPlayer5: AVAudioPlayer! = nil
   var audioPlayer6: AVAudioPlayer! = nil
   var audioPlayer7: AVAudioPlayer! = nil
   var audioPlayer8: AVAudioPlayer! = nil
   var audioPlayer9: AVAudioPlayer! = nil
   var audioPlayer10: AVAudioPlayer! = nil
   
   let SoundVolume: Float = 0.5
   
   
   init() {
      
      // サウンドファイルのパスを生成
      var soundFilePath = Bundle.main.path(forResource: "Katch", ofType: "caf")!
      var sound:URL = URL(fileURLWithPath: soundFilePath)
      // AVAudioPlayerのインスタンスを作成
      do {
         audioPlayer1 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
         
      } catch {
         print("Katchインスタンス作成失敗")
      }
      
      soundFilePath = Bundle.main.path(forResource: "RePut", ofType: "caf")!
      sound = URL(fileURLWithPath: soundFilePath)
      // AVAudioPlayerのインスタンスを作成
      do {
         audioPlayer2 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch {
         print("RePutインスタンス作成失敗")
      }
      
      soundFilePath = Bundle.main.path(forResource: "Pico", ofType: "caf")!
      sound = URL(fileURLWithPath: soundFilePath)
      // AVAudioPlayerのインスタンスを作成
      do {
         audioPlayer3 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch {
         print("Picoインスタンス作成失敗")
      }

      soundFilePath = Bundle.main.path(forResource: "ka", ofType: "caf")!
      sound = URL(fileURLWithPath: soundFilePath)
      // AVAudioPlayerのインスタンスを作成
      do {
         audioPlayer4 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch {
         print("Fa_Mokkinインスタンス作成失敗")
      }
//
//      soundFilePath = Bundle.main.path(forResource: "So_Mokkin", ofType: "mp3")!
//      sound = URL(fileURLWithPath: soundFilePath)
//      // AVAudioPlayerのインスタンスを作成
//      do {
//         audioPlayer5 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
//      } catch {
//         print("So_Mokkinインスタンス作成失敗")
//      }
//
//      soundFilePath = Bundle.main.path(forResource: "Ra_Mokkin", ofType: "mp3")!
//      sound = URL(fileURLWithPath: soundFilePath)
//      // AVAudioPlayerのインスタンスを作成
//      do {
//         audioPlayer6 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
//      } catch {
//         print("Ra_Mokkinインスタンス作成失敗")
//      }
//
//      soundFilePath = Bundle.main.path(forResource: "Si_Mokkin", ofType: "mp3")!
//      sound = URL(fileURLWithPath: soundFilePath)
//      // AVAudioPlayerのインスタンスを作成
//      do {
//         audioPlayer7 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
//      } catch {
//         print("Si_Mokkinインスタンス作成失敗")
//      }
//
//      soundFilePath = Bundle.main.path(forResource: "Do2_Mokkin", ofType: "mp3")!
//      sound = URL(fileURLWithPath: soundFilePath)
//      // AVAudioPlayerのインスタンスを作成
//      do {
//         audioPlayer8 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
//      } catch {
//         print("Do2_Mokkinインスタンス作成失敗")
//      }
//
//      soundFilePath = Bundle.main.path(forResource: "Re2_Mokkin", ofType: "mp3")!
//      sound = URL(fileURLWithPath: soundFilePath)
//      // AVAudioPlayerのインスタンスを作成
//      do {
//         audioPlayer9 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
//      } catch {
//         print("Re2_Mokkinインスタンス作成失敗")
//      }
//
//      soundFilePath = Bundle.main.path(forResource: "Mi2_Mokkin", ofType: "mp3")!
//      sound = URL(fileURLWithPath: soundFilePath)
//      // AVAudioPlayerのインスタンスを作成
//      do {
//         audioPlayer10 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
//      } catch {
//         print("Mi2_Mokkinインスタンス作成失敗")
//      }
//      // バッファに保持していつでも再生できるようにする
      audioPlayer1.prepareToPlay()
      audioPlayer2.prepareToPlay()
      audioPlayer3.prepareToPlay()
      audioPlayer4.prepareToPlay()
//      audioPlayer5.prepareToPlay()
//      audioPlayer6.prepareToPlay()
//      audioPlayer7.prepareToPlay()
//      audioPlayer8.prepareToPlay()
//      audioPlayer9.prepareToPlay()
//      audioPlayer10.prepareToPlay()
//
//      audioPlayer1.enableRate = true
//      audioPlayer1.rate = 2
//      audioPlayer2.enableRate = true
//      audioPlayer2.rate = 2
//      audioPlayer3.enableRate = true
//      audioPlayer3.rate = 2
//      audioPlayer4.enableRate = true
//      audioPlayer4.rate = 2
//      audioPlayer5.enableRate = true
//      audioPlayer5.rate = 2
//      audioPlayer6.enableRate = true
//      audioPlayer6.rate = 2
//      audioPlayer7.enableRate = true
//      audioPlayer7.rate = 2
//      audioPlayer8.enableRate = true
//      audioPlayer8.rate = 2
//      audioPlayer9.enableRate = true
//      audioPlayer9.rate = 2
//      audioPlayer10.enableRate = true
//      audioPlayer10.rate = 2
      
   }
   
//   public func PlaySoundsKA() {
//      
//      let queue = OperationQueue()
//      let operation = BlockOperation {
//         self.audioPlayer4.volume = 0
//         self.audioPlayer4.stop()
//         self.audioPlayer4.currentTime = 0
//         self.audioPlayer4.volume = self.SoundVolume
//         self.audioPlayer4.play()
//         
//      }
//      queue.addOperation(operation)
//      
//   }
   
   public func PlaySounds(Type: Int) {
      
      
      switch Type {
      case 1:
         self.audioPlayer1.volume = 0
         self.audioPlayer1.stop()
         self.audioPlayer1.currentTime = 0
         self.audioPlayer1.volume = SoundVolume
         self.audioPlayer1.play()
      case 2:
         self.audioPlayer2.volume = 0
         self.audioPlayer2.stop()
         self.audioPlayer2.currentTime = 0
         self.audioPlayer2.volume = SoundVolume
         self.audioPlayer2.play()
      case 3:
         self.audioPlayer3.volume = 0
         self.audioPlayer3.stop()
         self.audioPlayer3.currentTime = 0
         self.audioPlayer3.volume = SoundVolume
         self.audioPlayer3.play()
//      case 4:
//         self.audioPlayer4.volume = 0
//         self.audioPlayer4.stop()
//         self.audioPlayer4.currentTime = 0
//         self.audioPlayer4.volume = SoundVolume
//         self.audioPlayer4.play()
//      case 5:
//         self.audioPlayer5.volume = 0
//         self.audioPlayer5.stop()
//         self.audioPlayer5.currentTime = 0
//         self.audioPlayer5.volume = 0.5
//         self.audioPlayer5.play()
//      case 6:
//         self.audioPlayer6.volume = 0
//         self.audioPlayer6.stop()
//         self.audioPlayer6.currentTime = 0
//         self.audioPlayer6.volume = 0.5
//         self.audioPlayer6.play()
//      case 7:
//         self.audioPlayer7.volume = 0
//         self.audioPlayer7.stop()
//         self.audioPlayer7.currentTime = 0
//         self.audioPlayer7.volume = 0.5
//         self.audioPlayer7.play()
//      case 8:
//         self.audioPlayer8.volume = 0
//         self.audioPlayer8.stop()
//         self.audioPlayer8.currentTime = 0
//         self.audioPlayer8.volume = 0.5
//         self.audioPlayer8.play()
//      case 9:
//         self.audioPlayer9.volume = 0
//         self.audioPlayer9.stop()
//         self.audioPlayer9.currentTime = 0
//         self.audioPlayer9.volume = 0.5
//         self.audioPlayer9.play()
//      case 10:
//         self.audioPlayer10.volume = 0
//         self.audioPlayer10.stop()
//         self.audioPlayer10.currentTime = 0
//         self.audioPlayer10.volume = 0.5
//         self.audioPlayer10.play()
      default:
         print("What")
      }
      
   }
   
}
