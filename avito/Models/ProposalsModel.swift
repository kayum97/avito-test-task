import Foundation

struct AllInfo: Codable {
    var status: String
    var result: ResultModel
}

struct ResultModel: Codable {
    var title: String
    var actionTitle: String
    var selectedActionTitle: String
    var list: [ProposalModel]
}

struct ProposalModel: Codable {
    var id: String
    var icon: [String:String]
    var title: String
    var description: String?
    var price: String
    var isSelected: Bool
}
