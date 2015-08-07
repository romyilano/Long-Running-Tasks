//
//  ICFOperationQueueCustomViewController.h
//  LongRunningTasks
//
//  Created by Joe Keeley on 9/1/12.
//  Copyright (c) 2012 Joe Keeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICFCustomOperation.h"

@interface ICFOperationQueueCustomViewController : UITableViewController <ICFCustomOperationDelegate>

@property (nonatomic, strong) NSMutableArray *displayItems;
@property (nonatomic, strong) NSOperationQueue *processingQueue;
@property (nonatomic, strong) IBOutlet UIView *statusView;

- (IBAction)cancelButtonTouched:(id)sender;

@end
