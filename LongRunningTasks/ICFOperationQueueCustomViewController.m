//
//  ICFOperationQueueCustomViewController.m
//  LongRunningTasks
//
//  Created by Joe Keeley on 9/1/12.
//  Copyright (c) 2012 Joe Keeley. All rights reserved.
//

#import "ICFOperationQueueCustomViewController.h"

@interface ICFOperationQueueCustomViewController ()
- (void)updateTableData:(id)moreData;
@end

@implementation ICFOperationQueueCustomViewController

- (IBAction)cancelButtonTouched:(id)sender
{
    [self.processingQueue cancelAllOperations];
}

- (void)updateTableWithData:(NSArray *)moreData
{
    [self performSelectorOnMainThread:@selector(updateTableData:) withObject:moreData waitUntilDone:YES];
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
    
    self.processingQueue = [[NSOperationQueue alloc] init];
    [self.tableView setTableHeaderView:self.statusView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSMutableArray *operationsToAdd =
    [[NSMutableArray alloc] init];
    
    ICFCustomOperation *prevOperation = nil;
    for (int i=1; i<=5; i++)
    {
        
        NSNumber *iteration = [NSNumber numberWithInt:i];
        
        ICFCustomOperation *operation =
        [[ICFCustomOperation alloc] initWithIteration:iteration
                                          andDelegate:self];
        NSLog(@"...not cancelled, execute logic here");
        if (prevOperation)
        {
            [operation addDependency:prevOperation];
        }
        
        [operationsToAdd addObject:operation];
        
        prevOperation = operation;
    }
    
    for (ICFCustomOperation *operation in operationsToAdd)
    {
        [self.processingQueue addOperation:operation];
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
    static NSString *CellIdentifier = @"ICFOperationCustomCell";
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
