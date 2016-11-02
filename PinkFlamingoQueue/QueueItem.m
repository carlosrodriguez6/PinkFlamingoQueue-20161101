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
        id queueId = [JSONDictionary objectForKey:kQueueID];
        //For some reason the dictionary was interpreting the kQueueID value as an NSNumber, which, granted, it is
        //but it was happily sticking it in an NSString* property.  When this instance was then vended to Swift,
        //if swift tried to access it strictly wanted to treat it as a String and when it attempted to do the bridged
        //conversion from NSString to String is exploded.  This forces the property to be an NSString*
        self.queueID = [NSString stringWithFormat:@"%@",queueId];
    }
    
    return self;
}

@end
