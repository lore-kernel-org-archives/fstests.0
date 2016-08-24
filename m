Received: from userp1040.oracle.com ([156.151.31.81]:28130 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbcHXXHm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Aug 2016 19:07:42 -0400
Date: Wed, 24 Aug 2016 16:06:20 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: question about xfs/098
Message-ID: <20160824230620.GE8265@birch.djwong.org>
References: <57BD507C.6050204@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57BD507C.6050204@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[cc list]

On Wed, Aug 24, 2016 at 03:45:00PM +0800, Xiao Yang wrote:
> Hi Darrick
> 
> When i run xfstests test case xfs/098 on RHEL7.3Alpha with xfsprog-dev(4.5.0),
> I always get following error:
> ------------------------------------------------------------------
> + repair fs
> Phase 1 - find and verify superblock...
> Phase 2 - using internal log
>         - zero log...
> Log inconsistent (didn't find previous header)
> failed to find log head
> zero_log: cannot find log head/tail (xlog_find_tail=5)
> 
> fatal error -- ERROR: The log head and/or tail cannot be discovered. Attempt to mount the
> filesystem to replay the log or use the -L option to destroy the log and
> ------------------------------------------------------------------
> 
> When metadata is changed by corrupting the journal, xfs_repair fails
> to repair corrupt xfs filesystem.  I'd like to know this is expected
> behavior for xfs_repair?  Can we use -L option to repair corrupt xfs
> filesystem successfully.

xfs_repair is not capable of replaying the journal at all.  The only
option is to try to mount the fs, and if that fails, xfs_repair -L
will zero the log and check the filesystem.

So yes, that is the expected behavior.

--D

> 
> Please advise. Thanks very much.
> 
> Regards,
> Xiao Yang
> 
> 
> 
> 
