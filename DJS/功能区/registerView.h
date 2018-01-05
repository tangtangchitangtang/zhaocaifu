//
//  registerView.h
//  DJS
//
//  Created by 浪尖渝力 on 2018/1/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseView.h"

@interface registerView : BaseView<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *phoneText,*codeText,*pwdText;
@property(nonatomic,strong)UIButton *codeBtn;
@property(nonatomic,assign)int timeTick;
@property(nonatomic,strong)NSTimer *timer;
@end
