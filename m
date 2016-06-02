Received: from mx1.redhat.com ([209.132.183.28]:37136 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbcFBE0P (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Jun 2016 00:26:15 -0400
Date: Thu, 2 Jun 2016 12:26:13 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] 346: add to the quick and rw groups
Message-ID: <20160602042613.GX5140@eguan.usersys.redhat.com>
References: <1464784706-8886-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464784706-8886-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 01, 2016 at 02:38:26PM +0200, Christoph Hellwig wrote:
> The test runs quickly and covers code not covered by any other test, so add
> it to the quick group.  Also add it to the rw group while we're at it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me, except that I think the summary can be updated to
"generic/346: ...", though there's only one 346 right now.

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/generic/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 36fb759..217ffaa 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -348,7 +348,7 @@
>  343 auto quick metadata
>  344 auto
>  345 auto
> -346 auto
> +346 auto quick rw
>  347 auto quick rw thin
>  348 auto quick metadata
>  349 blockdev quick rw
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
