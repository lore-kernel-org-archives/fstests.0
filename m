Received: from mx1.redhat.com ([209.132.183.28]:43222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbbLKJHg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Dec 2015 04:07:36 -0500
Date: Fri, 11 Dec 2015 17:07:32 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: add generic/275 to the 'enospc' group
Message-ID: <20151211090732.GS2535@eguan.usersys.redhat.com>
References: <1449622819-12764-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449622819-12764-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 09, 2015 at 09:00:19AM +0800, Xiaoguang Wang wrote:
> Currently we're developing a new in-band deduplication feature for btrfs,
> when enabing this feature, it will take much long time to hit the enospc
> condition which 275 tries to create. I think 275 is also certain enospc
> test and we should add it to 'enospc' group, then we can skip it easily by
> excluding 'enospc' group when running fstests.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>

Makes sense to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/generic/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 355603f..3af390d 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -228,7 +228,7 @@
>  270 auto quota rw prealloc ioctl enospc stress
>  273 auto rw
>  274 auto rw prealloc
> -275 auto rw
> +275 auto rw enospc
>  277 auto ioctl quick metadata
>  280 auto quota freeze dangerous
>  285 auto rw
> -- 
> 1.8.2.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
