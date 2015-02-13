
//
//  Business.m
//  Yelp
//
//  Created by Neal Wu on 2/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

const CGFloat MILES_PER_METER = 0.000621371192;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.thumbImageUrl = dictionary[@"image_url"];
        self.name = dictionary[@"name"];
        self.ratingImageUrl = dictionary[@"rating_img_url"];
        self.numReviews = [dictionary[@"review_count"] integerValue];

        NSString *street = [dictionary valueForKeyPath:@"location.address"][0];
        NSString *neighborhood = [dictionary valueForKeyPath:@"location.neighborhoods"][0];
        self.address = [NSString stringWithFormat:@"%@, %@", street, neighborhood];

        NSArray *doubleCategories = dictionary[@"categories"];
        NSMutableArray *categories = [NSMutableArray array];

        for (NSArray *category in doubleCategories) {
            [categories addObject:category[0]];
        }

        self.categories = [categories componentsJoinedByString:@", "];
        self.distance = [dictionary[@"distance"] floatValue] * MILES_PER_METER;
    }

    return self;
}

+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *businesses = [NSMutableArray array];

    for (NSDictionary *dictionary in dictionaries) {
        Business *business = [[Business alloc] initWithDictionary:dictionary];
        [businesses addObject:business];
    }

    return businesses;
}

@end