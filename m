Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4584DC433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 21 May 2022 23:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbiEUXWd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 May 2022 19:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiEUXWb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 May 2022 19:22:31 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B28BC41F8F
        for <fstests@vger.kernel.org>; Sat, 21 May 2022 16:22:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 03F095346A4;
        Sun, 22 May 2022 09:22:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nsYQW-00Eowo-Tr; Sun, 22 May 2022 09:22:28 +1000
Date:   Sun, 22 May 2022 09:22:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 07/12] xfs/148: fix failure from bad shortform size
 assumptions
Message-ID: <20220521232228.GA2306852@dread.disaster.area>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-8-david@fromorbit.com>
 <20220520073438.bof3lpok2wx6krls@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520073438.bof3lpok2wx6krls@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62897436
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=T3xQO0tAKE-8xg4Tnu8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 03:34:38PM +0800, Zorro Lang wrote:
> On Tue, May 17, 2022 at 05:01:06PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > @@ -41,9 +41,12 @@ test_names=("something" "$nullstr" "$slashstr" "another")
> >  rm -f $imgfile $imgfile.old
> >  
> >  # Format image file w/o crcs so we can sed the image file
> > +# We need to use 512 byte inodes to ensure the attr forks remain in short form
> > +# even when security xattrs are present so we are always doing name matches on
> > +# lookup and not name hash compares as leaf/node forms will do.
> >  $XFS_IO_PROG -f -c 'truncate 40m' $imgfile
> >  loopdev=$(_create_loop_device $imgfile)
> > -MKFS_OPTIONS="-m crc=0" _mkfs_dev $loopdev >> $seqres.full
> > +MKFS_OPTIONS="-m crc=0 -i size=512" _mkfs_dev $loopdev >> $seqres.full
> 
> It's good to me, although I'm wondering why you didn't choose to use
> $SELINUX_MOUNT_OPTIONS [1]. Anyway, extending inode size can help too.

Because if we are running under any other context that adds xattrs
to the files by defaults (e.g. default acls, other LSMs, etc) will
cause it to fail the same way.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
