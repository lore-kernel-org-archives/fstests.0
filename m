Received: from mx1.redhat.com ([209.132.183.28]:34812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdCQEuH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Mar 2017 00:50:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAD613DBE2
        for <fstests@vger.kernel.org>; Fri, 17 Mar 2017 04:50:06 +0000 (UTC)
Date: Fri, 17 Mar 2017 12:50:05 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] generic/417: reduce extend attribute size
Message-ID: <20170317045005.yzdc5t2rzcpihkto@XZHOUW.usersys.redhat.com>
References: <20170316070637.6489-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316070637.6489-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 16, 2017 at 03:06:37PM +0800, Eryu Guan wrote:
> xattr size 1024 is too big for 1k block size ext3/4 filesystem, so
> test fails due to ENSPC message from multi_open_unlink when setting
> xattr.
> 
> Reduce the xattr size to 512 so it fits in 1k block size ext3/4.

Tested and ack.

> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/417 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/417 b/tests/generic/417
> index 45d63f5..690ceb5 100755
> --- a/tests/generic/417
> +++ b/tests/generic/417
> @@ -61,7 +61,7 @@ function create_dirty_orphans() {
>  
>  	num_files=200
>  	num_eas=1
> -	ea_val_size=1024
> +	ea_val_size=512
>  
>  	# sleep for ages and we will kill this pid when we are ready
>  	delay=100
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
