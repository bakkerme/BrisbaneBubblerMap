// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bCCResponse = try? JSONDecoder().decode(BCCResponse.self, from: jsonData)

import Foundation

// MARK: - BCCResponse
struct BCCResponse: Codable {
    let objectIDFieldName: String
    let uniqueIDField: UniqueIDField
    let globalIDFieldName, geometryType: String
    let spatialReference: SpatialReference
    let fields: [Field]
    let features: [Feature]

    enum CodingKeys: String, CodingKey {
        case objectIDFieldName = "objectIdFieldName"
        case uniqueIDField = "uniqueIdField"
        case globalIDFieldName = "globalIdFieldName"
        case geometryType, spatialReference, fields, features
    }
}

// MARK: - Feature
struct Feature: Codable {
    let attributes: Attributes
    let geometry: Geometry
}

// MARK: - Attributes
struct Attributes: Codable {
    let objectid: Int
    let parkNumber, parkName, sapEquipment, sapFunctionalLocation: String
    let itemType: ItemType
    let itemDescription: String
    let x, y: Double

    enum CodingKeys: String, CodingKey {
        case objectid = "OBJECTID"
        case parkNumber = "PARK_NUMBER"
        case parkName = "PARK_NAME"
        case sapEquipment = "SAP_EQUIPMENT"
        case sapFunctionalLocation = "SAP_FUNCTIONAL_LOCATION"
        case itemType = "ITEM_TYPE"
        case itemDescription = "ITEM_DESCRIPTION"
        case x = "X"
        case y = "Y"
    }
}

enum ItemType: String, Codable {
    case bubblerDrinkingFountain = "BUBBLER/DRINKING FOUNTAIN"
}

// MARK: - Geometry
struct Geometry: Codable {
    let x, y: Double
}

// MARK: - Field
struct Field: Codable {
    let name, type, alias, sqlType: String
    let domain, defaultValue: JSONNull?
    let length: Int?
}

// MARK: - SpatialReference
struct SpatialReference: Codable {
    let wkid, latestWkid: Int
}

// MARK: - UniqueIDField
struct UniqueIDField: Codable {
    let name: String
    let isSystemMaintained: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
