Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:7993 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753676AbcHRBEO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Aug 2016 21:04:14 -0400
Date: Thu, 18 Aug 2016 11:04:10 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] xfs/191: skip tests on older xfsprogs
Message-ID: <20160818010410.GB22388@dastard>
References: <20160817033640.GP27776@eguan.usersys.redhat.com>
 <1471409161-28510-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471409161-28510-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, jtulak@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 17, 2016 at 12:46:01PM +0800, Xiao Yang wrote:
> If we don't have /tmp/foo file on xfsprogs 3.2.2, _require_xfs_mkfs_validation
> will fail because mkfs.xfs can't create this file.  We need to skip tests
> before xfsprogs 4.7.0, so fix it.  the feature has been introduced since
> xfsprogs 4.2.0:
>   commit 20cec860e16b267ea0c71a2f648fa2b26aad2e65
>   Author: Eric Sandeen <sandeen@sandeen.net>
>   Date: Fri Jul 31 09:04:11 2015 +1000
>     mkfs.xfs: always use underlying fs sector size when mkfs'ing a file
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/rc b/common/rc
> index b19b698..1907c70 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3889,6 +3889,7 @@ _get_fs_sysfs_attr()
>  # number of failed cases.
>  _mkfs_validation_check()
>  {
> +	touch /tmp/foo >/dev/null 2>&1
>  	local cmd="$MKFS_XFS_PROG -f -N -d file,name=/tmp/foo,size=$((1024 * 1024 * 1024))"
>  	$cmd -s size=2s >/dev/null 2>&1
>  	local sum=$?


Couple of things here:

	1. this is an xfs specific check. The function needs to have
	   "xfs" in it's name. i.e. _xfs_mkfs_validation_check

	2. Don't hard code temporary files ie use mktemp for
	   creating the file like so:

		imgfile=`mktemp`
		.....
		rm -f $imgfile

	3. mkfs.xfs takes human readable units for sizes, such as
	   "1g" for a 1GB filesystem and "260k" for the log size. No
	   need calculations in the script for this, and this gets
	   rid of overly long lines and makes it easier to read.

	4. Whitespace between each check and result processing makes
	   it much easier to see each of the operations being
	   performed during the check.

i.e.

_xfs_mkfs_validation_check()
{
	local imgfile=`mktemp`
	local cmd="$MKFS_XFS_PROG -f -N -d file,name=/tmp/foo,size=1g"

	$cmd -s size=2s >/dev/null 2>&1
	local sum=$?

	$cmd -l version=2,su=260k >/dev/null 2>&1
	sum=`expr $sum + $?`

	rm -f $imgfile
	return $sum
}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
