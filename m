Received: from mx1.redhat.com ([209.132.183.28]:55018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933134AbdEWOB7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 May 2017 10:01:59 -0400
Date: Tue, 23 May 2017 22:01:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs: Make 'man' hard requirement for xfs/293
Message-ID: <20170523140156.GD7250@eguan.usersys.redhat.com>
References: <1495539943-9670-1-git-send-email-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495539943-9670-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 23, 2017 at 02:45:43PM +0300, Nikolay Borisov wrote:
> If xfs/293 is run on a system which doesn't have 'man' installed
> it will hang the due to $CAT waiting for input indefinitely
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Yeah, we need to make sure 'man' is available.

> 
> ---
>  tests/xfs/293 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/xfs/293 b/tests/xfs/293
> index df44e98e..9556b4bb 100755
> --- a/tests/xfs/293
> +++ b/tests/xfs/293
> @@ -40,6 +40,8 @@ _cleanup()
>  . ./common/rc
>  . ./common/filter
>  
> +_require_command man man
> +

Can you please add an entry in common/config for $MAN_PROG and do the
check in xfs/293 *after* _supported_os call, and call $MAN_PROG instead
of bare 'man'?

Thanks,
Eryu

>  # real QA test starts here
>  
>  # Modify as appropriate.
> -- 
> 2.12.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
