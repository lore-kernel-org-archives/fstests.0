Received: from mx1.redhat.com ([209.132.183.28]:42904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdFACxa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 31 May 2017 22:53:30 -0400
Date: Thu, 1 Jun 2017 10:53:27 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] xfs/055: add missing 055.cfg
Message-ID: <20170601025327.GU23805@eguan.usersys.redhat.com>
References: <1496221827-22720-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496221827-22720-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 31, 2017 at 05:10:26PM +0800, Xiao Yang wrote:
> _link_output_file sets output file suffix to null because 055.cfg is
> missing, so add it.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks for the patch! But we eventually want to remove IRIX support, I
don't think this is needed at this stage, especially that Eric Biggers
has posted patches to remove IRIX support.

BTW, your patch has '1/2' prefix, but I didn't see the second patch, do
you have a second patch that didn't hit the list?

Thanks,
Eryu

> ---
>  tests/xfs/055.cfg | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tests/xfs/055.cfg
> 
> diff --git a/tests/xfs/055.cfg b/tests/xfs/055.cfg
> new file mode 100644
> index 0000000..7ffdfc0
> --- /dev/null
> +++ b/tests/xfs/055.cfg
> @@ -0,0 +1,2 @@
> +irix: irix
> +linux: linux
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
