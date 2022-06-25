Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FAEC43334
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 22:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiFYWrP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Jun 2022 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiFYWrP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Jun 2022 18:47:15 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAC0813E3F
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 15:47:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C8AAA5EFAF5;
        Sun, 26 Jun 2022 08:47:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o5EYW-00B3cQ-8t; Sun, 26 Jun 2022 08:47:08 +1000
Date:   Sun, 26 Jun 2022 08:47:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     An Long <lan@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: Fix use of MKFS_OPTIONS
Message-ID: <20220625224708.GJ1098723@dread.disaster.area>
References: <20220623160825.31788-1-lan@suse.com>
 <Yrc6Pz67mL56ML6j@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrc6Pz67mL56ML6j@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62b7906f
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=7-415B0cAAAA:8
        a=5eWJavWNVerMDHAMmrAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jun 25, 2022 at 12:39:27PM -0400, Theodore Ts'o wrote:
> On Fri, Jun 24, 2022 at 12:08:25AM +0800, An Long wrote:
> >  
> > +# check the size value in $MKFS_OPTIONS is an integer
> > +if [[ $MKFS_OPTIONS =~ [0-9]+[^0-9\ ] ]] ; then
> > +        _fatal "error: \$MKFS_OPTIONS: Only number in bytes is allowed, no units."
> > +fi
> 
> This will break configs, since ext4 has a feature 64bit, so there
> might be MKFS_OPTIONS that contain "-O 64bit", or "-O ^64bit".
> 
> For that matter, this wll also break things like "-E encoding=12.1"
> which sets the Unicode encoding to 12.1.
> 
> ... or "-E lazy_itable_init=1,lazy_journal_init=1".
> 
> Bottom line, blindly assuming that any number followed by a non-number
> is a unit, is just not going to work.
> 
> I think the real problem is that we have fstests trying to parse
> MKFS_OPTIONS at all in the first place.

Yup. That's exactly the issue.

> For that matter, I'm not fond
> of tests that try to override MKFS_OPTIONS for their own nefarious
> purposes, because sometimes certain MKFS_OPTIONS imply something about
> what must be in MOUNT_OPTIONS, or vice versa.  I do understand why
> that has to be done for certain tests, but... yelch.  Especially in
> centralized functions like _scratch_mkfs_sized, it just leads to tech
> debt.
> 
> I'll note that generic tests and functions in common/rc that do unholy
> things with MKFS_OPTIONS already have to have per-file system hacks as
> it is.  So having more per-file system hacks for check_block_options()
> is par for the course, so long as we accept that we want to have
> generic tests and generic code violate the abstraction barrier and try
> to read or override MKFS_OPTIONS.
> 
> If we want to go down that approach, perhaps another approach would be
> to specify the desired blocksize diretly in the fs config.  Something
> like "FS_BLOCK_SIZE=1024"?  We can then have the fs-specific mkfs
> commands translate that into the appropriate "-b 1024" or whatever
> else might be appropriate for a particular file system.  And then
> tests that want to override the block size can just override
> FS_BLOCK_SIZE and then the _mkfs function can use it as appropriate.

This is the right way to fix the problem.

My plan was that once there was a single point of checking of
MKFS_OPTIONS, I'd use that to extract the default value ifor the
entire fstests run and convert everything else to use it. And then
add config section support for the variable so that it can easily be
specified on a config section by section basis.

I started writing an email that said exactly this, but then decided
half way through that it was a waste of time because people would
just nod, go their own way and yet again nothing would happen unless
I did it myself....

-Dave.

-- 
Dave Chinner
david@fromorbit.com
