Received: from mx1.redhat.com ([209.132.183.28]:56252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbdGFCvC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Jul 2017 22:51:02 -0400
Date: Thu, 6 Jul 2017 10:50:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/247: unmount test device, not scratch device
Message-ID: <20170706025059.GW23360@eguan.usersys.redhat.com>
References: <20170705203754.92140-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705203754.92140-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Brian Foster <bfoster@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 05, 2017 at 01:37:54PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit d55123c080cb ("generic/247: filter out expected XFS warnings for
> mixed mmap/direct I/O") made generic/247 start explicitly unmounting the
> scratch device.  However, the test doesn't actually use the scratch
> device, so it will fail if SCRATCH_DEV is undefined.  Fix it by
> unmounting the test device instead.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks for the fix! I found this in my review and I remembered I removed
the _scratch_unmount and updated the comments accordingly at commit
time, but clearly I didn't.

Thanks,
Eryu

> ---
>  tests/generic/247 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/247 b/tests/generic/247
> index 509e8808..aac70780 100755
> --- a/tests/generic/247
> +++ b/tests/generic/247
> @@ -82,7 +82,7 @@ echo "Silence is golden."
>  
>  # unmount and check dmesg, filtering out expected XFS warnings about mixed
>  # mmap/dio
> -_scratch_unmount
> +_test_unmount
>  if [ "$FSTYP" == "xfs" ]; then
>  	_check_dmesg _filter_xfs_dmesg
>  else
> -- 
> 2.13.2.725.g09c95d1e9-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
