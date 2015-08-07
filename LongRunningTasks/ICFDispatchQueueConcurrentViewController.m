//
//  ICFDispatchQueueConcurrentViewController.m
//  LongRunningTasks
//
//  Created by Joe Keeley on 8/25/12.
//  Copyright (c) 2012 Joe Keeley. All rights reserved.
//

#import "ICFDispatchQueueConcurrentViewController.h"

@interface ICFDispatchQueueConcurrentViewController ()
- (void)performLongRunningTaskForIteration:(id)iteration;
- (void)updateTableData:(id)moreData;
@end

@implementation ICFDispatchQueueConcurrentViewController

- (void)performLongRunningTaskForIteration:(id)iteration
{
    NSNumber *iterationNumber = (NSNumber *)iteration;
    
    __block NSMutableArray *newArray =
    [[NSMutableArray alloc] initWithCapacity:10];
    
    dispatch_queue_t detailQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);

    dispatch_apply(10, detailQueue, ^(size_t i)
    {
        [NSThread sleepForTimeInterval:.1];
        
        [newArray addObject:[NSString stringWithFormat:
                             @"Item %@-%zu",iterationNumber,i+1]];
        
        NSLog(@"DispQ Concurrent Added %@-%zu",iterationNumber,i+1);
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateTableData:newArray];
    });
}

- (void)updateTableData:(id)moreData
{
    NSArray *newArray = (NSArray *)moreData;
    [self.displayItems addObject:newArray];
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.displayItems = [[NSMutableArray alloc] initWithCapacity:2];
    [self.displayItems addObject:@[@"Item Initial-1",@"Item Initial-2",@"Item Initial-3",@"Item Initial-4",@"Item Initial-5"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_queue_t workQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    for (int i=1; i<=5; i++)
    {
        
        NSNumber *iteration = [NSNumber numberWithInt:i];

        dispatch_async(workQueue, ^{
            [self performLongRunningTaskForIteration:iteration];
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.displayItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.displayItems objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ICFDispatchConcurrentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSMutableArray *itemsForRow = [self.displayItems objectAtIndex:indexPath.section];
    NSString *labelForRow = [itemsForRow objectAtIndex:indexPath.row];
    [cell.textLabel setText:labelForRow];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
