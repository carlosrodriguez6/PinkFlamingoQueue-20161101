//
//  DiscoverItem.m
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/8/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverItem.h"

static const NSString *kBookID = @"id";
static const NSString *kBookTitle = @"title";
static const NSString *kBookDescription = @"description";
static const NSString *kBookISBN = @"isbn";
static const NSString *kBookPublisher = @"publisher";
static const NSString *kBookAuthors = @"authors";
static const NSString *kBookCover = @"cover";

@implementation DiscoverItem

- (instancetype)initWithJSONDictionary:(NSDictionary*)JSONDictionary {
    self = [super init];
    if (self) {
        self.bookID = [JSONDictionary objectForKey:kBookID];
        self.bookDescription = [JSONDictionary objectForKey:kBookDescription];
        self.bookTitle = [JSONDictionary objectForKey:kBookTitle];
        self.bookISBN = [JSONDictionary objectForKey:kBookISBN];
        self.bookAuthors = [JSONDictionary objectForKey:kBookAuthors];
        self.bookPublisherID = [JSONDictionary objectForKey:kBookPublisher];
        self.coverImage = [JSONDictionary objectForKey:kBookCover];
    }
    
    return self;
}

@end
