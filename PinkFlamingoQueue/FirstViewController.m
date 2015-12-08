//
//  FirstViewController.m
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/8/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import "FirstViewController.h"
#import "DiscoverTableViewCell.h"
#import "DiscoverItem.h"
#import "PinkFlamingoQueue-Swift.h"

@interface FirstViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *discoverItems;
@property (strong, nonatomic) APIDataManager *dataManager;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _discoverItems = @[];
    _dataManager = [[APIDataManager alloc] init];

    __weak typeof(self) welf = self;

    [_dataManager getDiscoverWithCallback:^(NSArray<DiscoverItem *> * _Nullable discoverItems, NSError * _Nullable error) {
        __strong typeof(welf) strongSelf = welf;

        strongSelf.discoverItems = discoverItems;
        [strongSelf.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_discoverItems count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Items Available to Queue";
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverTableViewCell *tableViewCell = (DiscoverTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"DiscoverTableCell" forIndexPath:indexPath];
    
    DiscoverItem *discoverItem = [_discoverItems objectAtIndex:indexPath.row];
    tableViewCell.bookDescriptionLabel.text = discoverItem.bookDescription;
    tableViewCell.bookTitleLabel.text = discoverItem.bookTitle;
    tableViewCell.addToQueueButton.tag = indexPath.row;
    [tableViewCell.addToQueueButton addTarget:self action:@selector(didSelectAddToQueue:) forControlEvents:UIControlEventTouchUpInside];
    
    return tableViewCell;
}

#pragma mark - button
- (void)didSelectAddToQueue:(UIButton*)sender {
    DiscoverItem *discoverItem = [_discoverItems objectAtIndex:sender.tag];

    [_dataManager addQueueWithItemID:[NSString stringWithFormat:@"%@", discoverItem.bookID] callback:^(QueueItem * _Nullable queueItem, NSError * _Nullable error) {
        NSLog(@"%@", queueItem);
    }];
}

@end
