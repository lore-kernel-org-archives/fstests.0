Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:48880 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272AbbEECG1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 4 May 2015 22:06:27 -0400
Message-ID: <554825A0.5010407@sandeen.net>
Date: Mon, 04 May 2015 21:06:24 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] filter: inode size output of mkfs.xfs can change
References: <1430776893-25158-1-git-send-email-david@fromorbit.com> <1430776893-25158-5-git-send-email-david@fromorbit.com>
In-Reply-To: <1430776893-25158-5-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 5/4/15 5:01 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> With the change to CRCs by default, the mkfs inode size is defaults
> to 512 bytes and the minimum block size changes to 1024 bytes. This
> causes mismatches with golden output that expects the inode size to
> be 256 bytes, and some tests are tailored around the amount of space
> inside a 256 byte inode. Fix them with appropriate filtering or mkfs
> parameters to allow 256 byte inodes to be used.

I guess I kind of have the same concerns here; lots of magic mkfs
args w/ no real clue about why they exist.

The things that filter out isize etc make good sense in general.

But the new mkfs args could use comments or helpers or something
that make it a little more obvious why they're used.  What do you
think?

-Eric

> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/073          |  4 ++--
>  tests/xfs/096          |  6 +++---
>  tests/xfs/096.external | 12 ++++++------
>  tests/xfs/096.internal | 12 ++++++------
>  tests/xfs/187          |  4 ++--
>  tests/xfs/194          |  4 +++-
>  tests/xfs/199          |  2 +-
>  tests/xfs/206          | 10 ++++++----
>  tests/xfs/206.out      | 12 ++++++------
>  tests/xfs/259          | 21 ++++++++++++++++++---
>  tests/xfs/292          |  4 ++--
>  tests/xfs/292.out      |  2 --
>  tests/xfs/300          |  3 ++-
>  13 files changed, 57 insertions(+), 39 deletions(-)
> 
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index 07fc71b..45a3fdf 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -136,7 +136,7 @@ _require_loop
>  
>  rm -f $seqres.full
>  
> -_scratch_mkfs_xfs -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
> +_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
>  _scratch_mount 2>/dev/null || _fail "initial scratch mount failed"
>  
>  echo
> @@ -156,7 +156,7 @@ _verify_copy $imgs.image $SCRATCH_DEV $SCRATCH_MNT
>  
>  echo 
>  echo === copying scratch device to single target, large ro device
> -${MKFS_XFS_PROG} -dfile,name=$imgs.source,size=100g | _filter_mkfs 2>/dev/null
> +${MKFS_XFS_PROG} -m crc=0 -dfile,name=$imgs.source,size=100g | _filter_mkfs 2>/dev/null
>  rmdir $imgs.source_dir 2>/dev/null
>  mkdir $imgs.source_dir
>  
> diff --git a/tests/xfs/096 b/tests/xfs/096
> index 2da8fa1..c289c10 100755
> --- a/tests/xfs/096
> +++ b/tests/xfs/096
> @@ -77,7 +77,7 @@ mkfs_filter()
>          -e 's/swidth=[0-9][0-9]* blks$/&, unwritten=1/' \
>  	-e 's/rtextents=[0-9][0-9]*/rtextents=N/' \
>  	-e 's/meta-data=[^ ]*/meta-data=DEV/' \
> -        -e 's/ *isize/ isize/' \
> +        -e 's/ *isize=[0-9]* / isize=N /' \
>  	-e '/ *= *sectsz=[0-9][0-9]* *attr=[0-9][0-9]*.*$/d' \
>  	-e '/ *= *mmr=[0-9][0-9]* *$/d' \
>  	-e 's/ *mixed-case=[YN]//' \
> @@ -130,9 +130,9 @@ cat >$tmp.seq.params <<EOF
>  # same test but get log stripe from data stripe
>    -l version=2 -d su=$big_su,sw=1
>  # test out data stripe
> -  -l version=1 -d su=$big_su,sw=1
> +  -m crc=0 -l version=1 -d su=$big_su,sw=1
>  # test out data stripe the same but using sunit & swidth
> -  -l version=1 -d sunit=`expr $big_su / 512`,swidth=`expr $big_su / 512`
> +  -m crc=0 -l version=1 -d sunit=`expr $big_su / 512`,swidth=`expr $big_su / 512`
>  EOF
>  
>  #
> diff --git a/tests/xfs/096.external b/tests/xfs/096.external
> index 7923340..3122330 100644
> --- a/tests/xfs/096.external
> +++ b/tests/xfs/096.external
> @@ -7,7 +7,7 @@ log stripe unit (262656) must be a multiple of the block size (4096)
>  
>  # test log stripe greater than LR size
>  --- mkfs=-l version=2,su=266240 ---
> -meta-data=DEV isize=256    agcount=N, agsize=N blks
> +meta-data=DEV isize=N      agcount=N, agsize=N blks
>  data     =                       bsize=4096   blocks=N, imaxpct=N
>           =                       sunit=0      swidth=0 blks, unwritten=1
>  naming   =version 2              bsize=4096
> @@ -17,7 +17,7 @@ realtime =REALTIME               extsz=N, blocks=N, rtextents=N
>  
>  # same test but get log stripe from data stripe
>  --- mkfs=-l version=2 -d su=266240,sw=1 ---
> -meta-data=DEV isize=256    agcount=N, agsize=N blks
> +meta-data=DEV isize=N      agcount=N, agsize=N blks
>  data     =                       bsize=4096   blocks=N, imaxpct=N
>           =                       sunit=65     swidth=65 blks, unwritten=1
>  naming   =version 2              bsize=4096
> @@ -27,8 +27,8 @@ realtime =REALTIME               extsz=N, blocks=N, rtextents=N
>  
>  
>  # test out data stripe
> ---- mkfs=-l version=1 -d su=266240,sw=1 ---
> -meta-data=DEV isize=256    agcount=N, agsize=N blks
> +--- mkfs=-m crc=0 -l version=1 -d su=266240,sw=1 ---
> +meta-data=DEV isize=N      agcount=N, agsize=N blks
>  data     =                       bsize=4096   blocks=N, imaxpct=N
>           =                       sunit=65     swidth=65 blks, unwritten=1
>  naming   =version 2              bsize=4096
> @@ -38,8 +38,8 @@ realtime =REALTIME               extsz=N, blocks=N, rtextents=N
>  
>  
>  # test out data stripe the same but using sunit & swidth
> ---- mkfs=-l version=1 -d sunit=520,swidth=520 ---
> -meta-data=DEV isize=256    agcount=N, agsize=N blks
> +--- mkfs=-m crc=0 -l version=1 -d sunit=520,swidth=520 ---
> +meta-data=DEV isize=N      agcount=N, agsize=N blks
>  data     =                       bsize=4096   blocks=N, imaxpct=N
>           =                       sunit=65     swidth=65 blks, unwritten=1
>  naming   =version 2              bsize=4096
> diff --git a/tests/xfs/096.internal b/tests/xfs/096.internal
> index eaba13f..80201d2 100644
> --- a/tests/xfs/096.internal
> +++ b/tests/xfs/096.internal
> @@ -7,7 +7,7 @@ log stripe unit (262656) must be a multiple of the block size (4096)
>  
>  # test log stripe greater than LR size
>  --- mkfs=-l version=2,su=266240 ---
> -meta-data=DEV isize=256    agcount=N, agsize=N blks
> +meta-data=DEV isize=N    agcount=N, agsize=N blks
>  data     =                       bsize=4096   blocks=N, imaxpct=N
>           =                       sunit=0      swidth=0 blks, unwritten=1
>  naming   =version 2              bsize=4096
> @@ -18,7 +18,7 @@ realtime =REALTIME               extsz=N, blocks=N, rtextents=N
>  
>  # same test but get log stripe from data stripe
>  --- mkfs=-l version=2 -d su=266240,sw=1 ---
> -meta-data=DEV isize=256    agcount=N, agsize=N blks
> +meta-data=DEV isize=N    agcount=N, agsize=N blks
>  data     =                       bsize=4096   blocks=N, imaxpct=N
>           =                       sunit=65     swidth=65 blks, unwritten=1
>  naming   =version 2              bsize=4096
> @@ -28,8 +28,8 @@ realtime =REALTIME               extsz=N, blocks=N, rtextents=N
>  
>  
>  # test out data stripe
> ---- mkfs=-l version=1 -d su=266240,sw=1 ---
> -meta-data=DEV isize=256    agcount=N, agsize=N blks
> +--- mkfs=-m crc=0 -l version=1 -d su=266240,sw=1 ---
> +meta-data=DEV isize=N    agcount=N, agsize=N blks
>  data     =                       bsize=4096   blocks=N, imaxpct=N
>           =                       sunit=65     swidth=65 blks, unwritten=1
>  naming   =version 2              bsize=4096
> @@ -39,8 +39,8 @@ realtime =REALTIME               extsz=N, blocks=N, rtextents=N
>  
>  
>  # test out data stripe the same but using sunit & swidth
> ---- mkfs=-l version=1 -d sunit=520,swidth=520 ---
> -meta-data=DEV isize=256    agcount=N, agsize=N blks
> +--- mkfs=-m crc=0 -l version=1 -d sunit=520,swidth=520 ---
> +meta-data=DEV isize=N    agcount=N, agsize=N blks
>  data     =                       bsize=4096   blocks=N, imaxpct=N
>           =                       sunit=65     swidth=65 blks, unwritten=1
>  naming   =version 2              bsize=4096
> diff --git a/tests/xfs/187 b/tests/xfs/187
> index 700ab04..836b924 100755
> --- a/tests/xfs/187
> +++ b/tests/xfs/187
> @@ -70,8 +70,8 @@ export MOUNT_OPTIONS=""
>  # lazysb, attr2 and other feature bits are held in features2 and will require
>  # morebitsbit on So test with lazysb and without it to see if the morebitsbit is
>  # okay etc. If the mkfs defaults change, these need to change as well.
> -export MKFS_NO_LAZY="-l lazy-count=0 -i projid32bit=0"
> -export MKFS_LAZY="-l lazy-count=1 -i projid32bit=0"
> +export MKFS_NO_LAZY="-m crc=0 -l lazy-count=0 -i projid32bit=0"
> +export MKFS_LAZY="-m crc=0 -l lazy-count=1 -i projid32bit=0"
>  
>  # Make sure that when we think we are testing with morebits off
>  # that we really are.
> diff --git a/tests/xfs/194 b/tests/xfs/194
> index f56702a..e11b459 100755
> --- a/tests/xfs/194
> +++ b/tests/xfs/194
> @@ -83,7 +83,9 @@ _filter_od()
>  _require_scratch
>  unset MKFS_OPTIONS
>  unset XFS_MKFS_OPTIONS
> -_scratch_mkfs_xfs -b size=$blksize >/dev/null 2>&1
> +
> +# we need 512 byte block size, so crc's are turned off
> +_scratch_mkfs_xfs -m crc=0 -b size=$blksize >/dev/null 2>&1
>  _scratch_mount
>  
>  # 512b block / 4k page example:
> diff --git a/tests/xfs/199 b/tests/xfs/199
> index c1b5962..0eef88b 100755
> --- a/tests/xfs/199
> +++ b/tests/xfs/199
> @@ -52,7 +52,7 @@ _require_scratch
>  # clear any mkfs options so taht we can directly specify the options we need to
>  # be able to test the features bitmask behaviour correctly.
>  MKFS_OPTIONS=
> -_scratch_mkfs_xfs -l lazy-count=1 -i projid32bit=0 >/dev/null 2>&1
> +_scratch_mkfs_xfs -m crc=0 -l lazy-count=1 -i projid32bit=0 >/dev/null 2>&1
>  
>  #
>  # Print the current flags.  Just a dummy so that the test breaks
> diff --git a/tests/xfs/206 b/tests/xfs/206
> index 198e413..0f5d97d 100755
> --- a/tests/xfs/206
> +++ b/tests/xfs/206
> @@ -75,19 +75,21 @@ dd if=/dev/zero of=$tmpfile bs=1 seek=19998630180864 count=1 >/dev/null 2>&1 \
>  
>  mkfs_filter()
>  {
> -	sed -e "s,^meta-data=.*isize,meta-data=FILE                   isize,g" \
> +	sed -e 's/meta-data=[^ ]*/meta-data=FILE/' \
> +	    -e 's/ *isize=[0-9]* / isize=N /' \
>  	    -e "s/\(^log.*blocks=\)\([0-9]*,\)/\1XXXXX,/" \
>  	    -e "s/, projid32bit=[0-9]//" \
>  	    -e "s/ ftype=[0-9]//" \
>  	    -e "s/\(sectsz\)\(=[0-9]* *\)/\1=512   /" \
>  	    -e "s/\(sunit=\)\([0-9]* blks,\)/\10 blks,/" \
> +	    -e "s/, lazy-count=[0-9]//" \
>  	    -e "/.*crc=/d"
>  }
>  
> -# mkfs slightly smaller than that
> +# mkfs slightly smaller than that, small log for speed.
>  echo "=== mkfs.xfs ==="
> -mkfs.xfs -f -bsize=4096 -dagsize=76288719b,size=3905982455b \
> -	 -llazy-count=0 $tmpfile  | mkfs_filter
> +mkfs.xfs -f -bsize=4096 -l size=32m -dagsize=76288719b,size=3905982455b \
> +	 $tmpfile  | mkfs_filter
>  
>  mount -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
>  
> diff --git a/tests/xfs/206.out b/tests/xfs/206.out
> index da70d01..2db839d 100644
> --- a/tests/xfs/206.out
> +++ b/tests/xfs/206.out
> @@ -1,30 +1,30 @@
>  QA output created by 206
>  === truncate file ===
>  === mkfs.xfs ===
> -meta-data=FILE                   isize=256    agcount=52, agsize=76288719 blks
> +meta-data=FILE isize=N    agcount=52, agsize=76288719 blks
>           =                       sectsz=512   attr=2
>  data     =                       bsize=4096   blocks=3905982455, imaxpct=5
>           =                       sunit=0      swidth=0 blks
>  naming   =version 2              bsize=4096   ascii-ci=0
>  log      =internal log           bsize=4096   blocks=XXXXX, version=2
> -         =                       sectsz=512   sunit=0 blks, lazy-count=0
> +         =                       sectsz=512   sunit=0 blks
>  realtime =none                   extsz=4096   blocks=0, rtextents=0
>  === xfs_growfs ===
> -meta-data=FILE                   isize=256    agcount=52, agsize=76288719 blks
> +meta-data=FILE isize=N    agcount=52, agsize=76288719 blks
>           =                       sectsz=512   attr=2
>  data     =                       bsize=4096   blocks=3905982455, imaxpct=5
>           =                       sunit=0      swidth=0 blks
>  naming   =version 2              bsize=4096   ascii-ci=0
>  log      =internal               bsize=4096   blocks=XXXXX, version=2
> -         =                       sectsz=512   sunit=0 blks, lazy-count=0
> +         =                       sectsz=512   sunit=0 blks
>  realtime =none                   extsz=4096   blocks=0, rtextents=0
>  data blocks changed from 3905982455 to 4882478016
>  === xfs_info ===
> -meta-data=FILE                   isize=256    agcount=64, agsize=76288719 blks
> +meta-data=FILE isize=N    agcount=64, agsize=76288719 blks
>           =                       sectsz=512   attr=2
>  data     =                       bsize=4096   blocks=4882478016, imaxpct=5
>           =                       sunit=0      swidth=0 blks
>  naming   =version 2              bsize=4096   ascii-ci=0
>  log      =internal               bsize=4096   blocks=XXXXX, version=2
> -         =                       sectsz=512   sunit=0 blks, lazy-count=0
> +         =                       sectsz=512   sunit=0 blks
>  realtime =none                   extsz=4096   blocks=0, rtextents=0
> diff --git a/tests/xfs/259 b/tests/xfs/259
> index 6587a65..16c1935 100755
> --- a/tests/xfs/259
> +++ b/tests/xfs/259
> @@ -37,6 +37,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
>  
>  # get standard environment, filters and checks
>  . ./common/rc
> +. ./common/filter
>  
>  # real QA test starts here
>  _supported_fs xfs
> @@ -47,9 +48,22 @@ _require_math
>  
>  testfile=$TEST_DIR/259.image
>  
> -# Test various sizes slightly less than 4 TB
> +# Test various sizes slightly less than 4 TB. Need to handle different
> +# minimum block sizes for CRC enabled filesystems, but use a small log so we
> +# don't write lots of zeros unnecessarily.
> +xfs_info $TEST_DIR | _filter_mkfs 2> $tmp.mkfs > /dev/null
> +. $tmp.mkfs
> +if [ $_fs_has_crcs -eq 1 ]; then
> +	blocksize=1024
> +	sizes_to_check="1024 2048 4096"
> +	echo "Trying to make (4 TB - 512) B long xfs fs image"
> +else
> +	blocksize=512
> +	sizes_to_check="512 1024 2048 4096"
> +fi
> +
>  four_TB=$(_math "2^42")
> -for del in 512 1024 2048 4096; do
> +for del in $sizes_to_check; do
>  	ddseek=$(_math "$four_TB - $del")
>  	echo "Trying to make (4 TB - $del) B long xfs fs image"
>  	rm -f "$testfile"
> @@ -57,7 +71,8 @@ for del in 512 1024 2048 4096; do
>  					>/dev/null 2>&1 || echo "dd failed"
>  	lofile=$(losetup -f)
>  	losetup $lofile "$testfile"
> -	"$MKFS_XFS_PROG" -b size=512 $lofile >/dev/null || echo "mkfs failed!"
> +	"$MKFS_XFS_PROG" -l size=32m -b size=$blocksize $lofile \
> +					>/dev/null || echo "mkfs failed!"
>  	sync
>  	losetup -d $lofile
>  done
> diff --git a/tests/xfs/292 b/tests/xfs/292
> index a476d91..db890b5 100755
> --- a/tests/xfs/292
> +++ b/tests/xfs/292
> @@ -55,12 +55,12 @@ $XFS_IO_PROG -f -c "truncate 256g" $fsfile
>  
>  echo "mkfs.xfs without geometry"
>  mkfs.xfs -f $fsfile | _filter_mkfs 2> $tmp.mkfs > /dev/null
> -grep -E 'ddev|isize|agcount|agsize' $tmp.mkfs | \
> +grep -E 'ddev|agcount|agsize' $tmp.mkfs | \
>      sed -e "s:$fsfile:FILENAME:g"
>  
>  echo "mkfs.xfs with cmdline geometry"
>  mkfs.xfs -f -d su=16k,sw=5 $fsfile | _filter_mkfs 2> $tmp.mkfs > /dev/null
> -grep -E 'ddev|isize|agcount|agsize' $tmp.mkfs | \
> +grep -E 'ddev|agcount|agsize' $tmp.mkfs | \
>      sed -e "s:$fsfile:FILENAME:g"
>  
>  rm -f $fsfile
> diff --git a/tests/xfs/292.out b/tests/xfs/292.out
> index 2837d74..1d69507 100644
> --- a/tests/xfs/292.out
> +++ b/tests/xfs/292.out
> @@ -1,11 +1,9 @@
>  QA output created by 292
>  mkfs.xfs without geometry
>  ddev=FILENAME
> -isize=256
>  agcount=4
>  agsize=16777216
>  mkfs.xfs with cmdline geometry
>  ddev=FILENAME
> -isize=256
>  agcount=16
>  agsize=4194304
> diff --git a/tests/xfs/300 b/tests/xfs/300
> index db83fd4..9489cbe 100755
> --- a/tests/xfs/300
> +++ b/tests/xfs/300
> @@ -51,7 +51,8 @@ getenforce | grep -q "Enforcing\|Permissive" || _notrun "SELinux not enabled"
>  
>  rm -f $seqres.full
>  
> -_scratch_mkfs_xfs -i size=256 >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_xfs -m crc=0 -i size=256 >> $seqres.full 2>&1 \
> +			|| _fail "mkfs failed"
>  
>  # Manually mount to avoid fs-wide context set by default in xfstests
>  mount $SCRATCH_DEV $SCRATCH_MNT
> 

