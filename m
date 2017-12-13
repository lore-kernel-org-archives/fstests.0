Received: from userp2130.oracle.com ([156.151.31.86]:57616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbdLMRge (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Dec 2017 12:36:34 -0500
Date: Wed, 13 Dec 2017 09:36:29 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/466: be more precise about which block sizes to
 use
Message-ID: <20171213173629.GG6896@magnolia>
References: <20171211172742.3490-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211172742.3490-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 11, 2017 at 12:27:42PM -0500, Theodore Ts'o wrote:
> The test previously blindly tried block sizes from 512 to 65536 and
> relied on mkfs to fail.  This is problematic for a number of file
> systems.  For example, when testing btrfs, _scratch_mkfs_sized simply
> ignores the blocksize, so the test will pointlessly run the same test
> multiple times.  For ext4, when encryption is enabled, the only block
> size which is supported is the page size.
> 
> So define two new functions _fs_min_blocksize and _fs_max_blocksize,
> and use it so that generic/466 will only try using the block sizes
> that will work.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/rc         | 23 +++++++++++++++++++++++
>  tests/generic/466 |  6 +++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 59d4b961..7aa747ad 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1067,6 +1067,29 @@ _scratch_mkfs_blocksized()
>      esac
>  }
>  
> +_fs_min_blocksize()
> +{
> +    case $FSTYP in
> +    ext4)
> +	if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
> +	    get_page_size
> +	else
> +            echo 1024
> +	fi
> +       ;;
> +    btrfs)
> +	get_page_size
> +	;;
> +    *)
> +	echo 512

FWIW XFS' minimum block size is 1k for v5 filesystems, though you can't
really tell until you run mkfs.xfs -N.

> +    esac
> +}
> +
> +_fs_max_blocksize()
> +{
> +    get_page_size

Also, one can run xfstests against a fuse2fs-mounted 64k-block ext4 fs.

--D

> +}
> +
>  _scratch_resvblks()
>  {
>  	case $FSTYP in
> diff --git a/tests/generic/466 b/tests/generic/466
> index 07f24a74..a1d944d3 100755
> --- a/tests/generic/466
> +++ b/tests/generic/466
> @@ -54,7 +54,11 @@ unset MKFS_OPTIONS
>  
>  echo "Starting test" > $seqres.full
>  devsize=$(blockdev --getsize64 $SCRATCH_DEV)
> -for blocksize in 512 1024 2048 4096 8192 16384 32768 65536; do
> +min_blocksize=$(_fs_min_blocksize)
> +max_blocksize=$(_fs_max_blocksize)
> +
> +for (( blocksize = min_blocksize ; blocksize <= max_blocksize ;
> +       blocksize = blocksize * 2)); do
>  	echo "+ Format blocksize $blocksize and mount" >> $seqres.full
>  	_scratch_unmount > /dev/null 2>&1
>  	# Try to format and mount with the given blocksize.  If they don't
> -- 
> 2.11.0.rc0.7.gbe5a750
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
