//
//  MeSetUserInfoTableViewController.m
//  琥珀旅行
//
//  Created by mac on 16/2/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeSetUserInfoTableViewController.h"
#import "MeSetUserTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MeSetUserCellTwo.h"
@interface MeSetUserInfoTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSIndexPath *lastIndexPath;
@end

@implementation MeSetUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.title = @"设置个人信息";
    //这里可以设置navi返回栏的样式
    [self setUpBackButton];
}




/**
 *  设置返回按钮样式
 */
- (void)setUpBackButton
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"button_default"] forState:UIControlStateNormal];
    leftBtn.size = leftBtn.currentBackgroundImage.size;
    leftBtn.layer.cornerRadius = leftBtn.currentBackgroundImage.size.width * 0.5;
    leftBtn.clipsToBounds = YES;
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

/**
 *  设置返回按钮动作
 */
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0?1:3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MeSetUserTableViewCell *cell = (MeSetUserTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"MeSetUserTableViewCell" owner:nil options:nil] lastObject];
        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.avatar_large] placeholderImage:[UIImage imageNamed:@"user_image"]];
        return cell;
    }else{
        MeSetUserCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[MeSetUserCellTwo alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        
        if (indexPath.row == 0) {
            cell.genderLabel.hidden = YES;
            cell.nameTextFiled.hidden = NO;
            cell.typeLabel.text = @"昵称";
            cell.nameTextFiled.text = self.model.screen_name;
            
        }else if(indexPath.row == 1){
            cell.genderLabel.hidden = NO;
            cell.nameTextFiled.hidden = YES;
            cell.typeLabel.text = @"性别";
            cell.genderLabel.text = [self.model.gender isEqualToString:@"m"]? @"男":@"女";
        }else if(indexPath.row == 2){
            cell.genderLabel.hidden = YES;
            cell.nameTextFiled.hidden = NO;
            cell.typeLabel.text = @"邮箱";
            cell.nameTextFiled.text = @"270081841@qq.com";
        }
        
        return cell;
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //切换到相册
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            return;
        }
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        //说明是性别那一栏
        
        //关闭第一个跟第三个的textfiled
        MeSetUserCellTwo *firstcell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        [firstcell.nameTextFiled endEditing:YES];
        
        MeSetUserCellTwo *thirdCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        [thirdCell.nameTextFiled endEditing:YES];
        
        [self openGenderPickerView];
    }
    
    
}



/**
 *  打开一个pickerVIew
 */
- (void)openGenderPickerView
{
    //在这里要移除textfiled
    
    
    UIView *coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    //添加window上面
    [self.view.window addSubview:coverView];
    
    //添加pickerView
    CGFloat pickerX = 0;
    CGFloat pickerY = kScreenHeight;
    CGFloat pickerW = kScreenWidth;
    CGFloat pickerH = kScreenHeight * 0.4;
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(pickerX,pickerY,pickerW,pickerH)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    [coverView addSubview:picker];
    
    [UIView animateWithDuration:0.5 animations:^{
        picker.top -= picker.height;
    }];
    
}
#pragma mark - UIpickerView Delegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    return row == 0?@"男":@"女";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    //当选中一个pickerView的莫一行的时候
    NSString *genderString = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    MeSetUserCellTwo *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.genderLabel.text = genderString;
    
    //让pickerView滑下去
    [UIView animateWithDuration:0.5 animations:^{
        pickerView.top += pickerView.height;
    } completion:^(BOOL finished) {
        //让coverView移除
        [pickerView.superview removeFromSuperview];
    }];
    
}
#pragma mark - 相片选中的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath.section == 0) {
        MeSetUserTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        cell.iconView.image = image;
    }else{
        switch (indexPath.row) {
            case 0:
               //名字框
                break;
            case 1:
                
                break;
            case 2:
                
                break;
                
            default:
                break;
        }
    }
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //这里可以选择发送post请求给网络去更换图片，因为没有借口，所以自己不能实现
}

@end
