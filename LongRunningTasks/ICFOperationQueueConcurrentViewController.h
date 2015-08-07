//
//  ICFOperationQueueViewController.h
//  LongRunningTasks
//
//  Created by Joe Keeley on 8/25/12.
//  Copyright (c) 2012 Joe Keeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICFOperationQueueConcurrentViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *displayItems;
@property (nonatomic, strong) NSOperationQueue *processingQueue;
@property (nonatomic, strong) IBOutlet UIView *statusView;
@property (nonatomic, strong) IBOutlet UILabel *activityLabel;

- (IBAction)cancelButtonTouched:(id)sender;

@end
