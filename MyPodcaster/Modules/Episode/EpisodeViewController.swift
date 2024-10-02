import UIKit
import AVFoundation

final class EpisodeViewController: UIViewController {
    
    private var episode: EpisodeModel
    private var player: AVPlayer?
    
    private lazy var episodeView = EpisodeView()
    
    private var session: AVAudioSession

    init(episode: EpisodeModel, session: AVAudioSession = AVAudioSession.sharedInstance()) {
        self.episode = episode
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = episodeView
        configureEpisodeView()
        episodeView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAudio()
    }

    private func configureEpisodeView() {
        episodeView.configureView(episode)
    }

    private func activateSession() {
        do {
            try session.setCategory(
                .playback,
                mode: .default,
                options: []
            )
        } catch _ {}

        do {
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch _ {}

        do {
            try session.overrideOutputAudioPort(.speaker)
        } catch _ {}
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
                let image = UIImage(systemName: "play.fill")
                episodeView.playPauseButton.setImage(image, for: .normal)
                episodeView.playPauseButton.setTitle("   Play", for: .normal)
                player.pause()
            } else {
                let image = UIImage(systemName: "pause")
                episodeView.playPauseButton.setImage(image, for: .normal)
                episodeView.playPauseButton.setTitle("   Pause", for: .normal)
                player.play()
            }
        }
    }

    func startAudio() {
        guard let url = URL(string: episode.link) else { return }
        //activateSession()
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        if let player = player {
            player.replaceCurrentItem(with: playerItem)
        } else {
            player = AVPlayer(playerItem: playerItem)
        }

        player?.allowsExternalPlayback = true
        player?.appliesMediaSelectionCriteriaAutomatically = true
        player?.automaticallyWaitsToMinimizeStalling = true
        player?.volume = 1.0

        if let player = player {
            player.play()
        }
    }
}
