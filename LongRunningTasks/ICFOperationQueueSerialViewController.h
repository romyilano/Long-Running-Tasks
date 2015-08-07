//
//  ICFOperationQueueSerialViewController.h
//  LongRunningTasks
//
//  Created by Joe Keeley on 9/1/12.
//  Copyright (c) 2012 Joe Keeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICFOperationQueueSerialViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *displayItems;
@property (nonatomic, strong) NSOperationQueue *processingQueue;

@end
