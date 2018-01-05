//
//  registerView.m
//  DJS
//
//  Created by 浪尖渝力 on 2018/1/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "registerView.h"

@implementation registerView

-(void)creatView{
    
    UIImageView *phoneImage=[UIImageView new];
    [self addSubview:phoneImage];
    [phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(140);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(27);
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
    _phoneText.placeholder=@"请输入昵称";
    _phoneText.textColor=ColorWithRGB(49, 49, 49);
    _phoneText.font=[UIFont systemFontOfSize:19];
    _phoneText.returnKeyType=UIReturnKeyDone;
//    _phoneText.keyboardType=UIKeyboardTypePhonePad;
    
    UIView *xianView=[UIView new];
    [self addSubview:xianView];
    [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneText.mas_bottom).mas_equalTo(10);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(1);
    }];
    xianView.backgroundColor=_LightGrey;
    
    
    UIImageView *codeImage=[UIImageView new];
    [self addSubview:codeImage];
    [codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(xianView.mas_bottom).mas_equalTo(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(27);
    }];
    codeImage.image=[UIImage imageNamed:@"手机号"];
    
    
//    _codeBtn=[UIButton new];
//    [self addSubview:_codeBtn];
//    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.width.mas_equalTo(-15);
//        make.height.mas_equalTo(35);
//        make.width.mas_equalTo(130);
//        make.centerY.mas_equalTo(codeImage);
//    }];
//    _codeBtn.layer.masksToBounds=YES;
//    _codeBtn.layer.cornerRadius=5;
//    _codeBtn.layer.borderWidth=1;
//    _codeBtn.layer.borderColor=ColorWithRGB(230, 230, 230).CGColor;
//    [_codeBtn setTitle:@"发送验证码" forState:0];
//    [_codeBtn setTitleColor:ColorWithRGB(49, 49, 49) forState:0];
//    _codeBtn.titleLabel.font=[UIFont systemFontOfSize:16];
//    [_codeBtn  addTarget:self action:@selector(huoQuYanZhen:) forControlEvents:UIControlEventTouchUpInside];
    
    _codeText=[UITextField new];
    [self addSubview:_codeText];
    [_codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeImage.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(codeImage);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-15);
    }];
    _codeText.delegate=self;
    _codeText.placeholder=@"请输入账号";
    _codeText.textColor=ColorWithRGB(49, 49, 49);
    _codeText.font=[UIFont systemFontOfSize:19];
    _codeText.returnKeyType=UIReturnKeyDone;
    _codeText.keyboardType=UIKeyboardTypePhonePad;
    
    UIView *xianView2=[UIView new];
    [self addSubview:xianView2];
    [xianView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeText.mas_bottom).mas_equalTo(10);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(1);
    }];
    xianView2.backgroundColor=_LightGrey;
    
    
    UIImageView *pwdImage=[UIImageView new];
    [self addSubview:pwdImage];
    [pwdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(xianView2.mas_bottom).mas_equalTo(10);
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
    
    
    UIView *xianView3=[UIView new];
    [self addSubview:xianView3];
    [xianView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdText.mas_bottom).mas_equalTo(10);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(1);
    }];
    xianView3.backgroundColor=_LightGrey;
    

    UIButton *loginBtn=[UIButton new];
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(xianView3.mas_bottom).mas_equalTo(40);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(xianView2);
    }];
    loginBtn.layer.cornerRadius=25;
    loginBtn.backgroundColor=ColorWithRGB(216 , 146, 51);
    [loginBtn setTitle:@"注册并登陆" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    [loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)loginBtn:(id)sender{
    NSString *userName=_codeText.text;
    NSString *passWord=_pwdText.text;
    NSString *nickName=_phoneText.text;
    
    if ([ZQTools charIsNil:nickName]) {
        [ZQTools svpInfo:@"昵称不能为空"];
        return;
    }
    if ([ZQTools charIsNil:userName]) {
        [ZQTools svpInfo:@"账号不能为空"];
        return;
    }
    if ([ZQTools charIsNil:passWord]) {
        [ZQTools svpInfo:@"密码不能为空"];
        return;
    }
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:userName,@"userName",passWord,@"passWord",nickName,@"nickName", nil];
    [ZQTools AFNPostDataUrl:@"app/register" Dict:dic andTableView:nil andView:self andSuccessBlock:^(id responseObject) {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    } anderrorBlock:nil];
    
}

-(IBAction)huoQuYanZhen:(UIButton *)sender{
    
    NSString *mobile=_phoneText.text;
    if (![ZQTools isMobileNumber:mobile]) {
        [ZQTools svpInfo:@"手机号错误"];
        return;
    }
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:mobile,@"phone",@"0",@"code_type",@"1",@"user_role", nil];
    [ZQTools AFNPostDataUrl:@"api/index/get_code" Dict:dic andTableView:nil andView:self andSuccessBlock:^(id responseObject) {
        _codeBtn.enabled=NO;
        _timeTick=60;
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        
        _codeText.text=[NSString stringWithFormat:@"%@",responseObject];
        
    } anderrorBlock:nil];
    
}

-(void)timeFireMethod
{
    if (_timeTick==0) {
        _codeBtn.enabled=YES;
        [_codeBtn setTitle:@"发送验证码" forState:0];
        _codeBtn.backgroundColor=_backgroundColor;
        [_timer invalidate];
        return;
    }
    _timeTick--;
    [_codeBtn setTitle:[NSString stringWithFormat:@"%dS重发",_timeTick] forState:0];
    _codeBtn.backgroundColor=_DarkGrey;
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
