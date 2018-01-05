
//
//  orderTableViewCell.m
//  DJS
//
//  Created by 浪尖渝力 on 2018/1/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "orderTableViewCell.h"

@implementation orderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)creatView{
   
    
    UIImageView *logImage=[UIImageView new];
    [self addSubview:logImage];
    [logImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.height.width.mas_equalTo(50);
    }];
    NSString *shopLogo=[_dic objectForKey:@"shopLogo"];
    NSURL *logoUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",_imageUrl,shopLogo]];
    [logImage sd_setImageWithURL:logoUrl];
    
    UILabel *tiltleLabel=[UILabel new];
    [self addSubview:tiltleLabel];
    [tiltleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logImage.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(-100);
        make.top.mas_equalTo(logImage);
    }];
    tiltleLabel.text=[_dic objectForKey:@"shopName"];
    tiltleLabel.font=[UIFont systemFontOfSize:16];
    tiltleLabel.textColor=ColorWithRGB(49, 49, 49);
    
    NSNumber *status=[_dic objectForKey:@"status"];
    UILabel *statusLabel=[UILabel new];
    [self addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(tiltleLabel);
    }];
    statusLabel.font=[UIFont systemFontOfSize:18];
    statusLabel.textColor=ColorWithRGB(189, 74, 59);
    if (status.intValue==2) {
        statusLabel.text=@"已完成";
    }
    else{
        statusLabel.text=@"待评价";
    }
    

    NSString *addTime=[_dic objectForKey:@"addTime"];
    
    UILabel *timeLabel=[UILabel new];
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(tiltleLabel);
        make.top.mas_equalTo(tiltleLabel.mas_bottom).mas_equalTo(10);
    }];
    timeLabel.text=[NSString stringWithFormat:@"时间:%@",[addTime substringToIndex:addTime.length-2]];
    timeLabel.font=[UIFont systemFontOfSize:15];
    timeLabel.textColor=ColorWithRGB(149, 149, 149);
    
    
    UILabel *priceLabel=[UILabel new];
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(tiltleLabel);
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_equalTo(5);
    }];
    NSString *totalMoney=[_dic objectForKey:@"totalMoney"];
    priceLabel.text=[NSString stringWithFormat:@"价格:%@",totalMoney];
    priceLabel.font=[UIFont systemFontOfSize:15];
    priceLabel.textColor=ColorWithRGB(149, 149, 149);
    
    
    UILabel *numLabel=[UILabel new];
    [self addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(priceLabel);
        make.top.mas_equalTo(priceLabel.mas_bottom).mas_equalTo(5);
    }];
    NSString *order_num=[_dic objectForKey:@"order_num"];
    numLabel.text=[NSString stringWithFormat:@"价格:%@",order_num];
    numLabel.font=[UIFont systemFontOfSize:15];
    numLabel.textColor=ColorWithRGB(149, 149, 149);

}

@end
