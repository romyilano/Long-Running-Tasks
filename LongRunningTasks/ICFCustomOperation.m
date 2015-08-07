//
//  ICFCustomOperation.m
//  LongRunningTasks
//
//  Created by Joe Keeley on 9/1/12.
//  Copyright (c) 2012 Joe Keeley. All rights reserved.
//

#import "ICFCustomOperation.h"

@implementation ICFCustomOperation

- (id)initWithIteration:(NSNumber *)iterationNumber
            andDelegate:(id)myDelegate
{
    if (self = [super init])
    {
        self.iteration = iterationNumber;
        self.delegate = myDelegate;
    }
    return self;
}

- (void)main
{
    NSMutableArray *newArray =
    [[NSMutableArray alloc] initWithCapacity:10];
    
    for (int i=1; i<=10; i++)
    {
        
        if ([self isCancelled])
        {
            break;
        }
        
        [newArray addObject:
         [NSString stringWithFormat:@"Item %@-%d",
          self.iteration,i]];
        
        [NSThread sleepForTimeInterval:.1];
        NSLog(@"OpQ Custom Added %@-%d",self.iteration,i);
    }
    
    [self.delegate updateTableWithData:newArray];
}

@end
