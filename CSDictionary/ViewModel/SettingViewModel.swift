import Foundation

final class SettingViewModel {
    let sections: [String] = ["문의하기", "일반", "이미지", "후원하기"]
    let icons: [[String]] = [
        ["envelope", "folder.badge.plus"],
        ["display", "textformat.size", "highlighter", "bell"],
        ["photo.on.rectangle"],
        ["xmark.bin"]
    ]
    let items: [[String]] = [
        ["개발자에게 문의하기", "CS 키워드 / 문제 추가 요청하기"],
        ["화면 모드", "글자 크기", "리뷰 남기기", "알림 설정"],
        ["이미지 캐쉬 용량 비우기"],
        ["광고 제거"]
    ]
    
    var itemsCount: Int {
        items.count
    }
    
    func icon(at indexPath: IndexPath) -> String {
        icons[indexPath.section][indexPath.row]
    }
    
    func item(at indexPath: IndexPath) -> String {
        items[indexPath.section][indexPath.row]
    }
    
    func itemsCount(in section: Int) -> Int {
        items[section].count
    }
    
    func section(at index: Int) -> String {
        sections[index]
    }
    
    func sectionCount() -> Int {
        sections.count
    }
}
