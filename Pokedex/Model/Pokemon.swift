//
//  Pokemon.swift
//  Pokedex
//
//  Created by Squad Apps on 03/11/23.
//

import UIKit

//struct Pokemon: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case officialArtwork = "official-artwork"
//        case id, name, weight, height, sprites
//    }
//
//    var id: Int
//    var name: String
//    var weight: Double
//    var height: Double
//    var sprites: Sprites
//
//    struct Sprites: Decodable {
//        var other: Other
//
//        struct Other: Decodable {
//            var officialArtwork: OfficialArtwork
//
//            struct OfficialArtwork: Decodable {
//                var front_default: String
//            }
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
//         id = try container.decode(Int.self, forKey: .id)
//         name = try container.decode(String.self, forKey: .name)
//         weight = try container.decode(Double.self, forKey: .weight)
//         height = try container.decode(Double.self, forKey: .height)
//         sprites = try container.decode(Sprites.self, forKey: .sprites)
//     }
//}

class Pokemon: Decodable {

    //atributes
    var id: Int
    var name: String
//    private var types: [String]
    var weight: Double
    var height: Double
//    private var moves: [String]
//    private var text: String
     var sprites: Sprites //photo
//    var sprites: Other
//    private var stats: [(String)]

    struct Sprites: Decodable {
        var front_default: String
    }

//        func showInfos() -> String {
//            return """
//            ID: \(self.id)
//            Name: \(self.name)
//            PhotoURL: \(self.sprites.front_default)
//            """
//        }


    struct Other: Decodable {
        var other: OfficialArtWork
    }

    struct OfficialArtWork: Decodable {
        var officialArtwork: FrontDefault
    }

    struct FrontDefault: Decodable {
        var front_default: String
    }

    enum CodingStringKeys: String, CodingKey {
        //the string values should match EXACTLY with the corresponding key in the JSON object
        case officialArtwork = "official-artwork"
    }

}
