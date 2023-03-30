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

    
    func fetchUserSets() async throws -> SetModel? {
        guard let userToken else { return nil }
        
        let baseURL = "https://rebrickable.com/api/v3/users/\(userToken)/sets/?key=91d5dc698499d14ed4ebfedd4d337f17&search=-0"
        
        guard var userSet = try await fetchSet(urlString: baseURL) else { return nil }
    
        
        for indexSet in 0..<userSet.results.count {
            let imageUrl = userSet.results[indexSet].propertySet.setImgURL
            userSet.results[indexSet].propertySet.coverImage = try await fetchImageForSet(imageUrl: imageUrl)
        }
        
        
        return userSet
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
    
    private func fetchSet(urlString: String) async throws -> SetModel? {
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
