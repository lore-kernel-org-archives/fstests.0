Received: from mail-pg0-f68.google.com ([74.125.83.68]:36237 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeEQCmz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 22:42:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id z70-v6so1146250pgz.3
        for <fstests@vger.kernel.org>; Wed, 16 May 2018 19:42:55 -0700 (PDT)
Date: Thu, 17 May 2018 10:42:50 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 2/3] generic/382: Fix test when report uses /etc/passwd
Message-ID: <20180517024250.GD29080@desktop.hz.ali.com>
References: <20180514170351.13737-1-jack@suse.cz>
 <20180514170351.13737-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514170351.13737-3-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 14, 2018 at 07:03:50PM +0200, Jan Kara wrote:
> On older kernels xfs_quota uses /etc/passwd to report quota entries. In
> such case all-zero lines disturb its output and the test fails. Fix the
> problem by ignoring all-zero lines in quota report.

I notice that generic/381 does quota report in a similar way as in
generic/382, is 381 affected by the same problem? If only generic/382 is
affected, we could move the filter from common/filter to the test
itself.

BTW, I'm curious what kernel behaves in this way, what distribution are
you using that reproduces this failure? I want to try it myself too.

Thanks,
Eryu

> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  common/filter     | 8 ++++++++
>  tests/generic/382 | 6 +++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 53874a08f5e3..037799e5cd19 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -344,6 +344,14 @@ _filter_project_quota()
>  	_filter_quota | grep -v "^\#0 \|^(null) "
>  }
>  
> +_filter_quota_report()
> +{
> +	# When xfs_quota uses /etc/passwd for reporting, it may report lines
> +	# full of zeros. Ignore them.
> +	grep -v -E '^[^ ]+ +0 +0 +0 +00 +\[--------\] +0 +0 +0 +00 +\[--------\]' |
> +	grep -v -E '^[^ ]+ +0 +0 +0 +00 +\[--------\]$'
> +}
> +
>  # Account for different "ln" failure messages
>  _filter_ln()
>  {
> diff --git a/tests/generic/382 b/tests/generic/382
> index 33326ffa4d1b..02b98a9ef027 100755
> --- a/tests/generic/382
> +++ b/tests/generic/382
> @@ -79,12 +79,12 @@ do_test()
>  	$XFS_QUOTA_PROG -x -c "limit bsoft=20M bhard=20M isoft=20 ihard=20 $type -d" $SCRATCH_MNT
>  	$XFS_QUOTA_PROG -x -c "limit bsoft=40M bhard=40M isoft=40 ihard=40 $type fsgqa" $SCRATCH_MNT
>  	echo "$qname blocks and inode limit"
> -	$XFS_QUOTA_PROG -x -c "report $type -N -bi" $SCRATCH_MNT | grep -v ^root | _filter_spaces
> +	$XFS_QUOTA_PROG -x -c "report $type -N -bi" $SCRATCH_MNT | grep -v ^root | _filter_quota_report | _filter_spaces
>  
>  	## blocks default quota test ##
>  	_user_do "$XFS_IO_PROG -f -c \"pwrite 0 30M\" -c \"fsync\" $SCRATCH_MNT/data" | _filter_xfs_io
>  	echo "$qname blocks quota after write 30M data"
> -	$XFS_QUOTA_PROG -x -c "report $type -N -b" $SCRATCH_MNT | grep -v ^root | _filter_spaces
> +	$XFS_QUOTA_PROG -x -c "report $type -N -b" $SCRATCH_MNT | grep -v ^root | _filter_quota_report | _filter_spaces
>  
>  	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
>  
> @@ -95,7 +95,7 @@ do_test()
>  	sync
>  
>  	echo "$qname inode quota after creating 30 inodes"
> -	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT | grep -v ^root | _filter_spaces
> +	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT | grep -v ^root | _filter_quota_report | _filter_spaces
>  
>  	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
>  }
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
