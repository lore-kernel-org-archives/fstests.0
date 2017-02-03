Received: from aserp1040.oracle.com ([141.146.126.69]:40910 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbdBCVqd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2017 16:46:33 -0500
Date: Fri, 3 Feb 2017 13:46:26 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/388: use the src/godown program instead of xfs_io
Message-ID: <20170203214626.GB6280@birch.djwong.org>
References: <20170203205037.6027-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203205037.6027-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 03, 2017 at 03:50:37PM -0500, Theodore Ts'o wrote:
> The "xfs_io -xc shutdown $MNT" command doesn't work on non-xfs file
> systems.  So use the equivalent src/godown program instead, which is
> how the other tests which use the shutdown command were converted from
> xfs-specific tests to generic tests.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/388 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/388 b/tests/generic/388
> index c00a7548..9d4ba9d6 100755
> --- a/tests/generic/388
> +++ b/tests/generic/388
> @@ -71,7 +71,7 @@ for i in $(seq 1 50); do
>  	# purposely include 0 second sleeps to test shutdown immediately after
>  	# recovery
>  	sleep $((RANDOM % 3))
> -	$XFS_IO_PROG -xc shutdown $SCRATCH_MNT
> +	./src/godown $SCRATCH_MNT

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Though to avoid inconsistency I recommend sending an xfsprogs patch
adding CMD_FLAG_FOREIGN_OK to the shutdown command once support lands in
ext4.

--D

>  
>  	ps -e | grep fsstress > /dev/null 2>&1
>  	while [ $? -eq 0 ]; do
> -- 
> 2.11.0.rc0.7.gbe5a750
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
