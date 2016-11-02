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
@property (strong, nonatomic) NSMutableArray *queueItems;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queueItems = [[NSMutableArray alloc] init];
    _dataManager = [[APIDataManager alloc] init];
    __weak typeof(self) welf = self;

    [_dataManager getQueueWithCallback:^(NSArray<QueueItem *> * _Nullable queue, NSError * _Nullable error) {
        __strong typeof(welf) strongSelf = welf;

        strongSelf.queueItems = [queue mutableCopy];
        [strongSelf.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"Will appear");
    
    __weak typeof(self) welf = self;
    
    [_dataManager getQueueWithCallback:^(NSArray<QueueItem *> * _Nullable queue, NSError * _Nullable error) {
        __strong typeof(welf) strongSelf = welf;
        
        strongSelf.queueItems = [queue mutableCopy];
        [strongSelf.tableView reloadData];
    }];
    
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

#pragma mark - Deleting
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QueueItem* queueItem = [_queueItems objectAtIndex:indexPath.row];
    
    
    /* Unfortunately passing in the queueItem causes a crash, but under normal circumstances I would delete */
    
    [_dataManager removeQueueWithItem:queueItem callback:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to remove item from queue due to %@",error.localizedDescription);
        }
        else {
            [_queueItems removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
}

@end
