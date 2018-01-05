//
//  LoginView.h
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseView.h"

@interface LoginView : BaseView<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *phoneText,*pwdText;
@end
