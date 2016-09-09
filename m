Received: from cn.fujitsu.com ([59.151.112.132]:52945 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751038AbcIIIjr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Sep 2016 04:39:47 -0400
Message-ID: <57D27545.6050706@cn.fujitsu.com>
Date: Fri, 9 Sep 2016 16:39:33 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/263: skip test if Q_XGETQSTAT has been supported
 by kernel and xfsprogs
References: <1473409820-7390-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1473409820-7390-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On 2016/09/09 16:30, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/263 | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/xfs/263 b/tests/xfs/263
> index 1dc47ae..01bbe3b 100755
> --- a/tests/xfs/263
> +++ b/tests/xfs/263
> @@ -58,6 +58,10 @@ _require_xfs_quota
>  _require_xfs_mkfs_crc
>  _require_xfs_crc
>  
> +#check if Q_XGETQSTAT has been supported by kernel and xfsprogs
> +grep -q 'Q_XGETQSTATV' /usr/include/linux/dqblk_xfs.h || _notrun "Q_XGETQSTAT hasn't been supported by kernel"
> +grep -q 'Q_XGETQSTATV' /usr/include/xfs/xqm.h || _notrun "Q_XGETQSTAT hasn't been supported by xfsprogs"
> +
>  rm -f $seqres.full
>  
>  function option_string()
sorry, please ignore this mail, i will resend it.


