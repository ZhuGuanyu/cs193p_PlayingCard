//
//  Deck.h
//  PlayingCard
//
//  Created by Guanyu Zhu on 7/29/14.
//  Copyright (c) 2014 Guanyu Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *) drawRandomCard;

@end
