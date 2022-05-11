Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5F8C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 05:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbiEKFbb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 May 2022 01:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbiEKFah (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 May 2022 01:30:37 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24DD6244F18
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 22:29:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5F9615346AD;
        Wed, 11 May 2022 15:29:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1noev2-00AZkU-2z; Wed, 11 May 2022 15:29:52 +1000
Date:   Wed, 11 May 2022 15:29:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/298: Add 100ms sleep before scratch_umount
Message-ID: <20220511052952.GG2306852@dread.disaster.area>
References: <1652079417-2255-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652079417-2255-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=627b49d1
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=omOdbC7AAAAA:8 a=7-415B0cAAAA:8
        a=_zop-4oxbUxdrHR50OMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 09, 2022 at 02:56:57PM +0800, Yang Xu wrote:
> When testing this case on my machine, it reports the following error:
> umount: /mnt/xfstests/scratch: target is busy.
> xfs_db: /dev/sda11 contains a mounted filesystem
> 
> scratch_unmount failed, so  _scratch_xfs_db reports scratch_dev is a
> mounted filesystem. It seems filesystem has something to be doing.
> 
> To avoid this, just add a 100ms sleep before scratch_umount.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/298 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/298 b/tests/xfs/298
> index b0153ebf..17510379 100755
> --- a/tests/xfs/298
> +++ b/tests/xfs/298
> @@ -51,6 +51,7 @@ while [ $SIZE -lt 1024 ];do
>  	rm $SYMLINK_FILE
>  # umount and check the number of extents on the inode. Should be 0.
>  	cd /
> +	sleep 0.1
>  	_scratch_unmount >/dev/null 2>&1

What? No.

Never put random undocument sleeps in tests to hide failures - they
are almost always covering up a problem that needs to be understood
and fixed.

First thing to do here is understand why the filesystem is busy and
can't unmount. What is holding a reference that prevents unmount?

Is systemd or udev doing something stupid on your system and so
racing with unmount? Or is something else going on?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
