import Foundation
import UIKit.UIImage

public class Hotel: Codable, Identifiable, Hashable {
    public var id: Int
    var name: String
    var address: String
    var stars: Int
    var distance: Double
    var suitesAvailability: String
    
    public class Details: Codable, Identifiable, Hashable {
        public var id: Int?
        var name, address: String?
        var stars, distance: Int?
        var image, suitesAvailability: String?
        var lat, lon: Double?

        enum CodingKeys: String, CodingKey {
            case id, name, address, stars, distance, image
            case suitesAvailability = "suites_availability"
            case lat, lon
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        public static func == (lhs: Details, rhs: Details) -> Bool {
            return lhs.id == rhs.id && lhs.name == rhs.name && lhs.address == rhs.address && lhs.stars == rhs.stars && lhs.distance == rhs.distance && lhs.image == rhs.image && lhs.suitesAvailability == rhs.suitesAvailability && lhs.lat == rhs.lat && lhs.lon == rhs.lon
        }

        init(id: Int?, name: String?, address: String?, stars: Int?, distance: Int?, image: String?, suitesAvailability: String?, lat: Double?, lon: Double?) {
            self.id = id ?? 0
            self.name = name ?? ""
            self.address = address ?? ""
            self.stars = stars ?? 0
            self.distance = distance ?? 0
            self.image = image ?? ""
            self.suitesAvailability = suitesAvailability ?? ""
            self.lat = lat ?? 0.0
            self.lon = lon ?? 0.0
        }
    }
    
    var details: Details?
    
    var image: UIImage
    var availableRooms: Int
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Hotel, rhs: Hotel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.address == rhs.address && lhs.stars == rhs.stars && lhs.distance == rhs.distance && lhs.suitesAvailability == rhs.suitesAvailability && lhs.image == rhs.image && lhs.availableRooms == rhs.availableRooms
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }

    init(id: Int?, name: String?, address: String?, stars: Int?, distance: Double?, suitesAvailability: String?) {
        self.id = id ?? 0
        self.name = name ?? ""
        self.address = address ?? ""
        self.stars = stars ?? 0
        self.distance = distance ?? 0.0
        self.suitesAvailability = suitesAvailability ?? ""
        
        self.image = .init()
        self.availableRooms = suitesAvailability?.split(separator: ":").compactMap{Int($0)}.count ?? 0
    }
        
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        address = try values.decode(String.self, forKey: .address)
        stars = try values.decode(Int.self, forKey: .stars)
        distance = try values.decode(Double.self, forKey: .distance)
        suitesAvailability = try values.decode(String.self, forKey: .suitesAvailability)
        
        image = .init()
        availableRooms = try values.decode(String.self, forKey: .suitesAvailability).split(separator: ":").compactMap{Int($0)}.count
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(stars, forKey: .stars)
        try container.encode(distance, forKey: .distance)
        try container.encode(suitesAvailability, forKey: .suitesAvailability)
    }
}
