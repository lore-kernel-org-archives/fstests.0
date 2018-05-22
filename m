Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:26045 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753253AbeEVWOJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 May 2018 18:14:09 -0400
Date: Wed, 23 May 2018 08:14:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] check: Make the test harness unmount fs when
 finishing a test
Message-ID: <20180522221407.GX10363@dastard>
References: <1526969013-16134-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1526982599-8914-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526982599-8914-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Tue, May 22, 2018 at 05:49:59PM +0800, Xiao Yang wrote:
> Finishing xfs/132 left a shutdown scratch fs and the test harness didn't
> unmount the fs(because we told it not to check the fs) so the test harness
> called by subsequent xfs/133 tried to "test -d $SCRATCH_MNT" and received
> the IO error from the dead fs.
> 
> i.e. Running xfs/132 and xfs/133 together got the following error:
> ------------------------------------------------------------
> ...
> xfs/132 1s ... 1s
> xfs/133 1s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//xfs/133.out.bad)
> ...
> QA output created by 133
> -Format and mount
> -Corrupt filesystem
> -Remount, try to append
> -Write did not succeed (ok).
> +SCRATCH_DEV=/dev/sda11 is mounted but not on SCRATCH_MNT=common/config: - aborting
> +Already mounted result:
> +/dev/sda11 /mnt/xfstests/scratch
> ...
> ------------------------------------------------------------
> 
> Even if we don't check fs, the test harness is supposed to unmount fs and
> return an initial state before running the next test.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  check | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/check b/check
> index 96198ac..f6fb352 100755
> --- a/check
> +++ b/check
> @@ -489,10 +489,14 @@ _check_filesystems()
>  	if [ -f ${RESULT_DIR}/require_test ]; then
>  		_check_test_fs || err=true
>  		rm -f ${RESULT_DIR}/require_test*
> +	else
> +		_test_unmount 2> /dev/null
>  	fi
>  	if [ -f ${RESULT_DIR}/require_scratch ]; then
>  		_check_scratch_fs || err=true
>  		rm -f ${RESULT_DIR}/require_scratch*
> +	else
> +		_scratch_unmount 2> /dev/null
>  	fi
>  }

Looks good! Thanks for fixing this up, Xiao.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
