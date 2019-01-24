//
//  FeedResponse.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 22/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    let items: [FeedItem]
    let profiles: [Profile]
    let groups: [Group]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let date: Double
    let postId: Int?
    let text: String?
    let signerId: Int?
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    
}

struct CountableItem: Decodable {
    let count: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresentable {
    
    let uid: Int
    let firstName: String
    let lastName: String
    let photoMediumRec: String
    
    var id: Int { return uid }
    var name: String { return firstName + " " + lastName }
    var photo: String { return photoMediumRec}
}

struct Group: Decodable, ProfileRepresentable {
    
    let gid: Int
    var name: String
    let photoMedium: String
    
    var id: Int { return gid}
    var photo: String { return photoMedium }
    
    
}
