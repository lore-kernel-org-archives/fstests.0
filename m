Received: from mx1.redhat.com ([209.132.183.28]:40904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbcF3HHp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 03:07:45 -0400
Date: Thu, 30 Jun 2016 15:07:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/042: remove from quick group
Message-ID: <20160630070743.GX23649@eguan.usersys.redhat.com>
References: <1467270238-28429-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467270238-28429-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 09:03:58AM +0200, Christoph Hellwig wrote:
> This test has been removed from the auto group because it fails without
> an expected fix.  Remove it from the quick group as well, as the quick
> group should be a subset of the auto group.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/generic/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 7491282..d320d8e 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -44,7 +44,7 @@
>  039 metadata auto quick
>  040 metadata auto quick
>  041 metadata auto quick
> -042 quick rw
> +042 rw
>  043 metadata log auto
>  044 metadata log auto
>  045 metadata log auto
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
