Received: from sandeen.net ([63.231.237.45]:53209 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbbLARuj (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 1 Dec 2015 12:50:39 -0500
Subject: Re: [patch] make sure to _require_attrs when necessary
References: <x49two2kr5r.fsf@segfault.boston.devel.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <565DDC56.9000901@sandeen.net>
Date: Tue, 1 Dec 2015 11:43:50 -0600
MIME-Version: 1.0
In-Reply-To: <x49two2kr5r.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 12/1/15 11:36 AM, Jeff Moyer wrote:
> xfs/073 and xfs/295 forgot to _require_attrs.  Fix it.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

thanks!

> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index 32faffd..9def3c6 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -33,6 +33,7 @@ status=1	# failure is the default!
>  # get standard environment, filters and checks
>  . ./common/rc
>  . ./common/filter
> +. ./common/attr
>  
>  # don't put fs images in /tmp
>  imgs=$TEST_DIR/$$
> @@ -127,6 +128,7 @@ _verify_copy()
>  _supported_fs xfs
>  _supported_os Linux
>  _require_test
> +_require_attrs
>  
>  [ "$USE_EXTERNAL" = yes ] && _notrun "Cannot xfs_copy with external devices"
>  [ -n "$XFS_COPY_PROG" ] || _notrun "xfs_copy binary not yet installed"
> diff --git a/tests/xfs/295 b/tests/xfs/295
> index 79f27bd..2325537 100755
> --- a/tests/xfs/295
> +++ b/tests/xfs/295
> @@ -39,6 +39,7 @@ _cleanup()
>  # get standard environment, filters and checks
>  . ./common/rc
>  . ./common/filter
> +. ./common/attr
>  
>  # real QA test starts here
>  
> @@ -46,6 +47,7 @@ _cleanup()
>  _supported_fs xfs
>  _supported_os IRIX Linux
>  _require_scratch
> +_require_attrs
>  
>  rm -f $seqres.full
>  
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
