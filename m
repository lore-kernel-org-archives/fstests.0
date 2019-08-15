Received: from userp2120.oracle.com ([156.151.31.85]:37150 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfHOPY7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Aug 2019 11:24:59 -0400
Date: Thu, 15 Aug 2019 08:24:25 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 1/2] fstests: make generic/500 xfs+ext4 only
Message-ID: <20190815152425.GA15181@magnolia>
References: <20190815150033.15996-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815150033.15996-1-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 15, 2019 at 11:00:31AM -0400, Josef Bacik wrote:
> I recently fixed some bugs in btrfs's enospc handling that made it start
> failing generic/500.
> 
> The point of this test is to make the thin provisioned device run out of
> space, which results in an EIO being seen on a device from the file
> systems perspective.  This is fine for xfs and ext4 who's metadata is
> being overwritten and already allocated on the thin provisioned device.
> They get an EIO on data writes, fstrim to free up the space, and keep it
> going.
> 
> Btrfs however has dynamic metadata, so the rm -rf could result in
> metadata IO being done on the file system.  Since the thin provisioned
> device is out of space this gives us an EIO, and we flip read only.  We
> didn't remove the file, so the fstrim doesn't recover space anyway, so
> we can't even fstrim and remount.
> 
> Make this test for ext4/xfs only, it just simply won't work right for
> btrfs in it's current form.

How about:

test $FSTYP = "btrfs" && _notrun "btrfs doesn't work that way lol"

since afaik btrfs is the only fs that shouldn't run this test?
Also, I think Ted was trying to kill off tests/shared/...

--D

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/generic/500 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/500 b/tests/generic/500
> index 201d8b9f..1cbd9d65 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -44,7 +44,7 @@ _cleanup()
>  rm -f $seqres.full
>  
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs xfs ext4
>  _supported_os Linux
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
> -- 
> 2.21.0
> 
