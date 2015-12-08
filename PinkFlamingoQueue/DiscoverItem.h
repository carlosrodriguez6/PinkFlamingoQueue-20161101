//
//  DiscoverItem.h
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/8/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface DiscoverItem : NSObject

- (instancetype)initWithJSONDictionary:(NSDictionary*)JSONDictionary;

@property (strong, nonatomic) NSString *bookID;
@property (strong, nonatomic) NSString *bookTitle;
@property (strong, nonatomic) NSString *bookDescription;
@property (strong, nonatomic) NSString *bookISBN;
@property (strong, nonatomic) NSString *bookPublisherID;
@property (strong, nonatomic) NSArray *bookAuthors;
@property (strong, nonatomic) UIImage *coverImage;

@end
