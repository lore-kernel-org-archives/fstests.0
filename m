Received: from userp2120.oracle.com ([156.151.31.85]:54254 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438040AbfFLQY5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jun 2019 12:24:57 -0400
Date: Wed, 12 Jun 2019 09:24:49 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/191: update mkfs.xfs input results
Message-ID: <20190612162449.GC1872778@magnolia>
References: <1560340921-2622-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560340921-2622-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 12, 2019 at 08:02:01PM +0800, Yang Xu wrote:
> Currently, on 5.2.0-rc4+ kernel, when I run xfs/191-input-validation with upstream xfsprogs,
> I get the following errors because mkfs.xfs binary has changed a lot.
> 
> --------------------------
> PLATFORM      -- Linux/x86_64  5.2.0-rc4+
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda11
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda11 /mnt/xfstests/scratch
> 
> pass -n size=2b /dev/sda11
> pass -d agsize=8192b /dev/sda11
> pass -d agsize=65536s /dev/sda11
> pass -d su=0,sw=64 /dev/sda11
> pass -d su=4096s,sw=64 /dev/sda11
> pass -d su=4096b,sw=64 /dev/sda11
> pass -l su=10b /dev/sda11
> fail -n log=15 /dev/sda11
> fail -i log=10 /dev/sda11
> --------------------------
> 
> "pass -d su=0,sw=64 /dev/sda11", expect fail, this behavior has been fixed by commit 16adcb88:
> (mkfs: more sunit/swidth sanity checking).
> 
> "fail -n log=15 /dev/sda11" "fail -i log=10 /dev/sda11", expect pass, this option has been removed
> since commit 2cf637c(mkfs: remove logarithm based CLI option).
> 
> Also, if I enable reflink(I see Darrick will enable it by default on for-next branch), "-r rtdev"
> fails because reflink was not supported in realtime devices since commit bfa66ec.

This particular check probably needs to get smarter about detecting
whether the mkfs supports reflink and explicitly setting reflink=0.  I
don't see rt reflink getting supported any time soon (unless someone
steps up to review the metadir series...)

> I change the expected result for compatibility with current xfsprogs.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Seems fine to me, but do the other xfs maintainers have opinions (about
this test which we've been dragging behind the boat for years)?

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/191-input-validation | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
> index b6658015..87953c2d 100755
> --- a/tests/xfs/191-input-validation
> +++ b/tests/xfs/191-input-validation
> @@ -112,10 +112,11 @@ do_mkfs_fail -b size=2b $SCRATCH_DEV
>  do_mkfs_fail -b size=nfi $SCRATCH_DEV
>  do_mkfs_fail -b size=4096nfi $SCRATCH_DEV
>  do_mkfs_fail -n size=2s $SCRATCH_DEV
> -do_mkfs_fail -n size=2b $SCRATCH_DEV
>  do_mkfs_fail -n size=nfi $SCRATCH_DEV
>  do_mkfs_fail -n size=4096nfi $SCRATCH_DEV
>  
> +do_mkfs_pass -n size=2b $SCRATCH_DEV
> +
>  # bad label length
>  do_mkfs_fail -L thisiswaytoolong $SCRATCH_DEV
>  
> @@ -129,6 +130,8 @@ do_mkfs_pass -d agsize=32M $SCRATCH_DEV
>  do_mkfs_pass -d agsize=1g $SCRATCH_DEV
>  do_mkfs_pass -d agsize=$((32 * 1024 * 1024)) $SCRATCH_DEV
>  do_mkfs_pass -b size=4096 -d agsize=8192b $SCRATCH_DEV
> +do_mkfs_pass -d agsize=8192b $SCRATCH_DEV
> +do_mkfs_pass -d agsize=65536s $SCRATCH_DEV
>  do_mkfs_pass -d sectsize=512,agsize=65536s $SCRATCH_DEV
>  do_mkfs_pass -s size=512 -d agsize=65536s $SCRATCH_DEV
>  do_mkfs_pass -d noalign $SCRATCH_DEV
> @@ -136,7 +139,10 @@ do_mkfs_pass -d sunit=0,swidth=0 $SCRATCH_DEV
>  do_mkfs_pass -d sunit=8,swidth=8 $SCRATCH_DEV
>  do_mkfs_pass -d sunit=8,swidth=64 $SCRATCH_DEV
>  do_mkfs_pass -d su=0,sw=0 $SCRATCH_DEV
> +do_mkfs_pass -d su=0,sw=64 $SCRATCH_DEV
>  do_mkfs_pass -d su=4096,sw=1 $SCRATCH_DEV
> +do_mkfs_pass -d su=4096s,sw=64 $SCRATCH_DEV
> +do_mkfs_pass -d su=4096b,sw=64 $SCRATCH_DEV
>  do_mkfs_pass -d su=4k,sw=1 $SCRATCH_DEV
>  do_mkfs_pass -d su=4K,sw=8 $SCRATCH_DEV
>  do_mkfs_pass -b size=4096 -d su=1b,sw=8 $SCRATCH_DEV
> @@ -147,8 +153,6 @@ do_mkfs_pass -s size=512 -d su=8s,sw=8 $SCRATCH_DEV
>  do_mkfs_fail -d size=${fssize}b $SCRATCH_DEV
>  do_mkfs_fail -d size=${fssize}s $SCRATCH_DEV
>  do_mkfs_fail -d size=${fssize}yerk $SCRATCH_DEV
> -do_mkfs_fail -d agsize=8192b $SCRATCH_DEV
> -do_mkfs_fail -d agsize=65536s $SCRATCH_DEV
>  do_mkfs_fail -d agsize=32Mbsdfsdo $SCRATCH_DEV
>  do_mkfs_fail -d agsize=1GB $SCRATCH_DEV
>  do_mkfs_fail -d agcount=1k $SCRATCH_DEV
> @@ -159,13 +163,10 @@ do_mkfs_fail -d sunit=64,swidth=0 $SCRATCH_DEV
>  do_mkfs_fail -d sunit=64,swidth=64,noalign $SCRATCH_DEV
>  do_mkfs_fail -d sunit=64k,swidth=64 $SCRATCH_DEV
>  do_mkfs_fail -d sunit=64,swidth=64m $SCRATCH_DEV
> -do_mkfs_fail -d su=0,sw=64 $SCRATCH_DEV
>  do_mkfs_fail -d su=4096,sw=0 $SCRATCH_DEV
>  do_mkfs_fail -d su=4097,sw=1 $SCRATCH_DEV
>  do_mkfs_fail -d su=4096,sw=64,noalign $SCRATCH_DEV
>  do_mkfs_fail -d su=4096,sw=64s $SCRATCH_DEV
> -do_mkfs_fail -d su=4096s,sw=64 $SCRATCH_DEV
> -do_mkfs_fail -d su=4096b,sw=64 $SCRATCH_DEV
>  do_mkfs_fail -d su=4096garabge,sw=64 $SCRATCH_DEV
>  do_mkfs_fail -d su=4096,sw=64,sunit=64,swidth=64 $SCRATCH_DEV
>  do_mkfs_fail -d sectsize=10,agsize=65536s $SCRATCH_DEV
> @@ -206,6 +207,7 @@ do_mkfs_pass -l sunit=64 $SCRATCH_DEV
>  do_mkfs_pass -l sunit=64 -d sunit=8,swidth=8 $SCRATCH_DEV
>  do_mkfs_pass -l sunit=8 $SCRATCH_DEV
>  do_mkfs_pass -l su=$((4096*10)) $SCRATCH_DEV
> +do_mkfs_pass -l su=10b $SCRATCH_DEV
>  do_mkfs_pass -b size=4096 -l su=10b $SCRATCH_DEV
>  do_mkfs_pass -l sectsize=512,su=$((4096*10)) $SCRATCH_DEV
>  do_mkfs_pass -l internal $SCRATCH_DEV
> @@ -228,7 +230,6 @@ do_mkfs_fail -l agnum=32 $SCRATCH_DEV
>  do_mkfs_fail -l sunit=0  $SCRATCH_DEV
>  do_mkfs_fail -l sunit=63 $SCRATCH_DEV
>  do_mkfs_fail -l su=1 $SCRATCH_DEV
> -do_mkfs_fail -l su=10b $SCRATCH_DEV
>  do_mkfs_fail -l su=10s $SCRATCH_DEV
>  do_mkfs_fail -l su=$((4096*10+1)) $SCRATCH_DEV
>  do_mkfs_fail -l sectsize=10,agsize=65536s $SCRATCH_DEV
> @@ -246,7 +247,6 @@ do_mkfs_fail -l version=0  $SCRATCH_DEV
>  
>  # naming section, should pass
>  do_mkfs_pass -n size=65536 $SCRATCH_DEV
> -do_mkfs_pass -n log=15 $SCRATCH_DEV
>  do_mkfs_pass -n version=2 $SCRATCH_DEV
>  do_mkfs_pass -n version=ci $SCRATCH_DEV
>  do_mkfs_pass -n ftype=0 -m crc=0 $SCRATCH_DEV
> @@ -257,6 +257,7 @@ do_mkfs_fail -n version=1 $SCRATCH_DEV
>  do_mkfs_fail -n version=cid $SCRATCH_DEV
>  do_mkfs_fail -n ftype=4 $SCRATCH_DEV
>  do_mkfs_fail -n ftype=0 $SCRATCH_DEV
> +do_mkfs_fail -n log=15 $SCRATCH_DEV
>  
>  reset_fsimg
>  
> @@ -280,7 +281,6 @@ do_mkfs_pass -r extsize=1G $SCRATCH_DEV
>  do_mkfs_pass -r size=65536,rtdev=$fsimg $SCRATCH_DEV
>  do_mkfs_pass -r noalign $SCRATCH_DEV
>  
> -
>  # realtime section, should fail
>  do_mkfs_fail -r rtdev=$SCRATCH_DEV
>  do_mkfs_fail -r extsize=256 $SCRATCH_DEV
> @@ -293,7 +293,6 @@ do_mkfs_fail -r size=65536 $SCRATCH_DEV
>  do_mkfs_pass -i size=256 -m crc=0 $SCRATCH_DEV
>  do_mkfs_pass -i size=512 $SCRATCH_DEV
>  do_mkfs_pass -i size=2048 $SCRATCH_DEV
> -do_mkfs_pass -i log=10 $SCRATCH_DEV
>  do_mkfs_pass -i perblock=2 $SCRATCH_DEV
>  do_mkfs_pass -i maxpct=10 $SCRATCH_DEV
>  do_mkfs_pass -i maxpct=100 $SCRATCH_DEV
> @@ -317,6 +316,8 @@ do_mkfs_fail -i align=2 $SCRATCH_DEV
>  do_mkfs_fail -i sparse -m crc=0 $SCRATCH_DEV
>  do_mkfs_fail -i align=0 -m crc=1 $SCRATCH_DEV
>  do_mkfs_fail -i attr=1 -m crc=1 $SCRATCH_DEV
> +do_mkfs_fail -i log=10 $SCRATCH_DEV
> +
>  
>  status=0
>  exit
> -- 
> 2.18.1
> 
> 
> 
