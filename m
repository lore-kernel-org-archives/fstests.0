Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbaEVRGv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 May 2014 13:06:51 -0400
Date: Thu, 22 May 2014 13:06:48 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] xfs/005: filter _scratch_mount output and fix golden
 output to match it
Message-ID: <20140522170647.GA25877@bfoster.bfoster>
References: <1400775429-30015-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400775429-30015-1-git-send-email-eguan@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, May 23, 2014 at 12:17:09AM +0800, Eryu Guan wrote:
> Failure message of _scratch_mount is something like:
> 
> mount: mount /dev/sda5 on /mnt/scratch failed: Structure needs cleaning
> 
> not
> 
> mount: Structure needs cleaning
> 
> Filter the output and fix the golden image to match the new output.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/005     | 2 +-
>  tests/xfs/005.out | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/005 b/tests/xfs/005
> index 94157c4..534f910 100755
> --- a/tests/xfs/005
> +++ b/tests/xfs/005
> @@ -59,7 +59,7 @@ _scratch_mkfs_xfs -m crc=1 >> $seqres.full 2>&1 || _fail "mkfs failed"
>  $XFS_IO_PROG -c "pwrite 224 4" $SCRATCH_DEV | _filter_xfs_io
>  
>  # should FAIL, the crc is bad; golden output contains mount failure
> -_scratch_mount
> +_scratch_mount 2>&1 | _filter_scratch
>  
>  # success, all done
>  status=0
> diff --git a/tests/xfs/005.out b/tests/xfs/005.out
> index 13d0125..853e446 100644
> --- a/tests/xfs/005.out
> +++ b/tests/xfs/005.out
> @@ -1,4 +1,4 @@
>  QA output created by 005
>  wrote 4/4 bytes at offset 224
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -mount: Structure needs cleaning
> +mount: mount SCRATCH_DEV on SCRATCH_MNT failed: Structure needs cleaning
> -- 
> 1.9.0
> 
> _______________________________________________
> xfs mailing list
> xfs@oss.sgi.com
> http://oss.sgi.com/mailman/listinfo/xfs
