//
//  ICFPerformBackgroundViewController.m
//  LongRunningTasks
//
//  Created by Joe Keeley on 8/25/12.
//  Copyright (c) 2012 Joe Keeley. All rights reserved.
//

#import "ICFPerformBackgroundViewController.h"

@interface ICFPerformBackgroundViewController ()
- (void)performLongRunningTaskForIteration:(id)iteration;
- (void)updateTableData:(id)moreData;
@end

@implementation ICFPerformBackgroundViewController

- (void)performLongRunningTaskForIteration:(id)iteration
{
    NSNumber *iterationNumber = (NSNumber *)iteration;
    
    NSMutableArray *newArray =
    [[NSMutableArray alloc] initWithCapacity:10];
    
    for (int i=1; i<=10; i++)
    {
        
        [newArray addObject:
         [NSString stringWithFormat:@"Item %@-%d",
          iterationNumber,i]];
        
        [NSThread sleepForTimeInterval:.1];
        
        NSLog(@"Background Added %@-%d",iterationNumber,i);
    }
    
    [self performSelectorOnMainThread:@selector(updateTableData:)
                           withObject:newArray
                        waitUntilDone:NO];
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
    
    self.displayItems = [[NSMutableArray alloc] initWithCapacity:5];
    [self.displayItems addObject:@[@"Item Initial-1",@"Item Initial-2",@"Item Initial-3",@"Item Initial-4",@"Item Initial-5"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    SEL taskSelector =
    @selector(performLongRunningTaskForIteration:);
    
    for (int i=1; i<=5; i++)
    {
        
        NSNumber *iteration = [NSNumber numberWithInt:i];
        
        [self performSelectorInBackground:taskSelector
                               withObject:iteration];
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
    static NSString *CellIdentifier = @"ICFBackgroundCell";
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
