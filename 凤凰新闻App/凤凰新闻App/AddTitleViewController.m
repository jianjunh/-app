//
//  AddTitleViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/16.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "AddTitleViewController.h"
#import "TitleCollectionViewCell.h"
#import "Header.h"
@interface AddTitleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_selectedArray;
    NSMutableArray *_optionalArray;
    
}
@end

@implementation AddTitleViewController
//懒加载
-(UIView *)groundView
{
    if (!_groundView) {
        _groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, W, H - 20)];
    }
    return _groundView;
}

-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 50)];
    }
    return _headerView;
}

-(UIButton *)editButton
{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _editButton;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.groundView];
    
    
    [self initHeaderView];
    
    _selectedArray = [NSMutableArray arrayWithObjects:@"头条",@"娱乐",@"萌物",@"段子",@"哲思",@"直播",@"财经", nil];
    
    _optionalArray = [NSMutableArray arrayWithObjects:@"科技",@"美女",@"房产",@"国学",@"评论",@"暖新闻",@"旅游",@"公益",@"博报", nil];
    
    [self initCollectionView];
    
    [self initUpButton];
    
}

-(void)initHeaderView
{
    self.headerView.backgroundColor = RGBA(240, 240, 240, 1);
    
    [self.groundView addSubview:self.headerView];
    
    
    UILabel *enterLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
    
    enterLabel.text = @"点击进入频道";
    
    [self.headerView addSubview:enterLabel];
    
    
    self.editButton.frame = CGRectMake(W - 60, 0, 60, 50);
    
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    
    [self.editButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.editButton setTitle:@"完成" forState:UIControlStateSelected];
    
    [self.editButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [self.editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView addSubview:self.editButton];
}


-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((W - 75) / 4, 30);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(0, 30);
    [flowLayout setSectionInset:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, W, 0)collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = RGBA(240, 240, 240, 1);
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
    
    [self.groundView addSubview:self.collectionView];
    
    
}

-(void)edit:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


#pragma mark -- collection delegate
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
        headView.backgroundColor = [UIColor colorWithRed:210 / 255. green:210 / 255. blue:210 / 255. alpha:1];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, headView.frame.size.width, headView.frame.size.height)];
    
        
        label.text = @"已选频道";
        [headView addSubview:label];
        return headView;
    }else{
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header2" forIndexPath:indexPath];
        headView.backgroundColor = [UIColor colorWithRed:210 / 255. green:210 / 255. blue:210 / 255. alpha:1];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, headView.frame.size.width, headView.frame.size.height)];
        label.text = @"更多频道";
        [headView addSubview:label];
        return headView;
    }
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0){
        return [_selectedArray count];
    }else{
        return [_optionalArray count];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            cell.titleLabel.textColor = [UIColor redColor];
        }
        cell.titleLabel.text = [_selectedArray objectAtIndex:indexPath.row];
    }else{
        cell.titleLabel.text = [_optionalArray objectAtIndex:indexPath.row];
        
    }
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.editButton.selected == YES) {
            if(indexPath.row != 0){
                [_optionalArray addObject:[_selectedArray objectAtIndex:indexPath.row]];
                
                [_selectedArray removeObjectAtIndex:indexPath.row];
                
                [collectionView reloadData];
            }else{
                return;
            }
        }
    }else{
        [_selectedArray addObject:[_optionalArray objectAtIndex:indexPath.row]];
        [_optionalArray removeObject:[_optionalArray objectAtIndex:indexPath.row]];
        [collectionView reloadData];
    }
}

-(void)initUpButton
{
    self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.upButton.backgroundColor = RGBA(240, 240, 240, 1);
    
    self.upButton.frame = CGRectMake(0, 0, W, 0);
    
    [self.upButton setImage:[UIImage imageNamed:@"向上.png"] forState:UIControlStateNormal];
    
    [self.upButton addTarget:self action:@selector(upButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.groundView addSubview:self.upButton];
}

-(void)upButton:(UIButton *)sender
{
    [UIView animateWithDuration:1. animations:^{
        
        self.collectionView.frame = CGRectMake(0, 50, W, 0);
        
        self.upButton.frame = CGRectMake(0, 50, W, 0);
        
        
    }completion:^(BOOL finished) {
        self.headerView.hidden = YES;
        self.view.hidden = YES;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
