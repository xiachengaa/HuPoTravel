//
//  SearchBar.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/9.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "SearchBar.h"
#import "ScenicSpotViewController.h"
#import "SearchViewController.h"

#define SearchVCIdentifier @"SearchViewController"

@interface SearchBar () <UISearchBarDelegate>

@end

@implementation SearchBar

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupConfig];
    }
    return self;
}

- (void)setupConfig{
    self.delegate = self;
    UITextField *textField = [self valueForKey:@"_searchField"];
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor blackColor];
    
}

- (UIViewController *)viewController{
    
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder != nil);
    return nil;
}

#pragma mark - UISearchBar Delegate

//自定义push动画
- (void)transitionPush{
    CATransition *tran = [CATransition animation];
    tran.duration =.4;
    tran.type = kCATransitionMoveIn;
    tran.subtype =kCATransitionFromTop;
    [((ScenicSpotViewController *)[self viewController]).navigationController.view.layer addAnimation:tran forKey:nil];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    if (self.tag == 300) {
        UIStoryboard *scenicSB = [UIStoryboard storyboardWithName:@"ScenicSpot" bundle:nil];
        SearchViewController *searchVC = [scenicSB instantiateViewControllerWithIdentifier:SearchVCIdentifier];
        searchVC.searchDataDic = self.searchDataDic;
        [self transitionPush];
        [((ScenicSpotViewController *)[self viewController]).navigationController pushViewController:searchVC animated:NO];
    }
}


@end
