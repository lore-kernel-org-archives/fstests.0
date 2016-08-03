Date: Wed, 3 Aug 2016 18:38:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 09/17] common/dmerror: fix mount option issues
Message-ID: <20160803103800.GO27776@eguan.usersys.redhat.com>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914483353.11762.14647880235199676753.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914483353.11762.14647880235199676753.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:47:13PM -0700, Darrick J. Wong wrote:
> Calling _mount doesn't work when we want to add mount options
> such as realtime devices.  Since it's just a normal scratch device
> mount except for the source device, just call _scratch_mount with
> SCRATCH_DEV set to the dmerror device.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  common/dmerror |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> 
> diff --git a/common/dmerror b/common/dmerror
> index 5ad9994..22b9ea9 100644
> --- a/common/dmerror
> +++ b/common/dmerror
> @@ -41,14 +41,9 @@ _dmerror_init()
>  	DMERROR_TABLE="0 $blk_dev_size error $dm_backing_dev 0"
>  }
>  
> -_dmerror_mount_options()
> -{
> -	echo `_common_dev_mount_options $*` $DMERROR_DEV $SCRATCH_MNT
> -}
> -
>  _dmerror_mount()
>  {
> -	_mount -t $FSTYP `_dmerror_mount_options $*`
> +	SCRATCH_DEV=$DMERROR_DEV _scratch_mount $*

Perhaps you can add "_scratch_options mount" to _dmerror_mount then
mount with $SCRATCH_OPTIONS? Like what _mount_delay does in
common/dmdelay.

Thanks,
Eryu

>  }
>  
>  _dmerror_unmount()
> 
