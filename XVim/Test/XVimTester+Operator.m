//
//  XVimTester+Operator.m
//  XVim
//
//  Created by Suzuki Shuichiro on 4/30/13.
//
//

#import "XVimTester.h"

@implementation XVimTester (Operator)
- (NSArray*)operator_testcases{
    static NSString* text0 = @"aAa bbb ccc\n";
    
    static NSString* text1 = @"aaa\n"   // 0  (index of each WORD)
                             @"bbb\n"   // 4
                             @"ccc";    // 8
    
    static NSString* text2 = @"aAa bbb ccc";
    
    static NSString* a_result = @"aAa bbXXXb ccc\n";
    static NSString* A_result = @"aAa bbb cccXXX\n";
   
    static NSString* cw_result1 = @"aAa baaa ccc\n";
    static NSString* cw_result2 = @"aAa bbb caaa\n";
    static NSString* cw_result3 = @"aaa\nccc";
    static NSString* Cw_result1 = @"aAa baaaa\n";
    
    static NSString* dw_result = @"bbb ccc\n";
    static NSString* D_result = @"\n"
                                @"bbb\n"
                                @"ccc";
    
    static NSString* dw_result2 = @"\n"
                                  @"bbb\n"
                                  @"ccc";
    static NSString* dw_result3 = @"aAa bbb ";
    static NSString* dw_result4 = @"aAa bbb c";
    
    static NSString* yw_result1 = @"aAa aAa bbb ccc\n";
    static NSString* yw_result2 = @"aAa bbb cccccc";
    
    static NSString* oO_text = @"int abc(){\n"  // 0 4
                               @"}\n";          // 11
    
    static NSString* oO_result = @"int abc(){\n" // This result may differ from editor setting. This is for 4 spaces for indent.
                                 @"    \n"      // 11
                                 @"}\n";
    
    static NSString* guw_result = @"aaa bbb ccc\n";
    static NSString* gUw_result = @"AAA bbb ccc\n";
    static NSString* guu_result = @"aaa bbb ccc\n";
    static NSString* gUU_result = @"AAA BBB CCC\n";
    
    static NSString* tilde_result = @"Aaa bbb ccc\n";
    static NSString* g_tilde_w_result = @"AaA bbb ccc\n";
    
    static NSString* C_o_result = @"abcdefbbb ccc\n";
    static NSString* C_w_result = @"aAa bbb \n";
    static NSString* C_w_result2 = @"aAa bbb c\n";
    //static NSString* C_w_resutl3= @"aaabbb\n"
    //                              @"ccc";
    
    return [NSArray arrayWithObjects:
           // a, A
           XVimMakeTestCase(text0, 5,  0, @"aXXX<ESC>", a_result, 8, 0), // aXXX<ESC>
           XVimMakeTestCase(text0, 5,  0, @"AXXX<ESC>", A_result, 13, 0), // AXXX<ESC>
           
           // c, C
           XVimMakeTestCase(text0, 5,  0, @"cwaaa<ESC>", cw_result1,  7, 0),
           XVimMakeTestCase(text0, 9,  0, @"cwaaa<ESC>", cw_result2, 11, 0),
           XVimMakeTestCase(text1, 1,  0, @"2cwaa<ESC>", cw_result3,  2, 0),
           XVimMakeTestCase(text0, 5,  0, @"Caaaa<ESC>", Cw_result1,  8, 0),
           
           // d, D
           XVimMakeTestCase(text0, 0, 0, @"dw", dw_result, 0, 0),
           XVimMakeTestCase(text1, 0, 0, @"D", D_result, 0, 0),
           // dw at the end of line should not delete newline
           XVimMakeTestCase(text1, 0, 0, @"dw", dw_result2, 0, 0),
           // dw at the end of file
            XVimMakeTestCase(text2, 8, 0, @"dw", dw_result3, 7, 0),
           // dvw at the end of file should not delete last character( a little strange behaviour in vim)
           XVimMakeTestCase(text2, 8, 0, @"dvw", dw_result4, 8, 0),
            
           // y, Y
           XVimMakeTestCase(text0, 0,  0, @"ywP", yw_result1,  3, 0),
           XVimMakeTestCase(text2, 8,  0, @"ywP", yw_result2, 10, 0), // Yank to end of file
            
           // gu, gU
           XVimMakeTestCase(text0, 0,  0, @"guw", guw_result, 0, 0),
           XVimMakeTestCase(text0, 0,  0, @"gUw", gUw_result, 0, 0),
           XVimMakeTestCase(text0, 4,  0, @"guu", guu_result, 0, 0),
           XVimMakeTestCase(text0, 4,  0, @"gUU", gUU_result, 0, 0),
           
           // ~, g~
           XVimMakeTestCase(text0, 0,  0,     @"~~",     tilde_result,   2, 0),
           XVimMakeTestCase(text0, 0,  0, @"~~hh~~",            text0,   2, 0),
           XVimMakeTestCase(text0, 0,  0,    @"g~w", g_tilde_w_result,   0, 0),
           
           // o, O
           XVimMakeTestCase(oO_text,  4, 0, @"o<ESC>", oO_result, 14, 0),
           XVimMakeTestCase(oO_text, 11, 0, @"O<ESC>", oO_result, 14, 0),
           
           // Insert and Ctrl-o
           XVimMakeTestCase(text0,  0, 0, @"iabc<C-o>dwdef<ESC>", C_o_result, 5, 0),
           
           // Insert and Ctrl-w
           XVimMakeTestCase(text0, 11, 0, @"a<C-w><ESC>", C_w_result, 7, 0),
           XVimMakeTestCase(text0, 11, 0, @"i<C-w><ESC>", C_w_result2, 7, 0),
           // XVimMakeTestCase(text1, 4 , 0, @"i<C-w><ESC>", C_w_result3, 2, 0), // C-w should delete LF but not works currently
   nil];
    
}
@end