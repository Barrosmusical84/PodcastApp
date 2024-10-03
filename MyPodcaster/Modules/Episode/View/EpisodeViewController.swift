import UIKit
import AVFoundation

final class EpisodeViewController: UIViewController {
   
    private let viewModel: EpisodeModelProtocol
    
    private var player: AVPlayer?
    
    private lazy var episodeView = EpisodeView()
    
    private var session: AVAudioSession

    init(viewModel: EpisodeModelProtocol, session: AVAudioSession = AVAudioSession.sharedInstance()) {
        self.viewModel = viewModel
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
        let episode = viewModel.fetchEpisode()
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
    func setupPlayerAudio(episode: EpisodeModel) {
        guard let url = URL(string: episode.link) else { return }
        player = AVPlayer(url: url)
    }

    func didTapPlayPauseButton() {
        if let player = player {
            if player.timeControlStatus == .playing {
                let image = UIImage(systemName: "play.fill")
                episodeView.playPauseButton.setImage(image, for: .normal)
                player.pause()
            } else {
                let image = UIImage(systemName: "pause")
                episodeView.playPauseButton.setImage(image, for: .normal)
                player.play()
            }
        }
    }

    func startAudio() {
        let episode = viewModel.fetchEpisode()
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
