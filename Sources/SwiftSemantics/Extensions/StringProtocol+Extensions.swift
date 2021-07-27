extension StringProtocol {
    var nonEmpty: String? {
        return isEmpty ? nil : String(self)
    }

    var trimmed: String {
        let startIndex = firstIndex(where: { !$0.isWhitespace }) ?? self.startIndex
        let endIndex = lastIndex(where: { !$0.isWhitespace }) ?? self.endIndex
        return String(self[startIndex...endIndex])
    }
}

extension String {
    var unindented: String {
        let lines = split(separator: "\n", omittingEmptySubsequences: false)
        guard lines.count > 1 else { return trimmingCharacters(in: .whitespaces) }

        let indentation = lines.compactMap { $0.firstIndex(where: { !$0.isWhitespace })?.utf16Offset(in: $0) }
            .min() ?? 0

        return lines.map {
            guard $0.count > indentation else { return String($0) }
            return String($0.suffix($0.count - indentation))
        }.joined(separator: "\n")
    }
}
