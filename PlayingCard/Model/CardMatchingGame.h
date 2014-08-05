//
//  CardMatchingGame.h
//  PlayingCard
//
//  Created by Guanyu Zhu on 7/31/14.
//  Copyright (c) 2014 Guanyu Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject


- (instancetype)initWithCardCount:(NSUInteger)count //初始化的时候要给在哪个deck中去了多少 count卡片
                        usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger score; //设为readonly 别人不可随意写
@property (nonatomic) NSUInteger maxMatchingCards;
@property (nonatomic,readonly) NSInteger lastScore;
@property (nonatomic,readonly) NSArray *lastChosenCards; 

@end
