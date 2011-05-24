
#import "UIQueryTableView.h"


@implementation UIQueryTableView

-(UIQuery *)scrollToBottom {
	UITableView *table = (UITableView *)self;
	int numberOfSections = [table numberOfSections];
	int numberOfRowsInSection = [table numberOfRowsInSection:numberOfSections-1];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numberOfRowsInSection-1 inSection:numberOfSections-1];
	[table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	return [UIQuery withViews:views className:className];
}

-(UIQuery *)scrollDown:(int)numberOfRows {
	//NSLog(@"scrollDown %d", numberOfRows);
	UITableView *table = self;
	NSArray *indexPathsForVisibleRows = [table indexPathsForVisibleRows];
	NSArray *rowIndexPathList = [self rowIndexPathList];
	
	//NSLog(@"indexPathsForVisibleRows = %@", indexPathsForVisibleRows);
	NSIndexPath *indexPathForLastVisibleRow = [indexPathsForVisibleRows lastObject];
	
	int indexOfLastVisibleRow = [rowIndexPathList indexOfObject:indexPathForLastVisibleRow];
	//NSLog(@"indexOfLastVisibleRow = %d", indexOfLastVisibleRow);
	int scrollToIndex = indexOfLastVisibleRow + numberOfRows;
	if (scrollToIndex >= rowIndexPathList.count) {
		scrollToIndex = rowIndexPathList.count - 1;
	}
	NSIndexPath *scrollToIndexPath = [rowIndexPathList objectAtIndex:scrollToIndex];
	[table scrollToRowAtIndexPath:scrollToIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	return [UIQuery withViews:views className:className];
}

-(UIQuery*)scrollToTop {
	UITableView *table = self;
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	if ([self isValidIndexPath:indexPath forTableView:table]) {
		[table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}
	return [UIQuery withViews:views className:className];
}

-(UIQuery *)scrollToSection:(NSString*)sec {
	int section = [sec intValue];
	UITableView *table = self;
	if ([table numberOfSections] > section && [table numberOfRowsInSection:section] > 0) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
		[table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}
}

-(NSArray *)rowIndexPathList {
	UITableView *table = (UITableView *)self;
	NSMutableArray *rowIndexPathList = [NSMutableArray array];
	int numberOfSections = [table numberOfSections];
	for(int i=0; i< numberOfSections; i++) {
		int numberOfRowsInSection = [table numberOfRowsInSection:i];
		for(int j=0; j< numberOfRowsInSection; j++) {
			[rowIndexPathList addObject:[NSIndexPath indexPathForRow:j inSection:i]];
		}
	}
	//NSLog(@"sectionList size = %d", sectionList.count);
	return rowIndexPathList;
}

@end
