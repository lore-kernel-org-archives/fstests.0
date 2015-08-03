Received: from mx1.redhat.com ([209.132.183.28]:42293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbbHCDJr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 2 Aug 2015 23:09:47 -0400
Date: Mon, 3 Aug 2015 11:09:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: mount scratch before checking it
Message-ID: <20150803030943.GN17933@dhcp-13-216.nay.redhat.com>
References: <1438236489-24747-1-git-send-email-yangds.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438236489-24747-1-git-send-email-yangds.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, fdmanana@suse.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 30, 2015 at 02:08:09PM +0800, Dongsheng Yang wrote:
> We want to check the size of scratch with _require_fs_space,
> but we have to mount it firstly.
> 
> Reported-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/generic/038 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/038 b/tests/generic/038
> index 7bfebfc..4d108cf 100755
> --- a/tests/generic/038
> +++ b/tests/generic/038
> @@ -121,8 +121,8 @@ create_files()
>  }
>  
>  _scratch_mkfs >>$seqres.full 2>&1
> -_require_fs_space $SCRATCH_MNT $((10 * 1024 * 1024))
>  _scratch_mount
> +_require_fs_space $SCRATCH_MNT $((10 * 1024 * 1024))
>  _require_batched_discard $SCRATCH_MNT
>  
>  for ((i = 0; i < $((4 * $LOAD_FACTOR)); i++)); do
> -- 
> 1.8.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
