Received: from imap.thunk.org ([74.207.234.97]:34014 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeJKVND (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Oct 2018 17:13:03 -0400
Date: Thu, 11 Oct 2018 09:45:41 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4/018: fix mismatch wildcard with debugfs
Message-ID: <20181011134541.GA13429@thunk.org>
References: <20181011131410.3587-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011131410.3587-1-yuyufen@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Yufen Yu <yuyufen@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 11, 2018 at 09:14:10PM +0800, Yufen Yu wrote:
> For the new version of debugfs(v1.44.0+), it changes "File ACL:" format
> from "%sFile ACL: %llu    Directory ACL: %d\n" to "%sFile ACL: %llu\n".
> 
> Thus, update this case accordingly.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Thanks, I don't normally running -g fuzzers so I didn't notice this.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

> ---
>  tests/ext4/018 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/018 b/tests/ext4/018
> index 0116c5f7..eb6d827b 100755
> --- a/tests/ext4/018
> +++ b/tests/ext4/018
> @@ -55,7 +55,7 @@ echo "+ check fs"
>  e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
>  
>  echo "+ corrupt image"
> -blk="$(debugfs -R 'stat /attrfile' "${SCRATCH_DEV}" 2> /dev/null | grep 'File ACL:' | sed -e 's/^.*File ACL: \([0-9]*\).*Directory.*$/\1/g')"
> +blk="$(debugfs -R 'stat /attrfile' "${SCRATCH_DEV}" 2> /dev/null | grep 'File ACL:' | sed -e 's/^.*File ACL: \([0-9]*\)/\1/g')"
>  $XFS_IO_PROG -f -c "pwrite -S 0x62 $((blk * blksz + 20)) 8" "${SCRATCH_DEV}" >> $seqres.full
>  
>  echo "+ mount image"
> -- 
> 2.13.6
> 
