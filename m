Received: from mail.cn.fujitsu.com ([183.91.158.132]:61675 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728806AbeLMMQk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Dec 2018 07:16:40 -0500
Message-ID: <5C124D9A.3040305@cn.fujitsu.com>
Date: Thu, 13 Dec 2018 20:16:26 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] common: add _require_test_swapfile
References: <20181203064256.26768-1-david@fromorbit.com> <20181203064256.26768-2-david@fromorbit.com>
In-Reply-To: <20181203064256.26768-2-david@fromorbit.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2018/12/03 14:42, Dave Chinner wrote:

> From: Dave Chinner <dchinner@redhat.com>
>
> Because we can host swap files on the test device, not just the
> scratch device.
>
> Also, move the tests for the utilities needed to manipulate swap
> files into the functions that test whether swap files are supported
> so they are checked for existence /before/ we try to us them. This
> fixes all the tests that currently check for these utilities
> manually /after/ checking if swapfiles are supported.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/rc         | 29 +++++++++++++++++++++--------
>  tests/generic/472 |  2 --
>  tests/generic/495 |  2 --
>  tests/generic/496 |  2 --
>  tests/generic/497 |  2 --
>  5 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index ecb17380bad8..5b344b25012b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2214,22 +2214,35 @@ _format_swapfile() {
>  }
>  
>  # Check that the filesystem supports swapfiles
> -_require_scratch_swapfile()
> +_require_swapfile()
>  {
> -	_require_scratch
> +	dir=$1
>  
> -	_scratch_mkfs >/dev/null
> -	_scratch_mount
> +	# fstests also has custom binaries for mkswap/swapon
> +	_require_test_program mkswap
> +	_require_test_program swapon
Hi Dave,

Is it necessary to include the check for custom mkswap/swapon in _require_swapfile()?
In fact, some tests calling _require_scratch_swapfile() just use default mkswap/swapon
command(e.g. generic/356, generic/357, generic/493, generic/494).  I perfer to keep it
in separate tests.

Other than that, it looks good to me.

Best Regards,
Xiao Yang

>  
>  	# Minimum size for mkswap is 10 pages
> -	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> +	_format_swapfile "$dir/swap" $(($(get_page_size) * 10))
>  
> -	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> -		_scratch_unmount
> +	if ! swapon "$dir/swap" >/dev/null 2>&1; then
>  		_notrun "swapfiles are not supported"
>  	fi
>  
> -	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
> +	swapoff "$dir/swap" >/dev/null 2>&1
> +}
> +
> +_require_test_swapfile()
> +{
> +	_require_swapfile $TEST_DIR
> +}
> +
> +_require_scratch_swapfile()
> +{
> +	_require_scratch
> +	_scratch_mkfs >/dev/null
> +	_scratch_mount
> +	_require_swapfile $SCRATCH_MNT
>  	_scratch_unmount
>  }
>  
> diff --git a/tests/generic/472 b/tests/generic/472
> index aba4a00719bc..d598eef37997 100755
> --- a/tests/generic/472
> +++ b/tests/generic/472
> @@ -33,8 +33,6 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_swapfile
> -_require_test_program mkswap
> -_require_test_program swapon
>  
>  rm -f $seqres.full
>  _scratch_mkfs >>$seqres.full 2>&1
> diff --git a/tests/generic/495 b/tests/generic/495
> index 88df26c78ec2..63f45cf4b336 100755
> --- a/tests/generic/495
> +++ b/tests/generic/495
> @@ -31,8 +31,6 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_swapfile
> -_require_test_program mkswap
> -_require_test_program swapon
>  
>  _scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount
> diff --git a/tests/generic/496 b/tests/generic/496
> index 3083eef0bebc..0e214909f596 100755
> --- a/tests/generic/496
> +++ b/tests/generic/496
> @@ -34,8 +34,6 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_swapfile
> -_require_test_program mkswap
> -_require_test_program swapon
>  _require_xfs_io_command "falloc"
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/497 b/tests/generic/497
> index 3d5502ef7c08..d9f9b7521eff 100755
> --- a/tests/generic/497
> +++ b/tests/generic/497
> @@ -34,8 +34,6 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_swapfile
> -_require_test_program mkswap
> -_require_test_program swapon
>  _require_xfs_io_command "fcollapse"
>  
>  rm -f $seqres.full
