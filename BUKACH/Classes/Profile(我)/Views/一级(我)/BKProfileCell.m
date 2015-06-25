//
//  BKProfileCell.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileCell.h"
#import "BKProfileItem.h"
#import "BKProfileArrowItem.h"
#import "BKProfileTextItem.h"

@interface BKProfileCell()

@property (nonatomic, strong) UIImageView * arrowImage;

@property (nonatomic, strong) UILabel * textView;

@end

@implementation BKProfileCell

#pragma mark - 懒加载

- (UIImageView *)arrowImage
{
    if (_arrowImage == nil)
    {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next_arrow"]];
    }
    
    return _arrowImage;
}

- (UILabel *)textView
{
    if (_textView == nil)
    {
        _textView = [[UILabel alloc] init];
    }
    return _textView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * identifier = @"ProfileCell";
    
    BKProfileCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[BKProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)setItem:(BKProfileItem *)item
{
    _item = item;
    
    // 设置数据
    self.textLabel.text = _item.tilte;
    self.imageView.image = [UIImage imageNamed:_item.icon];
    
    // 设置辅助视图
    //1.箭头模式
    if ([item isKindOfClass:[BKProfileArrowItem class]])
    {
        self.accessoryView = self.arrowImage;
    }
    //2.文本模式
    else if ([item isKindOfClass:[BKProfileTextItem class]])
    {
        BKProfileTextItem * newItem = (BKProfileTextItem *)item;
        NSString * text = [NSString stringWithFormat:@"Ver %@", newItem.customerText];
        
        //设置文字内容
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = BKHighlightFont;
        self.textView.size = [text sizeWithAttributes:dict];
        
        //将文字封装到小视图里
        self.textView.text = text;
        self.textView.font = BKCustomFont;
        self.textView.contentMode = UIViewContentModeRight;
        
        self.accessoryView = self.textView;
    }
    else
    {
        self.accessoryView = nil;
    }
    
}

@end
