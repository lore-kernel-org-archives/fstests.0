Received: from mail.cn.fujitsu.com ([183.91.158.132]:28702 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727331AbeK0Rki (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Nov 2018 12:40:38 -0500
Message-ID: <5BFCE79C.4070707@cn.fujitsu.com>
Date: Tue, 27 Nov 2018 14:43:40 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/111: Filter a "Structure needs cleaning" error from
 xfs_fsr
References: <1543298175-5405-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1543298175-5405-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Dave,

I am not familiar with the bulkstat code in kernel, so i am not sure
if the fix patch is OK. Could you help me review it? Thanks a lot.

Best Regards,
Xiao Yang
On 2018/11/27 13:56, Xiao Yang wrote:
> on upstream kernel, running xfs/111 got the following error:
> -------------------------------------------------
> +xfs_fsr: xfs_bulkstat: Structure needs cleaning
> -------------------------------------------------
>
> Since kernel commit 29cad0b, we don't convert a -EFSCORRUPTED error
> to -EINVAL in xfs_imap_to_bp() if we are doing an untrusted lookup.
> So xfs_bulkstat() called by xfs_fsr command fails and returns
> EFSCORRUPTED.  We think it is reasonable for xfs_fsr to report
> EFSCORRUPTED because some inodes are actually corrupted.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/111 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/xfs/111 b/tests/xfs/111
> index 2ef69f0..2bcf002 100755
> --- a/tests/xfs/111
> +++ b/tests/xfs/111
> @@ -58,7 +58,8 @@ _try_scratch_mount || _fail "Couldn't mount after itrash"
>  
>  echo Attempting bulkstat
>  #src/bstat -q $SCRATCH_MNT
> -$XFS_FSR_PROG $SCRATCH_MNT | _filter_scratch
> +#Since kernel commit 29cad0b, xfs_fsr reports a "Structure needs cleaning" error
> +$XFS_FSR_PROG $SCRATCH_MNT | _filter_scratch | grep -v "Structure needs cleaning"
>  
>  # Fix up intentional corruption so test can pass
>  _scratch_unmount
