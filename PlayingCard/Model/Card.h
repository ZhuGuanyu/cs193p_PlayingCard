//
//  Card.h
//  PlayingCard
//
//  Created by Guanyu Zhu on 7/29/14.
//  Copyright (c) 2014 Guanyu Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(strong,nonatomic) NSString *contens;

@property(nonatomic, getter = isChosen) BOOL chosen;
@property(nonatomic, getter = isMatched) BOOL matched;

-(int)match:(NSArray *) otherCard;

@end