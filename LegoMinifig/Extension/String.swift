//
//  String.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 27/03/23.
//

import Foundation

extension String {

    mutating func until(_ string: String) {
        let components = self.components(separatedBy: string)
        self = components[0]
    }

}
