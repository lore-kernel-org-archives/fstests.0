Received: from mx1.redhat.com ([209.132.183.28]:51956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeAKHXZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Jan 2018 02:23:25 -0500
Date: Thu, 11 Jan 2018 15:23:23 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/5] fstests: filter: Introduce filter to filter out
 offset for xfs_io
Message-ID: <20180111072323.GF5123@eguan.usersys.redhat.com>
References: <20180111065601.5831-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111065601.5831-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 11, 2018 at 02:55:57PM +0800, Qu Wenruo wrote:
> Some test cases (AFAIK, btrfs RAID recovery test cases) read out certain
> location to verify its data.
> 
> Such read is mostly OK, but the golden output contains the on-disk
> offset, which can differ due to underlying chunk change.
> (This time is mkfs chunk layout change for btrfs)
> 
> So introduce macro _filter_xfs_io_offset to filter out the offset part
> wrote 65536/65536 bytes at offset 136708096
>                        ^^^^^^^^^^^^^^^^^^^^
> And offset from "pread -v"
> 08260000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> ^^^^^^^^^
> 
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/filter | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/common/filter b/common/filter
> index 9c33efac..77afcbc4 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -226,6 +226,15 @@ _filter_xfs_io()
>      sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.]* [EPGMKiBbytes]*\/sec and [infa0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
>  }
>  
> +# Also filter out the offset part of xfs_io output
> +# Some test cases may be affected by underlaying extent/chunk layout change,
> +# so wipe out this part to avoid golden output difference
> +_filter_xfs_io_offset()
> +{
> +    # filter out " at offset XXX" and offset of "pread -v"
> +    sed -e "s/ at offset [0-9]*$//" -e "s/^[0-9a-f]\+:/XXXXXXXX:/"
> +}
> +

I'd put _filter_xfs_io part of _filter_xfs_io_offset, so the callers
don't have to chain the filter themselves, e.g.

- $XFS_IO_PROG ... | _filter_xfs_io | _filter_xfs_io_offset
+ $XFS_IO_PROG ... | _filter_xfs_io_offset

And I perfer folding this 5-patch patchset into a single patch, so the
introduction and the usage of the new helper function together provide a
complete context in git log.

Thanks,
Eryu

>  # stderr filter for xfs_io to handle change of error output format (e.g.
>  # pwrite64 -> pwrite).
>  _filter_xfs_io_error()
> @@ -277,7 +286,6 @@ _filter_xfs_io_pages_modified()
>  	_filter_xfs_io_units_modified "Page" $PAGE_SIZE
>  }
>  
> -
>  _filter_test_dir()
>  {
>  	# TEST_DEV may be a prefix of TEST_DIR (e.g. /mnt, /mnt/ovl-mnt)
> -- 
> 2.15.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
