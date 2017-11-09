Received: from userp1040.oracle.com ([156.151.31.81]:46586 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdKISZ4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Nov 2017 13:25:56 -0500
Date: Thu, 9 Nov 2017 10:25:51 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/204: do not call _scratch_mkfs_sized in a pipe
Message-ID: <20171109182551.GB6299@magnolia>
References: <20171105081110.26373-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171105081110.26373-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Nov 05, 2017 at 04:11:10PM +0800, Eryu Guan wrote:
> _scratch_mkfs_sized will create a filesystem of the given size, and
> call _notrun and exit if current $FSTYP doesn't support sized mkfs.
> But when it's called in a pipe, the exit in _notrun only exits from
> the subshell created by the pipe not the test itself, and test
> continues to run unnecessarily.
> 
> Fix it by not calling _scratch_mkfs_sized in a pipe, but dumping the
> output to a tmp file, which will be fed to _filter_mkfs later.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> This is uncovered by Darrick's patch "generic/204: use available blocks
> to determine the number of files to create", with this patch applied
> test will 'hang' when testing on a large NFS export, because the number
> of files to be created was based on the size of available space.
> 
> Note that I've dropped that patch because it also caused failure in 512B
> block size XFS test.
> 
>  tests/generic/204 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/204 b/tests/generic/204
> index 4c203a213f5b..ebc9c0fa001b 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -58,8 +58,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
>  
>  SIZE=`expr 115 \* 1024 \* 1024`
> -_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null \
> -		| _filter_mkfs 2> $tmp.mkfs > /dev/null
> +_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
> +cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Though xfs/015 seems to employ this same strategy (piped mkfs_sized) so
that test needs fixing too, right?

--D

>  _scratch_mount
>  
>  # Source $tmp.mkfs to get geometry
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
