Received: from mx1.redhat.com ([209.132.183.28]:42617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758995AbcCVMQb (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Mar 2016 08:16:31 -0400
Date: Tue, 22 Mar 2016 20:14:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: overlay/001, change supported fs from generic
 to overlay
Message-ID: <20160322121418.GK11419@eguan.usersys.redhat.com>
References: <1458648571-4468-1-git-send-email-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458648571-4468-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 22, 2016 at 12:09:31PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The supported fs was set to generic by mistake, so fix it by setting it
> to the proper type 'overlay'.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for fixing it!

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/overlay/001 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/overlay/001 b/tests/overlay/001
> index 6eae737..7be9ae5 100755
> --- a/tests/overlay/001
> +++ b/tests/overlay/001
> @@ -47,7 +47,7 @@ _cleanup()
>  rm -f $seqres.full
>  
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs overlay
>  _supported_os Linux
>  _require_scratch
>  
> -- 
> 2.7.0.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
