Received: from userp1040.oracle.com ([156.151.31.81]:18129 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334AbcE0RW6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 May 2016 13:22:58 -0400
Date: Fri, 27 May 2016 10:22:42 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/122: update against xfsprogs 4.5
Message-ID: <20160527172242.GA5050@birch.djwong.org>
References: <1464337935-29183-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464337935-29183-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 27, 2016 at 04:32:15PM +0800, Xiao Yang wrote:
> 1) add necessary version check for xfs/122
> 2} filter out reflink, rmap and rmapx related outputs
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc         |  8 ++++++++
>  tests/xfs/122     | 10 ++--------
>  tests/xfs/122.out |  5 -----
>  3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 51092a0..992a3af 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1654,6 +1654,14 @@ _require_xfs_crc()
>  	_scratch_unmount
>  }
>  
> +_require_xfs_version()
> +{
> +	local version=`_scratch_mkfs_xfs -V | awk '{split($3,ver,"."); print ver[1]*100 + ver[2]*10 + ver[3]}'`
> +	if [ $version -lt $1 ]; then
> +		_notrun "this test requires higher xfsprogs"
> +	fi
> +}
> +
>  # this test requires the ext4 kernel support crc feature on scratch device
>  #
>  _require_scratch_ext4_crc()
> diff --git a/tests/xfs/122 b/tests/xfs/122
> index 845cdd2..945c979 100755
> --- a/tests/xfs/122
> +++ b/tests/xfs/122
> @@ -224,20 +224,14 @@ echo 'return 0; }' >>$cprog
>  # create and run program
>  cc -o $oprog $cprog >> $seqres.full 2>&1 || \
>    _notrun "Could not compile test program (see end of $seqres.full)"
> -$oprog | _type_size_filter | _type_name_filter > $progout
> +$oprog | _type_size_filter | _type_name_filter | egrep -v 'xfs_refcount.*|xfs_rmap.*' > $progout

NAK.  Do not unconditionally mask out ondisk structures; this makes it
impossible to detect structure size mutations in the future, which is
exactly the point of this testcase.

I was hoping you'd change the testcase to find the structures listed
in the golden output and not listed in the program output, and copy
just those lines into the program output.  Those lines would prevent
false errors for structs that the old xfsprogs doesn't know about.

Oh well, I'm nearly done with a PoC patch to do that, so I'll post
that instead.

--D

>  
>  #
>  # add addition sizes and xfs_sb_t fields that don't exist in the version
>  # being tested.
>  #
>  
> -# xfsprogs 2.9.8: sb_bad_features2 in pv 978822
> -if [ $XFSPROGS_VERSION -lt 20908 ]; then
> -	echo 'offsetof(xfs_sb_t, sb_bad_features2 ) = 204' >>$progout
> -fi
> -if [ $XFSPROGS_VERSION -lt 30000 ]; then
> -	echo 'sizeof( xfs_dsb_t ) = 208' >>$progout;
> -fi
> +_require_xfs_version 450
>  
>  LC_COLLATE=POSIX sort $progout
>  
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index 451871e..8ba121e 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -75,11 +75,6 @@ sizeof(struct xfs_extent_data) = 24
>  sizeof(struct xfs_extent_data_info) = 32
>  sizeof(struct xfs_fs_eofblocks) = 128
>  sizeof(struct xfs_icreate_log) = 28
> -sizeof(struct xfs_refcount_key) = 4
> -sizeof(struct xfs_refcount_rec) = 12
> -sizeof(struct xfs_rmap_key) = 4
> -sizeof(struct xfs_rmap_rec) = 24
> -sizeof(struct xfs_rmapx_key) = 20
>  sizeof(xfs_agf_t) = 224
>  sizeof(xfs_agfl_t) = 36
>  sizeof(xfs_agi_t) = 336
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
