//
//  MinifiguresSetManager.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 24/03/23.
//

import Foundation

struct MinifiguresSetManager {
    let urlSession = URLSession.shared
    let userToken = UserDefaults.standard.string(forKey: "user_token")
    
    let allSets: [String] = ["71000", "71001", "71002", "71003", "71004", "71005", "71006", "71007", "71008", "71009", "71010", "71011", "71012", "71013", "71014", "71015", "71016", "71017", "71018", "71019", "71020", "71021", "71022", "71023", "71024", "71025", "71026", "71027", "71028", "71029", "71030", "71031", "71032", "71033", "71034", "71035", "71036", "71037", "71038"]
    
    func fetchUserSets() async throws -> [SetModel]? {
        guard let userToken else { return nil }
        let baseURL = "https://rebrickable.com/api/v3/users/\(userToken)/sets/?key=91d5dc698499d14ed4ebfedd4d337f17&set_num="
        return try await withThrowingTaskGroup(of: SetModel?.self) { group in
            var sets: [SetModel] = []
            
            sets.reserveCapacity(allSets.count)
            
            for sets in allSets {
                group.addTask {
                    let urlString = baseURL + sets + "-0"
                    print("urlString \(urlString)")
                    return try? await self.fetchSet(urlString: urlString)
                }
            }
            
            for try await singleSet in group {
                if let singleSet, !singleSet.results.isEmpty {
                    let imageUrl = singleSet.results[0].propertySet.setImgURL
                    let imageData = try await fetchImageForSet(imageUrl: imageUrl)
                    var updatedSet = singleSet
                    updatedSet.results[0].propertySet.addCoverImageData(imageData)
                    sets.append(updatedSet)
                }
            }
            
            print("sets \(sets)")
            return sets
        }
    }
    
    private func fetchImageForSet(imageUrl: String) async throws -> Data {
        guard let url = URL(string: imageUrl) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
    
    private func fetchSet(urlString: String) async throws -> SetModel {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let set = try JSONDecoder().decode(SetModel.self, from: data)
            return set
        } catch {
            throw error
        }
    }
}
