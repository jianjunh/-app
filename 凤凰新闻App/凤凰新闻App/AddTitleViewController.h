//
//  AddTitleViewController.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/16.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol changeArray <NSObject>

@optional
-(void)changeArray;

@end

@interface AddTitleViewController : UIViewController

@property (nonatomic,strong)UIView *groundView;

@property (nonatomic,strong)UIButton *editButton;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UIView *headerView;

@property (nonatomic,strong)UIView *underView;

@property (nonatomic,strong)UIButton *upButton;

@property (nonatomic,strong)NSArray *selectedArray;

@property (nonatomic,strong)NSArray *optionalArray;

@property (nonatomic,assign)id<changeArray>delegate;

@end
