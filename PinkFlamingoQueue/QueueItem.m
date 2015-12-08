//
//  QueueItem.m
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/8/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import "QueueItem.h"

@implementation QueueItem

- (instancetype)initWithJSONDictionary:(NSDictionary*)JSONDictionary {
    self = [super init];
    if (self) {
        self.bookTitle = [JSONDictionary objectForKey:kBookTitle];
        self.bookID = [JSONDictionary objectForKey:kBookID];
        self.userName = [JSONDictionary objectForKey:kUserName];
        self.userID = [JSONDictionary objectForKey:kUserID];
        self.queueID = [JSONDictionary objectForKey:kQueueID];
    }
    
    return self;
}

@end
