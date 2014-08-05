//
//  PlayingCardViewController.m
//  PlayingCard
//
//  Created by Guanyu Zhu on 7/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface PlayingCardViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modelController;  // 因为是outlet,所以可以随时跟踪着数据的变化 然后由这个数据来改变其他的
@property (weak, nonatomic) IBOutlet UILabel *flipDescriptionLable;

@end

@implementation PlayingCardViewController


- (IBAction)changeModelController:(UISegmentedControl *)sender {
    
    int x = [self.modelController selectedSegmentIndex];
    NSLog(@"%d",x);
    self.game.maxMatchingCards = [sender selectedSegmentIndex]? 3:2 ;
}

- (IBAction)touchDealButton:(UIButton *)sender { // 重置桌面
    
    self.modelController.enabled = YES;
    self.game = nil;  //简单的设置为nil 就可以重置
    [self updateUI];  // update 很有用的
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        [self changeModelController:self.modelController];  //相当于也要重新设置model的模式，因为之前给设置为nil了，所以 maxMatchingCard也要重新设置
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (Deck *)deck  //重写getter 的deck 函数， 相当于在使用的时候会进行初始化
{
    if(!_deck)
    {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck ;
}


- (IBAction)touchCardButton:(UIButton *)sender {
    
    self.modelController.enabled = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex]; //将view的数据传给了model，进行逻辑上的处理
    [self updateUI]; // 在把更新后的数据现实在view中 也就是update
    
    }
- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    
    //更新下面的描述label
    if (self.game) {
        NSString *description = @"";
        
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards)
            {
                [cardContents addObject:card.contens];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        
        if (self.game.lastScore >0) {
            description = [NSString stringWithFormat:@"Matched %@ for %d points.",description,self.game.lastScore];
            
        } else if (self.game.lastScore < 0)
        {
            description = [NSString stringWithFormat:@"%@ don't match! %d point penalty!",description,-self.game.lastScore];
        }
        self.flipDescriptionLable.text = description;
    }

}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contens : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    if (card.isChosen) {

        return [UIImage imageNamed:@"cardfront"];
        
    } else{

        return [UIImage imageNamed:@"cardback"];
    }
}

- (IBAction)redealButton:(UIButton *)sender {
}
@end
