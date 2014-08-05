//
//  PlayingCard.m
//  PlayingCard
//
//  Created by Guanyu Zhu on 7/29/14.
//  Copyright (c) 2014 Guanyu Zhu. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//重写 match 函数, 这个函数是继承Card的函数
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int numOtherCards = [otherCards count];
    
    if (numOtherCards) {
        for (PlayingCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                score += 4;
            }else if([otherCard.suit isEqualToString:self.suit]){
                score += 1;
            }
        }
    }
    
    if (numOtherCards > 1) {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numOtherCards - 1)]] ;
            }
    
    
    return score;
    
}





- (NSString *)contens   //相当于重写了contens的get函数
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


+ (NSArray *)validSuits
{
    return @[@"♥",@"♠",@"♦",@"♣"];
}


@synthesize suit = _suit;
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank //检验有效性
{
    if(rank <= [PlayingCard maxRank])
        _rank = rank;
}


@end
