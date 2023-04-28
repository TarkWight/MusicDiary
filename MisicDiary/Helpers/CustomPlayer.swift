import UIKit
import AVFoundation

final class AppPlayer {
    
    private static let instance = AppPlayer()
    
    lazy private var player : AVPlayer = {
        let avPlayer = AVPlayer()
         avPlayer.automaticallyWaitsToMinimizeStalling = false
         
         do {
             try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
             print("Playback OK")
             try AVAudioSession.sharedInstance().setActive(true)
             print("Session is Active")
         } catch {
             print(error)
         }
         return avPlayer
    }()
    
    private init() { }
    
    public var timeControlStatus: AVPlayer.TimeControlStatus {
        get {
            player.timeControlStatus
        }
    }
    
    public var volume: Float {
        set {
            player.volume = newValue
        }
        get {
            player.volume
        }
    }
    
    public var currentItem: AVPlayerItem? {
        get {
            player.currentItem
        }
    }
    
    public var currentTime: CMTime {
        get {
            player.currentTime()
        }
    }
    
    
    
    public func pause() {
        player.pause()
    }
    
    public static func getInstance() -> AppPlayer{
        return instance
    }
    
    public func replaceCurrentItem(with item: AVPlayerItem) {
        player.replaceCurrentItem(with: item)
        
    }
    
    public func play() {
        player.play()
    }
    
    public func addBoundaryTimeObserver(forTimes: [NSValue], queue: DispatchQueue, using: @escaping () -> Void) {
        player.addBoundaryTimeObserver(forTimes: forTimes, queue: queue, using: using)
    }
    
    
    public func addPeriodicTimeObserver(forInterval: CMTime, queue: DispatchQueue, using: @escaping (CMTime) -> Void) {
        player.addPeriodicTimeObserver(forInterval: forInterval, queue: queue, using: using)
    }
    
    
    public func seek(seekTime: CMTime) {
        player.seek(to: seekTime)
    }
    
    
}
