
//
//  dinDanXaingQingView.m
//  qmzk
//
//  Created by tangtangchitangtang on 2017/6/27.
//  Copyright © 2017年 www.fuyuan.qmzk. All rights reserved.
//

#import "dinDanXaingQingView.h"
@implementation dinDanXaingQingView


-(void)creatView1{
    _scorl=@5;
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

    
    self.backgroundColor=_LightGrey;
    UIView *topView=[UIView new];
    [_scrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(_mainW);
        make.height.mas_equalTo(90);
    }];
    topView.backgroundColor=[UIColor whiteColor];
    [self creatTopView:topView];
    
    UIView *xiangXiView=[UIView new];
    [_scrollView addSubview:xiangXiView];
    [xiangXiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(_mainW);
        make.height.mas_equalTo(212);
    }];
    xiangXiView.backgroundColor=[UIColor whiteColor];
    [self creatXiangXiView:xiangXiView];
    
    [self creatPingJia];


}
-(void)creatTopView:(UIView *)view{
    
    UIImageView *imageView=[UIImageView new];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(75);
    }];
    NSString *img=[_tableDic objectForKey:@"shopLogo"];
    NSURL *rul=[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",_imageUrl,img]];
    [imageView sd_setImageWithURL:rul];
    
    UILabel *titileLabel=[UILabel new];
    [view addSubview:titileLabel];
    [titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView);
        make.left.mas_equalTo(imageView.mas_right).mas_equalTo(15);
    }];
    NSString *goodsName=[_tableDic objectForKey:@"shopName"];
    if ([ZQTools charIsNil:goodsName]) {
        goodsName=@"";
    }
    titileLabel.text=goodsName;
    
    titileLabel.font=[UIFont fontWithName:@"Helvetica" size:17];
    titileLabel.textColor=ColorWithRGB(10, 10, 10);
    
    UILabel *pingFenAndDiZhi=[UILabel new];
    [view addSubview:pingFenAndDiZhi];
    [pingFenAndDiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView);
        make.left.mas_equalTo(titileLabel);
        make.right.mas_equalTo(15);
    }];
    NSString *address=[_tableDic objectForKey:@"address"];
    pingFenAndDiZhi.text=address;
    pingFenAndDiZhi.font=[UIFont fontWithName:@"Helvetica" size:12];
    pingFenAndDiZhi.textColor=ColorWithRGB(150, 150, 150);
    
    UILabel *piceLabel=[UILabel new];
    [view addSubview:piceLabel];
    [piceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(imageView);
        make.left.mas_equalTo(pingFenAndDiZhi);
    }];
    NSNumber *price=[_tableDic objectForKey:@"totalMoney"];
    if ([ZQTools charIsNil:[NSString stringWithFormat:@"%@",price]]) {
        price=0;
    }
    
    piceLabel.text=[NSString stringWithFormat:@"¥%@",price];
    piceLabel.font=[UIFont fontWithName:@"Helvetica" size:17];
    piceLabel.textColor=ColorWithRGB(255, 37, 78);
    
    
}
-(void)creatXiangXiView:(UIView *)view{
    UIView *xiangXiView=[UIView new];
    [view addSubview:xiangXiView];
    [xiangXiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *xiangLabel=[UILabel new];
    [xiangXiView addSubview:xiangLabel];
    [xiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
    }];
    xiangLabel.text=@"订单明细";
    xiangLabel.font=[UIFont fontWithName:@"Helvetica" size:16];
    xiangLabel.textColor=ColorWithRGB(150, 150, 150);
    
    UILabel *XianLabel=[UILabel new];
    [view addSubview:XianLabel];
    [XianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(xiangXiView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    XianLabel.backgroundColor=_LightGrey;
    
    UILabel *biaoHaoLabel=[UILabel new];
    [view addSubview:biaoHaoLabel];
    [biaoHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(XianLabel.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(xiangLabel);
        make.height.mas_equalTo(20);
    }];
    
    biaoHaoLabel.text=@"订单编号";
    biaoHaoLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
    biaoHaoLabel.textColor=ColorWithRGB(50, 50, 50);
    
    UILabel *bianHaoLabel2=[UILabel new];
    [view addSubview:bianHaoLabel2];
    [bianHaoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(biaoHaoLabel);
        make.right.mas_equalTo(-15);
    }];
    NSString *orderNum=[_tableDic objectForKey:@"order_num"];
    bianHaoLabel2.text=orderNum;
    bianHaoLabel2.font=[UIFont fontWithName:@"Helvetica" size:13];
    bianHaoLabel2.textColor=ColorWithRGB(50, 50, 50);
    
    UILabel *timeLabel=[UILabel new];
    [view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(biaoHaoLabel.mas_bottom).mas_equalTo(9);
        make.left.mas_equalTo(xiangLabel);
        make.height.mas_equalTo(20);
    }];
    timeLabel.text=@"下单时间";
    timeLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
    timeLabel.textColor=ColorWithRGB(50, 50, 50);
    
    UILabel *timeLabel2=[UILabel new];
    [view addSubview:timeLabel2];
    [timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(timeLabel);
        make.right.mas_equalTo(-15);
    }];
    NSString *createTime=[_tableDic objectForKey:@"addTime"];
   
    timeLabel2.text=[createTime substringToIndex:createTime.length-2];
    timeLabel2.font=[UIFont fontWithName:@"Helvetica" size:13];
    timeLabel2.textColor=ColorWithRGB(50, 50, 50);
    
    UILabel *phoneLabel=[UILabel new];
    [view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_equalTo(9);
        make.left.mas_equalTo(xiangLabel);
        make.height.mas_equalTo(20);
    }];
    phoneLabel.text=@"手机号";
    phoneLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
    phoneLabel.textColor=ColorWithRGB(50, 50, 50);
    
    UILabel *phoneLabel2=[UILabel new];
    [view addSubview:phoneLabel2];
    [phoneLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneLabel);
        make.right.mas_equalTo(-15);
    }];
    
    NSString *mobilePhone=[_tableDic objectForKey:@"phone"];
   
    phoneLabel2.text=[ZQTools PhoneModel:mobilePhone];
    
    phoneLabel2.font=[UIFont fontWithName:@"Helvetica" size:13];
    phoneLabel2.textColor=ColorWithRGB(50, 50, 50);

    
    UILabel *allPiceLabel=[UILabel new];
    [view addSubview:allPiceLabel];
    [allPiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).mas_equalTo(9);
        make.left.mas_equalTo(phoneLabel);
        make.height.mas_equalTo(20);
    }];
    allPiceLabel.text=@"总价";
    allPiceLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
    allPiceLabel.textColor=ColorWithRGB(50, 50, 50);
    
    UILabel *allPiceLabel2=[UILabel new];
    [view addSubview:allPiceLabel2];
    [allPiceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(allPiceLabel);
        make.right.mas_equalTo(-15);
    }];
    NSString *discountPrice=[_tableDic objectForKey:@"totalMoney"];
    allPiceLabel2.text=[NSString stringWithFormat:@"¥%@",discountPrice];
    allPiceLabel2.font=[UIFont fontWithName:@"Helvetica" size:13];
    allPiceLabel2.textColor=ColorWithRGB(50, 50, 50);
    UILabel *xianLabel2=[UILabel new];
    [view addSubview:xianLabel2];
    [xianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(allPiceLabel2.mas_bottom).mas_equalTo(9);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    xianLabel2.backgroundColor=_LightGrey;

    UIView *fuKuanView=[UIView new];
    [view addSubview:fuKuanView];
    [fuKuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(xianLabel2.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];

    UILabel *fuKuanLable=[UILabel new];
    [fuKuanView addSubview:fuKuanLable];
    [fuKuanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
    fuKuanLable.text=[NSString stringWithFormat:@"已付款: ¥%@",discountPrice];
    fuKuanLable.font=[UIFont fontWithName:@"Helvetica" size:16];
    fuKuanLable.textColor=ColorWithRGB(50, 50, 50);
}

-(void)creatPingJia{
    
    NSDictionary *comment=[_tableDic objectForKey:@"comment"];
    NSNumber *status=[_tableDic objectForKey:@"status"];
    
    
    NSNumber *grade;
    NSString *content;
    
    NSString *replyContent;
    
    CGSize size=[ZQTools getNSStringSize:content andViewWight:_mainW-40 andFont:14];
    CGSize size2=[ZQTools getNSStringSize:replyContent andViewWight:_mainW-40 andFont:14];
    
    if (status.intValue==2) {
        grade=[comment objectForKey:@"grade"];
        content=[comment objectForKey:@"content"];
       
        size=[ZQTools getNSStringSize:content andViewWight:_mainW-40 andFont:14];
        NSNumber *status1=[comment objectForKey:@"status"];
        if (status1.intValue==1) {
            replyContent=[comment objectForKey:@"replyContent"];
            size2=[ZQTools getNSStringSize:replyContent andViewWight:_mainW-40 andFont:14];
        }
    }
    
    UIView *pingJiaView=[UIView new];
    [_scrollView addSubview:pingJiaView];
    [pingJiaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(380);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(_mainW);
        if (status.intValue==2) {
            make.height.mas_equalTo(110+size.height+size2.height);
        }
        else{
             make.height.mas_equalTo(250);
        }
    }];
    pingJiaView.backgroundColor=[UIColor whiteColor];
    
    UIView *xiangXiView=[UIView new];
    [pingJiaView addSubview:xiangXiView];
    [xiangXiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *xiangLabel=[UILabel new];
    [xiangXiView addSubview:xiangLabel];
    [xiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
    }];
    xiangLabel.text=@"订单明细";
    xiangLabel.font=[UIFont fontWithName:@"Helvetica" size:16];
    xiangLabel.textColor=ColorWithRGB(150, 150, 150);
    
    UILabel *XianLabel=[UILabel new];
    [pingJiaView addSubview:XianLabel];
    [XianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(xiangXiView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    XianLabel.backgroundColor=_LightGrey;
    
    
    
    
    if (status.intValue==2) {
       
        
        int index=grade.floatValue+0.5;
        
        UILabel *gradeLabel=[UILabel new];
        [pingJiaView addSubview:gradeLabel];
        [gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(xiangLabel);
            make.top.mas_equalTo(XianLabel.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(60);
        }];
        gradeLabel.text=@"评分:";
        gradeLabel.font=[UIFont fontWithName:@"Helvetica" size:16];
        gradeLabel.textColor=ColorWithRGB(50, 50, 50);
        
        for (int i=0; i<index; i++) {
            UIImageView *xingImage=[UIImageView new];
            [self addSubview:xingImage];
            [xingImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(gradeLabel.mas_right).mas_equalTo(23*i+6);
                make.height.width.mas_equalTo(18);
                make.centerY.mas_equalTo(gradeLabel);
            }];
            xingImage.image=[UIImage imageNamed:@"home-star1"];
        }
        
        UILabel *gradeLabel2=[UILabel new];
        [pingJiaView addSubview:gradeLabel2];
        [gradeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(gradeLabel.mas_right).mas_equalTo(23*index+10);
            make.centerY.mas_equalTo(gradeLabel);
            make.width.mas_equalTo(60);
        }];
        gradeLabel2.text=[NSString stringWithFormat:@"%@分",grade];
        gradeLabel2.font=[UIFont fontWithName:@"Helvetica" size:16];
        gradeLabel2.textColor=[UIColor orangeColor];
        
        UILabel *contentLabel=[UILabel new];
        [pingJiaView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(xiangLabel);
            make.top.mas_equalTo(gradeLabel.mas_bottom).mas_equalTo(10);
            make.right.mas_equalTo(-15);
        }];
        contentLabel.text=content;
        contentLabel.font=[UIFont systemFontOfSize:14];
        contentLabel.textColor=ColorWithRGB(49, 49, 49);
        
        UILabel *replyContentLabel=[UILabel new];
        [pingJiaView addSubview:replyContentLabel];
        [replyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(xiangLabel);
            make.top.mas_equalTo(contentLabel.mas_bottom).mas_equalTo(10);
            make.right.mas_equalTo(-15);
        }];
        replyContentLabel.text=replyContent;
        replyContentLabel.font=[UIFont systemFontOfSize:14];
        replyContentLabel.textColor=ColorWithRGB(49, 49, 49);
        _scrollView.contentSize = CGSizeMake(0,490+size2.height+size.height);
    }
    else{
        UILabel *gradeLabel=[UILabel new];
        [pingJiaView addSubview:gradeLabel];
        [gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(xiangLabel);
            make.top.mas_equalTo(XianLabel.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(60);
        }];
        gradeLabel.text=@"评分:";
        gradeLabel.font=[UIFont fontWithName:@"Helvetica" size:16];
        gradeLabel.textColor=ColorWithRGB(50, 50, 50);
     
        _btnArr=[NSMutableArray arrayWithCapacity:0];
        
        for (int i=0; i<5; i++) {
            UIButton *xing=[UIButton new];
            [pingJiaView addSubview:xing];
            [xing mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(gradeLabel);
                make.left.mas_equalTo(gradeLabel.mas_right).mas_equalTo(23*i+6);
                make.width.height.mas_equalTo(20);
            }];
            xing.tag=i+1;
            [xing setImage:[UIImage imageNamed:@"home-star1"] forState:0];
            [xing addTarget:self action:@selector(Xing:) forControlEvents:UIControlEventAllEvents];
            [_btnArr addObject:xing];
        }
        
       
        _scorLabel=[UILabel new];
        [pingJiaView addSubview:_scorLabel];
        [_scorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(gradeLabel.mas_right).mas_equalTo(23*5+10);
            make.centerY.mas_equalTo(gradeLabel);
            make.width.mas_equalTo(60);
        }];
        _scorLabel.text=@"5分";
        _scorLabel.font=[UIFont fontWithName:@"Helvetica" size:16];
        _scorLabel.textColor=[UIColor orangeColor];
        
        _textView=[UITextView new];
        [pingJiaView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(gradeLabel.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(100);
        }];
        _textView.layer.borderColor=_LightGrey.CGColor;
        _textView.layer.borderWidth=1;
        _textView.returnKeyType=UIReturnKeyDone;
        _textView.delegate=self;
        _textView.text=@"请输入你的评价";
        _textView.backgroundColor=ColorWithRGB(220, 220, 220);
        _textView.font=[UIFont systemFontOfSize:15];
        
        UIButton *tiJiao=[UIButton new];
        [pingJiaView addSubview:tiJiao];
        [tiJiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_textView.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(40);
        }];
        tiJiao.backgroundColor=ColorWithRGB(213, 78, 81);
        [tiJiao setTitle:@"提交" forState:0];
        [tiJiao setTitleColor:[UIColor whiteColor] forState:0];
        tiJiao.layer.cornerRadius=3;
        [tiJiao addTarget:self action:@selector(tiJiao:) forControlEvents:UIControlEventTouchUpInside];
        _scrollView.contentSize = CGSizeMake(0,650);
    }
}
-(IBAction)tiJiao:(UIButton *)sender{
    NSString *user_id=[_tableDic objectForKey:@"user_id"];
    NSString *order_id=[_tableDic objectForKey:@"order_id"];
    NSString *content=_textView.text;
    if ([content isEqualToString:@"请输入你的评价"]) {
        [ZQTools svpInfo:@"请输入你的评价"];
        return;
    }
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:user_id,@"user_id",order_id,@"order_id",content,@"content",_scorl,@"grade", nil];
    [ZQTools AFNPostDataUrl:@"app/orderComment" Dict:dic andTableView:nil andView:self andSuccessBlock:^(id responseObject) {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    } anderrorBlock:nil];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入你的评价"]) {
        textView.text=@"";
    }
    textView.textColor=ColorWithRGB(50, 50, 50);
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text=@"请输入你的评价";
    }
    textView.textColor=ColorWithRGB(150, 150, 150);
    
}

-(IBAction)Xing:(UIButton *)xing{
    int tag=(int)xing.tag;
    _scorl=[NSNumber numberWithInt:tag];
    for (int i=0; i<_btnArr.count; i++) {
        UIButton *btn=_btnArr[i];
        if (i<tag) {
            [btn setImage:[UIImage imageNamed:@"home-star1"] forState:0];

        }
        else{
            [btn setImage:[UIImage imageNamed:@"星评拷贝4"] forState:0];
        }
        
    }
    
    _scorLabel.text=[NSString stringWithFormat:@"%d分",tag];

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        
        [_textView resignFirstResponder];        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    if ((textView.text.length - range.length + text.length) > 200)
    {
        NSString *substring = [text substringToIndex:200 - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        return NO;
    }
    else
    {
        return YES;
    }
}




@end
