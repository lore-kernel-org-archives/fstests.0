Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02418C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 05:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiETFXb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 01:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345580AbiETFXb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 01:23:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8BF14B641
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 22:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9151FB82892
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 05:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5834AC385AA;
        Fri, 20 May 2022 05:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653024207;
        bh=8zdXgpENX5s9Wqoqgsd5AlqbRZJT/e9gnfRJR3TUy1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ciio30QqokbmPsXnWgvWvKQq6sp4AH83xEZGxhfom2Jqs2GPxngy6lqcz0rjelolw
         PwXrNPF/NUEX3F25ej0sXVT0C0xAl9ckZinzaQkKkvSsNxEqATCHZVeVGGomITOmSg
         t9xIqy19hrT+uwtLgk68AWqteBGTKbiHMJFPhx54NqHywcgFyNbfG3YUukq4nIFvrZ
         RBG6JGRaatFsFAKgzBPbrsHSCt5OOl8cUm44jxEbCBxfpWDJbcDkfZ5DDQtxdP2rDS
         lWMzRyK0fZLKQXtoUFT0z8uQq42CPOsmmL01cnTmbtFRqu1EdOL3oZdAgWTj7JaJyV
         67WG3bRnWv9nw==
Date:   Fri, 20 May 2022 13:23:22 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 05/12] README: document _begin_fstests better
Message-ID: <20220520052322.zbjoa6sv6r5es72g@zlang-mailbox>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-6-david@fromorbit.com>
 <YobPNOJvSyUYEZpm@magnolia>
 <20220520015830.GW2306852@dread.disaster.area>
 <Yob2xHavHkIGfYzH@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yob2xHavHkIGfYzH@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 19, 2022 at 07:02:44PM -0700, Darrick J. Wong wrote:
> On Fri, May 20, 2022 at 11:58:30AM +1000, Dave Chinner wrote:
> > On Thu, May 19, 2022 at 04:13:56PM -0700, Darrick J. Wong wrote:
> > > On Tue, May 17, 2022 at 05:01:04PM +1000, Dave Chinner wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Because how it actually gets used by the fstests infrastructure
> > > > has been undocumented and that has impact on how it should be set
> > > > up.
> > > > 
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > >  README | 41 ++++++++++++++++++++++++++++++++---------
> > > >  1 file changed, 32 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/README b/README
> > > > index 7da66cb6..eacf1acd 100644
> > > > --- a/README
> > > > +++ b/README
> > > > @@ -368,19 +368,42 @@ Test script environment:
> > > >  
> > > >       6. Test group membership: Each test can be associated with any number
> > > >  	of groups for convenient selection of subsets of tests.  Group names
> > > > -	can be any sequence of non-whitespace characters.  Test authors
> > > > -	associate a test with groups by passing the names of those groups as
> > > > -	arguments to the _begin_fstest function.  For example, the code:
> > > > +	can be any sequence of non-whitespace characters, though human-readable
> > > > +	names that match the set [A-Za-z0-9\-] are highly prefered.
> > > >  
> > > > -	_begin_fstest auto quick subvol snapshot
> > > > +	Test authors associate a test with groups by passing the names of those
> > > > +	groups as arguments to the _begin_fstest function. While _begin_fstests
> > > > +	is a shell function that must be called at the start of a test to
> > > > +	initialise the test environment correctly, the the build infrastructure
> > > > +	also scans the test files for _begin_fstests invocations. It does this
> > > > +	to compile the group lists that are used to determine which tests to run
> > > > +	when `check` is executed. In other words, test files files must call
> > > > +	_begin_fstest with their intended groups or they will not be run.
> > > > +
> > > > +	However, because the build infrastructure also uses _begin_fstests as
> > > > +	a defined keyword, addition restrictions are placed on how it must be
> > > > +	formatted:
> > > > +
> > > > +	(a) It must be a single line with no multi-line continuations.
> > > > +
> > > > +	(b) group names should be separated by spaces and not other whitespace
> > > > +
> > > > +	(c) A '#' placed anywhere in the list, even in the middle of a group
> > > > +	    name, will cause everything from the # to the end of the line to be
> > > > +	    ignored.
> > > 
> > > I don't see where this is implemented in mkgroupfile?
> > 
> > It doesn't need to be. It just aggregates the entire group line,
> > comments and all. Comments *must* be stripped by the thing that reads
> > the group file - mkgroupfile adds comments to every group file it
> > builds.
> > 
> > > Was that in the
> > > part of the patchset that got eaten by vger?  Or is this patch a
> > > proposal for how we want to define _begin_fstest usage and will be
> > > followed by changes to mkgroupfile to make it do what we now say it
> > > does?
> > 
> > It documents the behaviour the mkgroupfile parser currently expects.
> 
> Ok.
> 
> > > Also, under the old behavior, a '#' not preceded by whitespace or
> > > otherwise escaped on the command line is considered to be part of an
> > > argument:
> > > 
> > > $ echo moo#cow
> > > moo#cow
> > 
> > Yeah, but we don't need to support that sort of weird thing. The
> > original "Group names can be any sequence of non-whitespace
> > characters" requirement is just a can of worms.
> > 
> > > 
> > > Not that we /had/ any groups like that.
> > > 
> > > Also, I think we ought to add:
> > > 
> > > 	(d) Group names may not contain whitespace or punctuation.
> > > 
> > > 	(e) Quotation marks are considered a part of the group name.
> > 
> > The specification after I modified it reads:
> > 
> > 	.... Group names
> > 	can be any sequence of non-whitespace characters, though
> > 	human-readable names that match the set [A-Za-z0-9\-] are highly
> > 	prefered.
> > 
> > I'm happy to change that to something like:
> > 
> > 	Group names are to be humand readable names from the
> > 	character set defined by [:isalnum:\-_].

As you haven't sent the next version, I might be a little picky :)
I'm not a regex expert, just tried to run 'grep -E', I think [[:alnum:]_-] might
be better. The 'isalnum' is a function name, the '-' better to be at the end,
or it might be treated as a hyphen. For example:

...
$ echo a1-B_ | egrep -o [[:alnum:]\-_]
grep: Invalid range end
$ echo a1-B_ | egrep -o '[[:alnum:]\-_]'
a
1
B
_
$ echo a1-B_ | egrep -o [[:alnum:]_-]
a
1
-
B
_
...

Thanks,
Zorro

> > 
> > No quotation marks, nothing outside the above as a single line
> > whitespace separated list.
> 
> Yes, please.  Fewer possible characters are a plus.
> 
> > I want to get rid of the group files altogether - all they are used
> > for is being read by check to build an in memory list of all the
> > tests and groups. We can do that quickly and easily now, we don't
> > need to do it at build time anymore. The group dictionary checks can be
> > done at build time, but that can easily be done with a make file
> > rule and doesn't need the group files to be built.
> 
> <nod>
> 
> > Also, I want to apply the same approach "grep, collate, cull"
> > process to evaluating _requires rules when check starts. We evaluate
> > the same requires rules with the same results hundreds of times
> > during an auto run - we only need to run each rule once and cull the
> > tests that require unsupported things from the test list before we
> > start running tests...
> > 
> > > Otherwise, I'm happy with this.
> 
> <nod> I'm looking forward to the next version.
> 
> --D
> 
> > Thanks!
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> 
