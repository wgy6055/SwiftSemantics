import SwiftSyntax

extension SyntaxProtocol {
    var context: DeclSyntaxProtocol? {
        for case let node? in sequence(first: parent, next: { $0?.parent }) {
            guard let declaration = node.asProtocol(DeclSyntaxProtocol.self) else { continue }
            return declaration
        }

        return nil
    }
}

extension SyntaxProtocol {
    var lineComment: String? {
        return leadingTrivia?.lineComment
    }
}

extension Trivia {
    var lineComment: String? {
        let components = compactMap { $0.lineComment }
        guard !components.isEmpty else { return nil }
        return components.joined(separator: "\n").unindented
    }
}

fileprivate extension TriviaPiece {
    var lineComment: String? {
        switch self {
        case let .lineComment(comment):
            let startIndex = comment.index(comment.startIndex, offsetBy: 2)
            return String(comment.suffix(from: startIndex))
        case let .docBlockComment(comment):
            let startIndex = comment.index(comment.startIndex, offsetBy: 3)
            let endIndex = comment.index(comment.endIndex, offsetBy: -2)
            return String(comment[startIndex ..< endIndex])
        default:
            return nil
        }
    }
}
