Received: from userp2120.oracle.com ([156.151.31.85]:59064 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIZGX1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Sep 2018 02:23:27 -0400
Date: Tue, 25 Sep 2018 17:13:19 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/270: allow corrupted xfs_db write
Message-ID: <20180926001319.GB4594@magnolia>
References: <a2a62573-efd2-f3f6-b986-029bb691372d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a62573-efd2-f3f6-b986-029bb691372d@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 25, 2018 at 01:16:16PM -0500, Eric Sandeen wrote:
> Upcoming verifiers treat the unknown ro_compat flag written via xfs_db
> as corruption, so use the -d flag to allow it, and filter our the
> resulting informational message.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> diff --git a/tests/xfs/270 b/tests/xfs/270
> index d5c8df19..da66bc33 100755
> --- a/tests/xfs/270
> +++ b/tests/xfs/270
> @@ -44,7 +44,8 @@ _scratch_mkfs_xfs >>$seqres.full 2>&1
>  # set the highest bit of features_ro_compat, use it as an unknown
>  # feature bit. If one day this bit become known feature, please
>  # change this case.
> -$XFS_DB_PROG -x -c "sb 0" -c "write features_ro_compat $((2**31))" $SCRATCH_DEV
> +$XFS_DB_PROG -x -c "sb 0" -c "write -d features_ro_compat $((2**31))" \
> +	$SCRATCH_DEV | grep -v "Allowing write of corrupted data"
>  
>  # rw mount with unknown ro-compat feature should fail
>  echo "rw mount test"
> 
