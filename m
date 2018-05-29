Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:46645 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935386AbeE2CBh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 22:01:37 -0400
Date: Tue, 29 May 2018 12:01:27 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Make ./new work for non-root user
Message-ID: <20180529020127.GJ23861@dastard>
References: <20180524183055.16031-1-jack@suse.cz>
 <20180529013914.GI23861@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529013914.GI23861@dastard>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 29, 2018 at 11:39:14AM +1000, Dave Chinner wrote:
> Second go....
> 
> On Thu, May 24, 2018 at 08:30:55PM +0200, Jan Kara wrote:
> > Currently 'new' script sources common/config which tries to find mkfs
> > and fails if not found (which is likely for non-root user). This is
> > inconvenient as development usually does not happen as root. In fact the
> > vast majority of setup in common/config and common/rc is not necessary
> > for 'new'. Split out the necessary bits into new common/config-base and
> > use it in 'new'. Cleanup common/rc and common/config now that it's only
> > used from 'check'.
> 
> FWIW, common/config is also called from setup.
.....
> > @@ -88,12 +90,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
> >  
> >  export RECREATE_TEST_DEV=false
> >  
> > -# $1 = prog to look for
> > -set_prog_path()
> > -{
> > -	type -P $1
> > -}
> 
> Can we just get rid of set_prog_path() and replace it with direct
> calls to $(type -P foo) as an initial patch? This goes away at that
> point, because new can then just use a locally coded version....

Something like this?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

fstests: get rid of set_prog_path

From: Dave Chinner <dchinner@redhat.com>

It's just a one line wrapper that adds complexity, remove it. Move
the couple of calls in tests to common/config, but leave the xfsdump
setup in place and just convert it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/config   | 170 +++++++++++++++++++++++++++-----------------------------
 common/dump     |   6 +-
 tests/btrfs/085 |   2 -
 tests/xfs/446   |   1 -
 4 files changed, 86 insertions(+), 93 deletions(-)

diff --git a/common/config b/common/config
index 1cf402eee1dc..ef774b8d552b 100644
--- a/common/config
+++ b/common/config
@@ -88,17 +88,11 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
 export RECREATE_TEST_DEV=false
 
-# $1 = prog to look for
-set_prog_path()
-{
-	type -P $1
-}
-
 # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
 set_mkfs_prog_path_with_opts()
 {
 	local fstyp=$1
-	local p=`set_prog_path mkfs.$fstyp`
+	local p=$(type -P mkfs.$fstyp)
 
 	# Note: mkfs.f2fs doesn't support the --help option yet, but it doesn't
 	# matter since it also prints the help when an invalid option is given.
@@ -117,105 +111,106 @@ _fatal()
     exit 1
 }
 
-export MKFS_PROG="`set_prog_path mkfs`"
+export MKFS_PROG=$(type -P mkfs)
 [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
 
-export MOUNT_PROG="`set_prog_path mount`"
+export MOUNT_PROG=$(type -P mount)
 [ "$MOUNT_PROG" = "" ] && _fatal "mount not found"
 
-export UMOUNT_PROG="`set_prog_path umount`"
+export UMOUNT_PROG=$(type -P umount)
 [ "$UMOUNT_PROG" = "" ] && _fatal "umount not found"
 
 export FSSTRESS_PROG="./ltp/fsstress"
 [ ! -x $FSSTRESS_PROG ] && _fatal "fsstress not found or executable"
 
-export PERL_PROG="`set_prog_path perl`"
+export PERL_PROG=$(type -P perl)
 [ "$PERL_PROG" = "" ] && _fatal "perl not found"
 
-export AWK_PROG="`set_prog_path awk`"
+export AWK_PROG=$(type -P awk)
 [ "$AWK_PROG" = "" ] && _fatal "awk not found"
 
-export SED_PROG="`set_prog_path sed`"
+export SED_PROG=$(type -P sed)
 [ "$SED_PROG" = "" ] && _fatal "sed not found"
 
-export BC_PROG="`set_prog_path bc`"
+export BC_PROG=$(type -P bc)
 [ "$BC_PROG" = "" ] && _fatal "bc not found"
 
 export PS_ALL_FLAGS="-ef"
 
-export DF_PROG="`set_prog_path df`"
+export DF_PROG=$(type -P df)
 [ "$DF_PROG" = "" ] && _fatal "df not found"
 [ "$HOSTOS" = "Linux" ] && export DF_PROG="$DF_PROG -T -P"
 
-export XFS_IO_PROG="`set_prog_path xfs_io`"
+export XFS_IO_PROG=$(type -P xfs_io)
 [ "$XFS_IO_PROG" = "" ] && _fatal "xfs_io not found"
 
-export XFS_LOGPRINT_PROG="`set_prog_path xfs_logprint`"
-export XFS_REPAIR_PROG="`set_prog_path xfs_repair`"
-export XFS_DB_PROG="`set_prog_path xfs_db`"
-export XFS_GROWFS_PROG=`set_prog_path xfs_growfs`
-export XFS_SPACEMAN_PROG="`set_prog_path xfs_spaceman`"
-export XFS_SCRUB_PROG="`set_prog_path xfs_scrub`"
-export XFS_PARALLEL_REPAIR_PROG="`set_prog_path xfs_prepair`"
-export XFS_PARALLEL_REPAIR64_PROG="`set_prog_path xfs_prepair64`"
-export __XFSDUMP_PROG="`set_prog_path xfsdump`"
+export XFS_LOGPRINT_PROG=$(type -P xfs_logprint)
+export XFS_REPAIR_PROG=$(type -P xfs_repair)
+export XFS_DB_PROG=$(type -P xfs_db)
+export XFS_GROWFS_PROG=$(type -P xfs_growfs)
+export XFS_SPACEMAN_PROG=$(type -P xfs_spaceman)
+export XFS_SCRUB_PROG=$(type -P xfs_scrub)
+export XFS_PARALLEL_REPAIR_PROG=$(type -P xfs_prepair)
+export XFS_PARALLEL_REPAIR64_PROG=$(type -P xfs_prepair64)
+export __XFSDUMP_PROG=$(type -P xfsdump)
 if [ -n "$__XFSDUMP_PROG" ]; then
 	export XFSDUMP_PROG="$__XFSDUMP_PROG -e"
 else
 	export XFSDUMP_PROG=""
 fi
-export XFSRESTORE_PROG="`set_prog_path xfsrestore`"
-export XFSINVUTIL_PROG="`set_prog_path xfsinvutil`"
-export GETFATTR_PROG="`set_prog_path getfattr`"
-export SETFATTR_PROG="`set_prog_path setfattr`"
-export CHACL_PROG="`set_prog_path chacl`"
-export ATTR_PROG="`set_prog_path attr`"
-export QUOTA_PROG="`set_prog_path quota`"
-export XFS_QUOTA_PROG="`set_prog_path xfs_quota`"
-export KILLALL_PROG="`set_prog_path killall`"
-export INDENT_PROG="`set_prog_path indent`"
-export XFS_COPY_PROG="`set_prog_path xfs_copy`"
-export FSTRIM_PROG="`set_prog_path fstrim`"
-export DUMPE2FS_PROG="`set_prog_path dumpe2fs`"
-export FIO_PROG="`set_prog_path fio`"
-export FILEFRAG_PROG="`set_prog_path filefrag`"
-export E4DEFRAG_PROG="`set_prog_path e4defrag`"
-export LOGGER_PROG="`set_prog_path logger`"
-export DBENCH_PROG="`set_prog_path dbench`"
-export DMSETUP_PROG="`set_prog_path dmsetup`"
-export WIPEFS_PROG="`set_prog_path wipefs`"
-export DUMP_PROG="`set_prog_path dump`"
-export RESTORE_PROG="`set_prog_path restore`"
-export LVM_PROG="`set_prog_path lvm`"
-export CHATTR_PROG="`set_prog_path chattr`"
-export DEBUGFS_PROG="`set_prog_path debugfs`"
-export UUIDGEN_PROG="`set_prog_path uuidgen`"
-export GETRICHACL_PROG="`set_prog_path getrichacl`"
-export SETRICHACL_PROG="`set_prog_path setrichacl`"
-export KEYCTL_PROG="`set_prog_path keyctl`"
-export XZ_PROG="`set_prog_path xz`"
-export FLOCK_PROG="`set_prog_path flock`"
-export LDD_PROG="`set_prog_path ldd`"
-export TIMEOUT_PROG="`set_prog_path timeout`"
-export MAN_PROG="`set_prog_path man`"
-export NFS4_SETFACL_PROG="`set_prog_path nfs4_setfacl`"
-export NFS4_GETFACL_PROG="`set_prog_path nfs4_getfacl`"
-export UBIUPDATEVOL_PROG="`set_prog_path ubiupdatevol`"
-export THIN_CHECK_PROG="$(set_prog_path thin_check)"
-export PYTHON2_PROG="`set_prog_path python2`"
-export SQLITE3_PROG="`set_prog_path sqlite3`"
-export TIMEOUT_PROG="`set_prog_path timeout`"
-export SETCAP_PROG="`set_prog_path setcap`"
-export GETCAP_PROG="`set_prog_path getcap`"
+export XFSRESTORE_PROG=$(type -P xfsrestore)
+export XFSINVUTIL_PROG=$(type -P xfsinvutil)
+export GETFATTR_PROG=$(type -P getfattr)
+export SETFATTR_PROG=$(type -P setfattr)
+export CHACL_PROG=$(type -P chacl)
+export ATTR_PROG=$(type -P attr)
+export QUOTA_PROG=$(type -P quota)
+export XFS_QUOTA_PROG=$(type -P xfs_quota)
+export KILLALL_PROG=$(type -P killall)
+export INDENT_PROG=$(type -P indent)
+export XFS_COPY_PROG=$(type -P xfs_copy)
+export FSTRIM_PROG=$(type -P fstrim)
+export DUMPE2FS_PROG=$(type -P dumpe2fs)
+export FIO_PROG=$(type -P fio)
+export FILEFRAG_PROG=$(type -P filefrag)
+export E4DEFRAG_PROG=$(type -P e4defrag)
+export LOGGER_PROG=$(type -P logger)
+export DBENCH_PROG=$(type -P dbench)
+export DMSETUP_PROG=$(type -P dmsetup)
+export WIPEFS_PROG=$(type -P wipefs)
+export DUMP_PROG=$(type -P dump)
+export RESTORE_PROG=$(type -P restore)
+export LVM_PROG=$(type -P lvm)
+export CHATTR_PROG=$(type -P chattr)
+export DEBUGFS_PROG=$(type -P debugfs)
+export UUIDGEN_PROG=$(type -P uuidgen)
+export GETRICHACL_PROG=$(type -P getrichacl)
+export SETRICHACL_PROG=$(type -P setrichacl)
+export KEYCTL_PROG=$(type -P keyctl)
+export XZ_PROG=$(type -P xz)
+export FLOCK_PROG=$(type -P flock)
+export LDD_PROG=$(type -P ldd)
+export TIMEOUT_PROG=$(type -P timeout)
+export MAN_PROG=$(type -P man)
+export NFS4_SETFACL_PROG=$(type -P nfs4_setfacl)
+export NFS4_GETFACL_PROG=$(type -P nfs4_getfacl)
+export UBIUPDATEVOL_PROG=$(type -P ubiupdatevol)
+export THIN_CHECK_PROG=$(type -P thin_check)
+export PYTHON2_PROG=$(type -P python2)
+export SQLITE3_PROG=$(type -P sqlite3)
+export TIMEOUT_PROG=$(type -P timeout)
+export SETCAP_PROG=$(type -P setcap)
+export GETCAP_PROG=$(type -P getcap)
+export CHECKBASHISMS_PROG=$(type -P checkbashisms)
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
 # But if neither one is available, just set it to "sleep 1" to wait for lv to
 # be settled
-UDEV_SETTLE_PROG="`set_prog_path udevadm`"
+UDEV_SETTLE_PROG=$(type -P udevadm)
 if [ "$UDEV_SETTLE_PROG" == "" ]; then
 	# try udevsettle command
-	UDEV_SETTLE_PROG="`set_prog_path udevsettle`"
+	UDEV_SETTLE_PROG=$(type -P udevsettle)
 else
 	# udevadm is available, add 'settle' as subcommand
 	UDEV_SETTLE_PROG="$UDEV_SETTLE_PROG settle"
@@ -228,23 +223,24 @@ export UDEV_SETTLE_PROG
 
 case "$HOSTOS" in
     Linux)
-        export MKFS_XFS_PROG="`set_prog_path mkfs.xfs`"
-        export MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
-        export MKFS_UDF_PROG="`set_prog_path mkudffs`"
-        export MKFS_BTRFS_PROG="`set_mkfs_prog_path_with_opts btrfs`"
-        export MKFS_F2FS_PROG="`set_mkfs_prog_path_with_opts f2fs`"
-        export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
-        export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
-        export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
-	export BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
-        export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
-        export MKFS_NFS_PROG="false"
-        export MKFS_CIFS_PROG="false"
-        export MKFS_OVERLAY_PROG="false"
-        export MKFS_REISER4_PROG="`set_prog_path mkfs.reiser4`"
-	export E2FSCK_PROG="`set_prog_path e2fsck`"
-	export TUNE2FS_PROG="`set_prog_path tune2fs`"
-	export FSCK_OVERLAY_PROG="`set_prog_path fsck.overlay`"
+	export MKFS_XFS_PROG=$(type -P mkfs.xfs)
+	export MKFS_EXT4_PROG=$(type -P mkfs.ext4)
+	export MKFS_UDF_PROG=$(type -P mkudffs)
+	export MKFS_BTRFS_PROG=$(type -P btrfs)
+	export MKFS_F2FS_PROG=$(type -P f2fs)
+	export DUMP_F2FS_PROG=$(type -P dump.f2fs)
+	export BTRFS_UTIL_PROG=$(type -P btrfs)
+	export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
+	export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
+	export BTRFS_DEBUG_TREE_PROG=$(type -P btrfs-debug-tree)
+	export XFS_FSR_PROG=$(type -P xfs_fsr)
+	export MKFS_NFS_PROG="false"
+	export MKFS_CIFS_PROG="false"
+	export MKFS_OVERLAY_PROG="false"
+	export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
+	export E2FSCK_PROG=$(type -P e2fsck)
+	export TUNE2FS_PROG=$(type -P tune2fs)
+	export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
         ;;
 esac
 
diff --git a/common/dump b/common/dump
index 7b9c10a25414..8a0ba1096d6a 100644
--- a/common/dump
+++ b/common/dump
@@ -29,10 +29,10 @@ if [ -n "$DEBUGDUMP" ]; then
 
 	# Use dump/restore in qa directory (copy them here) for debugging
 	export PATH="$here:$PATH"
-	export __XFSDUMP_PROG="`set_prog_path xfsdump`"
+	export __XFSDUMP_PROG=$(type -P xfsdump)
 	export XFSDUMP_PROG="$__XFSDUMP_PROG -e"
-	export XFSRESTORE_PROG="`set_prog_path xfsrestore`"
-	export XFSINVUTIL_PROG="`set_prog_path xfsinvutil`"
+	export XFSRESTORE_PROG=$(type -P xfsrestore)
+	export XFSINVUTIL_PROG=$(type -P xfsinvutil)
 	[ -x $here/xfsdump ]    && echo "Using xfstests' xfsdump for debug"
 	[ -x $here/xfsrestore ] && echo "Using xfstests' xfsrestore for debug"
 	[ -x $here/xfsinvutil ] && echo "Using xfstests' xfsinvutil for debug"
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index 804899724cba..a1edc28341da 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -55,8 +55,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-
-BTRFS_DEBUG_TREE_PROG="`set_prog_path btrfs-debug-tree`"
 _require_command "$BTRFS_DEBUG_TREE_PROG" btrfs-debug-tree
 
 rm -f $seqres.full
diff --git a/tests/xfs/446 b/tests/xfs/446
index 752c6a7de827..ac74723f471f 100755
--- a/tests/xfs/446
+++ b/tests/xfs/446
@@ -37,7 +37,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs xfs
 _supported_os Linux
-export CHECKBASHISMS_PROG="`set_prog_path checkbashisms`"
 _require_command "$CHECKBASHISMS_PROG" checkbashisms
 
 test -z "$WORKAREA" && _notrun "Can't find xfsprogs source"
