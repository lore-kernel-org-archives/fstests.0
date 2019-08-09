Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55271 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405571AbfHIJrw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Aug 2019 05:47:52 -0400
Date: Fri, 9 Aug 2019 17:47:37 +0800
From: Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [PATCH] generic/322: remove bad xfs_io sync_range
Message-ID: <20190809094737.GG52397@e18g06458.et15sqa>
References: <20190805222738.21422-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805222738.21422-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 06, 2019 at 12:27:38AM +0200, Andreas Gruenbacher wrote:
> The xfs_io sync_range command requires offset and length arguments.  Those are
> missing here, so the command fails with:
> 
>   bad argument count 1 to sync_range, expected at least 2 arguments
> 
> This went unnoticed because xfs_io still exits with status 0 in such cases,
> which looks like a separate bug.

Yes, fstests should not rely on return status of xfs_io.

> 
> I'm assuming that the test did catch regressions as is and that the sync_range
> command isn't needed.  If this isn't the case, please fix the test.

Josef, would you please confirm?

> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  tests/generic/322 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/322 b/tests/generic/322
> index 2afd7127..22797c04 100755
> --- a/tests/generic/322
> +++ b/tests/generic/322
> @@ -65,7 +65,7 @@ _write_after_fsync_rename_test()
>  	echo "fsync rename test"
>  	_mount_flakey
>  	$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" -c "pwrite 2M 1M" \
> -		-c "sync_range -b" $SCRATCH_MNT/foo > $seqres.full 2>&1 || _fail "xfs_io failed"
> +		$SCRATCH_MNT/foo > $seqres.full 2>&1 || _fail "xfs_io failed"

We don't need the "_fail" part then, and appending xfs_io log to
$seqres.full, not overwriting. The same is true for _rename_test().

Thanks,
Eryu

>  	mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
>  	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
>  	md5sum $SCRATCH_MNT/bar | _filter_scratch
> -- 
> 2.20.1
