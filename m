Received: from mx1.redhat.com ([209.132.183.28]:42566 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbbHCDMN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 2 Aug 2015 23:12:13 -0400
Date: Mon, 3 Aug 2015 11:12:10 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 3/5] xfstest: generic/125 add _require_odirect
Message-ID: <20150803031210.GP17933@dhcp-13-216.nay.redhat.com>
References: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
 <1438236417-24612-4-git-send-email-yangds.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438236417-24612-4-git-send-email-yangds.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, dedekind1@gmail.com, richard.weinberger@gmail.com, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 30, 2015 at 02:06:55PM +0800, Dongsheng Yang wrote:
> generic/125 is using src/trunc which is testing O_DIRECT.
> So we have to add direct dependence to this test.
> 
> Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/generic/125 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/125 b/tests/generic/125
> index bcf9b3e..67eb63f 100755
> --- a/tests/generic/125
> +++ b/tests/generic/125
> @@ -41,6 +41,7 @@ _supported_os Linux
>  
>  _require_test
>  _require_user
> +_require_odirect
>  
>  TESTDIR=$TEST_DIR/ftrunc
>  TESTFILE=$TESTDIR/ftrunc.tmp
> -- 
> 1.8.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
