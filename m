Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F40C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 21:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiEPVk0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 17:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349432AbiEPVkX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 17:40:23 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B05A741F81
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 14:40:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B2050534751;
        Tue, 17 May 2022 07:40:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqiRv-00CoYb-0F; Tue, 17 May 2022 07:40:19 +1000
Date:   Tue, 17 May 2022 07:40:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] xfs/148: fix failure from bad shortform size
 assumptions
Message-ID: <20220516214018.GM2306852@dread.disaster.area>
References: <20220516085922.1306879-1-david@fromorbit.com>
 <20220516085922.1306879-4-david@fromorbit.com>
 <YoJvoETVVzsIHmvQ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJvoETVVzsIHmvQ@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6282c4c5
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=WQmH4K3oPmWSxOqEQ0wA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 08:37:04AM -0700, Darrick J. Wong wrote:
> On Mon, May 16, 2022 at 06:59:21PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > We replaced an attr named:
> > 
> > slashstr="are_bad_for_you"
> > 
> > with this substitution:
> > 
> > cp $imgfile $imgfile.old
> > sed -b \
> >         -e "s/$nullstr/too_many\x00beans/g" \
> >         -e "s/$slashstr/are_bad\/for_you/g" \
> >         -i $imgfile
> > 
> > We then try to retreive the attr named 'a_are_bad/for_you'. The
> > failure is:
> > 
> >     -Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
> >     -heh
> >     +attr_get: No data available
> >     +Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
> > 
> > The error returned is ENODATA - the xattr does not exist. While the
> > name might exist in the attr leaf block:
> > 
> > ....
> > nvlist[0].valuelen = 3
> > nvlist[0].namelen = 17
> > nvlist[0].name = "a_are_bad/for_you"
> > nvlist[0].value = "heh"
> > nvlist[1].valuelen = 3
> > ....
> > 
> > xattrs are not looked up by name matches when in leaf or node form
> > like they are in short form.  They are looked up by *name hash*
> > matches, and if the hash is not found, then the name does not exist.
> > Only if the has match is found, then it goes and retrieves the xattr
> > pointed to by the hash and checks the name.
> > 
> > At this point, it should be obvious that the hash of
> > "a_are_bad_for_you" is different to "a_a_are_bad/for_you". Hence the
> > leaf lookup is always rejected at the hash match stage and never
> > gets to the name compare stage.
> > 
> > IOWs, this test can *never* pass when the xattr is in leaf/node
> > form, only when it is in short form.
> > 
> > The reason the attr fork is in leaf form is that we are using
> > "-m crc=0" and so the inodes are only 256 bytes in size and can only
> > hold ~150 bytes in the literal area. That leaves ~100 bytes maximum
> > for shortform attr data. The test consumes ~80 bytes of shortform
> > space, so it should fit and the test pass.
> > 
> > However:
> > 
> > nvlist[4].valuelen = 37
> > nvlist[4].namelen = 7
> > nvlist[4].name = "selinux"
> > nvlist[4].value = "unconfined_u:object_r:unlabeled_t:s0\000"
> > 
> > Yes, I run the fstests with selinux enabled on some of test
> > machines. The selinux attr pushes the attr fork way over the size
> > that can fit in the shortform literal area, and so it moves to leaf
> > form as the attrs are initially added and the test fails.
> > 
> > Fix this by forcing the test to use 512 byte inodes, so as to
> > provide around 350 bytes of usable attr fork literal area so it's
> > not affected by security attributes.
> 
> I've long wondered if I should patch in a "security" module that
> automatically pastes in a fake "s3linux" attribute so that I can
> experience the different fs behavior that y'all see.

fstests basically already does that when selinux is turned on by
setting a context mount option automatically:

MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/vdb /mnt/scratch

The "-o context" options basically defines the security xattr that
is written to every file that is created on the scratch device. All
I've done on this VM is add this to the kernel CLI options:

selinux=1 security=selinux

and nothing else. Everyone should have at least on test VM set up
this way - we need to ensure that LSM paths are actually exercised
at some point during testing.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
