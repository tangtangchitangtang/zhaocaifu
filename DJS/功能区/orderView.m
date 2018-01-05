//
//  orderView.m
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "orderView.h"
#import "orderTableViewCell.h"
#import "dinDanXaingQingViewController.h"
@implementation orderView
-(void)creatView{
    self.backgroundColor=_LightGrey;
    UIView *topView=[UIView new];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    topView.backgroundColor=[UIColor whiteColor];
    

    
    _allBtn=[UILabel new];
    [topView addSubview:_allBtn];
    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(-_mainW/4);
    }];
    _allBtn.text=@"已评价";
    _allBtn.font=[UIFont fontWithName:@"Helvetica" size:15 ];
    
    _allBtn.userInteractionEnabled=YES;
    _allBtn.tag=1;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectZhuangTai:)];
    [_allBtn addGestureRecognizer:tapGesture];
    
    _allLabel=[UIView new];
    [topView addSubview:_allLabel];
    [_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(_allBtn);
        make.height.mas_equalTo(1.5);
        make.width.mas_equalTo(120);
    }];
    
    
    _pingJiaBtn=[UILabel new];
    [topView addSubview:_pingJiaBtn];
    [_pingJiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(_mainW/4);
    }];
    _pingJiaBtn.text=@"待评价";
    _pingJiaBtn.font=[UIFont fontWithName:@"Helvetica" size:15];
    _pingJiaBtn.userInteractionEnabled=YES;
    _pingJiaBtn.tag=2;
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectZhuangTai:)];
    [_pingJiaBtn addGestureRecognizer:tapGesture2];
    
    
    _pingJiaLabel=[UIView new];
    [topView addSubview:_pingJiaLabel];
    [_pingJiaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(_pingJiaBtn);
        make.height.mas_equalTo(1.5);
        make.width.mas_equalTo(120);
    }];

    
    _scrollView=[UIScrollView new];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).mas_equalTo(6);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(44);
    }];
    _scrollView.scrollsToTop = NO;
    _scrollView.contentSize = CGSizeMake(_mainW*2, 0);
    _scrollView.showsVerticalScrollIndicator = FALSE;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces = NO;
    _scrollView.delegate=self;
    _scrollView.tag=10;
    
    
    _allTabelView=[BaseTableView new];
    [_scrollView addSubview:_allTabelView];
    [_allTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(_mainW);
        make.height.mas_equalTo(_mainH-154);
    }];
    _allTabelView.tag=1;
    _allTabelView.delegate=self;
    _allTabelView.dataSource=self;
    
    _pingJiaTableView=[BaseTableView new];
    [_scrollView addSubview:_pingJiaTableView];
    [_pingJiaTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_mainW);
        make.width.mas_equalTo(_mainW);
        make.height.mas_equalTo(_mainH-154);
    }];
    _pingJiaTableView.tag=2;
    _pingJiaTableView.delegate=self;
    _pingJiaTableView.dataSource=self;
    
    _allLabel.backgroundColor=ColorWithRGB(189, 74, 59);
    _pingJiaLabel.backgroundColor=ColorWithRGB(189, 74, 59);;
    
    if (_abc==1) {
        _abc=1;
        
        _scrollView.contentOffset=CGPointMake(0, 0);
        
        _allBtn.textColor=ColorWithRGB(189, 74, 59);
        _pingJiaBtn.textColor=ColorWithRGB(50, 50, 50);
        
        
        _allLabel.hidden=NO;
        _pingJiaLabel.hidden=YES;
        
    }
    if (_abc==2) {
        _abc=2;
        _scrollView.contentOffset=CGPointMake(_mainW, 0);
        
        _allBtn.textColor=ColorWithRGB(50, 50, 50);
        _pingJiaBtn.textColor=ColorWithRGB(189, 74, 59);
        
        _allLabel.hidden=YES;
        _pingJiaLabel.hidden=NO;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView.tag==1) {
        return _tableArr1.count;
    }else if (tableView.tag==2) {
        return _tableArr2.count;
    }return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    orderTableViewCell *cell=[[orderTableViewCell alloc] init];
    
    if (tableView.tag==1) {
        cell.dic=_tableArr1[indexPath.row];
    }else if (tableView.tag==2) {
       cell.dic=_tableArr2[indexPath.row];
    }
    
    [cell creatView];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic;
    if (tableView.tag==1) {
        dic=_tableArr1[indexPath.row];
    }else if (tableView.tag==2) {
        dic=_tableArr2[indexPath.row];
    }
    dinDanXaingQingViewController *xiangQing=[[dinDanXaingQingViewController alloc] init];
    xiangQing.order_id=[dic objectForKey:@"order_id"];
    [ZQTools pushNextViewController:self.viewController  andRootController:xiangQing];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==10) {
        
        CGPoint points=scrollView.contentOffset;
        int pages=points.x/_mainW;
        if (pages==0) {
            _abc=1;
            _allBtn.textColor=ColorWithRGB(189, 74, 59);
            _pingJiaBtn.textColor=ColorWithRGB(50, 50, 50);
            
            
            _allLabel.hidden=NO;
            _pingJiaLabel.hidden=YES;
           
            
        }
        if (pages==1) {
            _abc=2;
            _allBtn.textColor=ColorWithRGB(50, 50, 50);
            _pingJiaBtn.textColor=ColorWithRGB(189, 74, 59);
          
            
            _allLabel.hidden=YES;
            _pingJiaLabel.hidden=NO;
        }
        
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag==10) {
        [self LoginDic1];
        
    }
    
    
}


-(void)selectZhuangTai:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag==1) {
        _abc=1;
        
        _scrollView.contentOffset=CGPointMake(0, 0);
        _allBtn.textColor=ColorWithRGB(189, 74, 59);
        _pingJiaBtn.textColor=ColorWithRGB(50, 50, 50);
        
        _allLabel.hidden=NO;
        _pingJiaLabel.hidden=YES;
        
    }
    if (tap.view.tag==2) {
        _abc=2;
        _scrollView.contentOffset=CGPointMake(_mainW, 0);
        
        _allBtn.textColor=ColorWithRGB(50, 50, 50);
        _pingJiaBtn.textColor=ColorWithRGB(189, 74, 59);
        
        _allLabel.hidden=YES;
        _pingJiaLabel.hidden=NO;
    }
  
  
    [self LoginDic1];
}

-(void)LoginDic1{
    NSString *status;
    if (_abc==1) {
       status=@"2";
        if (_tableArr1.count!=0) {
            return;
        }
    }
    if (_abc==2) {
         status=@"1";
        if (_tableArr2.count!=0) {
            return;
        }
    }
    NSDictionary *userDic = [NSKeyedUnarchiver unarchiveObjectWithFile:_userModelFile];
    NSNumber *user_id=[userDic objectForKey:@"user_id"];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:status,@"status",user_id,@"user_id", nil];
    [ZQTools AFNPostDataUrl:@"app/myOrder" Dict:dic andTableView:nil andView:self andSuccessBlock:^(id responseObject) {
        NSArray *typeArr=responseObject;
        if (_abc==1) {
             [_tableArr1 addObjectsFromArray:typeArr];
             [_allTabelView reloadData];
        }
        if (_abc==2) {
            [_tableArr2 addObjectsFromArray:typeArr];
             [_pingJiaTableView reloadData];
            
        }
        
     
    } anderrorBlock:nil];
    
}

@end
