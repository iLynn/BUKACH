//
//  BKProfileSuggestionController.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileSuggestionController.h"
#import "BKTextView.h"

#define BKButtonWidth  120
#define BKButtonHeight 40

@interface BKProfileSuggestionController ()<UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) BKTextView * textView;

@property (nonatomic, weak) UILabel * lab;

@property (nonatomic, weak) UITextField * emailField;

@property (nonatomic, weak) UITextField * phoneField;

@property (nonatomic, weak) UIButton * submit;

@end

@implementation BKProfileSuggestionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //1.添加输入控件
    [self setupTextView];
    
    //2.联系方式
    [self setupContactMore];
    
    //3.发送
    [self setupButton];
    
}

// 添加输入控件
- (void)setupTextView
{
    // 1.创建输入控件
    BKTextView * textView = [[BKTextView alloc] initWithFrame:CGRectMake(BKMargin, BKMargin, BKScreenWidth - 2 * BKMargin, 200)];
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    
    textView.backgroundColor = [UIColor colorWithRed:1.000 green:0.897 blue:0.905 alpha:0.5];
    [self.view addSubview:textView];
    self.textView = textView;
    
    self.textView.delegate = self;
    
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"如果您对此APP或者我机构有任何疑问、建议与意见，请写在此处提交给我们。";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
}

//2.联系方式
- (void)setupContactMore
{
    //指引
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.textView.frame) + BKMargin, BKScreenWidth - 2 * BKMargin, 30)];
    lab.text = @"如果您愿意进一步沟通，请填写以下联系方式之一:";
    lab.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:lab];
    
    NSMutableDictionary * labDict = [NSMutableDictionary dictionary];
    labDict[NSFontAttributeName] = lab.font;
    CGSize maxSize = CGSizeMake(lab.width, MAXFLOAT);

    CGRect rect = [lab.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:labDict context:nil];
    
    lab.height = rect.size.height;
    
    self.lab = lab;
    
    
    //邮箱
    UILabel * emailLab = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.lab.frame) + BKMargin, 50, 30)];
    emailLab.text = @"邮箱:";
    emailLab.textAlignment = NSTextAlignmentCenter;
    emailLab.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:emailLab];
    
    //邮箱填写
    UITextField * emailField = [[UITextField alloc] initWithFrame:CGRectMake(BKMargin * 2 + 50, CGRectGetMaxY(self.lab.frame) + BKMargin, BKScreenWidth - BKMargin * 5 - 50, 30)];

    emailField.delegate = self;
    emailField.borderStyle = UITextBorderStyleRoundedRect;
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:emailField];
    
    self.emailField = emailField;
    
    
    //电话
    UILabel * phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.emailField.frame) + BKMargin, 50, 30)];
    phoneLab.text = @"电话:";
    phoneLab.textAlignment = NSTextAlignmentCenter;
    phoneLab.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:phoneLab];
    
    //电话填写
    UITextField * phoneField = [[UITextField alloc] initWithFrame:CGRectMake(BKMargin * 2 + 50, CGRectGetMaxY(self.emailField.frame) + BKMargin, BKScreenWidth - BKMargin * 5 - 50, 30)];

    phoneField.delegate = self;
    phoneField.borderStyle = UITextBorderStyleRoundedRect;
    phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:phoneField];
    
    self.phoneField = phoneField;
    
}


//3.发送
- (void)setupButton
{
    CGFloat margin = (BKScreenWidth - BKButtonWidth ) /2;
    
    //1.提交
    CGFloat submitX = margin;
    CGFloat submitY = CGRectGetMaxY(self.phoneField.frame) + BKMargin;
    UIButton * submit = [[UIButton alloc] initWithFrame:CGRectMake(submitX, submitY, BKButtonWidth, BKButtonHeight)];
    
    submit.layer.cornerRadius = 5;
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
    [self.textView becomeFirstResponder];
    
}

- (void)submitBtnTouch
{
    BKLog(@"submit");
}


#pragma mark - UITextViewDelegate 的代理方法

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
