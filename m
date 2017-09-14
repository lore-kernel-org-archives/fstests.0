Received: from mx1.redhat.com ([209.132.183.28]:40680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdINGQm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 14 Sep 2017 02:16:42 -0400
Date: Thu, 14 Sep 2017 14:16:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [xfstests PATCH][RESEND] generic/441: whitelist gfs2 for full
 test
Message-ID: <20170914061638.GF8034@eguan.usersys.redhat.com>
References: <20170728104827.7260-1-jlayton@kernel.org>
 <20170913130400.23185-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913130400.23185-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, cluster-devel@redhat.com
List-ID: <fstests@vger.kernel.org>

Hi Jeff,

On Wed, Sep 13, 2017 at 09:04:00AM -0400, Jeff Layton wrote:
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

Seems you missed my previous reply to this patch on July 31st, or my
reply didn't hit the list at all..

Anyway, gfs2 has no external log device support yet in _scratch_mkfs,
gfs2 was created with internal log even _has_logdev returned true. So if
test still passes with patched gfs2 in this case, I think we can test
gfs2 in full-scale mode unconditionally? e.g.

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

But I pulled & built the latest Linus tree (which contains commit
d07a6ac7b6f8 ("gfs2: convert to errseq_t based writeback error reporting
for fsync")), and generic/441 still fails on gfs2 in the full-scale test
setup, and this doesn't match the commit log. Are there any additional
fixes required? Or did I miss anything?

--- tests/generic/441.out       2017-09-05 13:14:52.768000000 +0800
+++ /root/workspace/xfstests/results//gfs2/generic/441.out.bad  2017-09-14 13:03:57.280000000 +0800
@@ -1,3 +1,3 @@
 QA output created by 441
 Format and mount
-Test passed!
+Third fsync on fd[0] failed: Input/output error

Thanks,
Eryu

>  		# Do the more thorough test if we have a logdev
>  		_has_logdev && sflag=''
>  		;;
> -- 
> 2.13.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
