Received: from mx1.redhat.com ([209.132.183.28]:57098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbbHCDL7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 2 Aug 2015 23:11:59 -0400
Date: Mon, 3 Aug 2015 11:11:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/5] xfstest: generic/219 add _require_odirect
Message-ID: <20150803031156.GO17933@dhcp-13-216.nay.redhat.com>
References: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
 <1438236417-24612-3-git-send-email-yangds.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438236417-24612-3-git-send-email-yangds.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, dedekind1@gmail.com, richard.weinberger@gmail.com, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 30, 2015 at 02:06:54PM +0800, Dongsheng Yang wrote:
> generic/219 is testing quota in three use cases including
> Direct I/O. So we have to add a dependence to odirect in
> this test.
> 
> Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/generic/219 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/219 b/tests/generic/219
> index 2b75b89..866e7b7 100755
> --- a/tests/generic/219
> +++ b/tests/generic/219
> @@ -44,6 +44,7 @@ _supported_fs generic
>  _supported_os Linux #IRIX
>  _require_scratch
>  _require_quota
> +_require_odirect
>  _require_user
>  _require_group
>  
> -- 
> 1.8.4.2
> 
