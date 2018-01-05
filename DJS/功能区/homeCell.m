//
//  homeCell.m
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "homeCell.h"

@implementation homeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(void)ceatView{
    UIImageView *image=[UIImageView new];
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(75);
    }];
    NSString *shopLogo=[_dic objectForKey:@"shopLogo"];
    
    shopLogo=[NSString stringWithFormat:@"%@/%@",_imageUrl,shopLogo];
    [image sd_setImageWithURL:[NSURL URLWithString:shopLogo]];
    
    UILabel *tiltLabel=[UILabel new];
    [self addSubview:tiltLabel];
    [tiltLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(image.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(image);
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
    [self addSubview:preceLabel];
    [preceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tiltLabel.mas_left).mas_equalTo(23*index+5);
        make.top.mas_equalTo(tiltLabel.mas_bottom).mas_equalTo(5);
        make.height.mas_equalTo(20);
    }];
    NSNumber *money=[_dic objectForKey:@"money"];
    preceLabel.text=[NSString stringWithFormat:@"¥%@/人",money];
    preceLabel.textColor=ColorWithRGB(149, 149, 149);
    preceLabel.font=[UIFont systemFontOfSize:14];
    
    
    UILabel *juLiLabel=[UILabel new];
    [self addSubview:juLiLabel];
    [juLiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(preceLabel);
    }];
    NSNumber *juli=[_dic objectForKey:@"juli"];
    juLiLabel.text=[NSString stringWithFormat:@"%@km",juli];
    juLiLabel.font=[UIFont systemFontOfSize:14];
    juLiLabel.textColor=ColorWithRGB(149, 149, 149);
    
    UILabel *nameLable=[UILabel new];
    [self addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(tiltLabel);
        make.top.mas_equalTo(preceLabel.mas_bottom).mas_equalTo(8);
    }];
    nameLable.textColor=ColorWithRGB(149, 149, 149);
    nameLable.text=[_dic objectForKey:@"shopDetail"];
    nameLable.font=[UIFont systemFontOfSize:14];
    
}

@end
