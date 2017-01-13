//
//  commonFunctionsCallClass.m
//  Automate Firm
//
//  Created by leonine on 9/29/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "commonFunctionsCallClass.h"
#import "AppDelegate.h"
@implementation commonFunctionsCallClass

-(float)timerGotValueChanged:(NSString *)Time // To  set the value changed functionality of timer if it is 00 Hrs 00 Mins(Minimum or maximum time settings)
{
    NSArray *timeValues=[Time componentsSeparatedByString:@" "];
    NSString *hourString=[timeValues objectAtIndex:1];
    NSString *minuteString=[timeValues objectAtIndex:3];
    int hour=[hourString intValue];
    int hours=hour*60*60;
    int minute=[minuteString intValue];
    int minute1=minute*60;
    //int minutes= minute1-10;
    float totalSeconds=(hours+minute1) - 300;
    return totalSeconds;
}

-(float)timerGetValueChanged:(NSString *)timerValue // To  set the value changed functionality of timer if it is 00 : 00(Minimum or maximum time settings)
{
    
    NSArray *timeValues=[timerValue componentsSeparatedByString:@" "];
    NSString *hourString=[timeValues objectAtIndex:0];
    NSString *minuteString=[timeValues objectAtIndex:2];
    int hour=[hourString intValue];
    int hours=hour*60*60;
    int minute=[minuteString intValue];
    int minute1=minute*60;
    int minutes= minute1-10;
    float totalSeconds=hours+minutes;
    return  totalSeconds;
}


-(float)timerGetRemainingValue:(NSString *)time1 :(NSString *)time2 // timer shows the duration of two times
{
    NSArray *timeValues=[time1 componentsSeparatedByString:@" "];
    NSString *hourString=[timeValues objectAtIndex:1];
    NSString *minuteString=[timeValues objectAtIndex:3];
    NSString *date=[NSString stringWithFormat:@"%@:%@",hourString,minuteString];
    
    
    NSArray *timeValues1=[time2 componentsSeparatedByString:@" "];
    NSString *hourString1=[timeValues1 objectAtIndex:1];
    NSString *minuteString1=[timeValues1 objectAtIndex:3];
    NSString *dates=[NSString stringWithFormat:@"%@:%@",hourString1,minuteString1];
    
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    // Set the date format according to your needs
    [df setDateFormat:@"HH:mm"]; //for 12 hour format
    //[df setDateFormat:@"MM/dd/YYYY HH:mm "]  // for 24 hour format
    
    NSDate *date1 = [df dateFromString:date];
    NSDate *date2 = [df dateFromString:dates];
    int timeDiff=[date2 timeIntervalSinceDate:date1];
    int hours=timeDiff/3600;
    float remainder=timeDiff%3600;
    remainder=remainder/60;
    
    hours=hours*60*60;
    
    int minute=remainder*60;
    
    float totalSeconds=(hours+minute) - 300;
    return  totalSeconds;
}


//Time Initial Settings

-(id)timeInitialSettings  // Reset DatePicker
{
    NSDate *date1 = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date1];
    [components setHour: 0];
    [components setMinute: 0];
    NSDate *startDate = [gregorian dateFromComponents: components];
    
    [components setHour: 23];
    [components setMinute: 0];
    NSDate *endDate = [gregorian dateFromComponents: components];
    
    NSMutableArray *TimeArray=[[NSMutableArray alloc]init];
    [TimeArray addObject:startDate];
    [TimeArray addObject:endDate];
    return TimeArray;
}



//Time To set the minimum value


-(id)timeMinimumValueSetting:(NSString *)minimumTime
{
    NSString *str=minimumTime;
    NSArray *timeValues1=[str componentsSeparatedByString:@" "];
    NSString *timeV=[timeValues1 objectAtIndex:0];
    NSArray *timeValues=[timeV componentsSeparatedByString:@":"];
    NSString *hourString=[timeValues objectAtIndex:0];
    NSString *minuteString=[timeValues objectAtIndex:1];
    
    int hour=[hourString intValue];
    
    if ([[timeValues1 objectAtIndex:1]isEqualToString:@"AM"])
    {
        
    }
    else
    {
        hour+=12;
    }
    
    int minute=[minuteString intValue] + 10 ;
    NSString *time=[NSString stringWithFormat:@"%d###%d",hour,minute];
    return time;
    
}



-(void)splittingPDF:(NSString *)filePath
{
    NSMutableArray *myarray = [[NSMutableArray alloc] init];
    CFURLRef url = CFURLCreateWithFileSystemPath (NULL, (__bridge CFStringRef)[NSString stringWithFormat:@"%@",filePath], kCFURLPOSIXPathStyle, 0);
    
    
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL(url);
    // CGPDFPageRef myPageRef = CGPDFDocumentGetPage(pdf, 1);
    long  totalPages= CGPDFDocumentGetNumberOfPages(pdf);
    
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [documentPath objectAtIndex:0];
    
    //NSInteger pages = CGPDFDocumentGetNumberOfPages(pdfDocReference);
    
    for (int page = 1; page <= totalPages; page++)
    {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *dirName = [docDirectory stringByAppendingPathComponent:@"/CreatedPDF"];
        [fm createDirectoryAtPath:dirName withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *pdfPath = [dirName stringByAppendingPathComponent:[NSString stringWithFormat:@"page_%d.pdf",page]];
        
        [myarray addObject:pdfPath];
        
        //   NSLog(@"%@",myarray);
        
        NSURL *pdfUrl = [NSURL fileURLWithPath:pdfPath];
        
        CGContextRef context = CGPDFContextCreateWithURL((__bridge_retained CFURLRef)pdfUrl, NULL, NULL);
        
        CGPDFDocumentRef pdfDoc = CGPDFDocumentCreateWithURL(url);
        CGPDFPageRef pdfPage = CGPDFDocumentGetPage(pdfDoc, page);
        CGRect pdfCropBoxRect = CGPDFPageGetBoxRect(pdfPage, kCGPDFMediaBox);
        
        
        // Copy the page to the new document
        CGContextBeginPage(context, &pdfCropBoxRect);
        CGContextDrawPDFPage(context, pdfPage);
        
        
        // Close the source files
        CGContextEndPage(context);
        CGContextRelease (context);
        CGPDFDocumentRelease(pdfDoc);
        

    }
    
    [self convertingPDFtoImage:myarray];
}


-(void)convertingPDFtoImage:(NSMutableArray *)pdfArray
{
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableDictionary *docDict=[[NSUserDefaults standardUserDefaults]objectForKey:@"documentDict"];
    NSLog(@"%@",docDict);
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
//    [myappde.dropbox_array removeAllObjects];
    NSLog(@"%@",docDict);
    
    
    for (int i=0; i<pdfArray.count; i++) {
        
        CFURLRef url = CFURLCreateWithFileSystemPath (NULL, (__bridge CFStringRef)[NSString stringWithFormat:@"%@",[pdfArray objectAtIndex:i]], kCFURLPOSIXPathStyle, 0);
        
        
        CGPDFDocumentRef pdfDoc = CGPDFDocumentCreateWithURL(url);
        CGPDFPageRef SourcePDFPage = CGPDFDocumentGetPage(pdfDoc, 1);
        CGPDFPageRetain(SourcePDFPage);
        NSString *pdfPath = [pdfArray objectAtIndex:i];
        CGRect sourceRect = CGPDFPageGetBoxRect(SourcePDFPage, kCGPDFMediaBox);
        UIGraphicsBeginPDFContextToFile(pdfPath, sourceRect, nil);
        UIGraphicsBeginImageContext(CGSizeMake(sourceRect.size.width,sourceRect.size.height));
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(currentContext, 0.0, sourceRect.size.height); //596,842 //640×960,
        CGContextScaleCTM(currentContext, 1.0, -1.0);
        CGContextDrawPDFPage (currentContext, SourcePDFPage); // draws the page in the graphics context
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSString *imagePath = [pdfArray objectAtIndex:i];
        [UIImagePNGRepresentation(image) writeToFile: imagePath atomically:YES];
        
        [imageArray addObject:image];
        
        
    }
    self.imageArray=[[NSMutableArray alloc]initWithArray:imageArray];
    
    
    
    
    [myappde.dropbox_array addObjectsFromArray:self.imageArray];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"viewPdf" object:nil];
    
  
    //return self.imageArray;
    
}

@end
