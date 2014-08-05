//
//  CardMatchingGame.m
//  PlayingCard
//
//  Created by Guanyu Zhu on 7/31/14.
//  Copyright (c) 2014 Guanyu Zhu. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards;  //内部数据结构 其中存储的数据都是现在桌面上所有牌的内容
@property (nonatomic,readwrite) NSInteger lastScore;
@property (nonatomic,readwrite) NSArray *lastChosenCards;

@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if(self)
    {
        for(int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    return self;
    
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count])? self.cards[index]:nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if (card.isChosen) {
            card.chosen = NO;
        } else {  //要看看是不是和其他的已选中的牌是不是匹配
            NSMutableArray *otherCards = [NSMutableArray array];
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    [otherCards addObject:otherCard];
                }
            }
            self.lastScore = 0;
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            if ([otherCards count] + 1 == self.maxMatchingCards) { //表明现在已经是选择了两个了
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    self.lastScore += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                }
                else{
                    self.lastScore -= MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;  //没有匹配上就把之前的牌也给翻回去。
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}


@end
