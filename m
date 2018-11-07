Received: from mail-vs1-f67.google.com ([209.85.217.67]:34389 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbeKGJwK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Nov 2018 04:52:10 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so6650595vsi.1
        for <fstests@vger.kernel.org>; Tue, 06 Nov 2018 16:24:17 -0800 (PST)
MIME-Version: 1.0
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop> <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard> <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org>
In-Reply-To: <20181106231536.GB8691@thunk.org>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Tue, 6 Nov 2018 18:24:05 -0600
Message-ID: <CA+EzBbALcRgukoL+g1XXjLY=ZpmRFogWngjvxthKD3fJA_wAzw@mail.gmail.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

Hi Ted,

> > I believe that to _scratch_mkfs, I must first _cleanup dm_flakey. If I replace the above snippet by
> > _cleanup
> > _scratch_mkfs
> > _init_flakey
> >
> > The time taken for the test goes up by around 10 seconds (due to mkfs maybe). So I thought it was sufficient to remove the working directory.
>
> Can you try adding _check_scratch_fs after each test case?  Yes, it
> will increase the test time, but it will make it easier for a
> developer to figure out what might be going on.

As per Filipe's and Eryu's suggestions, each sub test in the patch
unmounts the device and tests for consistency using
_check_scratch_fs.
+       _unmount_flakey
+       _check_scratch_fs $FLAKEY_DEV
+       [ $? -ne 0 ] && _fatal "fsck failed"
This added about an additional 3-4 seconds of delay overall. I hope
this is what you're suggesting.


> Also, how big does the file system have to be?  I wonder if we can
> speed things up if a ramdisk is used as the backing device for
> dm-flakey.

The file system can be as small as 100MB. I would imagine that ramdisk
results in speedup.


> On the flip side, am I remembering correctly that the original
> technique used by your research paper used a custom I/O stack so you
> could find potential problems even in the operations getting lost
> after a power drop, no matter how unlikely, but rather, for anything
> that isn't guaranteed by the cache flush command?

Are you talking about re-ordering of the block IOs? We don't use that
feature for these tests - we only replay the block IOs in order, just
like dm-flakey/ dm-logwrites would do.


> One argument for not using a ramdisk to speed things up is that it
> would make be much less likely that potential problems would be found.
> But I wonder, given that we're not using dm-flakey, how likely that we
> would notice regressions in the first place.

To clarify, the patches I would be sending out, do not require
CrashMonkey in the loop for testing. We only use dm-flakey and the
in-order replay support it provides.


> For example, given that we know which patches were needed to fix the
> various problems found by your research.  Suppose we revert those
> patches, or use a kernel that doesn't have those fixes.  Will the
> xfstests script you've generated be able to trigger the failures with
> an unfixed kernel?

Yes, if you run these xftests on an unpatched kernel, you can
reproduce the bugs our paper claims.
