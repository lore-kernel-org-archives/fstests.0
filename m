Received: from aserp1040.oracle.com ([141.146.126.69]:40047 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbcH3EpS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Aug 2016 00:45:18 -0400
Date: Mon, 29 Aug 2016 21:45:07 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/159: record error value correctly
Message-ID: <20160830044507.GG8265@birch.djwong.org>
References: <20160830035114.13876-1-wangxg.fnst@cn.fujitsu.com>
 <20160830035940.GJ27776@eguan.usersys.redhat.com>
 <57C504EC.5070303@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57C504EC.5070303@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 30, 2016 at 12:00:44PM +0800, Wang Xiaoguang wrote:
> Hi,
> 
> On 08/30/2016 11:59 AM, Eryu Guan wrote:
> >On Tue, Aug 30, 2016 at 11:51:14AM +0800, Wang Xiaoguang wrote:
> >>This case failed in btrfs, it's because when trying to open an immutable
> >>file, vfs returns EPERM, not EACCESS, fix this.
> >>
> >>Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> >>---
> >>  tests/generic/159.out | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/tests/generic/159.out b/tests/generic/159.out
> >>index 92fe33a..3e5e47f 100755
> >>--- a/tests/generic/159.out
> >>+++ b/tests/generic/159.out
> >>@@ -2,4 +2,4 @@ QA output created by 159
> >>  Format and mount
> >>  Create the original files
> >>  Try reflink on immutable files
> >>-TEST_DIR/test-159/file2: Permission denied
> >>+TEST_DIR/test-159/file2: Operation not permitted
> >I think you need to do a filter in the test not change the golden image,
> >so older kernels won't fail because they still return EACCES on
> >immutable inodes.
> I just checked the upstream kernel, found that it retuns EPERM.
> OK, I'll send a new version.

I'm pretty sure "generic/159, 160: deal with EACCESS -> EPERM transition"
already covers this.

--D

> 
> Regards,
> Xiaoguang Wang
> 
> >
> >Thanks,
> >Eryu
> >
> >
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
