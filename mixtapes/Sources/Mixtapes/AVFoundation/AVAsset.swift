import AVFoundation

extension AVAsset {
    func chapterMetadataGroups() async throws -> [AVMetadataGroup] {
        let locales = try await load(.availableChapterLocales)
        let groups = try await loadChapterMetadataGroups(bestMatchingPreferredLanguages: locales.map { $0.identifier })
        return groups
    }
    
    func artwork() async throws -> Data {
        guard let data: Data = try await metadataItem("artwork").load(.dataValue) else {
            throw AVError(.contentIsUnavailable)
        }
        return data
    }
    
    func artist() async throws -> String {
        guard let string: String = try await metadataItem("artist").load(.stringValue),
              !string.isEmpty else {
            throw AVError(.contentIsUnavailable)
        }
        return string
    }
    
    func title() async throws -> String {
        guard let string: String = try await metadataItem("title").load(.stringValue),
              !string.isEmpty else {
            throw AVError(.contentIsUnavailable)
        }
        return string
    }
    
    func duration() async throws -> Double { try await load(.duration).seconds }
    
    func metadataItem(_ key: String) async throws -> AVMetadataItem {
        let metadata: [AVMetadataItem] = try await load(.commonMetadata)
        for item in metadata {
            guard item.commonKey?.rawValue == key else { continue }
            return item
        }
        throw AVError(.contentIsUnavailable)
    }
}
