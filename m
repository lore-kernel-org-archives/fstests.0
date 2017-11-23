Received: from mx1.redhat.com ([209.132.183.28]:59756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbdKWHIF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Nov 2017 02:08:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB84CC049D7F
        for <fstests@vger.kernel.org>; Thu, 23 Nov 2017 07:08:05 +0000 (UTC)
Received: from localhost (dhcp-12-147.nay.redhat.com [10.66.12.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A8DB5D9C7
        for <fstests@vger.kernel.org>; Thu, 23 Nov 2017 07:08:05 +0000 (UTC)
Date: Thu, 23 Nov 2017 15:08:04 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ltp/fsx: really skip fallocate keep_size calls when
 replaying ops
Message-ID: <20171123070804.GT2749@eguan.usersys.redhat.com>
References: <20171118061906.11227-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171118061906.11227-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Nov 18, 2017 at 02:19:06PM +0800, Eryu Guan wrote:
> On start up, fsx checks for various fallocate(2) operation support
> status and disables unsupported operations. But when replaying
> operations from a log, fsx failed to skip KEEP_SIZE fallocate(2)
> calls if underlying filesystem doesn't support it. For example,
> NFSv4.2 supports fallocate(2) but not KEEP_SIZE, and this causes
> generic/469 fails on NFSv4.2.
> 
> Fix it by taking 'keep_size_calls' into consideration when replaying
> ops from log file.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> Note that generic/469 hasn't been pushed to upstream yet. Will do in
> this week's update.

generic/469 is upstream now, still need some reviews on this patch.

Thanks,
Eryu

> 
>  ltp/fsx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 9c358f27bd92..fc1381e60f09 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1469,7 +1469,7 @@ test(void)
>  			offset = log_entry.args[0];
>  			size = log_entry.args[1];
>  			closeopen = !!(log_entry.flags & FL_CLOSE_OPEN);
> -			keep_size = !!(log_entry.flags & FL_KEEP_SIZE);
> +			keep_size = !!((log_entry.flags & FL_KEEP_SIZE) && keep_size_calls);
>  			goto have_op;
>  		}
>  		return 0;
> -- 
> 2.14.3
> 
