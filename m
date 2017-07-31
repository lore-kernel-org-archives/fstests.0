Received: from mx1.redhat.com ([209.132.183.28]:57204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbdGaItL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 31 Jul 2017 04:49:11 -0400
Date: Mon, 31 Jul 2017 16:49:07 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/441: whitelist gfs2 for full test
Message-ID: <20170731084907.GH9167@eguan.usersys.redhat.com>
References: <20170728104827.7260-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728104827.7260-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, cluster-devel@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 28, 2017 at 06:48:27AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> gfs2 passes the full-scale generic/441 test with the patch that
> converts it to use errseq_t reporting for fsync.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  tests/generic/441 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/441 b/tests/generic/441
> index 075d87723ca1..b98f709cb6eb 100755
> --- a/tests/generic/441
> +++ b/tests/generic/441
> @@ -55,7 +55,7 @@ case $FSTYP in
>  	btrfs)
>  		_notrun "btrfs has a specialized test for this"
>  		;;
> -	ext3|ext4|xfs)
> +	ext3|ext4|gfs2|xfs)

gfs2 has no external log device support yet in _scratch_mkfs, so if test
still passes with patched gfs2 in this case, I think we can test gfs2 in
full-scale mode unconditionally? e.g.

	ext3|ext4|xfs)
 		# Do the more thorough test if we have a logdev
 		_has_logdev && sflag=''
 		;;
	gfs2)
		# <comments here>
		sflag=''
		;;
	*)
		;;

Thanks,
Eryu
