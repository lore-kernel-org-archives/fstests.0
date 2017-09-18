Received: from mx1.redhat.com ([209.132.183.28]:39712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbdIRCpj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 17 Sep 2017 22:45:39 -0400
Date: Mon, 18 Sep 2017 10:45:37 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/115: add missing 115 into group file
Message-ID: <20170918024537.GM8034@eguan.usersys.redhat.com>
References: <1505698140-3414-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505698140-3414-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 18, 2017 at 09:29:00AM +0800, Xiao Yang wrote:
> From: xiao yang <yangx.jy@cn.fujitsu.com>
> 
> Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>

Ah, I forgot adding the group entry back when resolving git am
conflicts.. It was my fault, Carlos's original patch is fine.

Thanks for fixing this!

Eryu

> ---
>  tests/xfs/group | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 0a449b9..b0a8119 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -112,6 +112,7 @@
>  112 fuzzers
>  113 fuzzers
>  114 auto quick clone rmap
> +115 auto quick fuzzers dangerous
>  116 quota auto quick
>  117 fuzzers
>  118 auto quick fsr dangerous
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
