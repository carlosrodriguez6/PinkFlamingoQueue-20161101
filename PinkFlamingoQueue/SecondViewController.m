//
//  SecondViewController.m
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/8/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import "SecondViewController.h"
#import "QueueItem.h"
#import "QueueTableViewCell.h"
#import "PinkFlamingoQueue-Swift.h"

@interface SecondViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) APIDataManager *dataManager;
@property (strong, nonatomic) NSArray *queueItems;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queueItems = @[];
    _dataManager = [[APIDataManager alloc] init];
    __weak typeof(self) welf = self;

    [_dataManager getQueueWithCallback:^(NSArray<QueueItem *> * _Nullable queue, NSError * _Nullable error) {
        __strong typeof(welf) strongSelf = welf;

        strongSelf.queueItems = queue;
        [strongSelf.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_queueItems count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QueueTableViewCell *cell = (QueueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"QueueTableCell" forIndexPath:indexPath];
    QueueItem *queueItem = [_queueItems objectAtIndex:indexPath.row];
    
    cell.itemTitleLabel.text = queueItem.bookTitle;
    // todo
    cell.timeInQueueLabel.text = @"In Queue For 1 Day";
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Queued Items";
}

@end
