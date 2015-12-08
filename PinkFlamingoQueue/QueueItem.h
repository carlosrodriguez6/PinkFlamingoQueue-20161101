//
//  QueueItem.h
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/8/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString *kQueueID = @"id";
static const NSString *kBookID = @"book";
static const NSString *kBookTitle = @"book_title";
static const NSString *kUserName = @"user_name";
static const NSString *kUserID = @"user";

@interface QueueItem : NSObject

- (instancetype)initWithJSONDictionary:(NSDictionary*)JSONDictionary;

@property (strong, nonatomic) NSString *bookID;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *bookTitle;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *queueID;

@end
