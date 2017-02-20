Received: from cn.fujitsu.com ([59.151.112.132]:51250 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751789AbdBTCNz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Feb 2017 21:13:55 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 239F247C4E82
        for <fstests@vger.kernel.org>; Mon, 20 Feb 2017 10:13:46 +0800 (CST)
Message-ID: <58AA50DA.8080409@cn.fujitsu.com>
Date: Mon, 20 Feb 2017 10:13:46 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] shared/005,7: add check whether debugfs succeeds to set
 a negative i_size or not
References: <1486984910-4623-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1486984910-4623-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu

Sorry, The previous patch is defective. Please see the following two points:

1) If the kernel bug has been fixed, stat command fails to get i_size and
reports "Structure needs cleaning".

2) shared/007 passed unexpectedly because of invalid argument when debugfs
fails to set i_size to the highest multiple of 512 below -1. So we need
to add strict check.

Thanks for you review. I will rewrite this patch.

Best Regards,
Xiao Yang

On 2017/02/13 19:21, Xiao Yang Wrote:
> shared/005 and shared/007 work abnornamlly on RHEL6.8GA and
> RHEL6.9Beta because debugfs fails to set i_size to -1 or -512
> and reports "exceeds field size maximum".  When debugfs fails
> to set a negative i_size, we can skip these cases which don't
> trigger the kernel bug.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/shared/005 | 7 +++++++
>  tests/shared/007 | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/tests/shared/005 b/tests/shared/005
> index 296de17..37912d6 100755
> --- a/tests/shared/005
> +++ b/tests/shared/005
> @@ -67,6 +67,13 @@ $DEBUGFS_PROG -w -R "sif /a size -1" $SCRATCH_DEV >> $seqres.full 2>&1
>  
>  echo "Remount, try to append"
>  _scratch_mount
> +
> +#check whether debugfs succeeds to set i_size to -1 or not
> +i_size=$(stat -c "%s" $testdir/a)
> +if [ $i_size -ne -1 ]; then
> +	_notrun "Could not set i_size to -1 successfully, skip test."
> +fi
> +
>  dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
>  sync
>  
> diff --git a/tests/shared/007 b/tests/shared/007
> index 0729ab8..06055a0 100755
> --- a/tests/shared/007
> +++ b/tests/shared/007
> @@ -69,6 +69,13 @@ $DEBUGFS_PROG -w -R "sif /a size 0xFFFFFFFFFFFFFE00" $SCRATCH_DEV >> $seqres.ful
>  
>  echo "Remount, try to append"
>  _scratch_mount
> +
> +#check whether debugfs succeeds to set i_size to -512 or not
> +i_size=$(stat -c "%s" $testdir/a)
> +if [ $i_size -ne -512 ]; then
> +	_notrun "Could not set i_size to -512 successfully, skip test."
> +fi
> +
>  dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=direct,append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
>  sync
>  



