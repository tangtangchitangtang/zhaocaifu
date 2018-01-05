//
//  homeView.m
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "homeView.h"
#import "homeCell.h"
#import "detailsViewController.h"
@implementation homeView
-(void)creatView{
    _btnNameArr = [NSMutableArray arrayWithCapacity:0];
    [_btnNameArr addObject:@"全部"];
    [_btnNameArr addObject:@"附近"];
    [_btnNameArr addObject:@"智能排序"];
    _tableView=[BaseTableView new];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.bottom.mas_equalTo(44);
    }];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _headView=[UIView new];
    [_headView setFrame:CGRectMake(0, 0, _mainW, _mainH*0.24+181)];
    _headView.backgroundColor=_LightGrey;
    _tableView.tableHeaderView=_headView;
    [self creatTopView];
}
-(void)creatTopView{
    NSMutableArray *imageArr=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<_bannerArr.count; i++) {
        NSDictionary *dic=_bannerArr[i];
        NSString *imageStr=[dic objectForKey:@"SLIDEIMG"];
        NSString *imageUrl=[NSString stringWithFormat:@"%@/uploadFiles/uploadImgs/%@",_addressUrl,imageStr];
    
        [imageArr addObject:imageUrl];
    }
    
    [ZQTools getHederImage:CGRectMake(0, 0, _mainW,  _mainH*0.24) :imageArr :10 :_headView :^(int value) {
        NSLog(@"%d",value);
    }];
    
    
    UIView *gongNeiView=[UIView new];
    [_headView addSubview:gongNeiView];
    [gongNeiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(130);
        make.top.mas_equalTo(_mainH*0.24);
    }];
    gongNeiView.backgroundColor=[UIColor whiteColor];
    NSArray *nameArr=[NSArray arrayWithObjects:@"扫码付",@"付款码",@"开发票", nil];
    
    for (int i=0; i<3;i++ ) {
        UIView *beiJing=[UIView new];
        [gongNeiView addSubview:beiJing];
        [beiJing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(_mainW/3*i);
            make.width.mas_equalTo(_mainW/3);
        }];

        UIImageView *imageView=[UIImageView new];
        [beiJing addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.height.mas_equalTo(40);
        }];
        imageView.image=[UIImage imageNamed:nameArr[i]];

        UILabel *label=[UILabel new];
        [beiJing addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).mas_equalTo(10);
        }];
        label.text=nameArr[i];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=ColorWithRGB(29, 29, 29);
    }
//    _btnArr=[NSMutableArray arrayWithCapacity:0];
//
    UIView *selectView=[UIView new];
    [_headView addSubview:selectView];
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gongNeiView.mas_bottom).mas_equalTo(10);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    selectView.backgroundColor=[UIColor whiteColor];
//    for (int i=0; i<3; i++) {
//        UIButton *btn=[UIButton new];
//        [selectView addSubview:btn];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_mainW/3*i);
//            make.width.mas_equalTo(_mainW/3);
//            make.height.mas_equalTo(50);
//            make.top.mas_equalTo(0);
//        }];
//        [btn setTitle:_btnNameArr[i] forState:0];
//        [btn setTitleColor:ColorWithRGB(49, 49, 49) forState:0];
//        [btn setImage:[UIImage imageNamed:@"arrow-left-black"] forState:0];
//        btn.titleLabel.font=[UIFont systemFontOfSize:16];
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView.bounds.size.width+2, 0, btn.imageView.bounds.size.width);
//        // button图片的偏移量
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width);
//        [_btnNameArr addObject:btn];
//   }
    
    UIImageView *addressImage=[UIImageView new];
    [selectView addSubview:addressImage];
    [addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.height.width.mas_equalTo(15);
    }];
    addressImage.image=[UIImage imageNamed:@"home-location"];
    
    UILabel *addressLabel=[UILabel new];
    [selectView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressImage.mas_right).mas_equalTo(8);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(addressImage);
    }];
    addressLabel.text=@"当前:重庆市重庆市渝中区";
    addressLabel.textColor=ColorWithRGB(49, 49, 49);
    addressLabel.font=[UIFont systemFontOfSize:14];
    
    UIView *xianView=[UIView new];
    [_headView addSubview:xianView];
    [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(selectView.mas_bottom);
    }];
    xianView.backgroundColor=_LightGrey;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    homeCell *cell=[[homeCell alloc] init];
    cell.dic=_tableArr[indexPath.row];
    [cell ceatView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=_tableArr[indexPath.row];
    detailsViewController *details=[[detailsViewController alloc] init];
    details.shop_id=[dic objectForKey:@"shop_id"];
    [ZQTools pushNextViewController:self.viewController andRootController:details];
}
@end
