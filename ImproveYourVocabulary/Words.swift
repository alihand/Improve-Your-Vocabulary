//
//  Words.swift
//  ImproveYourVocabulary
//
//  Created by Alihan Demir on 4.03.2019.
//  Copyright © 2019 Alihan Demir. All rights reserved.
//

import Foundation
import RealmSwift

class Words : Object {
    @objc dynamic var word = ""
    @objc dynamic var mean = ""
    @objc dynamic var synonym = ""
    @objc dynamic var antonym = ""
}
