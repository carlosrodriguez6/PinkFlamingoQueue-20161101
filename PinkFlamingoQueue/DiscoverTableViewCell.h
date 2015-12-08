//
//  DiscoverTableViewCell.h
//  PinkFlamingoQueue
//
//  Created by Peter Malmgren on 12/9/15.
//  Copyright © 2015 Safari Books Online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *addToQueueButton;

@end
