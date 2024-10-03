import Foundation

enum Constants {
    
    enum Navigation: String {
        var localized: String { rawValue.localized }
        
        case rightButton = "navigation_bar_right_menu_button"
    }
    
    enum Alert: String {
        var localized: String { rawValue.localized }
        
        case alertInsertURL = "alert_insert_URL"
        case cancelAction = "cancel_action"
        case followAction = "follow_action"
        case urlText = "url_text"
        case alertInsertURLPlaceholder = "alert_insert_URL_placeholder"
        case alertError = "alert_error"
        case alertInvalidURL = "alert_invalid_URL"
        case alertErrorMessage = "alert_error_message"
        case alertOk = "alert_ok"
    }
    
    enum Home: String {
        var localized: String { rawValue.localized }
        
        case titleLabel = "title_label"
    }
    
    enum PodcastView: String {
        var localized: String { rawValue.localized }
        
        case lastestEpisodeButton = "lastest_episode_button"
        case noSummary = "no_summary_available"
        case hours = "hours"
        case minutes = "minutes"
        case descriptionUnavailable = "description_unavailable"
        
    }
    
    enum EpisodeView: String {
        var localized: String { rawValue.localized }
        case zeroTimer = "zero_timer"
    }
}
