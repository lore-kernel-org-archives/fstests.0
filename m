Received: from szxga05-in.huawei.com ([45.249.212.191]:17622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfE2NhM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 29 May 2019 09:37:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 738EA9191986F1DC35D0
        for <fstests@vger.kernel.org>; Wed, 29 May 2019 21:37:09 +0800 (CST)
Subject: Re: [PATCH] fstests: fix _repair_scratch_fs error reporting
References: <20190528120847.31003-1-amir73il@gmail.com>
From: "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <d33705aa-eeda-f6c3-9b14-77fe7fb4906d@huawei.com>
Date: Wed, 29 May 2019 21:37:03 +0800
MIME-Version: 1.0
In-Reply-To: <20190528120847.31003-1-amir73il@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>, Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2019/5/28 20:08, Amir Goldstein Wrote:
> _dump_err2() helper was introduced over two years ago and it broke
> the error reporting from _repair_scratch_fs.
> 
> Every test that runs:
> _repair_scratch_fs >> $seqres.full
> 
> and expect to fail if anything is written to stderr is not working
> as intended.
> 
> Spotted-by: zhangyi (F) <yi.zhang@huawei.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks for re-post it.
Reviewed-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks
Yi.

> ---
> 
> Eryu,
> 
> This bug was found by zhangyi while working on fsck.overlay patches,
> but it affects all filesystems. I just re-found zhangyi's fix while
> going through some old notes.
> 
> Amir.
> 
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 17b89d5d..e78e0920 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -98,7 +98,7 @@ _dump_err_cont()
>  _dump_err2()
>  {
>      _err_msg="$*"
> -    >2& echo "$_err_msg"
> +    >&2 echo "$_err_msg"
>  }
>  
>  _log_err()
> 
