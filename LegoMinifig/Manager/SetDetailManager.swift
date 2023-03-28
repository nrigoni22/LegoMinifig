//
//  SetDetailManager.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 27/03/23.
//

import Foundation

struct SetDetailManager {
    let urlSession = URLSession.shared
    let userToken = UserDefaults.standard.string(forKey: "user_token")
    
    func fetchSetAndComponents(setNum: String?) async throws -> SetDetailModel? {
        guard let setNum else { throw URLError(.badURL) }
        
        var setNumber = setNum
        setNumber.until("-")
        
        print("setNumber \(setNumber)")
        
        
        let baseURL = "https://rebrickable.com/api/v3/lego/sets/?key=91d5dc698499d14ed4ebfedd4d337f17&search=\(setNumber)"
        
        guard let url = URL(string: baseURL) else { throw URLError(.badURL) }
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let setDetail = try JSONDecoder().decode(SetDetailModel.self, from: data)
            print("setDetail \(setDetail)")
            return setDetail
        } catch {
            throw error
        }
    }
    
    
    private func fetchImageForSet(imageUrl: String) async throws -> Data {
        guard let url = URL(string: imageUrl) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            return data
        } catch {
            throw error
        }
    }
}
