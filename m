Received: from mx1.redhat.com ([209.132.183.28]:55770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbdF0EdH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Jun 2017 00:33:07 -0400
Date: Tue, 27 Jun 2017 12:33:04 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] common: remove tmp.mkfs[err/std] files by name
Message-ID: <20170627043304.GW23360@eguan.usersys.redhat.com>
References: <20170626134017.2741-1-ddiss@suse.de>
 <20170626134017.2741-2-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626134017.2741-2-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 26, 2017 at 03:40:17PM +0200, David Disseldorp wrote:
> Without any $tmp suffix, users silly enough to run xfstests without
> mktemp present will unintentionally "rm -f *".
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

I posted a patch back in Jan. to cleanup tmp files and other leftover
files after test, I switched from mktemp to a normal "tmp=/tmp/$$._mkfs"
assignment so it could avoid this problem you want to fix too. But my
patch got no review.

I'm going to send new version of my patch and will fix _scratch_do_mkfs
too, I really appreciate if you could help review and provide
Reviewed-by tag.

Thanks,
Eryu

> ---
>  common/rc  | 2 +-
>  common/xfs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index ff1b75c9..a38f4e03 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -595,7 +595,7 @@ _scratch_do_mkfs()
>  	cat $tmp.mkfsstd
>  	eval "cat $tmp.mkfserr | $mkfs_filter" >&2
>  
> -	rm -f $tmp*
> +	rm -f $tmp.mkfsstd $tmp.mkfserr
>  	return $mkfs_status
>  }
>  
> diff --git a/common/xfs b/common/xfs
> index 0f0825bc..59776a6f 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -104,7 +104,7 @@ _scratch_mkfs_xfs()
>  	# output mkfs stdout and stderr
>  	cat $tmp.mkfsstd
>  	cat $tmp.mkfserr >&2
> -	rm -f $tmp*
> +	rm -f $tmp.mkfsstd $tmp.mkfserr
>  
>  	return $mkfs_status
>  }
> -- 
> 2.12.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
