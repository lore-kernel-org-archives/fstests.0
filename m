Received: from mx1.redhat.com ([209.132.183.28]:42792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938274AbdAEJip (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Jan 2017 04:38:45 -0500
Date: Thu, 5 Jan 2017 17:38:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/102: Update strict check
Message-ID: <20170105093843.GU1859@eguan.usersys.redhat.com>
References: <1483606569-6515-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483606569-6515-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 05, 2017 at 04:56:09PM +0800, Xiao Yang wrote:
> Low memory may lead to "written less bytes than
> requested".  We only care about if xfs_io returned
> ENOSPC or not, so we can check stderr of xfs_io
> instead of stdout.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

I thought this was fine, but I'm not sure now. Because I recalled that
there was an ext4 bug in dax mount exposed by generic/102, and it was
the case that xfs_io returned less bytes than requested. See commit

e84dfbe ext4: retry block allocation for failed DIO and DAX writes

If we discard all the xfs_io stdout, we may miss such bugs in the
future. But I'd like to see more comments on this from filesystem
developers.

> ---
>  tests/generic/102     |  5 +++--
>  tests/generic/102.out | 20 --------------------
>  2 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/tests/generic/102 b/tests/generic/102
> index 3cdc2ba..104edc0 100755
> --- a/tests/generic/102
> +++ b/tests/generic/102
> @@ -54,8 +54,9 @@ _scratch_mount
>  for ((i = 0; i < 10; i++)); do
>  	echo "loop $i" >>$seqres.full
>  
> -	$XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file | \
> -_filter_xfs_io | _filter_scratch
> +	out="$($XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file 2>&1)"
> +	echo $out >>$seqres.full 2>&1
> +	echo $out | grep -q "No space left on device" && echo "pwrite failed with ENOSPC"

If we want to discard xfs_io stdout, just redirect it to /dev/null,
ENOSPC error messgage will go to stderr and break the golden image
anyway.

Thanks,
Eryu
