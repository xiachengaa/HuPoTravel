//
//  MeSetUserCellTwo.m
//  琥珀旅行
//
//  Created by mac on 16/2/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeSetUserCellTwo.h"
@interface MeSetUserCellTwo ()<UITextFieldDelegate>

@end

@implementation MeSetUserCellTwo
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 50)];
        [self.contentView addSubview:typeLabel];
        self.typeLabel = typeLabel;
        
        UITextField *nameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(85, 5, 200, 50)];
        nameTextFiled.font = [UIFont systemFontOfSize:13];
        nameTextFiled.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:nameTextFiled];
        self.nameTextFiled = nameTextFiled;
        nameTextFiled.delegate = self;
        nameTextFiled.hidden = YES;
        
        
        UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, 200, 50)];
        genderLabel.font = [UIFont systemFontOfSize:13];
        genderLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:genderLabel];
        self.genderLabel = genderLabel;
        genderLabel.hidden = YES;
        
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextFiled endEditing:YES];
    return YES;
}



@end
