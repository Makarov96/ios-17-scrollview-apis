//
//  Cities.swift
//  maps
//
//  Created by Guerin Steven Colocho Chacon on 11/11/23.
//

import Foundation
import Observation
import MapKit

@Observable
class City: Identifiable {
    var id: UUID = UUID()
    var direction: CLLocationCoordinate2D
    var cityName: String = ""
    var cityImages: Array<String> = []
    var cityPhoto: String = ""
    var reviews: Array<Review>
    
    
    init(direction:CLLocationCoordinate2D, cityName: String, cityPhoto: String,reviews: Array<Review>) {
        self.direction = direction
        self.cityName = cityName
        self.cityPhoto = cityPhoto
        self.reviews = reviews
    }
    
    static let this: Array<City> = [.init(direction: .newYork, cityName: "New York", cityPhoto: "new-york/image-peview", reviews: generateReviewList()),.init(direction:.manta, cityName: "Manta", cityPhoto: "manta/manta-preview", reviews: generateReviewList()),.init(direction: .mexico, cityName: "Mexico", cityPhoto: "mexico/mexico-preview", reviews: generateReviewList())
                                    ,.init(direction: .spain, cityName: "Spain", cityPhoto: "spain/madrid-preview", reviews: generateReviewList()),
    ]
}

@Observable
class Review: Identifiable  {
    var id: UUID = UUID()
    var description: String
    var points: Int
    var user:String
    
    init( description: String, points: Int,  userPhoto:String) {
        
        self.description = description
        self.points = points
        self.user = userPhoto
    }
}

func generateReviewList() -> [Review] {
    var reviews: [Review] = []
    
    let creativeDescriptions = [
        "A mesmerizing blend of colors and culture, a must-visit!",
        "Epic adventures await in this hidden gem.",
        "Dive into the vibrant atmosphere of this unique destination.",
        "Discover the secrets of the past in the heart of modernity.",
        "A taste of paradise – where every moment is a photo opportunity."
    ]
    
    let creativeImage = [   "https://xsgames.co/randomusers/assets/avatars/male/1.jpg",
                            "https://xsgames.co/randomusers/assets/avatars/male/2.jpg",
                            "https://xsgames.co/randomusers/assets/avatars/male/3.jpg",
                            "https://xsgames.co/randomusers/assets/avatars/male/4.jpg",
                            "https://xsgames.co/randomusers/assets/avatars/male/5.jpg",
    ]
    
    
    for i in 1...5 {
        let fakeDescription = creativeDescriptions[i - 1]
        let fakePoints = Int.random(in: 1...10)
        let fakeImage = creativeImage[i - 1]
        let review = Review( description: fakeDescription, points: fakePoints, userPhoto: fakeImage)
        reviews.append(review)
    }
    
    return reviews
}
