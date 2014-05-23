Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45564 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbaEWLjI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 23 May 2014 07:39:08 -0400
Date: Fri, 23 May 2014 07:39:02 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2] xfs/005: filter _scratch_mount output to match golden
 image
Message-ID: <20140523113902.GA38092@bfoster.bfoster>
References: <1400816603-2263-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400816603-2263-1-git-send-email-eguan@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, May 23, 2014 at 11:43:23AM +0800, Eryu Guan wrote:
> Failure message of mount has been changed since util-linux v2.21, to
> something like:
> 
> mount: mount /dev/sda5 on /mnt/scratch failed: Structure needs cleaning
> 
> Filter the output to match the golden image for newer mount binary so
> that both old and new version of mount work correctly.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> v2: filter the mount error message instead of changing the golden image
> 

Works for me on 2.24.2.

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/005 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/005 b/tests/xfs/005
> index 94157c4..509ac61 100755
> --- a/tests/xfs/005
> +++ b/tests/xfs/005
> @@ -40,6 +40,11 @@ _cleanup()
>      rm -f $tmp.*
>  }
>  
> +filter_mount()
> +{
> +	sed -e "s/mount .* failed: //"
> +}
> +
>  # get standard environment, filters and checks
>  . ./common/rc
>  . ./common/filter
> @@ -59,7 +64,7 @@ _scratch_mkfs_xfs -m crc=1 >> $seqres.full 2>&1 || _fail "mkfs failed"
>  $XFS_IO_PROG -c "pwrite 224 4" $SCRATCH_DEV | _filter_xfs_io
>  
>  # should FAIL, the crc is bad; golden output contains mount failure
> -_scratch_mount
> +_scratch_mount 2>&1 | filter_mount
>  
>  # success, all done
>  status=0
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
