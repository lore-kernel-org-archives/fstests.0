Received: from mx1.redhat.com ([209.132.183.28]:54028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753623AbcLLJsX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Dec 2016 04:48:23 -0500
Date: Mon, 12 Dec 2016 17:48:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/7] ocfs2/reflink: fix file block size reporting
Message-ID: <20161212094820.GY29149@eguan.usersys.redhat.com>
References: <148149316504.31093.16129068344227450710.stgit@birch.djwong.org>
 <148149317758.31093.14955725683270205488.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148149317758.31093.14955725683270205488.stgit@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: ocfs2-devel@oss.oracle.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 11, 2016 at 01:52:57PM -0800, Darrick J. Wong wrote:
> Some of the reflink tests try to require a specific filesystem block
> size so that they can test file block manipulation functions.  That's
> straightforward for most filesystems but ocfs2 throws in the additional
> twist that data fork block mappings are stored in units of clusters, not
> blocks, which causes these reflink tests to fail.
> 
> Therefore, introduce a new helper that retrieves the file minimum block
> size and adapt the reflink tests to use that instead.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  common/rc         |   21 +++++++++++++++++++--
>  tests/generic/205 |    2 +-
>  tests/generic/206 |    2 +-
>  tests/generic/216 |    2 +-
>  tests/generic/217 |    2 +-
>  tests/generic/218 |    2 +-
>  tests/generic/220 |    2 +-
>  tests/generic/222 |    2 +-
>  tests/generic/227 |    2 +-
>  tests/generic/229 |    2 +-
>  tests/generic/238 |    2 +-
>  11 files changed, 29 insertions(+), 12 deletions(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index 2639fbd..30111d4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -925,7 +925,7 @@ _scratch_mkfs_blocksized()
>  	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
>  	;;
>      ocfs2)
> -	yes | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
> +	yes | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
>  	;;
>      *)
>  	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
> @@ -3029,13 +3029,30 @@ _sysfs_dev()
>  	echo /sys/dev/block/$_maj:$_min
>  }
>  
> +# Get the minimum block size of a file.  Usually this is the
> +# minimum fs block size, but some filesystems (ocfs2) do block
> +# mappings in larger units.
> +get_file_block_size()

Name it with leading underscore? As it's a common helper.

> +{
> +	if [ -z $1 ] || [ ! -d $1 ]; then
> +		echo "Missing mount point argument for get_file_block_size"
> +		exit 1
> +	fi
> +	if [ "$FSTYP" = "ocfs2" ]; then
> +		stat -c '%o' $1
> +	else
> +		stat -f -c '%S' $1

We can use "get_block_size $1" here.

> +	fi
> +}
> +
> +# Get the minimum block size of an fs.
>  get_block_size()

We should rename it with a underscore too, but probably in an different
patch.

Thanks,
Eryu
