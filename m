Received: from userp1040.oracle.com ([156.151.31.81]:26023 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbcEEA03 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 4 May 2016 20:26:29 -0400
Date: Wed, 4 May 2016 17:26:22 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fstests: fix various $seqres.full issues
Message-ID: <20160505002622.GA4265@birch.djwong.org>
References: <1462358277-27766-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462358277-27766-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 04, 2016 at 06:37:57PM +0800, Eryu Guan wrote:
> There're many tests don't remove $seqres.full before writing to it, and
> accumulating logs there, then the logs are always growing over time.
> Let's fix them once.
> 
> generic/16[1-8] generic/170 and generic/33[34] truncate $seqres.full in
> the middle of the test, which results in partial logs. Fix them as well.

For the tests:
generic/161
generic/162
generic/163
generic/164
generic/165
generic/166
generic/167
generic/168
generic/170
generic/333
generic/334

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> xfs/227 has duplicated lines to remove $seqres.full, remove the extra
> line.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/ext4/301    | 1 +
>  tests/ext4/302    | 1 +
>  tests/ext4/303    | 1 +
>  tests/ext4/304    | 1 +
>  tests/ext4/307    | 1 +
>  tests/generic/161 | 2 +-
>  tests/generic/162 | 2 +-
>  tests/generic/163 | 2 +-
>  tests/generic/164 | 2 +-
>  tests/generic/165 | 2 +-
>  tests/generic/166 | 2 +-
>  tests/generic/167 | 2 +-
>  tests/generic/168 | 2 +-
>  tests/generic/170 | 2 +-
>  tests/generic/231 | 1 +
>  tests/generic/333 | 2 +-
>  tests/generic/334 | 2 +-
>  tests/xfs/104     | 2 ++
>  tests/xfs/109     | 1 +
>  tests/xfs/122     | 2 ++
>  tests/xfs/164     | 1 +
>  tests/xfs/227     | 2 --
>  tests/xfs/244     | 1 +
>  tests/xfs/261     | 1 +
>  tests/xfs/278     | 3 ++-
>  tests/xfs/304     | 1 +
>  tests/xfs/305     | 1 +
>  27 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/ext4/301 b/tests/ext4/301
> index 8e051f9..2606c33 100755
> --- a/tests/ext4/301
> +++ b/tests/ext4/301
> @@ -108,6 +108,7 @@ _workout()
>  
>  _require_fio $fio_config
>  
> +rm -f $seqres.full
>  _scratch_mkfs  >> $seqres.full 2>&1
>  _scratch_mount
>  
> diff --git a/tests/ext4/302 b/tests/ext4/302
> index e45dfb8..d6506f6 100755
> --- a/tests/ext4/302
> +++ b/tests/ext4/302
> @@ -126,6 +126,7 @@ _workout()
>  
>  _require_fio $fio_config
>  
> +rm -f $seqres.full
>  _scratch_mkfs  >> $seqres.full 2>&1
>  _scratch_mount
>  
> diff --git a/tests/ext4/303 b/tests/ext4/303
> index 3519002..ac75a39 100755
> --- a/tests/ext4/303
> +++ b/tests/ext4/303
> @@ -136,6 +136,7 @@ _workout()
>  
>  _require_fio $fio_config
>  
> +rm -f $seqres.full
>  _scratch_mkfs  >> $seqres.full 2>&1
>  _scratch_mount
>  
> diff --git a/tests/ext4/304 b/tests/ext4/304
> index 952bbb9..5287ab5 100755
> --- a/tests/ext4/304
> +++ b/tests/ext4/304
> @@ -113,6 +113,7 @@ _workout()
>  
>  _require_fio $fio_config
>  
> +rm -f $seqres.full
>  _scratch_mkfs  >> $seqres.full 2>&1
>  _scratch_mount
>  
> diff --git a/tests/ext4/307 b/tests/ext4/307
> index 505737d..4bca056 100755
> --- a/tests/ext4/307
> +++ b/tests/ext4/307
> @@ -65,6 +65,7 @@ _require_scratch
>  _require_defrag
>  _require_xfs_io_command "falloc"
>  
> +rm -f $seqres.full
>  _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount
>  
> diff --git a/tests/generic/161 b/tests/generic/161
> index c62e0fb..ba7108e 100755
> --- a/tests/generic/161
> +++ b/tests/generic/161
> @@ -58,7 +58,7 @@ loops=4096
>  blksz=65536
>  
>  echo "Initialize files"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _cp_reflink $testdir/file1 $testdir/file2
>  _scratch_cycle_mount
> diff --git a/tests/generic/162 b/tests/generic/162
> index c42c25a..5ff2ee2 100755
> --- a/tests/generic/162
> +++ b/tests/generic/162
> @@ -58,7 +58,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize files"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
>  _scratch_cycle_mount
> diff --git a/tests/generic/163 b/tests/generic/163
> index 4e916c6..fcba677 100755
> --- a/tests/generic/163
> +++ b/tests/generic/163
> @@ -58,7 +58,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize files"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
>  _scratch_cycle_mount
> diff --git a/tests/generic/164 b/tests/generic/164
> index e2ef55f..acacb7f 100755
> --- a/tests/generic/164
> +++ b/tests/generic/164
> @@ -60,7 +60,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize files"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
>  _cp_reflink $testdir/file1 $testdir/file3
> diff --git a/tests/generic/165 b/tests/generic/165
> index fc2ac1b..b742d19 100755
> --- a/tests/generic/165
> +++ b/tests/generic/165
> @@ -61,7 +61,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize files"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
>  _cp_reflink $testdir/file1 $testdir/file3
> diff --git a/tests/generic/166 b/tests/generic/166
> index 831b598..0e31f2e 100755
> --- a/tests/generic/166
> +++ b/tests/generic/166
> @@ -61,7 +61,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize file"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _scratch_cycle_mount
>  
> diff --git a/tests/generic/167 b/tests/generic/167
> index 355a2bf..b2d6c87 100755
> --- a/tests/generic/167
> +++ b/tests/generic/167
> @@ -60,7 +60,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize file"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _scratch_cycle_mount
>  
> diff --git a/tests/generic/168 b/tests/generic/168
> index 98e6f30..7047d10 100755
> --- a/tests/generic/168
> +++ b/tests/generic/168
> @@ -59,7 +59,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize files"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
>  _scratch_cycle_mount
> diff --git a/tests/generic/170 b/tests/generic/170
> index 4f34f3b..4861052 100755
> --- a/tests/generic/170
> +++ b/tests/generic/170
> @@ -60,7 +60,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize files"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
>  _scratch_cycle_mount
> diff --git a/tests/generic/231 b/tests/generic/231
> index 3133cfe..f063671 100755
> --- a/tests/generic/231
> +++ b/tests/generic/231
> @@ -70,6 +70,7 @@ _require_scratch
>  _require_quota
>  _require_user
>  
> +rm -f $seqres.full
>  _scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount "-o usrquota,grpquota"
>  chmod 777 $SCRATCH_MNT
> diff --git a/tests/generic/333 b/tests/generic/333
> index 61a2d02..8db86e3 100755
> --- a/tests/generic/333
> +++ b/tests/generic/333
> @@ -61,7 +61,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize file"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _scratch_cycle_mount
>  
> diff --git a/tests/generic/334 b/tests/generic/334
> index 28c47d6..5714125 100755
> --- a/tests/generic/334
> +++ b/tests/generic/334
> @@ -60,7 +60,7 @@ nr_loops=$((loops - 1))
>  blksz=65536
>  
>  echo "Initialize file"
> -echo > $seqres.full
> +echo >> $seqres.full
>  _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _scratch_cycle_mount
>  
> diff --git a/tests/xfs/104 b/tests/xfs/104
> index b78ac49..17f9b62 100755
> --- a/tests/xfs/104
> +++ b/tests/xfs/104
> @@ -71,6 +71,8 @@ _stress_scratch()
>  # real QA test starts here
>  _supported_fs xfs
>  _require_scratch
> +
> +rm -f $seqres.full
>  _scratch_mkfs_xfs | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
>  . $tmp.mkfs	# extract blocksize and data size for scratch device
>  
> diff --git a/tests/xfs/109 b/tests/xfs/109
> index 4d5450e..ac20619 100755
> --- a/tests/xfs/109
> +++ b/tests/xfs/109
> @@ -93,6 +93,7 @@ allocate()
>  # real QA test starts here
>  _scratch_unmount 2>/dev/null
>  _scratch_mount
> +rm -f $seqres.full
>  
>  # see if faststart is possible (and requested)
>  files=2000
> diff --git a/tests/xfs/122 b/tests/xfs/122
> index dc28c56..845cdd2 100755
> --- a/tests/xfs/122
> +++ b/tests/xfs/122
> @@ -41,6 +41,8 @@ _supported_fs xfs
>  _supported_os Linux
>  _require_command "$INDENT_PROG" indent
>  
> +rm -f $seqres.full
> +
>  # filter out known changes to xfs type sizes
>  _type_size_filter()
>  {
> diff --git a/tests/xfs/164 b/tests/xfs/164
> index 404c208..6413324 100755
> --- a/tests/xfs/164
> +++ b/tests/xfs/164
> @@ -70,6 +70,7 @@ _supported_os IRIX Linux
>  _require_test
>  
>  testfile=$TEST_DIR/file.$seq
> +rm -f $seqres.full
>  
>  _test_eof_hole()
>  {
> diff --git a/tests/xfs/227 b/tests/xfs/227
> index 64e8f14..817c968 100755
> --- a/tests/xfs/227
> +++ b/tests/xfs/227
> @@ -153,8 +153,6 @@ create_target_attr_last()
>  	create_attrs $nattrs $target
>  }
>  
> -rm -f $seqres.full
> -
>  # use a small filesystem so we can control freespace easily
>  _scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount
> diff --git a/tests/xfs/244 b/tests/xfs/244
> index 257d121..a84d87a 100755
> --- a/tests/xfs/244
> +++ b/tests/xfs/244
> @@ -52,6 +52,7 @@ _require_projid16bit
>  
>  export MOUNT_OPTIONS="-opquota"
>  
> +rm -f $seqres.full
>  # make fs with no projid32bit
>  _scratch_mkfs_xfs -i projid32bit=0 >> $seqres.full || _fail "mkfs failed"
>  _qmount
> diff --git a/tests/xfs/261 b/tests/xfs/261
> index 950c539..962f6fc 100755
> --- a/tests/xfs/261
> +++ b/tests/xfs/261
> @@ -51,6 +51,7 @@ _cleanup()
>  . ./common/quota
>  
>  echo "Silence is golden."
> +rm -r $seqres.full
>  
>  # real QA test starts here
>  
> diff --git a/tests/xfs/278 b/tests/xfs/278
> index 2b1db8a..caf2622 100755
> --- a/tests/xfs/278
> +++ b/tests/xfs/278
> @@ -47,7 +47,8 @@ _supported_fs xfs
>  _supported_os Linux
>  _require_scratch
>  
> -_scratch_mkfs >/dev/null 2>&1
> +rm -f $seqres.full
> +_scratch_mkfs >$seqres.full 2>&1
>  _scratch_mount
>  
>  mkdir -p $SCRATCH_MNT/dir/subdir
> diff --git a/tests/xfs/304 b/tests/xfs/304
> index 0f902fc..495356d 100755
> --- a/tests/xfs/304
> +++ b/tests/xfs/304
> @@ -51,6 +51,7 @@ _require_xfs_quota
>  _require_xfs_mkfs_crc
>  _require_xfs_crc
>  
> +rm -f $seqres.full
>  _scratch_mkfs_xfs -m crc=1 >/dev/null 2>&1
>  
>  _qmount_option "uquota,gquota,pquota"
> diff --git a/tests/xfs/305 b/tests/xfs/305
> index d925b8b..15fb1ad 100755
> --- a/tests/xfs/305
> +++ b/tests/xfs/305
> @@ -51,6 +51,7 @@ _require_xfs_quota
>  _require_xfs_mkfs_crc
>  _require_xfs_crc
>  
> +rm -f $seqres.full
>  _scratch_mkfs_xfs -m crc=1 >/dev/null 2>&1
>  
>  _qmount_option "uquota,gquota,pquota"
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
