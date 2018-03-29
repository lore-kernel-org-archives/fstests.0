Received: from aserp2120.oracle.com ([141.146.126.78]:36146 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeC2PqH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Mar 2018 11:46:07 -0400
Date: Thu, 29 Mar 2018 08:46:01 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/xfs: don't call xfs_scrub on a block device
Message-ID: <20180329154601.GB20548@magnolia>
References: <20180321165716.GB4818@magnolia>
 <20180322024656.GC4810@magnolia>
 <5ABCBF30.4060403@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ABCBF30.4060403@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 29, 2018 at 06:25:52PM +0800, Xiao Yang wrote:
> On 2018/03/22 10:46, Darrick J. Wong wrote:
> >From: Darrick J. Wong<darrick.wong@oracle.com>
> >
> >xfs_scrub takes an xfs mountpoint as its argument, not a block device.
> >Therefore, fix _check_xfs_filesystem to call it correctly.
> Hi Darrick,
> 
> According to xfs_scrub manpage, it seems that xfs_scrub can take a mounted block device
> as its argument.  Is the xfs_scrub manpage incorrect?

Yes, the manpage is wrong and will be fixed in xfsprogs 4.16.

--D

> Thanks,
> Xiao Yang
> 
> >Signed-off-by: Darrick J. Wong<darrick.wong@oracle.com>
> >---
> >  common/xfs |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/common/xfs b/common/xfs
> >index 5dbd81e..1d98ba1 100644
> >--- a/common/xfs
> >+++ b/common/xfs
> >@@ -358,7 +358,7 @@ _check_xfs_filesystem()
> >  	# Run online scrub if we can.
> >  	mntpt="$(_is_dev_mounted $device)"
> >  	if [ -n "$mntpt" ]&&  _supports_xfs_scrub "$mntpt" "$device"; then
> >-		"$XFS_SCRUB_PROG" $scrubflag -v -d -n $device>  $tmp.scrub 2>&1
> >+		"$XFS_SCRUB_PROG" $scrubflag -v -d -n $mntpt>  $tmp.scrub 2>&1
> >  		if [ $? -ne 0 ]; then
> >  			_log_err "_check_xfs_filesystem: filesystem on $device failed scrub"
> >  			echo "*** xfs_scrub $scrubflag -v -d -n output ***">>  $seqres.full
> >--
> >To unsubscribe from this list: send the line "unsubscribe fstests" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> 
> 
> 
