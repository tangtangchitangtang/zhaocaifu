//
//  myView.m
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "myView.h"
#import "securityViewController.h"
#import <AlipaySDK/AlipaySDK.h>
@implementation myView

-(void)creatView{
    _scrollView=[UIScrollView new];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    _scrollView.scrollsToTop =NO;
    
    _scrollView.showsVerticalScrollIndicator = FALSE;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(0,720);
    UIView *topView=[UIView new];
    [_scrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(_mainW);
        make.height.mas_equalTo(180);
    }];
    [self creaTopView:topView];
    
    UIView *VIPView=[UIView new];
    [_scrollView addSubview:VIPView];
    [VIPView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(topView);
        make.top.mas_equalTo(topView.mas_bottom);
        make.height.mas_equalTo(280);
    }];
    [self creatVipView:VIPView];
    
    UIView *bottomView=[UIView new];
    [_scrollView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(VIPView.mas_bottom);
        make.left.right.mas_equalTo(topView);
        make.height.mas_equalTo(203);
    }];
    [self cratBottom:bottomView];
   

}
-(void)creaTopView:(UIView *)topView{
    UIImageView *beiJing=[UIImageView new];
    [topView addSubview:beiJing];
    [beiJing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.top.mas_equalTo(0);
    }];
    beiJing.image=[UIImage imageNamed:@"矩形1拷贝"];

    UIImageView *userImage=[UIImageView new];
    [topView addSubview:userImage];
    [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(60);
    }];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=30;
//    userImage.backgroundColor=[UIColor whiteColor];
//    [userImage sd_setImageWithURL:nil];
    userImage.image=[UIImage imageNamed:@"mine-photo"];
    
    UILabel *nameLabel=[UILabel new];
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(userImage.mas_bottom).mas_equalTo(10);
        make.width.mas_equalTo(_mainW-30);
    }];
    nameLabel.text=@"124235364789";
    nameLabel.font=[UIFont systemFontOfSize:25];
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.textAlignment=NSTextAlignmentCenter;

    
    UILabel *phoneLabel=[UILabel new];
    [topView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(nameLabel.mas_bottom).mas_equalTo(10);
        make.width.mas_equalTo(130);
    }];
    phoneLabel.textColor=[UIColor whiteColor];
    phoneLabel.font=[UIFont systemFontOfSize:20];
    phoneLabel.text=@"18183128005";
    phoneLabel.textAlignment=NSTextAlignmentCenter;
    
    UIImageView *phoneImage=[UIImageView new];
    [topView addSubview:phoneImage];
    [phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(phoneLabel.mas_left).mas_equalTo(-7);
        make.centerY.mas_equalTo(phoneLabel);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(10);
    }];
    phoneImage.image=[UIImage imageNamed:@"mine-phone"];
}
-(void)creatVipView:(UIView *)VIPView{
    UIImageView *imageView=[UIImageView new];
    [VIPView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(200);
    }];
    imageView.image=[UIImage imageNamed:@"mine-card-1"];
    
    UIImageView *logoImage=[UIImageView new];
    [imageView addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(25);
        make.width.height.mas_equalTo(40);
    }];
    logoImage.image=[UIImage imageNamed:@"mine-card-logo"];
    
    UILabel *nameLabel=[UILabel new];
    [imageView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoImage.mas_right).mas_equalTo(5);
        make.top.mas_equalTo(20);
    }];
    nameLabel.text=@"昭财富会员卡";
    nameLabel.font=[UIFont systemFontOfSize:25];
    nameLabel.textColor=ColorWithRGB(184, 141, 63);
    
    UILabel *numLabel=[UILabel new];
    [imageView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.bottom.mas_equalTo(logoImage.mas_bottom).mas_equalTo(2);
    }];
    numLabel.text=@"NO.12343256";
    numLabel.textColor=ColorWithRGB(184, 141, 63);
    numLabel.font=[UIFont systemFontOfSize:15];
    
    UILabel *VIPLabel=[UILabel new];
    [imageView addSubview:VIPLabel];
    [VIPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(logoImage);
    }];
    VIPLabel.text=@"VIP";
    VIPLabel.textColor=ColorWithRGB(184, 141, 63);
    VIPLabel.font=[UIFont systemFontOfSize:30];
    
    UIImageView *moneyImage=[UIImageView new];
    [imageView addSubview:moneyImage];
    [moneyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoImage);
        make.bottom.mas_equalTo(-15);
        make.width.height.mas_equalTo(30);
    }];
    moneyImage.image=[UIImage imageNamed:@"mine-card-money"];
    
    UILabel *moneyLabel=[UILabel new];
    [imageView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.centerY.mas_equalTo(moneyImage);
    }];
    moneyLabel.textColor=[UIColor whiteColor];
    moneyLabel.font=[UIFont systemFontOfSize:20];
    moneyLabel.text=@"余额:¥1000.0";
    
    UIButton *btn=[UIButton new];
    [imageView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(VIPLabel);
        make.centerY.mas_equalTo(moneyImage);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    imageView.userInteractionEnabled=YES;
    [btn setTitle:@"充值" forState:0];
    [btn setTitleColor:ColorWithRGB(184, 141, 63) forState:0];
    btn.backgroundColor=[UIColor whiteColor];
    btn.titleLabel.font=[UIFont systemFontOfSize:20];
    [btn addTarget:self action:@selector(zhiFu) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *jiLuView=[UIView new];
    [VIPView addSubview:jiLuView];
    [jiLuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom);
        make.width.mas_equalTo(_mainW/3);
    }];
    
    UILabel *jiLuLabel=[UILabel new];
    [jiLuView addSubview:jiLuLabel];
    [jiLuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    jiLuLabel.text=@"充值记录";
    jiLuLabel.textColor=ColorWithRGB(49, 49, 49);
    jiLuLabel.font=[UIFont systemFontOfSize:15];
    
    
    UILabel *chaKanLabel=[UILabel new];
    [jiLuView addSubview:chaKanLabel];
    [chaKanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(jiLuLabel.mas_bottom).mas_equalTo(10);
    }];
    chaKanLabel.textColor=_backgroundColor;
    chaKanLabel.font=[UIFont systemFontOfSize:18];
    chaKanLabel.text=@"查看";
    
    
    UIView *jiFenView=[UIView new];
    [VIPView addSubview:jiFenView];
    [jiFenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom);
        make.width.mas_equalTo(_mainW/3);
    }];
    
    UILabel *jiFenLabel=[UILabel new];
    [jiFenView addSubview:jiFenLabel];
    [jiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    jiFenLabel.text=@"我的积分";
    jiFenLabel.textColor=ColorWithRGB(49, 49, 49);
    jiFenLabel.font=[UIFont systemFontOfSize:15];
    
    
    UILabel *jiFenLabel2=[UILabel new];
    [jiFenView addSubview:jiFenLabel2];
    [jiFenLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(jiLuLabel.mas_bottom).mas_equalTo(10);
    }];
    jiFenLabel2.textColor=_backgroundColor;
    jiFenLabel2.font=[UIFont systemFontOfSize:18];
    jiFenLabel2.text=@"0.00";
    
    
    UIView *dengJiView=[UIView new];
    [VIPView addSubview:dengJiView];
    [dengJiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom);
        make.width.mas_equalTo(_mainW/3);
    }];
    
    UILabel *dengJiLabel=[UILabel new];
    [dengJiView addSubview:dengJiLabel];
    [dengJiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    dengJiLabel.text=@"我的等级";
    dengJiLabel.textColor=ColorWithRGB(49, 49, 49);
    dengJiLabel.font=[UIFont systemFontOfSize:15];
    
    
    UILabel *dengJiLabel2=[UILabel new];
    [dengJiView addSubview:dengJiLabel2];
    [dengJiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(jiLuLabel.mas_bottom).mas_equalTo(10);
    }];
    dengJiLabel2.textColor=_backgroundColor;
    dengJiLabel2.font=[UIFont systemFontOfSize:18];
    dengJiLabel2.text=@"普通会员";
}

-(void)cratBottom:(UIView *)bottomView{
    NSArray *Arr=[NSArray arrayWithObjects:@"申请管理",@"实名认证",@"安全设置",@"意见反馈", nil];
    for (int i=0; i<4; i++) {
        UIView *beiJingView=[UIView new];
        [bottomView addSubview:beiJingView];
        [beiJingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo((50+1)*i);
            make.height.mas_equalTo(50);
        }];
        beiJingView.tag=i;
//        beiJingView.backgroundColor=[UIColor redColor]; 
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnQuan:)];
        [beiJingView addGestureRecognizer:tapGesture];
        

        if (i!=3) {
            UIView *xianView=[UIView new];
            [bottomView addSubview:xianView];
            [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.mas_equalTo(0);
                make.top.mas_equalTo(beiJingView.mas_bottom);
                make.height.mas_equalTo(1);
            }];
            xianView.backgroundColor=_LightGrey;
        }

        UILabel *label=[UILabel new];
        [beiJingView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        label.font=[UIFont systemFontOfSize:16];
        label.text=Arr[i];
        label.textColor=ColorWithRGB(49, 49, 49);

        UIImageView *jianTou=[UIImageView new];
        [beiJingView addSubview:jianTou];
        [jianTou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(15);
        }];
        jianTou.image=[UIImage imageNamed:@"iconfont-fanhui-拷贝-3"];
    }
}
-(void)pushToAnQuan:(UITapGestureRecognizer *)tap{
    int tag=(int)tap.view.tag;
    if (tag==2) {
        securityViewController *security=[[securityViewController alloc] init];
        [ZQTools pushNextViewController:self.viewController andRootController:security];
    }
    
}
-(void)zhiFu{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"buy_type",@"1",@"vip_id",@"123",@"user_id", nil];
    [ZQTools AFNPostDataUrl:@"app/alipay/createOrder" Dict:dic andTableView:nil andView:self andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self diaoZhiFuBao:responseObject];
    } anderrorBlock:nil];
    
}
-(void)diaoZhiFuBao:(NSString *)order{
    

    
    NSString *appScheme = @"alisdkPaydemo";
    [[AlipaySDK defaultService] payOrder:order fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"]intValue] == 9000) {
        
        } else {
            [ZQTools svpInfo:@"支付失败"];
        }
    }];
}
@end
