//
//  ICFCustomOperation.h
//  LongRunningTasks
//
//  Created by Joe Keeley on 9/1/12.
//  Copyright (c) 2012 Joe Keeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ICFCustomOperationDelegate <NSObject>

- (void)updateTableWithData:(NSArray *)moreData;

@end

@interface ICFCustomOperation : NSOperation

@property (nonatomic, weak) id<ICFCustomOperationDelegate> delegate;
@property (nonatomic, strong) NSNumber *iteration;

- (id)initWithIteration:(NSNumber *)iterationNumber andDelegate:(id)myDelegate;

@end
