import Foundation

final class CSListViewModel {
    @Published private(set) var items: [CSItem] = [CSItem](repeating: CSItem(
        name: "Stack",
        shortDescription: """
        스택(Stack)은 컴퓨터 과학에서 사용하는 기본적인 자료구조로, 데이터를 선형으로 저장합니다. 
        
        후입선출(Last In, First Out, LIFO) 원칙에 따라 가장 마지막에 추가된 요소가 가장 먼저 제거됩니다.
        
        스택의 주요 연산에는 데이터를 추가하는 '푸시(Push)'와 가장 상단의 데이터를 제거하는 '팝(Pop)'이 있습니다.
        """,
        description: """
        스택은 컴퓨터 프로그래밍에서 널리 사용되는 중요한 자료구조입니다. 후입선출(Last In, First Out, LIFO) 원칙을 따르는 스택은 마치 책 더미나 식기 세척기에 쌓인 접시처럼 생각할 수 있습니다. 새로운 요소는 항상 상단에 추가되며, 요소를 제거할 때도 상단에서부터 이루어집니다. 이러한 특성 때문에, 스택은 다음과 같은 두 가지 기본적인 연산을 지원합니다:

        푸시(Push): 스택의 상단에 새로운 요소를 추가합니다. 이 연산은 스택에 데이터를 삽입하는 과정입니다.
        팝(Pop): 스택의 상단에 있는 요소를 제거하고, 그 값을 반환합니다. 이 연산은 스택에서 가장 최근에 추가된 데이터를 제거합니다.
        스택은 다양한 프로그래밍 문제와 시스템 작업을 해결하는 데 유용합니다. 예를 들어, 웹 브라우저의 뒤로 가기 기능, 함수의 호출 스택, 수식의 괄호 검사, 후위 표현식의 계산 등에 스택이 활용됩니다. 이외에도 스택은 재귀 알고리즘을 이해하고 구현하는 데에도 필수적인 역할을 합니다.

        스택의 구현은 배열이나 연결 리스트를 사용할 수 있으며, 이러한 구현 방식에 따라 스택의 성능이 달라질 수 있습니다. 배열 기반의 스택 구현은 고정된 크기를 가질 수 있기 때문에, 스택의 크기를 초과하지 않도록 관리해야 합니다. 반면, 연결 리스트 기반의 구현은 동적으로 크기가 조절될 수 있어, 더 유연한 스택 구현이 가능합니다.
        """, category: "자료구조"), count: 10)
    
    func getItemsCount() -> Int {
        return items.count
    }
    
    func fetchItems() -> [CSItem] {
        return items
    }
    
    func fetchItem(at index: Int) -> CSItem {
        return items[index]
    }
}
