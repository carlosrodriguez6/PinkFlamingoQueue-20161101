//
//  QueueItemTest.m
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/8/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QueueItem.h"

@interface QueueItemTest : XCTestCase

@end

@implementation QueueItemTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testQueueItemInitializesWithJSONDictionary {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSData *JSONData = [NSData dataWithContentsOfFile:[testBundle pathForResource:@"QueueItem" ofType:@"json"]];
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:JSONData
                                                                   options:kNilOptions
                                                                     error:&error];
    XCTAssertNil(error);
    
    QueueItem *queueItem = [[QueueItem alloc] initWithJSONDictionary:JSONDictionary];
    
    XCTAssertEqual(queueItem.bookID, JSONDictionary[@"book"]);
    XCTAssertEqual(queueItem.userID, JSONDictionary[@"user"]);
    XCTAssertEqual(queueItem.bookTitle, JSONDictionary[@"book_title"]);
    XCTAssertEqual(queueItem.userName, JSONDictionary[@"user_name"]);
    XCTAssertEqual(queueItem.queueID, JSONDictionary[@"id"]);
}

@end
