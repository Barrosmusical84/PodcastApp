import UIKit
import AVFoundation

final class EpisodeViewController: UIViewController {
    
    var items: RSSItem?
    private var player: AVPlayer?
    
    private lazy var episodeView = EpisodeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = episodeView
        configureEpisodeView()
        episodeView.delegate = self
    }
    
    private func configureEpisodeView() {
        guard let item = items else { return }
        episodeView.configureView(item)
    }
}

extension EpisodeViewController: EpisodeViewProtocolDelegate {
    func setupPlayerAudio(item: RSSItem) {
        guard let url = URL(string: item.link) else { return }
        player = AVPlayer(url: url)
    }
    
    func didTapPlayPauseButtonButton() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
                let image = UIImage(systemName: "play.fill")
                episodeView.playPauseButton.setImage(image, for: .normal)
                episodeView.playPauseButton.setTitle("   Play", for: .normal)
            } else {
                player.play()
                let image = UIImage(systemName: "pause")
                episodeView.playPauseButton.setImage(image, for: .normal)
                episodeView.playPauseButton.setTitle("   Pause", for: .normal)
            }
        }
    }
}
