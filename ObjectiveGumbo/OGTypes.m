// OGUtility.m
//
// Copyright 2014 Programming Thomas
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "OGTypes.h"

@implementation OGTypes

+ (NSString*)tagForGumboTag:(OGTag)tag {
    NSArray * tagNames = [OGTypes tagStrings];
    if (tag < tagNames.count) {
        return tagNames[tag];
    }
    return nil;
}

+ (OGTag)gumboTagForTag:(NSString *)tag {
    NSArray * tagNames = [OGTypes tagStrings];
    NSInteger index = [tagNames indexOfObject:tag];
    if (index == NSNotFound) {
        return OGTagUnknown;
    }
    return index;
}

+ (NSArray*)tagStrings {
    static NSMutableArray * array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = [NSMutableArray arrayWithCapacity:OGTagLast];
        array[OGTagHtml] = @"html";
        array[OGTagHead] = @"head";
        array[OGTagTitle] = @"title";
        array[OGTagBase] = @"base";
        array[OGTagLink] = @"link";
        array[OGTagMeta] = @"meta";
        array[OGTagStyle] = @"style";
        array[OGTagScript] = @"script";
        array[OGTagNoScript] = @"noscript";
        array[OGTagTemplate] = @"template";
        array[OGTagBody] = @"body";
        array[OGTagArticle] = @"article";
        array[OGTagSection] = @"section";
        array[OGTagNav] = @"nav";
        array[OGTagAside] = @"aside";
        array[OGTagH1] = @"h1";
        array[OGTagH2] = @"h2";
        array[OGTagH3] = @"h3";
        array[OGTagH4] = @"h4";
        array[OGTagH5] = @"h5";
        array[OGTagH6] = @"h6";
        array[OGTagHGroup] = @"hgroup";
        array[OGTagHeader] = @"header";
        array[OGTagFooter] = @"footer";
        array[OGTagAddress] = @"address";
        array[OGTagP] = @"p";
        array[OGTagHr] = @"hr";
        array[OGTagPre] = @"pre";
        array[OGTagBlockQuote] = @"blockquote";
        array[OGTagOl] = @"ol";
        array[OGTagUl] = @"ul";
        array[OGTagLi] = @"li";
        array[OGTagDl] = @"dl";
        array[OGTagDt] = @"dt";
        array[OGTagDd] = @"dd";
        array[OGTagFigure] = @"figure";
        array[OGTagFigCaption] = @"figcaption";
        array[OGTagMain] = @"main";
        array[OGTagDiv] = @"div";
        array[OGTagA] = @"a";
        array[OGTagEm] = @"em";
        array[OGTagStrong] = @"strong";
        array[OGTagSmall] = @"small";
        array[OGTagS] = @"s";
        array[OGTagCite] = @"cite";
        array[OGTagQ] = @"q";
        array[OGTagDfn] = @"dfn";
        array[OGTagAbbr] = @"abbr";
        array[OGTagDdata] = @"ddata";
        array[OGTagTime] = @"time";
        array[OGTagCode] = @"code";
        array[OGTagVar] = @"var";
        array[OGTagSamp] = @"samp";
        array[OGTagKbd] = @"kbd";
        array[OGTagSub] = @"sub";
        array[OGTagSup] = @"sup";
        array[OGTagI] = @"i";
        array[OGTagB] = @"b";
        array[OGTagU] = @"u";
        array[OGTagMark] = @"mark";
        array[OGTagRuby] = @"ruby";
        array[OGTagRt] = @"rt";
        array[OGTagRp] = @"rp";
        array[OGTagBdi] = @"bdi";
        array[OGTagBdo] = @"bdo";
        array[OGTagSpan] = @"span";
        array[OGTagBr] = @"br";
        array[OGTagWbr] = @"wbr";
        array[OGTagINS] = @"ins";
        array[OGTagDEL] = @"del";
        array[OGTagImage] = @"image";
        array[OGTagImg] = @"img";
        array[OGTagIFrame] = @"iframe";
        array[OGTagEmbed] = @"embed";
        array[OGTagObject] = @"object";
        array[OGTagParam] = @"param";
        array[OGTagVideo] = @"video";
        array[OGTagAudio] = @"audio";
        array[OGTagSource] = @"source";
        array[OGTagTrack] = @"track";
        array[OGTagCanvas] = @"canvas";
        array[OGTagMap] = @"map";
        array[OGTagArea] = @"area";
        array[OGTagMath] = @"math";
        array[OGTagMI] = @"mi";
        array[OGTagMO] = @"mo";
        array[OGTagMN] = @"mn";
        array[OGTagMS] = @"ms";
        array[OGTagMText] = @"mtext";
        array[OGTagMGlyph] = @"mglyph";
        array[OGTagMAlignMark] = @"malignmark";
        array[OGTagAnnotationXML] = @"annotationxml";
        array[OGTagSVG] = @"svg";
        array[OGTagForeignObject] = @"foreignobject";
        array[OGTagDesc] = @"desc";
        array[OGTagTable] = @"table";
        array[OGTagCaption] = @"caption";
        array[OGTagColGroup] = @"colgroup";
        array[OGTagCol] = @"col";
        array[OGTagTBody] = @"tbody";
        array[OGTagTHead] = @"thead";
        array[OGTagTFoot] = @"tfoot";
        array[OGTagTR] = @"tr";
        array[OGTagTD] = @"td";
        array[OGTagTH] = @"th";
        array[OGTagForm] = @"form";
        array[OGTagFieldSet] = @"fieldset";
        array[OGTagLegend] = @"legend";
        array[OGTagLabel] = @"label";
        array[OGTagInput] = @"input";
        array[OGTagButton] = @"button";
        array[OGTagSelect] = @"select";
        array[OGTagDataList] = @"datalist";
        array[OGTagOptGroup] = @"optgroup";
        array[OGTagOption] = @"option";
        array[OGTagTextArea] = @"textarea";
        array[OGTagKeygen] = @"keygen";
        array[OGTagOutput] = @"output";
        array[OGTagProgress] = @"progress";
        array[OGTagMeter] = @"meter";
        array[OGTagDetails] = @"details";
        array[OGTagSummary] = @"summary";
        array[OGTagMenu] = @"menu";
        array[OGTagMenuItem] = @"menuitem";
        array[OGTagApplet] = @"applet";
        array[OGTagAcronym] = @"acronym";
        array[OGTagBgSound] = @"bgsound";
        array[OGTagDir] = @"dir";
        array[OGTagFrame] = @"frame";
        array[OGTagFrameSet] = @"frameset";
        array[OGTagNoFrames] = @"noframes";
        array[OGTagIsIndex] = @"isindex";
        array[OGTagListing] = @"listing";
        array[OGTagXmp] = @"xmp";
        array[OGTagNextId] = @"nextid";
        array[OGTagNoEmbed] = @"noembed";
        array[OGTagPlainText] = @"plaintext";
        array[OGTagRb] = @"rb";
        array[OGTagStrike] = @"strike";
        array[OGTagBaseFont] = @"basefont";
        array[OGTagBig] = @"big";
        array[OGTagBlink] = @"blink";
        array[OGTagCenter] = @"center";
        array[OGTagFont] = @"font";
        array[OGTagMarquee] = @"marquee";
        array[OGTagMutliCol] = @"mutlicol";
        array[OGTagNoBR] = @"nobr";
        array[OGTagSpacer] = @"spacer";
        array[OGTagTt] = @"tt";
        array[OGTagUnknown] = @"unknown";
    });
    return array;
}

@end
