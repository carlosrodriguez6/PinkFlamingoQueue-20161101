//
//  QueueTableViewCell.h
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/9/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueueTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeInQueueLabel;

@end
