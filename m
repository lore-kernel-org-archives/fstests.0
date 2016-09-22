Received: from mx1.redhat.com ([209.132.183.28]:58924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965510AbcIVS5F (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Sep 2016 14:57:05 -0400
Date: Thu, 22 Sep 2016 13:57:02 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH 2/3 V2] modify xfs/ quota tests to work on generic
 filesystems
Message-ID: <20160922185702.GA13740@redhat.com>
References: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
 <ef6b5c28-9579-c13e-0547-17d05f150714@sandeen.net>
 <fb2a04f4-885c-df41-3af3-f4e87441826f@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2a04f4-885c-df41-3af3-f4e87441826f@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 22, 2016 at 01:54:16PM -0500, Eric Sandeen wrote:
> Fix several xfs quota tests to work on non-xfs filesystems.
> 
> New _require function to be sure that the xfs_quota tool can operate
> on foreign filesystems; if it can, and if it needs to, it adds "-f"
> to the XFS_QUOTA_PROG variable.
> 
> Modify _qmount to do quotacheck/quotaon to mount and /enable/
> quota.  On xfs this isn't needed and/or fails; it's ignored.
> 
> All quota-related options used as arguments to _qmount are changed
> from i.e. uquota to i.e. usrquota; the latter is standard across
> almost all linux filesytems, including xfs.
> 
> xfs/260 filters out the root/default quota line, because ext4
> consumes a different amount of space than xfs, and it's not what
> we're testing for, so just ignore it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> ---
> 
> V2:
> 
> * only do quotaon for non-xfs; otherwise tests that want "noenforce"
>   options will fail (xfs/050, oops)
> 
> * Fix Eryu's review comments.
> 
> diff --git a/common/quota b/common/quota
> index d91062a..afc1606 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -78,6 +78,20 @@ _require_xfs_quota()
>  }
>  
>  #
> +# checks that xfs_quota can operate on foreign (non-xfs) filesystems
> +# Skips check on xfs filesystems, old xfs_quota is fine there.
> +# Appends "-f" to enable foreign behavior on non-xfs filesystems if available.
> +#
> +_require_xfs_quota_foreign()
> +{
> +	if [ "$FSTYP" != "xfs" ]; then
> +		$XFS_QUOTA_PROG -f -V &>/dev/null || \
> +		 _notrun "xfs_quota binary does not support foreign filesystems"
> +		XFS_QUOTA_PROG="$XFS_QUOTA_PROG -f"
> +	fi
> +}
> +
> +#
>  # checks that the XFS project quota support in the kernel is enabled.
>  #
>  _require_prjquota()
> @@ -169,6 +183,12 @@ _qmount()
>  {
>      _scratch_unmount >/dev/null 2>&1
>      _scratch_mount || _fail "qmount failed"
> +    # xfs doesn't need these setups and quotacheck even fails on xfs
> +    # redirect the output to $seqres.full for debug purpose and ignore results
> +    if [ "$FSTYP" != "xfs" ]; then
> +	quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
> +	quotaon -ug $SCRATCH_MNT >>$seqres.full 2>&1
> +    fi
>      chmod ugo+rwx $SCRATCH_MNT
>  }
>  
> diff --git a/tests/xfs/054 b/tests/xfs/054
> index ea0f9f8..b4e5dd1 100755
> --- a/tests/xfs/054
> +++ b/tests/xfs/054
> @@ -44,14 +44,15 @@ _cleanup()
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  # real QA test starts here
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os Linux IRIX
>  
>  cp /dev/null $seqres.full
>  chmod ugo+rwx $seqres.full
>  
>  _require_scratch
> -_require_xfs_quota
> +_require_quota
> +_require_xfs_quota_foreign
>  
>  _filter_stat()
>  {
> @@ -67,7 +68,7 @@ _filter_stat()
>  
>  _exercise()
>  {
> -	_scratch_mkfs_xfs >/dev/null 2>&1
> +	_scratch_mkfs >/dev/null 2>&1
>  	_qmount
>  
>  	umask 022
> @@ -99,9 +100,9 @@ _exercise()
>  	_scratch_unmount 2>/dev/null
>  }
>  
> -_scratch_mkfs_xfs >> $seqres.full 2>&1 || _fail "mkfs failed!"
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed!"
>  
> -_qmount_option "uquota,gquota"
> +_qmount_option "usrquota,grpquota"
>  _qmount
>  if src/feature -G $SCRATCH_DEV ; then
>  	:
> @@ -114,16 +115,15 @@ _qmount_option "rw" # no quota options
>  echo "*** Default mount options"
>  _exercise
>  
> -_qmount_option "uquota"
> +_qmount_option "usrquota"
>  echo "*** User quota mount option"
>  _exercise
>  
> -export MOUNT_OPTIONS="-o gquota"
> -_qmount_option "gquota"
> +_qmount_option "grpquota"
>  echo "*** Group quota mount option"
>  _exercise
>  
> -_qmount_option "uquota,gquota"
> +_qmount_option "usrquota,grpquota"
>  echo "*** User and Group quota mount options"
>  _exercise
>  
> diff --git a/tests/xfs/118 b/tests/xfs/118
> index 8414594..8861108 100755
> --- a/tests/xfs/118
> +++ b/tests/xfs/118
> @@ -47,11 +47,12 @@ _cleanup()
>  # real QA test starts here
>  
>  # Modify as appropriate.
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os IRIX Linux
>  
>  _require_scratch
> -_require_xfs_quota
> +_require_quota
> +_require_xfs_quota_foreign
>  
>  _chowning_file()
>  {
> @@ -72,10 +73,10 @@ _chowning_file()
>  }
>  
>  echo "mkfs on scratch"
> -_scratch_mkfs_xfs >$seqres.full
> +_scratch_mkfs >$seqres.full 2>&1
>  
>  echo "mount with quotas"
> -export MOUNT_OPTIONS="-o uquota"
> +export MOUNT_OPTIONS="-o usrquota"
>  _scratch_mount
>  
>  echo "creating quota file with holes"
> diff --git a/tests/xfs/138 b/tests/xfs/138
> index c6a6f50..6b6a12f 100755
> --- a/tests/xfs/138
> +++ b/tests/xfs/138
> @@ -47,17 +47,18 @@ _cleanup()
>  rm -f $seqres.full
>  
>  # real QA test starts here
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os Linux
>  _require_scratch
>  _require_quota
> +_require_xfs_quota_foreign
>  
>  # need user and group named 123456-fsgqa
>  _require_user 123456-fsgqa
>  _require_group 123456-fsgqa
>  
> -_scratch_mkfs_xfs >/dev/null 2>&1
> -_qmount_option "uquota,gquota"
> +_scratch_mkfs >/dev/null 2>&1
> +_qmount_option "usrquota,grpquota"
>  _qmount
>  
>  # user test
> diff --git a/tests/xfs/260 b/tests/xfs/260
> index 9c6162b..a2bc3ce 100755
> --- a/tests/xfs/260
> +++ b/tests/xfs/260
> @@ -52,10 +52,11 @@ _cleanup()
>  rm -f $seqres.full
>  
>  # real QA test starts here
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os Linux
>  _require_scratch
>  _require_quota
> +_require_xfs_quota_foreign
>  _require_user
>  _require_group
>  
> @@ -78,12 +79,12 @@ do_test()
>  	$XFS_QUOTA_PROG -x -c "limit bsoft=20M bhard=20M isoft=20 ihard=20 $type -d" $SCRATCH_MNT
>  	$XFS_QUOTA_PROG -x -c "limit bsoft=40M bhard=40M isoft=40 ihard=40 $type fsgqa" $SCRATCH_MNT
>  	echo "$qname blocks and inode limit"
> -	$XFS_QUOTA_PROG -x -c "report $type -N -bi" $SCRATCH_MNT | _filter_spaces
> +	$XFS_QUOTA_PROG -x -c "report $type -N -bi" $SCRATCH_MNT | grep -v ^root | _filter_spaces
>  
>  	## blocks default quota test ##
>  	_user_do "$XFS_IO_PROG -f -c \"pwrite 0 30M\" -c \"fsync\" $SCRATCH_MNT/data" | _filter_xfs_io
>  	echo "$qname blocks quota after write 30M data"
> -	$XFS_QUOTA_PROG -x -c "report $type -N -b" $SCRATCH_MNT | _filter_spaces
> +	$XFS_QUOTA_PROG -x -c "report $type -N -b" $SCRATCH_MNT | grep -v ^root | _filter_spaces
>  
>  	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
>  
> @@ -94,22 +95,22 @@ do_test()
>  	sync
>  
>  	echo "$qname inode quota after creating 30 inodes"
> -	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT | _filter_spaces
> +	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT | grep -v ^root | _filter_spaces
>  
>  	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
>  }
>  
>  ### user default quota test ###
> -_scratch_mkfs_xfs >/dev/null 2>&1
> -_qmount_option "uquota,gquota"
> +_scratch_mkfs >/dev/null 2>&1
> +_qmount_option "usrquota,grpquota"
>  _qmount
>  
>  do_test user
>  
>  ### group default quota test ###
>  _scratch_unmount
> -_scratch_mkfs_xfs >/dev/null 2>&1
> -_qmount_option "gquota,uquota"
> +_scratch_mkfs >/dev/null 2>&1
> +_qmount_option "grpquota,usrquota"
>  _qmount
>  
>  do_test group
> diff --git a/tests/xfs/260.out b/tests/xfs/260.out
> index 0b198bf..5eb1070 100644
> --- a/tests/xfs/260.out
> +++ b/tests/xfs/260.out
> @@ -1,31 +1,25 @@
>  QA output created by 260
>  === user quota test ===
>  user blocks and inode limit
> -root 0 20480 20480 00 [--------] 3 20 20 00 [--------]
>  fsgqa 0 40960 40960 00 [--------] 0 40 40 00 [--------]
>  
>  wrote 31457280/31457280 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  user blocks quota after write 30M data
> -root 0 20480 20480 00 [--------]
>  fsgqa 30720 40960 40960 00 [--------]
>  
>  user inode quota after creating 30 inodes
> -root 3 20 20 00 [--------]
>  fsgqa 30 40 40 00 [--------]
>  
>  === group quota test ===
>  group blocks and inode limit
> -root 0 20480 20480 00 [--------] 3 20 20 00 [--------]
>  fsgqa 0 40960 40960 00 [--------] 0 40 40 00 [--------]
>  
>  wrote 31457280/31457280 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  group blocks quota after write 30M data
> -root 0 20480 20480 00 [--------]
>  fsgqa 30720 40960 40960 00 [--------]
>  
>  group inode quota after creating 30 inodes
> -root 3 20 20 00 [--------]
>  fsgqa 30 40 40 00 [--------]
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
