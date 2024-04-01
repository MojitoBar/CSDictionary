import Foundation
import FirebaseFirestore

final class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func saveDevice(_ device: Device) {
        let encoder = Firestore.Encoder()
        do {
            let deviceDic = try encoder.encode(device)
            db.collection("devices").document(device.token).setData(deviceDic, merge: true)
        } catch {
            NSLog("Failed to save device: \(error)")
        }
    }
    
    func fetchKeywords() async -> [CSItem] {
        var keywords: [CSItem] = []
        let keywordsRef = db.collection("keywords").order(by: "keyword")
        
        do {
            let snapshot = try await keywordsRef.getDocuments()
            for document in snapshot.documents {
                let keyword = try Firestore.Decoder().decode(CSItem.self, from: document.data())
                keywords.append(keyword)
            }
            return keywords
        } catch {
            fatalError()
        }
    }
    
    func fetchQuestions() async -> [CSQuestion] {
        var questions: [CSQuestion] = []
        let questionsRef = db.collection("questions").order(by: "question")
        
        do {
            let snapshot = try await questionsRef.getDocuments()
            for document in snapshot.documents {
                let question = try Firestore.Decoder().decode(CSQuestion.self, from: document.data())
                questions.append(question)
            }
            return questions
        } catch {
            fatalError()
        }
    }
}
