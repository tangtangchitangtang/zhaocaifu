//
//  LoginView.m
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "LoginView.h"
#import "registerViewController.h"

@implementation LoginView
-(void)creatView{
 
    UIImageView *phoneImage=[UIImageView new];
    [self addSubview:phoneImage];
    [phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(140);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(27);;
    }];
    phoneImage.image=[UIImage imageNamed:@"账号"];
    
    _phoneText=[UITextField new];
    [self addSubview:_phoneText];
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneImage.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(phoneImage);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-10);
    }];
    _phoneText.delegate=self;
    _phoneText.placeholder=@"请输入账号";
    _phoneText.textColor=ColorWithRGB(49, 49, 49);
    _phoneText.font=[UIFont systemFontOfSize:19];
    _phoneText.returnKeyType=UIReturnKeyDone;
    _phoneText.keyboardType=UIKeyboardTypePhonePad;
    
    UIView *xianView=[UIView new];
    [self addSubview:xianView];
    [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneText.mas_bottom).mas_equalTo(10);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(1);
    }];
    xianView.backgroundColor=_LightGrey;
    
    
    UIImageView *pwdImage=[UIImageView new];
    [self addSubview:pwdImage];
    [pwdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(xianView.mas_bottom).mas_equalTo(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(27);
    }];
    pwdImage.image=[UIImage imageNamed:@"密码"];
    
    _pwdText=[UITextField new];
    [self addSubview:_pwdText];
    [_pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(pwdImage.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(pwdImage);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-10);
    }];
    _pwdText.placeholder=@"请输入密码";
    _pwdText.textColor=ColorWithRGB(49, 49, 49);
    _pwdText.font=[UIFont systemFontOfSize:19];
    _pwdText.keyboardType=UIKeyboardTypeDefault;
    _pwdText.delegate=self;
    _pwdText.secureTextEntry=YES;//密文
    _pwdText.returnKeyType=UIReturnKeyDone;


    UIView *xianView2=[UIView new];
    [self addSubview:xianView2];
    [xianView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdText.mas_bottom).mas_equalTo(10);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(1);
    }];
    xianView2.backgroundColor=_LightGrey;
    
    
    UILabel *wangJiLabel=[UILabel new];
    [self addSubview:wangJiLabel];
    [wangJiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(xianView2.mas_bottom).mas_equalTo(25);
    }];
    wangJiLabel.text=@"忘记密码？";
    wangJiLabel.textColor=ColorWithRGB(216 , 146, 51);
    wangJiLabel.font=[UIFont systemFontOfSize:16];
    wangJiLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToForget:)];
    [wangJiLabel addGestureRecognizer:tapGesture];
    
    UILabel *zuCheLabel=[UILabel new];
    [self addSubview:zuCheLabel];
    [zuCheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(wangJiLabel);
    }];
    zuCheLabel.textColor=ColorWithRGB(216 , 146, 51);
    zuCheLabel.text=@"立即注册";
    zuCheLabel.font=[UIFont systemFontOfSize:16];
    
    zuCheLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToRegister:)];
    [zuCheLabel addGestureRecognizer:tapGesture2];


    UIButton *loginBtn=[UIButton new];
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(zuCheLabel.mas_bottom).mas_equalTo(40);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(xianView2);
    }];
    loginBtn.layer.cornerRadius=25;
    loginBtn.backgroundColor=ColorWithRGB(216 , 146, 51);
    [loginBtn setTitle:@"登录" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    [loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];

}

-(IBAction)loginBtn:(UIButton *)btn{
    NSString *waiter_phone=_phoneText.text;
    NSString *waiter_pass=_pwdText.text;
    
//    if (![ZQTools isMobileNumber:waiter_phone]) {
//        [ZQTools svpInfo:@"手机号有误"];
//        return;
//    }
//    if ([ZQTools charIsNil:waiter_pass]||waiter_pass.length<6||waiter_pass.length>16) {
//        [ZQTools svpInfo:@"密码必须是6到16位字符组成"];
//        return;
//    }
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:waiter_phone,@"userName",waiter_pass,@"passWord", nil];
    [ZQTools AFNPostDataUrl:@"app/login" Dict:dic andTableView:nil andView:self andSuccessBlock:^(id responseObject) {
        [NSKeyedArchiver archiveRootObject:responseObject toFile:_userModelFile];
        [self.viewController.navigationController popViewControllerAnimated:YES];
    } anderrorBlock:nil];
    
}

-(void)pushToRegister:(UITapGestureRecognizer *)tap{
    registerViewController *registerView=[[registerViewController alloc] init];
    [ZQTools pushNextViewController:self.viewController andRootController:registerView];
}
-(void)pushToForget:(UITapGestureRecognizer *)tap{
//    forgetViewController *registerView=[[forgetViewController alloc] init];
//    [ZQTools pushNextViewController:self.viewController andRootController:registerView];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
