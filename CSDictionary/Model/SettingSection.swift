enum SettingOption {
    case contactDeveloper
    case addCSKeyword
    case displayMode
    case textSize
    case leaveReview
    case notificationSetting
    case clearImageCache
    case removeAds
    
    var title: String {
        switch self {
        case .contactDeveloper: return "개발자에게 문의하기"
        case .addCSKeyword: return "CS 키워드 / 문제 추가 요청하기"
        case .displayMode: return "화면 모드"
        case .textSize: return "글자 크기"
        case .leaveReview: return "리뷰 남기기"
        case .notificationSetting: return "알림 설정"
        case .clearImageCache: return "캐시 용량 비우기"
        case .removeAds: return "광고 제거"
        }
    }
    
    var icon: String {
        switch self {
        case .contactDeveloper: return "envelope"
        case .addCSKeyword: return "folder.badge.plus"
        case .displayMode: return "display"
        case .textSize: return "textformat.size"
        case .leaveReview: return "highlighter"
        case .notificationSetting: return "bell"
        case .clearImageCache: return "photo.on.rectangle"
        case .removeAds: return "xmark.bin"
        }
    }
}

enum SettingSection: String, CaseIterable {
    case contact = "문의하기"
    case general = "일반"
    case image = "이미지"
    case donation = "후원하기"
    
    var items: [SettingOption] {
        switch self {
        case .contact:
            return [.contactDeveloper, .addCSKeyword]
        case .general:
            return [.displayMode, .textSize, .leaveReview, .notificationSetting]
        case .image:
            return [.clearImageCache]
        case .donation:
            return [.removeAds]
        }
    }
    
    var icons: [String] {
        switch self {
        case .contact:
            return ["envelope", "folder.badge.plus"]
        case .general:
            return ["display", "textformat.size", "highlighter", "bell"]
        case .image:
            return ["photo.on.rectangle"]
        case .donation:
            return ["xmark.bin"]
        }
    }
}
