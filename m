Received: from mail-pg0-f66.google.com ([74.125.83.66]:43131 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeEQCg0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 22:36:26 -0400
Date: Thu, 17 May 2018 10:36:20 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/3] generic/459: use xfs_freeze instead of fsfreeze
Message-ID: <20180517023620.GC29080@desktop.hz.ali.com>
References: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
 <1526276991-23897-2-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526276991-23897-2-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 14, 2018 at 08:49:49AM +0300, Amir Goldstein wrote:
> This is what all other tests use as well as _require_freeze
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I'll drop this patch for now per discussion but take the other two
patches, the XFS_FREEZE_PROG conversion is not urgent and could wait I
think :)

Thanks,
Eryu

> ---
>  tests/generic/459 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/459 b/tests/generic/459
> index e755cf7..22b8e62 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -113,7 +113,7 @@ $XFS_IO_PROG -f -d -c 'pwrite -b 1m 0 120m' $SCRATCH_MNT/f1 >>$seqres.full 2>&1
>  # extended. It is expected, and is only used so xfsaild is triggered to
>  # flush AIL items, other filesystems usually get remounted as read-only during
>  # the above write process.
> -fsfreeze -f $SCRATCH_MNT >>$seqres.full 2>&1 &
> +xfs_freeze -f $SCRATCH_MNT >>$seqres.full 2>&1 &
>  freezeid=$!
>  
>  # Wait enough so xfsaild can run
> @@ -132,7 +132,7 @@ ret=$?
>  #	- The filesystem stays in Read-Write mode, but can be frozen/thawed
>  #	  without getting stuck.
>  if [ $ret -ne 0 ]; then
> -	# fsfreeze failed, filesystem should reject further writes and remount
> +	# freeze failed, filesystem should reject further writes and remount
>  	# as readonly. Sometimes the previous write process won't trigger
>  	# ro-remount, e.g. on ext3/4, do additional touch here to make sure
>  	# filesystems see the metadata I/O error.
> @@ -148,7 +148,7 @@ if [ $ret -ne 0 ]; then
>  else
>  	# Try to thaw the filesystem, and complete test if if succeed.
>  	# NOTE: This will hang on affected XFS filesystems.
> -	fsfreeze -u $SCRATCH_MNT >>$seqres.full 2>&1
> +	xfs_freeze -u $SCRATCH_MNT >>$seqres.full 2>&1
>  	echo "Test OK"
>  fi
>  
> -- 
> 2.7.4
> 
