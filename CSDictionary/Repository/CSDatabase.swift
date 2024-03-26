enum DB {
    static let CSSections: [String] = ["자료구조", "알고리즘", "네트워크"]
    static let SearchSection: [String] = ["검색 결과"]
    static let csList = [
        CSItem(
            name: "Stack",
            shortDescription: """
            Stack은 후입선출(LIFO: Last In, First Out) 원칙을 따르는 선형 자료구조입니다.
            """,
            description: """
            Stack은 데이터를 저장하고 액세스하는 데 있어서 마지막에 들어간 데이터가 가장 먼저 나오는 방식을 따릅니다. 
            
            이는 실생활의 쌓여있는 접시나 책 더미와 유사한 구조로 생각할 수 있습니다.
            
            Stack의 주요 연산에는 push (데이터 추가), pop (최근 추가된 데이터 삭제 및 반환), peek/top (스택의 최상단 데이터 확인), 그리고 isEmpty (스택이 비어있는지 확인) 등이 있습니다.
            
            이러한 특성 때문에 스택은 다양한 프로그래밍 문제 해결, 특히 재귀 함수, 깊이 우선 탐색(DFS) 등에 유용하게 사용됩니다.
            """,
            category: "자료구조",
            urls: ["https://www.youtube.com/watch?v=cyf4HycvxXg",
                  "https://www.youtube.com/watch?v=3Z2TTzTe7bE&pp=ygUGCHF1ZXVl",
                  "https://www.youtube.com/watch?v=BdsyG5yP1cQ&pp=ygUGCHF1ZXVl",
                  "https://www.youtube.com/watch?v=DpcJP-wQWGI",
                  "https://www.youtube.com/watch?v=Uz-pSps2T-A",
                  "https://www.youtube.com/watch?v=c1DcQABWypk"]
        ),
        CSItem(
            name: "LinkedList",
            shortDescription: """
            연결 리스트(LinkedList)는 데이터 항목들이 노드 형태로 이루어지고, 각 노드가 다음 노드를 가리키는 형태의 선형 자료구조입니다.
            
            각 노드는 데이터와 다음 노드에 대한 참조(또는 포인터)를 포함합니다.
            
            연결 리스트는 데이터를 동적으로 추가하거나 제거하기 용이하여, 크기가 변하는 상황에서 유용합니다.
            """,
            description: """
            연결 리스트는 배열과 비교했을 때, 미리 크기를 지정할 필요가 없고, 요소의 삽입과 삭제가 용이하다는 장점이 있습니다. 연결 리스트는 단일 연결 리스트(Singly Linked List), 이중 연결 리스트(Doubly Linked List), 원형 연결 리스트(Circular Linked List) 등 여러 형태가 있습니다.
            
            연결 리스트는 스택이나 큐와 같은 다른 자료구조의 기반이 되기도 하며, 해시 테이블의 충돌 해결 방법 중 하나인 체이닝(Chaining)에서도 사용됩니다.
            """,
            category: "자료구조"
        ),
        CSItem(
            name: "Binary Tree",
            shortDescription: """
            이진 트리(Binary Tree)는 각 노드가 최대 두 개의 자식 노드를 가질 수 있는 계층적 자료구조입니다.
            
            이진 트리는 데이터의 효율적인 검색과 정렬, 삽입, 삭제를 위해 사용됩니다.
            
            이진 검색 트리(Binary Search Tree, BST)는 이진 트리의 한 형태로, 각 노드의 왼쪽 자식은 부모보다 작고, 오른쪽 자식은 부모보다 큰 값을 가집니다.
            """,
            description: """
            이진 트리는 효율적인 검색과 정렬을 위해 널리 사용됩니다. 특히, 이진 검색 트리는 중위 순회(Inorder Traversal)를 통해 정렬된 순서로 데이터를 검색할 수 있습니다.
            
            이진 트리는 또한 힙(Heap), AVL 트리, 레드-블랙 트리와 같은 균형을 맞춘 트리 구조의 기반이 되며, 이들은 데이터의 삽입, 삭제, 검색에 있어서 일정한 시간 복잡도를 보장합니다.
            """,
            category: "자료구조"
        ),
        CSItem(
            name: "QuickSort",
            shortDescription: """
            퀵소트(QuickSort)는 분할 정복 알고리즘의 한 예로, 평균적으로 매우 빠른 실행 시간을 제공합니다.
            
            기준점(Pivot)을 선택하여, 기준점보다 작은 요소는 왼쪽으로, 큰 요소는 오른쪽으로 분류합니다. 이 과정을 반복하여 전체 배열을 정렬합니다.
            
            퀵소트는 평균적인 경우 O(n log n)의 시간 복잡도를 가지지만, 최악의 경우 O(n^2)이 될 수 있습니다.
            """,
            description: """
            퀵소트는 배열을 빠르게 정렬할 수 있는 효율적인 알고리즘입니다. 기준점의 선택에 따라 성능이 크게 달라질 수 있으며, 이를 개선하기 위한 여러 전략이 있습니다. 예를 들어, 랜덤하게 기준점을 선택하거나, 세 개의 요소 중 중간 값을 기준점으로 선택하는 방법 등입니다.
            
            퀵소트는 정렬이 필요한 거의 모든 상황에서 널리 사용되며, 특히 대규모 데이터셋을 다룰 때 그 효율성이 더욱 빛을 발합니다.
            """,
            category: "알고리즘"
        ),
        CSItem(
            name: "Dijkstra's Algorithm",
            shortDescription: """
            다익스트라 알고리즘(Dijkstra's Algorithm)은 그래프에서 한 노드에서 다른 모든 노드로의 최단 경로를 찾는 알고리즘입니다.
            
            음의 가중치가 없는 그래프에서 사용할 수 있으며, 우선순위 큐를 사용하여 효율적으로 구현됩니다.
            
            이 알고리즘은 네트워크 라우팅 프로토콜 등 다양한 분야에서 활용됩니다.
            """,
            description: """
            다익스트라 알고리즘은 그래프의 모든 노드를 순회하며, 현재 노드에서 갈 수 있는 인접 노드 중 가장 비용이 적게 드는 노드로 이동하는 방식으로 작동합니다. 이 과정을 반복하여, 시작 노드로부터 각 노드까지의 최단 경로를 찾습니다.
            
            이 알고리즘은 네트워크 라우팅, 지도의 경로 탐색, 사회 네트워크 분석 등 다양한 분야에서 중요하게 사용됩니다.
            """,
            category: "알고리즘"
        ),
        CSItem(
            name: "MergeSort",
            shortDescription: """
            병합 정렬(MergeSort)은 분할 정복 방식을 사용하는 안정적인 정렬 알고리즘입니다.
            
            배열을 반으로 나누고, 각 부분을 재귀적으로 정렬한 후, 두 부분을 합쳐 전체를 정렬합니다.
            
            병합 정렬은 모든 경우에 O(n log n)의 시간 복잡도를 가집니다.
            """,
            description: """
            병합 정렬은 큰 데이터 집합을 효율적으로 정렬할 수 있는 강력한 알고리즘입니다. 이 알고리즘은 두 부분으로 나눈 뒤 각각을 정렬하고, 정렬된 두 리스트를 하나의 정렬된 리스트로 합치는 과정을 반복합니다.
            
            병합 정렬은 안정적인 정렬 방법이며, 대규모 데이터셋을 다룰 때 높은 성능을 발휘합니다. 또한, 분산 처리와 같은 병렬 컴퓨팅 환경에서도 효과적으로 구현할 수 있습니다.
            """,
            category: "알고리즘"
        ),
        CSItem(
            name: "TCP/IP",
            shortDescription: """
            TCP/IP(Transmission Control Protocol/Internet Protocol)는 인터넷에서 데이터를 전송하기 위한 기본 통신 프로토콜입니다.
            
            이 프로토콜은 신뢰성 있는 데이터 전송을 보장하며, 데이터가 목적지에 정확히 도착하도록 합니다.
            
            TCP/IP 모델은 네트워크 계층, 인터넷 계층, 전송 계층, 응용 계층으로 구성됩니다.
            """,
            description: """
            TCP/IP 프로토콜은 인터넷의 핵심 프로토콜로, 다양한 네트워크 환경에서 효율적인 데이터 전송을 가능하게 합니다. TCP는 연결 지향적 프로토콜로, 데이터의 순서 보장과 에러 없는 전송을 책임집니다. IP는 데이터 패킷을 올바른 목적지로 라우팅하는 역할을 합니다.
            
            이 프로토콜은 웹 브라우징, 이메일 전송, 파일 전송과 같은 다양한 인터넷 서비스의 기반이 됩니다.
            """,
            category: "네트워크"
        ),
        CSItem(
            name: "HTTP",
            shortDescription: """
            HTTP(Hypertext Transfer Protocol)는 웹 페이지와 그 콘텐츠를 전송하기 위한 프로토콜입니다.
            
            클라이언트와 서버 간의 요청 및 응답으로 작동하며, 웹의 기본적인 데이터 교환 방식을 정의합니다.
            
            HTTPS는 HTTP에 보안을 추가한 버전으로, 데이터 전송 과정에서 암호화를 제공합니다.
            """,
            description: """
            HTTP는 웹에서 정보를 교환하는 기본적인 방법입니다. 사용자가 웹 브라우저를 통해 웹 사이트에 접속할 때, 브라우저는 서버에 HTTP 요청을 보내고, 서버는 요청된 웹 페이지를 HTTP 응답으로 반환합니다.
            
            HTTPS는 SSL(Secure Sockets Layer) 또는 TLS(Transport Layer Security)를 사용하여 데이터를 암호화하므로, 사용자 데이터의 안전성을 높여 줍니다. 이는 특히 개인 정보와 같은 민감한 데이터를 다룰 때 중요합니다.
            """,
            category: "네트워크"
        ),
        CSItem(
            name: "DNS",
            shortDescription: """
            DNS(Domain Name System)는 인터넷 상의 도메인 이름을 IP 주소로 변환하는 시스템입니다.
            
            사용자가 웹 브라우저에 웹 사이트 주소를 입력할 때, DNS는 해당 도메인 이름을 IP 주소로 매핑하여 웹 사이트에 접속할 수 있도록 합니다.
            
            DNS는 인터넷의 전화번호부와 같은 역할을 하며, 사용자가 기억하기 쉬운 도메인 이름으로 복잡한 IP 주소에 접근할 수 있게 해줍니다.
            """,
            description: """
            DNS는 인터넷의 핵심 구성 요소 중 하나로, 사용자가 웹 사이트에 접속할 때마다 이루어지는 도메인 이름 해석 과정을 담당합니다. 이 시스템은 전 세계적으로 분산된 서버 네트워크를 통해 운영됩니다.
            
            DNS 서버는 도메인 이름을 요청 받으면, 해당 도메인 이름이 가리키는 IP 주소를 찾아 사용자의 요청을 해당 서버로 전달합니다. 이 과정은 사용자가 웹 사이트에 빠르고 효율적으로 접속할 수 있게 해줍니다.
            """,
            category: "네트워크"
        )
    ]
    static let questionList = [
        CSQuestion(question: "삽입 정렬이 다른 정렬 알고리즘(예: 선택 정렬, 버블 정렬)에 비해 유리한 경우는 어떤 상황인가요?",
                   answer: """
                   # 프로젝트 소개
                   ![intro](https://github.com/MojitoBar/pins/assets/16567811/e088d4de-4b83-47f2-b7f4-271edeaf4be5)

                   지도 기반 SNS 서비스를 개발함으로써 다양한 기술의 통합적 역량을 높이고자 시작한 프로젝트입니다. <br>
                   이 프로젝트의 핵심은 사용자가 지도에 핀을 생성하여 커뮤니티와 소통하는 것입니다.
                   """,
                   category: "자료구조", 
                   tailQuestion: ["삽입 정렬의 시간 복잡도와 최악의 경우 시간 복잡도는 각각 무엇인가요?"]),
        CSQuestion(question: "삽입 정렬이 다른 정렬 알고리즘(예: 선택 정렬, 버블 정렬)에 비해 유리한 경우는 어떤 상황인가요?",
                   answer: """
                   삽입 정렬은 주로 거의 정렬된 데이터나 데이터 크기가 작을 때 다른 정렬 알고리즘에 비해 효율적입니다.
                   
                   이는 삽입 정렬이 데이터를 적절한 위치에 삽입해야 하므로 이미 정렬된 부분은 크게 이동하지 않아도 되기 때문입니다. 따라서, 데이터가 이미 거의 정렬된 상태거나 데이터 크기가 작을 때 삽입 정렬은 선택 정렬이나 버블 정렬보다 빠르게 동작할 수 있습니다.
                   """,
                   category: "알고리즘",
                   tailQuestion: ["삽입 정렬의 시간 복잡도와 최악의 경우 시간 복잡도는 각각 무엇인가요?"]),
        CSQuestion(question: "삽입 정렬이 다른 정렬 알고리즘(예: 선택 정렬, 버블 정렬)에 비해 유리한 경우는 어떤 상황인가요?",
                   answer: """
                   삽입 정렬은 주로 거의 정렬된 데이터나 데이터 크기가 작을 때 다른 정렬 알고리즘에 비해 효율적입니다.
                   
                   이는 삽입 정렬이 데이터를 적절한 위치에 삽입해야 하므로 이미 정렬된 부분은 크게 이동하지 않아도 되기 때문입니다. 따라서, 데이터가 이미 거의 정렬된 상태거나 데이터 크기가 작을 때 삽입 정렬은 선택 정렬이나 버블 정렬보다 빠르게 동작할 수 있습니다.
                   """,
                   category: "네트워크",
                   tailQuestion: ["삽입 정렬의 시간 복잡도와 최악의 경우 시간 복잡도는 각각 무엇인가요?"])
    ]
}
