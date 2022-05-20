Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F785C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 05:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiETFmm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 01:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbiETFml (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 01:42:41 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8ECD59322
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 22:42:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 71A1653451E;
        Fri, 20 May 2022 15:42:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nrvPI-00E8YF-NJ; Fri, 20 May 2022 15:42:36 +1000
Date:   Fri, 20 May 2022 15:42:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 05/12] README: document _begin_fstests better
Message-ID: <20220520054236.GX2306852@dread.disaster.area>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-6-david@fromorbit.com>
 <YobPNOJvSyUYEZpm@magnolia>
 <20220520015830.GW2306852@dread.disaster.area>
 <Yob2xHavHkIGfYzH@magnolia>
 <20220520052322.zbjoa6sv6r5es72g@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520052322.zbjoa6sv6r5es72g@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62872a4e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=AH95d8jJAAAA:8
        a=7-415B0cAAAA:8 a=TRu9KZqZIltZXEInBEAA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=pSGbBc17UZ4dCur9id4D:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 01:23:22PM +0800, Zorro Lang wrote:
> On Thu, May 19, 2022 at 07:02:44PM -0700, Darrick J. Wong wrote:
> > On Fri, May 20, 2022 at 11:58:30AM +1000, Dave Chinner wrote:
> > > On Thu, May 19, 2022 at 04:13:56PM -0700, Darrick J. Wong wrote:
> > > > On Tue, May 17, 2022 at 05:01:04PM +1000, Dave Chinner wrote:
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > 
> > > > > Because how it actually gets used by the fstests infrastructure
> > > > > has been undocumented and that has impact on how it should be set
> > > > > up.
> > > > > 
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > ---
> > > > >  README | 41 ++++++++++++++++++++++++++++++++---------
> > > > >  1 file changed, 32 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/README b/README
> > > > > index 7da66cb6..eacf1acd 100644
> > > > > --- a/README
> > > > > +++ b/README
> > > > > @@ -368,19 +368,42 @@ Test script environment:
> > > > >  
> > > > >       6. Test group membership: Each test can be associated with any number
> > > > >  	of groups for convenient selection of subsets of tests.  Group names
> > > > > -	can be any sequence of non-whitespace characters.  Test authors
> > > > > -	associate a test with groups by passing the names of those groups as
> > > > > -	arguments to the _begin_fstest function.  For example, the code:
> > > > > +	can be any sequence of non-whitespace characters, though human-readable
> > > > > +	names that match the set [A-Za-z0-9\-] are highly prefered.
> > > > >  
> > > > > -	_begin_fstest auto quick subvol snapshot
> > > > > +	Test authors associate a test with groups by passing the names of those
> > > > > +	groups as arguments to the _begin_fstest function. While _begin_fstests
> > > > > +	is a shell function that must be called at the start of a test to
> > > > > +	initialise the test environment correctly, the the build infrastructure
> > > > > +	also scans the test files for _begin_fstests invocations. It does this
> > > > > +	to compile the group lists that are used to determine which tests to run
> > > > > +	when `check` is executed. In other words, test files files must call
> > > > > +	_begin_fstest with their intended groups or they will not be run.
> > > > > +
> > > > > +	However, because the build infrastructure also uses _begin_fstests as
> > > > > +	a defined keyword, addition restrictions are placed on how it must be
> > > > > +	formatted:
> > > > > +
> > > > > +	(a) It must be a single line with no multi-line continuations.
> > > > > +
> > > > > +	(b) group names should be separated by spaces and not other whitespace
> > > > > +
> > > > > +	(c) A '#' placed anywhere in the list, even in the middle of a group
> > > > > +	    name, will cause everything from the # to the end of the line to be
> > > > > +	    ignored.
> > > > 
> > > > I don't see where this is implemented in mkgroupfile?
> > > 
> > > It doesn't need to be. It just aggregates the entire group line,
> > > comments and all. Comments *must* be stripped by the thing that reads
> > > the group file - mkgroupfile adds comments to every group file it
> > > builds.
> > > 
> > > > Was that in the
> > > > part of the patchset that got eaten by vger?  Or is this patch a
> > > > proposal for how we want to define _begin_fstest usage and will be
> > > > followed by changes to mkgroupfile to make it do what we now say it
> > > > does?
> > > 
> > > It documents the behaviour the mkgroupfile parser currently expects.
> > 
> > Ok.
> > 
> > > > Also, under the old behavior, a '#' not preceded by whitespace or
> > > > otherwise escaped on the command line is considered to be part of an
> > > > argument:
> > > > 
> > > > $ echo moo#cow
> > > > moo#cow
> > > 
> > > Yeah, but we don't need to support that sort of weird thing. The
> > > original "Group names can be any sequence of non-whitespace
> > > characters" requirement is just a can of worms.
> > > 
> > > > 
> > > > Not that we /had/ any groups like that.
> > > > 
> > > > Also, I think we ought to add:
> > > > 
> > > > 	(d) Group names may not contain whitespace or punctuation.
> > > > 
> > > > 	(e) Quotation marks are considered a part of the group name.
> > > 
> > > The specification after I modified it reads:
> > > 
> > > 	.... Group names
> > > 	can be any sequence of non-whitespace characters, though
> > > 	human-readable names that match the set [A-Za-z0-9\-] are highly
> > > 	prefered.
> > > 
> > > I'm happy to change that to something like:
> > > 
> > > 	Group names are to be humand readable names from the
> > > 	character set defined by [:isalnum:\-_].
> 
> As you haven't sent the next version, I might be a little picky :)
> I'm not a regex expert, just tried to run 'grep -E', I think [[:alnum:]_-] might
> be better. The 'isalnum' is a function name, the '-' better to be at the end,
> or it might be treated as a hyphen. For example:

Sure, I wasn't trying to write a fully working regex - that takes
thought and this was just a brain dump to indicate roughly what I
meant. It looks like you understood it well enough. :)

I do intend to change the code to tested and correct regex, then
copy it across to the documentation....

FWIW, if you want to improve your regex game, you can get plenty
of practice here:

https://regexcrossword.com/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
