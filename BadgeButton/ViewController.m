//
//  ViewController.m
//  BadgeButton
//
//  Created by Dmitry Stadnik on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

static const NSInteger kBadgeButtonTag = 34574546234;

@interface ViewController ()

@end

@implementation ViewController

@synthesize tableView = _tableView;

- (void)viewDidUnload {
    [super viewDidUnload];
	self.tableView = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 12;
}

- (UITableViewCell *)makeBadgeCell:(UITableView *)tableView withCount:(NSUInteger)count {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BadgeCell"];
	UIButton *badgeButton;
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:@"BadgeCell"];
		UIImage *bgImage = [UIImage imageNamed:@"cell-bg.png"];
		UIImageView *bgView = [[UIImageView alloc] initWithImage:bgImage];
		bgView.contentMode = UIViewContentModeScaleToFill;
		cell.backgroundView = bgView;
		UIImage *hlImage = [UIImage imageNamed:@"cell-bg-hl.png"];
		UIImageView *hlView = [[UIImageView alloc] initWithImage:hlImage];
		hlView.contentMode = UIViewContentModeScaleToFill;
		cell.selectedBackgroundView = hlView;
		
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.textLabel.opaque = NO;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
		cell.textLabel.text = @"Text";
		
		badgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		badgeButton.tag = kBadgeButtonTag;
		UIImage *badgeImage = [[UIImage imageNamed:@"button-badge.png"] stretchableImageWithLeftCapWidth:15
																							topCapHeight:10];
		[badgeButton setBackgroundImage:badgeImage forState:UIControlStateNormal];
		badgeButton.adjustsImageWhenHighlighted = NO;
		badgeButton.contentEdgeInsets = UIEdgeInsetsMake(1, 8, 1, 8);
		[badgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		badgeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
		badgeButton.titleLabel.textAlignment = UITextAlignmentCenter;
		[cell.contentView addSubview:badgeButton];
	} else {
		badgeButton = (UIButton *)[cell.contentView viewWithTag:kBadgeButtonTag];
	}
	[badgeButton setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
	[badgeButton sizeToFit];
	CGRect badgeRect = badgeButton.frame;
	badgeRect.origin.x = 300 - badgeRect.size.width;
	badgeRect.origin.y = (44 - badgeRect.size.height) / 2;
	badgeButton.frame = badgeRect;
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [self makeBadgeCell:tableView withCount:(indexPath.row * indexPath.row)];
}

@end
