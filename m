Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53288 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbbBYQLz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Feb 2015 11:11:55 -0500
Date: Wed, 25 Feb 2015 11:11:51 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 1/4] xfs/104: log size too small for 4k sector drives
Message-ID: <20150225161151.GC28053@bfoster.bfoster>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
 <1424818479-10083-2-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424818479-10083-2-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 25, 2015 at 09:54:36AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> xfs/104, xfs/119, xfs/291 and xfs/297 have small fixed log sizes. A
> recent change to the kernel ramdisk changed it's physical sector
> size from 512B to 4kB, and this results in mkfs calculating a log
> size larger than the fixed test size and hence the tests fail.
> 
> Change the log size to a larger size that works with 4k sectors, and
> also increase the size of the filesystem being created so that the
> amount of data space in the filesystem does not change and hence
> does not perturb the rest of the test.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Well for some reason I can't mount a ramdisk on the current tot to test
this. In fact, I can't mount _anything_ after the ramdisk mount attempt.
The mount actually reports success too, but there's nothing there... :/

# modprobe brd
# mkfs.xfs -f /dev/ram0 
meta-data=/dev/ram0              isize=256    agcount=1, agsize=4096
blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=0        finobt=0
data     =                       bsize=4096   blocks=4096, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=0
log      =internal log           bsize=4096   blocks=1605, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
# mount /dev/ram0 /mnt/
# mount | grep mnt
# umount  /mnt/
umount: /mnt/: not mounted

... and then I can't even mount my normal scratch device until after a
reboot:

# mount /dev/test/scratch /mnt/
# mount | grep mnt
# umount  /mnt/
umount: /mnt/: not mounted

I see some general flakiness with loop devices as well (re: patch 3/4).
Anyways... until I get a chance to look at that, a couple nits to
follow. Otherwise this looks Ok to me.

>  tests/xfs/104     |  8 ++++----
>  tests/xfs/104.out | 46 +++++++++++++++++++++++-----------------------
>  tests/xfs/119     |  2 +-
>  tests/xfs/291     |  2 +-
>  tests/xfs/297     |  2 +-
>  5 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/tests/xfs/104 b/tests/xfs/104
> index 69fcc69..ca2ae21 100755
> --- a/tests/xfs/104
> +++ b/tests/xfs/104
> @@ -81,10 +81,10 @@ modsize=`expr   4 \* $incsize`	# pause after this many increments
>  [ `expr $endsize / $dbsize` -lt $dblocks ] || _notrun "Scratch device too small"
>  
>  nags=4
> -size=`expr 120 \* 1048576`	# 120 megabytes initially
> +size=`expr 125 \* 1048576`	# 120 megabytes initially

The comment is wrong now.

>  sizeb=`expr $size / $dbsize`	# in data blocks
>  echo "*** creating scratch filesystem"
> -_create_scratch -lsize=5m -dsize=${size} -dagcount=${nags}
> +_create_scratch -lsize=10m -dsize=${size} -dagcount=${nags}
>  
>  fillsize=`expr 110 \* 1048576`	# 110 megabytes of filling
>  echo "*** using some initial space on scratch filesystem"
> @@ -95,13 +95,13 @@ _fill_scratch $fillsize
>  # Kick off more stress threads on each iteration, grow; repeat.
>  #
>  while [ $size -le $endsize ]; do
> -	echo "*** stressing a ${size} byte filesystem"
> +	echo "*** stressing filesystem"
>  	echo "*** stressing a ${sizeb} block filesystem" >> $seqres.full
>  	_stress_scratch
>  	sleep 1
>  	size=`expr $size + $incsize`
>  	sizeb=`expr $size / $dbsize`	# in data blocks
> -	echo "*** growing to a ${size} byte filesystem"
> +	echo "*** growing filesystem"
>  	echo "*** growing to a ${sizeb} block filesystem" >> $seqres.full
>  	xfs_growfs -D ${sizeb} $SCRATCH_MNT \
>  		| tee -a $seqres.full | _filter_mkfs 2>$tmp.growfs
> diff --git a/tests/xfs/104.out b/tests/xfs/104.out
> index f237e5e..de6c7f2 100644
> --- a/tests/xfs/104.out
> +++ b/tests/xfs/104.out
> @@ -15,8 +15,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  *** mount
>  *** using some initial space on scratch filesystem
> -*** stressing a 125829120 byte filesystem
> -*** growing to a 169869312 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -25,8 +25,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=4
>  
> -*** stressing a 169869312 byte filesystem
> -*** growing to a 213909504 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -35,8 +35,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=6
>  
> -*** stressing a 213909504 byte filesystem
> -*** growing to a 257949696 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -45,8 +45,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=7
>  
> -*** stressing a 257949696 byte filesystem
> -*** growing to a 301989888 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -55,8 +55,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=9
>  
> -*** stressing a 301989888 byte filesystem
> -*** growing to a 346030080 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -65,8 +65,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=10
>  
> -*** stressing a 346030080 byte filesystem
> -*** growing to a 390070272 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -75,8 +75,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=11
>  
> -*** stressing a 390070272 byte filesystem
> -*** growing to a 434110464 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -85,8 +85,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=13
>  
> -*** stressing a 434110464 byte filesystem
> -*** growing to a 478150656 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -95,18 +95,18 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=14
>  
> -*** stressing a 478150656 byte filesystem
> -*** growing to a 522190848 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
>  naming   =VERN bsize=XXX
>  log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
> -AGCOUNT=16
> +AGCOUNT=15
>  
> -*** stressing a 522190848 byte filesystem
> -*** growing to a 566231040 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -115,8 +115,8 @@ log      =LDEV bsize=XXX blocks=XXX
>  realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>  AGCOUNT=17
>  
> -*** stressing a 566231040 byte filesystem
> -*** growing to a 610271232 byte filesystem
> +*** stressing filesystem
> +*** growing filesystem
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> diff --git a/tests/xfs/119 b/tests/xfs/119
> index c7c46d9..490495b 100755
> --- a/tests/xfs/119
> +++ b/tests/xfs/119
> @@ -54,7 +54,7 @@ _require_scratch
>  # this may hang
>  sync
>  
> -export MKFS_OPTIONS="-l version=2,size=1200b,su=64k" 
> +export MKFS_OPTIONS="-l version=2,size=2500b,su=64k" 

Trailing space here.

Brian

>  export MOUNT_OPTIONS="-o logbsize=64k"
>  _scratch_mkfs_xfs >/dev/null
>  
> diff --git a/tests/xfs/291 b/tests/xfs/291
> index fbf9c51..c226e65 100755
> --- a/tests/xfs/291
> +++ b/tests/xfs/291
> @@ -46,7 +46,7 @@ _supported_os IRIX Linux
>  # real QA test starts here
>  rm -f $seqres.full
>  _require_scratch
> -_scratch_mkfs_xfs -n size=16k -l size=5m -d size=128m >> $seqres.full 2>&1
> +_scratch_mkfs_xfs -n size=16k -l size=10m -d size=133m >> $seqres.full 2>&1
>  _scratch_mount
>  
>  # First we cause very badly fragmented freespace, then
> diff --git a/tests/xfs/297 b/tests/xfs/297
> index 1cdbbb9..25b597e 100755
> --- a/tests/xfs/297
> +++ b/tests/xfs/297
> @@ -50,7 +50,7 @@ _require_scratch
>  _require_freeze
>  
>  rm -f $seqres.full
> -_scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=2560b >/dev/null 2>&1
> +_scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=5120b >/dev/null 2>&1
>  _scratch_mount >/dev/null 2>&1
>  
>  STRESS_DIR="$SCRATCH_MNT/testdir"
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
