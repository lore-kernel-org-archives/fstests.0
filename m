Received: from mx1.redhat.com ([209.132.183.28]:39547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbcFWJzC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 23 Jun 2016 05:55:02 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40BA47F0B0
	for <fstests@vger.kernel.org>; Thu, 23 Jun 2016 09:55:02 +0000 (UTC)
Date: Thu, 23 Jun 2016 17:55:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v6 2/3] generic/026: This test doesn't require runas
Message-ID: <20160623095500.GH3226@eguan.usersys.redhat.com>
References: <1464725931-27588-1-git-send-email-agruenba@redhat.com>
 <1464725931-27588-2-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464725931-27588-2-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 31, 2016 at 10:18:50PM +0200, Andreas Gruenbacher wrote:
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

I queued this patch in my next pull request to Dave.

Thanks,
Eryu

> ---
>  tests/generic/026 | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tests/generic/026 b/tests/generic/026
> index 4d3fac6..69b1cbe 100755
> --- a/tests/generic/026
> +++ b/tests/generic/026
> @@ -29,7 +29,6 @@ echo "QA output created by $seq"
>  
>  here=`pwd`
>  tmp=/tmp/$$
> -runas=$here/src/runas
>  status=1	# FAILure is the default!
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> @@ -54,8 +53,6 @@ _acl_setup_ids
>  _require_acls
>  _require_acl_get_max
>  
> -[ -x $runas ] || _notrun "$runas executable not found"
> -
>  rm -f $seqres.full
>  
>  # get dir
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
