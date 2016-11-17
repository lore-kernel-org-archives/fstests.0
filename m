Received: from mx1.redhat.com ([209.132.183.28]:37944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbcKQF0O (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 17 Nov 2016 00:26:14 -0500
Date: Thu, 17 Nov 2016 13:26:11 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: test concurrent non-overlapping direct I/O on
 the same extents
Message-ID: <20161117052611.GX27776@eguan.usersys.redhat.com>
References: <1edb45d8895de8fe347e800a5fd22b0f6eafb181.1479342541.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edb45d8895de8fe347e800a5fd22b0f6eafb181.1479342541.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 16, 2016 at 04:29:34PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There have been a couple of logic bugs in `btrfs_get_extent()` which
> could lead to spurious -EEXIST errors from read or write. This test
> exercises those conditions by having two threads race to add an extent
> to the extent map.
> 
> This is fixed by Linux commit 8dff9c853410 ("Btrfs: deal with duplciates
> during extent_map insertion in btrfs_get_extent") and the patch "Btrfs:
> deal with existing encompassing extent map in btrfs_get_extent()"
> (http://marc.info/?l=linux-btrfs&m=147873402311143&w=2).
> 
> Although the bug is Btrfs-specific, nothing about the test is.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
[snip]
> +# real QA test starts here
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_xfs_io_command "falloc"
> +_require_test_program "dio-interleaved"
> +
> +extent_size="$(($(stat -f -c '%S' "$TEST_DIR") * 2))"

There's a helper to get fs block size: "get_block_size".

> +num_extents=1024
> +testfile="$TEST_DIR/$$-testfile"
> +
> +truncate -s 0 "$testfile"

I prefer using xfs_io to do the truncate, 

$XFS_IO_PROG -fc "truncate 0" "$testfile"

Because in rare cases truncate(1) may be unavailable, e.g. RHEL5,
usually it's not a big issue, but xfs_io works all the time, we have a
better way, so why not :)

> +for ((off = 0; off < num_extents * extent_size; off += extent_size)); do
> +	xfs_io -c "falloc $off $extent_size" "$testfile"

Use $XFS_IO_PROG not bare xfs_io.

I can fix all the tiny issues at commit time.

Thanks,
Eryu

> +done
> +
> +# To reproduce the Btrfs bug, the extent map must not be cached in memory.
> +sync
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +"$here/src/dio-interleaved" "$extent_size" "$num_extents" "$testfile"
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/390.out b/tests/generic/390.out
> new file mode 100644
> index 0000000..3c7b405
> --- /dev/null
> +++ b/tests/generic/390.out
> @@ -0,0 +1,2 @@
> +QA output created by 390
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 08007d7..d137d01 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -392,3 +392,4 @@
>  387 auto clone
>  388 auto log metadata
>  389 auto quick acl
> +390 auto quick rw
> -- 
> 2.10.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
