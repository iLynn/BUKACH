//
//  BKProfileSuggestionController.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileSuggestionController.h"
#import "BKTextView.h"
#import "BKHttpTool.h"

#define BKButtonWidth  BKScreenWidth / 3
#define BKButtonHeight BKButtonWidth / 3

@interface BKProfileSuggestionController ()<UITextViewDelegate>

/** 具体建议区 */
@property (nonatomic, weak) BKTextView * suggestionView;
/** 是否愿意进一步沟通 */
@property (nonatomic, weak) UILabel * lab;
/** “邮箱” */
@property (nonatomic, weak) UILabel * email;
/** 邮箱区 */
@property (nonatomic, weak) BKTextView * emailView;
/** “电话” */
@property (nonatomic, weak) UILabel * phone;
/** 电话号码区 */
@property (nonatomic, weak) BKTextView * phoneView;
/** 提交按钮 */
@property (nonatomic, weak) UIButton * submit;

@end

@implementation BKProfileSuggestionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    //添加输入子控件们
    [self createSubviews];
    
    //提交按钮
    [self setupSubmitButton];
    
    //加上手势控制
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTouch)];
    [gesture setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:gesture];
    
    // 监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

/** 当触摸非输入区时，隐藏键盘 */
- (void)screenTouch
{
    [self.view endEditing:YES];
}

/** 键盘即将隐藏，计算view的偏移 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        
        // 将view还原
        self.view.frame = CGRectMake(0, 20 + 44, BKScreenWidth, BKScreenHeight - 20 - 44);
        
    }];
}

/** 键盘即将弹出，计算view的偏移 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 取出键盘高度
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    CGFloat height = [self getFirstResponderMaxY];
    
    //计算需要偏移的量
    CGFloat viewY = (keyboardHeight + height) < self.view.height ? 0 : (keyboardHeight + height) - self.view.height;
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
  
        self.view.frame = CGRectMake(0, - viewY + 20 + 44, BKScreenWidth, BKScreenHeight - 20 - 44);
        
    }];
    
}

- (CGFloat)getFirstResponderMaxY
{
    CGFloat height = 0;
    
    UIView * firstResponder = [[UIView alloc] init];
    
    for (UIView * subView in self.view.subviews)
    {
        if (subView.isFirstResponder)
        {
            firstResponder = subView;
        }
    }
    
    if (firstResponder == self.suggestionView)
    {
        height = CGRectGetMaxY(self.suggestionView.frame);
    }
    else if (firstResponder == self.emailView)
    {
        height = CGRectGetMaxY(self.emailView.frame);
    }
    else if (firstResponder == self.phoneView)
    {
        height = CGRectGetMaxY(self.phoneView.frame);
    }
    else
    {
        height = 0;
    }
    
    
    return height;
}


// 添加输入控件
- (void)createSubviews
{
    //1. suggestionField
    BKTextView * suggestionView = [self addOneTextViewWithRect:CGRectMake(BKCustomMargin, BKCustomMargin, BKFullWidth, BKScreenHeight * 0.3)];
    //设置提醒文字（占位文字）
    suggestionView.placehoder = @"如果您对此APP或者我机构有任何疑问、建议与意见，请写在此处提交给我们。";
    
    self.suggestionView = suggestionView;
    
    
    //2. lab
    UILabel * lab = [self addOneLabelWithRect:CGRectZero andTextAlignment:NSTextAlignmentLeft];
    lab.text = @"如果您愿意与我们进一步联络，可填写以下联系方式：";
    
    NSMutableDictionary * labDict = [NSMutableDictionary dictionary];
    labDict[NSFontAttributeName] = lab.font;
    CGSize maxSize = CGSizeMake(BKFullWidth, MAXFLOAT);
    
    CGRect rect = [lab.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:labDict context:nil];
    lab.frame = CGRectMake(BKCustomMargin, CGRectGetMaxY(self.suggestionView.frame) + BKSubviewMargin, BKFullWidth, rect.size.height);
    
    self.lab = lab;
    
    
    //3. emailView
    UILabel * email = [self addOneLabelWithRect:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.lab.frame) + BKCustomMargin, BKFullWidth * 0.2, 30) andTextAlignment:NSTextAlignmentCenter];
    email.text = @"邮箱：";
    self.email = email;
    
    BKTextView * emailView = [self addOneTextViewWithRect:CGRectMake(CGRectGetMaxX(self.email.frame), CGRectGetMaxY(self.lab.frame) + BKSubviewMargin, BKFullWidth * 0.8, 30)];
    //设置提醒文字（占位文字）
    emailView.placehoder = @"abc@126.com";
    
    self.emailView = emailView;
    
    
    //4. phoneView
    UILabel * phone = [self addOneLabelWithRect:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.email.frame) + BKSubviewMargin, BKFullWidth * 0.2, 30) andTextAlignment:NSTextAlignmentCenter];
    phone.text = @"电话：";
    self.phone = phone;
    
    BKTextView * phoneView = [self addOneTextViewWithRect:CGRectMake(CGRectGetMaxX(self.phone.frame), CGRectGetMaxY(self.email.frame) + BKSubviewMargin, BKFullWidth * 0.8, 30)];
    //设置提醒文字（占位文字）
    phoneView.placehoder = @"138 **** ****";
    
    self.phoneView = phoneView;
    
    
}

- (BKTextView *)addOneTextViewWithRect:(CGRect)rect
{
    // 1.创建输入控件
    BKTextView * textView = [[BKTextView alloc] initWithFrame:rect];
    textView.layer.cornerRadius = BKCornerRadius;
    textView.layer.masksToBounds = YES;
    
    textView.backgroundColor = [UIColor colorWithRed:1.000 green:0.897 blue:0.905 alpha:0.5];
    [self.view addSubview:textView];
    
    textView.delegate = self;
    
    // 2.设置字体
    textView.font = BKCustomFont;
    
    return textView;
    
}

- (UILabel *)addOneLabelWithRect:(CGRect)rect andTextAlignment:(NSTextAlignment)align
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    label.textAlignment = align;
    label.font = BKCustomFont;
    label.textColor = BKCustomColor;
    
    label.numberOfLines = 0;
    
    [self.view addSubview:label];
    
    return label;
    
}


//提交按钮
- (void)setupSubmitButton
{

    CGFloat submitX = BKButtonWidth;
    CGFloat submitY = CGRectGetMaxY(self.phoneView.frame) + BKSubviewMargin;
    UIButton * submit = [[UIButton alloc] initWithFrame:CGRectMake(submitX, submitY, BKButtonWidth, BKButtonHeight)];
    
    submit.layer.cornerRadius = BKCornerRadius;
    submit.layer.masksToBounds = YES;
    
    [submit setBackgroundImage:[UIImage resizedImage:@"btn_bg_enable"] forState:UIControlStateNormal];
    [submit setBackgroundImage:[UIImage resizedImage:@"btn_bg_unable"] forState:UIControlStateDisabled];
    
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submit];
    
    
    submit.enabled = NO;
    
    self.submit = submit;
    
}

/** view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.suggestionView becomeFirstResponder];
    
}

- (void)submitBtnTouch
{
    BKLog(@"submit");
    
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"content"] = self.suggestionView.text;
    params[@"email"] = self.emailView.text;
    params[@"phone"] = self.phoneView.text;
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@add_feedback", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * statusResponse) {
        
        BKLog(@"%@", statusResponse);
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
    
}


#pragma mark - UITextViewDelegate 的代理方法

/** 当用户开始拖拽scrollView时调用 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/** 当textView的文字改变就会调用 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.submit.enabled = (textView.text.length != 0);
}


#pragma mark = UITextFieldDelegate 的代理方法

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    BKLog(@"check");
}

@end
