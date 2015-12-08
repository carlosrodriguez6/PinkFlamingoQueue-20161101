//
//  DiscoverItemTest.m
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/8/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DiscoverItem.h"

@interface DiscoverItemTest : XCTestCase

@end

@implementation DiscoverItemTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDiscoverItemInitializesWithJSONDictionary {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSData *JSONData = [NSData dataWithContentsOfFile:[testBundle pathForResource:@"DiscoverItem" ofType:@"json"]];
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:JSONData
                                                                   options:kNilOptions
                                                                     error:&error];
    XCTAssertNil(error);
    
    DiscoverItem *discoverItem = [[DiscoverItem alloc] initWithJSONDictionary:JSONDictionary];
    
    XCTAssertEqual(discoverItem.bookID, JSONDictionary[@"id"]);
    XCTAssertEqual(discoverItem.bookDescription, JSONDictionary[@"description"]);
    XCTAssertEqual(discoverItem.bookTitle, JSONDictionary[@"title"]);
    XCTAssertEqual(discoverItem.bookISBN, JSONDictionary[@"isbn"]);
    XCTAssertEqual(discoverItem.bookPublisherID, JSONDictionary[@"publisher"]);
    XCTAssertEqual(discoverItem.bookAuthors, JSONDictionary[@"authors"]);
}

@end
