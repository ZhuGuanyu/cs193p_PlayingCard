//
//  Card.m
//  PlayingCard
//
//  Created by Guanyu Zhu on 7/29/14.
//  Copyright (c) 2014 Guanyu Zhu. All rights reserved.
//

#import "Card.h"

@interface Card();

@end

@implementation Card


-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for(Card *card in otherCards){
        
        if([card.contens isEqualToString:self.contens]){
            score = 1;
        }
        
    }
    return score;
}

@end