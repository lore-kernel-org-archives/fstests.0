Received: from mail-pg0-f68.google.com ([74.125.83.68]:39203 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759316AbeD1Dc6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Apr 2018 23:32:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id b9-v6so2840736pgf.6
        for <fstests@vger.kernel.org>; Fri, 27 Apr 2018 20:32:58 -0700 (PDT)
Date: Sat, 28 Apr 2018 11:32:54 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH][RESEND] generic/441: whitelist gfs2 for full test
Message-ID: <20180428033254.GS11384@desktop>
References: <20180427163327.20442-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427163327.20442-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Jeff,

On Fri, Apr 27, 2018 at 12:33:27PM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> gfs2 passes the full-scale generic/441 test with the patch that
> converts it to use errseq_t reporting for fsync.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Sorry for letting you resend the same patch again and again, but I
didn't get any feedback on my previous replies to the patch.

Please see
https://patchwork.kernel.org/patch/9868465/
https://patchwork.kernel.org/patch/9952475/

> ---
>  tests/generic/441 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/441 b/tests/generic/441
> index 5fbfececadc0..be903fbf94f8 100755
> --- a/tests/generic/441
> +++ b/tests/generic/441
> @@ -58,7 +58,7 @@ case $FSTYP in
>  	btrfs)
>  		_notrun "btrfs has a specialized test for this"
>  		;;
> -	ext3|ext4|xfs)
> +	ext3|ext4|gfs2|xfs)
>  		# Do the more thorough test if we have a logdev
>  		_has_logdev && sflag=''

So my concern remains, _scratch_mkfs doesn't create gfs2 with external
log device even if we set SCRATCH_LOGDEV and USE_EXTERNAL=yes, i.e.
_has_logdev returns true. So with this modification, gfs2 still runs
with internal log (and test still *fails* with v4.16 kernel, I hit the
same failure as in the second link above).

If running gfs2 test with internal log is expected, I think we can run
the test in full-scale mode unconditionally for gfs2, as suggested in
above two replies. i.e. something like

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

If gfs2 really requires external log to run in full-scale test, I think
we should also add external log device support to _scratch_mkfs().

Any comments?

Thanks,
Eryu
