import UIKit
import AVFoundation

final class EpisodeViewController: UIViewController {
   
    private let episode: EpisodeModel
    
    init(episode: EpisodeModel) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var player: AVPlayer?
    
    private lazy var episodeView = EpisodeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = episodeView
        configureEpisodeView()
        episodeView.delegate = self
    }
    
    private func configureEpisodeView() {
        episodeView.configureView(episode)
    }
}

extension EpisodeViewController: EpisodeViewProtocolDelegate {
    func setupPlayerAudio(item: EpisodeModel) {
        guard let url = URL(string: item.link) else { return }
        player = AVPlayer(url: url)
    }
    
    func didTapPlayPauseButton() {
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
