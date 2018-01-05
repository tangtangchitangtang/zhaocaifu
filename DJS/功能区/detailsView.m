//
//  detailsView.m
//  DJS
//
//  Created by 浪尖渝力 on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "detailsView.h"

@implementation detailsView

-(void)creatView{
    self.backgroundColor=_LightGrey;
    _scrollView=[UIScrollView new];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    _scrollView.scrollsToTop =NO;
    
    _scrollView.showsVerticalScrollIndicator = FALSE;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(0,720);
    UIView *bannerView=[UIView new];
    [_scrollView addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(_mainW);
    }];
    [self creatBanner:bannerView];
    
    UIView *centerView=[UIView new];
    [_scrollView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bannerView);
        make.top.mas_equalTo(bannerView.mas_bottom);
        make.height.mas_equalTo(110);
    }];
    centerView.backgroundColor=[UIColor whiteColor];
    [self creatCenterView:centerView];
    
    NSString *shopDetail=[_dic objectForKey:@"shopDetail"];
    
    CGSize size=[ZQTools getNSStringSize:shopDetail andViewWight:_mainW-40 andFont:15];
    
    UIView *bottomView=[UIView new];
    [_scrollView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(centerView);
        make.height.mas_equalTo(80+size.height);
        make.top.mas_equalTo(centerView.mas_bottom).mas_equalTo(10);
    }];
    [self creaBottomView:bottomView];
    _scrollView.contentSize = CGSizeMake(0,400+size.height);
}
-(void)creatBanner:(UIView *)bannerView{
    NSArray *bannerArr=[_dic objectForKey:@"lunboimg"];
    NSMutableArray *imageArr=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<bannerArr.count; i++) {
        NSDictionary *dic=bannerArr[i];
        NSString *imageStr=[dic objectForKey:@"IMGURL"];
        NSString *imageUrl=[NSString stringWithFormat:@"%@/uploadFiles/uploadImgs/%@",_addressUrl,imageStr];
        
        [imageArr addObject:imageUrl];
    }
    
    [ZQTools getHederImage:CGRectMake(0, 0, _mainW,  200) :imageArr :10 :bannerView :^(int value) {
        NSLog(@"%d",value);
    }];
}
-(void)creatCenterView:(UIView *)centerView{
    
    
    UILabel *tiltLabel=[UILabel new];
    [centerView addSubview:tiltLabel];
    [tiltLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    NSString *address=[_dic objectForKey:@"address"];
    NSString *shopName=[_dic objectForKey:@"shopName"];
    tiltLabel.text=[NSString stringWithFormat:@"%@(%@)",shopName,address];
    tiltLabel.font=[UIFont systemFontOfSize:18];
    tiltLabel.textColor=ColorWithRGB(29, 29, 29);
    
    NSNumber *avgGrade=[_dic objectForKey:@"avgGrade"];
    
    int index=avgGrade.floatValue+0.5;
    
    for (int i=0; i<index; i++) {
        UIImageView *xingImage=[UIImageView new];
        [self addSubview:xingImage];
        [xingImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tiltLabel.mas_left).mas_equalTo(23*i);
            make.height.width.mas_equalTo(18);
            make.top.mas_equalTo(tiltLabel.mas_bottom).mas_equalTo(5);
        }];
        xingImage.image=[UIImage imageNamed:@"home-star1"];
    }
    
    UILabel *preceLabel=[UILabel new];
    [centerView addSubview:preceLabel];
    [preceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tiltLabel.mas_left).mas_equalTo(23*index+5);
        make.top.mas_equalTo(tiltLabel.mas_bottom).mas_equalTo(5);
        make.height.mas_equalTo(20);
    }];
    NSNumber *money=[_dic objectForKey:@"money"];
    preceLabel.text=[NSString stringWithFormat:@"人均:¥%@",money];
    preceLabel.textColor=ColorWithRGB(149, 149, 149);
    preceLabel.font=[UIFont systemFontOfSize:14];
    
    UIView *xianView=[UIView new];
    [centerView addSubview:xianView];
    [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(preceLabel.mas_bottom).mas_equalTo(5);
        make.height.mas_equalTo(1);
    }];
    xianView.backgroundColor=_LightGrey;
    
    UIImageView *addressImage=[UIImageView new];
    [centerView addSubview:addressImage];
    [addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tiltLabel);
        make.top.mas_equalTo(xianView.mas_bottom).mas_equalTo(15);
        make.height.width.mas_equalTo(15);
    }];
    addressImage.image=[UIImage imageNamed:@"home-location"];
    
    
    CGSize size1=[ZQTools getNSStringWeight:address andViewWight:20 andFont:14];
    
    UILabel *addressLabel=[UILabel new];
    [centerView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addressImage);
        make.left.mas_equalTo(addressImage.mas_right).mas_equalTo(5);
        if (size1.width>_mainW-130) {
            make.width.mas_equalTo(_mainW-130);
        }
        else{
            make.width.mas_equalTo(size1.width+10);
        }
    }];
    addressLabel.text=address;
    addressLabel.font=[UIFont systemFontOfSize:14];
    addressLabel.textColor=ColorWithRGB(149, 149, 149);
    
    UIButton *phoneBtn=[UIButton new];
    [centerView addSubview:phoneBtn];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressLabel.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(addressLabel);
        make.width.height.mas_equalTo(25);
    }];
    [phoneBtn setImage:[UIImage imageNamed:@"电话"] forState:0];
    
}
-(void)creaBottomView:(UIView *)bottomView{
    bottomView.backgroundColor=[UIColor whiteColor];
    
    UILabel *tiltLabel=[UILabel new];
    [bottomView addSubview:tiltLabel];
    [tiltLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
 
    tiltLabel.text=@"店铺详情";
    tiltLabel.font=[UIFont systemFontOfSize:18];
    tiltLabel.textColor=ColorWithRGB(29, 29, 29);
    
    UIView *xianView=[UIView new];
    [bottomView addSubview:xianView];
    [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(45);
    }];
    xianView.backgroundColor=_LightGrey;
    
    UILabel *DetailLAbel=[UILabel new];
    [bottomView addSubview:DetailLAbel];
    [DetailLAbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(15);
        make.top.mas_equalTo(xianView.mas_bottom).mas_equalTo(15);
    }];
    DetailLAbel.text=[_dic objectForKey:@"shopDetail"];
    DetailLAbel.font=[UIFont systemFontOfSize:15];
    DetailLAbel.textColor=ColorWithRGB(49, 49, 49);
}

@end
