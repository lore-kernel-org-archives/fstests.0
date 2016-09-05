Received: from mx1.redhat.com ([209.132.183.28]:58068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754601AbcIEFeD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 5 Sep 2016 01:34:03 -0400
Date: Mon, 5 Sep 2016 13:33:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ext4/021: add -F flag for xfs_io
Message-ID: <20160905053356.GL27776@eguan.usersys.redhat.com>
References: <1472824535-24928-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472824535-24928-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 02, 2016 at 09:55:35PM +0800, Xiao Yang wrote:
> xfs_io needs -F flag to write data in non-XFS filesystem on xfsprogs 3.1.1.
> The -F flag has been removed from usage() & man pages since xfsprogs 3.1.8,
> but is still accepted.  Please see the following commit d1b8818
> ("xfs_io: deprecate the "-F" foreign flag")
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/ext4/021 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/021 b/tests/ext4/021
> index d758818..f82d7fb 100755
> --- a/tests/ext4/021
> +++ b/tests/ext4/021
> @@ -80,7 +80,7 @@ fi
>  # disk, the s_squence offset to the beginning of journal superblock is 24
>  # we do this to let jbd2 start to run with a initial big transaction id,
>  # which will reduce the time taken to trigger this bug.
> -xfs_io  -c "pwrite -S 0x81 $((offset+24)) 1" \
> +xfs_io -F -c "pwrite -S 0x81 $((offset+24)) 1" \

Use $XFS_IO_PROG and "-F" is added when needed. See init_rc().

        # Figure out if we need to add -F ("foreign", deprecated) option to xfs_io                                                                                                             
        xfs_io -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \                                                                                                             
        export XFS_IO_PROG="$XFS_IO_PROG -F"

Thanks,
Eryu

>  	-c "pwrite -S 0xd1 $((offset+25)) 1" \
>  	-c "pwrite -S 0xa4 $((offset+26)) 1" \
>  	-c "pwrite -S 0x80 $((offset+27)) 1" $SCRATCH_DEV >> $seqres.full 2>&1
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
