Received: from userp2130.oracle.com ([156.151.31.86]:44412 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKLut (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Oct 2018 07:50:49 -0400
Date: Wed, 10 Oct 2018 21:25:17 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v3] geneirc/077 fix min size for btrfs
Message-ID: <20181011042517.GA6695@magnolia>
References: <1539228360-8575-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539228360-8575-1-git-send-email-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 11, 2018 at 11:26:00AM +0800, Anand Jain wrote:
> If btrfs need to be tested at its default blockgroup which is non-mixed,
> then it needs at least 256mb.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2->v3:
> 	separated from the patch set of 9.
> 	notrun for the cases where filler is not big enough to fill the
> 		fssize.
> v2->v1: ref the cover-letter of the set.
> 
>  tests/generic/077 | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/077 b/tests/generic/077
> index ef6af18c83e3..784afe448940 100755
> --- a/tests/generic/077
> +++ b/tests/generic/077
> @@ -13,7 +13,7 @@ echo "QA output created by $seq"
>  here=`pwd`
>  tmp=/tmp/$$
>  status=1
> -# Something w/ enough data to fill 50M of fs...
> +# Something w/ enough data to fill 256M of fs...
>  filler=/lib/modules/
>  
>  # fall back in case /lib/modules doesn't exist
> @@ -38,6 +38,11 @@ _supported_os Linux
>  
>  [ ! -d $filler ] && _notrun "No directory to source files from"
>  
> +# check if two iterations of the assigned filler is big enough to fill fssize
> +fs_size=$((256 * 1024 * 1024))
> +[ $(( $(du -h -m /usr | tail -1| cut -f1) * 2 )) -lt 256 ] && \

Err... what does measuring /usr have to do with /lib/modules?

Also, /lib/modules is 58M on my test VM, which means that a 256M
filesystem isn't going to ENOSPC.

(Though weirdly it doesn't fail despite the lack of ENOSPC even at the
50M size, so I'm not sure what this test is actually supposed to do...)

--D

> +	_notrun "filler $filler isn't big enough to fill fssize $fssize"
> +
>  _require_scratch
>  _require_attrs
>  _require_acls
> @@ -49,9 +54,7 @@ rm -f $seqres.full
>  _scratch_unmount >/dev/null 2>&1
>  echo "*** MKFS ***"                         >>$seqres.full
>  echo ""                                     >>$seqres.full
> -SIZE=`expr 50 \* 1024 \* 1024`
> -_scratch_mkfs_sized $SIZE                   >>$seqres.full 2>&1 \
> -	|| _fail "mkfs failed"
> +_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount
>  mkdir $SCRATCH_MNT/subdir
>  
> -- 
> 1.8.3.1
> 
