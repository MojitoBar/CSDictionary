import Foundation

final class SettingViewModel {
    let sections: [String] = ["문의하기", "일반", "후원하기"]
    let icons: [[String]] = [
        ["envelope", "folder.badge.plus"],
        ["display", "textformat.size", "arrow.clockwise", "highlighter", "bell"],
        ["xmark.bin", "cup.and.saucer", "star"]
    ]
    let items: [[String]] = [
        ["개발자에게 문의하기", "CS 키워드 / 문제 추가 요청하기"],
        ["화면 모드", "글자 크기", "업데이트 확인", "리뷰 남기기", "알림 설정"],
        ["광고 제거", "커피 후원", "구독하기"]
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
