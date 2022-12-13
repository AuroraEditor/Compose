//
//  SHA256Digest.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Crypto
import Foundation

extension SHA256Digest {
    var base64: String {
        Data(self).base64EncodedString()
    }
    
    var base64URLEncoded: String {
        Data(self).base64URLEncodedString()
    }
}
