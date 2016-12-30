Received: from mx1.redhat.com ([209.132.183.28]:48614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbcL3GSB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Dec 2016 01:18:01 -0500
Date: Fri, 30 Dec 2016 14:17:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] fstests: btrfs/006: Fix false alert due to output
 change
Message-ID: <20161230061759.GG1859@eguan.usersys.redhat.com>
References: <20161230041410.10038-1-suy.fnst@cn.fujitsu.com>
 <20161230041410.10038-2-suy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161230041410.10038-2-suy.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Su Yue <suy.fnst@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 29, 2016 at 11:14:10PM -0500, Su Yue wrote:
> Btrfs-progs v4.9 changed "device status" output by adding one more
> space, which differs from golden output.
> 
> Fix it by introducing new filter to convert multi space into one.
> 
> Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>
> ---
>  common/filter       |  6 ++++++
>  tests/btrfs/006     | 16 ++++++++++++----
>  tests/btrfs/006.out | 24 ++++++++++++------------
>  3 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 397b456..4d5e4d0 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -401,5 +401,11 @@ _filter_mknod()
>  	sed -e "s/mknod: [\`']\(.*\)': File exists/mknod: \1: File exists/"
>  }
>  
> +# Filter spaces into one
> +_filter_spaces()
> +{
> +	sed -e "s/\s\+/ /g"
> +}
> +

There's already one such filter with the same name in common/filter,
does this existing helper work for you?

>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/btrfs/006 b/tests/btrfs/006
> index 0863394..dc9bfb9 100755
> --- a/tests/btrfs/006
> +++ b/tests/btrfs/006
> @@ -82,13 +82,21 @@ echo "== Sync filesystem"
>  $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT > /dev/null
>  
>  echo "== Show device stats by mountpoint"
> -$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_btrfs_device_stats $TOTAL_DEVS
> +$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | \
> +       	_filter_btrfs_device_stats $TOTAL_DEVS | \

Spaces before tab in above line.

Thanks,
Eryu

> +	_filter_spaces
>  echo "== Show device stats by first/scratch dev"
> -$BTRFS_UTIL_PROG device stats $SCRATCH_DEV | _filter_btrfs_device_stats
> +$BTRFS_UTIL_PROG device stats $SCRATCH_DEV | \
> +	_filter_btrfs_device_stats | \
> +	_filter_spaces
>  echo "== Show device stats by second dev"
> -$BTRFS_UTIL_PROG device stats $FIRST_POOL_DEV | sed -e "s,$FIRST_POOL_DEV,FIRST_POOL_DEV,g"
> +$BTRFS_UTIL_PROG device stats $FIRST_POOL_DEV | \
> +	sed -e "s,$FIRST_POOL_DEV,FIRST_POOL_DEV,g" | \
> +	_filter_spaces
>  echo "== Show device stats by last dev"
> -$BTRFS_UTIL_PROG device stats $LAST_POOL_DEV | sed -e "s,$LAST_POOL_DEV,LAST_POOL_DEV,g"
> +$BTRFS_UTIL_PROG device stats $LAST_POOL_DEV | \
> +	sed -e "s,$LAST_POOL_DEV,LAST_POOL_DEV,g" | \
> +	_filter_spaces
>  
>  # success, all done
>  status=0
> diff --git a/tests/btrfs/006.out b/tests/btrfs/006.out
> index 05b9ac0..a976972 100644
> --- a/tests/btrfs/006.out
> +++ b/tests/btrfs/006.out
> @@ -16,25 +16,25 @@ Label: 'TestLabel.006'  uuid: <EXACTUUID>
>  == Sync filesystem
>  == Show device stats by mountpoint
>  <NUMDEVS> [SCRATCH_DEV].corruption_errs <NUM>
> -<NUMDEVS> [SCRATCH_DEV].flush_io_errs   <NUM>
> +<NUMDEVS> [SCRATCH_DEV].flush_io_errs <NUM>
>  <NUMDEVS> [SCRATCH_DEV].generation_errs <NUM>
> -<NUMDEVS> [SCRATCH_DEV].read_io_errs    <NUM>
> -<NUMDEVS> [SCRATCH_DEV].write_io_errs   <NUM>
> +<NUMDEVS> [SCRATCH_DEV].read_io_errs <NUM>
> +<NUMDEVS> [SCRATCH_DEV].write_io_errs <NUM>
>  == Show device stats by first/scratch dev
>  [SCRATCH_DEV].corruption_errs <NUM>
> -[SCRATCH_DEV].flush_io_errs   <NUM>
> +[SCRATCH_DEV].flush_io_errs <NUM>
>  [SCRATCH_DEV].generation_errs <NUM>
> -[SCRATCH_DEV].read_io_errs    <NUM>
> -[SCRATCH_DEV].write_io_errs   <NUM>
> +[SCRATCH_DEV].read_io_errs <NUM>
> +[SCRATCH_DEV].write_io_errs <NUM>
>  == Show device stats by second dev
> -[FIRST_POOL_DEV].write_io_errs   0
> -[FIRST_POOL_DEV].read_io_errs    0
> -[FIRST_POOL_DEV].flush_io_errs   0
> +[FIRST_POOL_DEV].write_io_errs 0
> +[FIRST_POOL_DEV].read_io_errs 0
> +[FIRST_POOL_DEV].flush_io_errs 0
>  [FIRST_POOL_DEV].corruption_errs 0
>  [FIRST_POOL_DEV].generation_errs 0
>  == Show device stats by last dev
> -[LAST_POOL_DEV].write_io_errs   0
> -[LAST_POOL_DEV].read_io_errs    0
> -[LAST_POOL_DEV].flush_io_errs   0
> +[LAST_POOL_DEV].write_io_errs 0
> +[LAST_POOL_DEV].read_io_errs 0
> +[LAST_POOL_DEV].flush_io_errs 0
>  [LAST_POOL_DEV].corruption_errs 0
>  [LAST_POOL_DEV].generation_errs 0
> -- 
> 2.9.3
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
