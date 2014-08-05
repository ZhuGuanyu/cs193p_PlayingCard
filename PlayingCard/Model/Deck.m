//
//  Deck.m
//  PlayingCard
//
//  Created by Guanyu Zhu on 7/29/14.
//  Copyright (c) 2014 Guanyu Zhu. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong,nonatomic) NSMutableArray *cards; //mutable 是可以往里面添加东西的数组
@end

@implementation Deck

- (NSMutableArray *)cards //rewrite the getter method of cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(void) addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }
}

-(void) addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

-(Card *) drawRandomCard
{
    Card *randownCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random()% [self.cards count];
        randownCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randownCard;
}

@end
