Received: from mail-pf0-f196.google.com ([209.85.192.196]:35552 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbeDHDiK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 Apr 2018 23:38:10 -0400
Date: Sun, 8 Apr 2018 11:38:03 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/159 superblock corruption test case
Message-ID: <20180408033803.GB2932@desktop>
References: <20180329102848.12669-1-anand.jain@oracle.com>
 <20180405062849.2351-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405062849.2351-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 05, 2018 at 02:28:49PM +0800, Anand Jain wrote:
> Verify if the superblock corruption is handled correctly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v1->v2:
>  $subject slightly changed
>  Added more info about the test-case
>  Keep the stuff from the ./new btrfs
>  Add mount_opt_minus_args() to get the options (if) set at the config file
>  Move DEV_GOOD & DEV_BAD to where it starts to use
>  To help debugging added run_check where possible
>  Remove {} in the out file
>  Use _filter_error_mount for mount fail cases other than -EINVAL
> 
>  tests/btrfs/159     | 177 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/159.out |  23 +++++++
>  tests/btrfs/group   |   1 +
>  3 files changed, 201 insertions(+)
>  create mode 100755 tests/btrfs/159
>  create mode 100644 tests/btrfs/159.out
> 
> diff --git a/tests/btrfs/159 b/tests/btrfs/159
> new file mode 100755
> index 000000000000..521cfdab0242
> --- /dev/null
> +++ b/tests/btrfs/159
> @@ -0,0 +1,177 @@
> +#! /bin/bash
> +# FS QA Test 159
> +#
> +# Test if the superblock corruption is handled correctly:
> +# 	- Test fsid miss-match (csum ok) between primary and copy superblock
> +#	Fixed by the ML patch:
> +#	btrfs: check if the fsid in the primary sb and copy sb are same
> +# 	- Test if the mount fails if the primary superblock csum is
> +#		corrupted on any disk
> +# 	- Test if the mount does not fail if the copy1 sb csum is corrupted
> +#	Fixed by the ML patches:
> +#	btrfs: verify superblock checksum during scan
> +#	btrfs: verify checksum for all devices in mount context
> +#
> +#---------------------------------------------------------------------
> +# Copyright (c) 2018 Oracle.  All Rights Reserved.
> +# Author: Anand Jain <anand.jain@oracle.com>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	_scratch_dev_pool_put
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/module
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_dev_pool 2
> +_require_loadable_fs_module "btrfs"
> +_require_command "$WIPEFS_PROG" wipefs
> +
> +_scratch_dev_pool_get 2
> +
> +mount_opt_minus_args()
> +{
> +	local nr
> +	local mnt_opt=""
> +
> +	nr=`_scratch_mount_options | awk '{print NF}'`
> +	if [ $nr -eq 4 ]; then

Seems this only works with "scratch_mount_options" returns something
like:

"-o opt dev mnt" or "-o opt1,opt2 dev mnt"

but not

"-oopt dev mnt" nor
"-o opt1 -o opt2 dev mnt" nor if $SELINUX_MOUNT_OPTIONS not empty.

Also if MOUNT_OPTIONS is "-oopt1 -oopt2", mount_opt_minus_args would
return something like "-o -oopt2,device=<dev>", which are not valid
mount options.

> +		#gets only the mount option set in the config file
> +		mnt_opt=`_scratch_mount_options | awk '{print $2}'`
> +	fi
> +	#Append the additional opts provide as func args.
> +	#Make sure -o is not echo-ed if both config file mnt-option
> +	#and the test case mnt-option are null.
> +	if [ -z $mnt_opt ]; then
> +		if [ ! -z $* ]; then
> +			echo "-o $*"
> +		fi
> +	else
> +		if [ -z $* ]; then
> +			echo "-o $mnt_opt"
> +		else
> +			echo "-o $mnt_opt,$*"
> +		fi
> +	fi
> +}
> +
> +wipe()
> +{
> +	$WIPEFS_PROG -a $DEV_GOOD > /dev/null 2>&1
> +	$WIPEFS_PROG -a $DEV_BAD > /dev/null 2>&1
> +}
> +
> +# Test for fsid miss-match (csum ok) with primary and copy superblock.
> +check_copy1_fsid()
> +{
> +	local bytenr=67108864
> +	echo -e "\\ncheck_copy1_fsid\\n" | tee -a $seqres.full
> +
> +	wipe
> +	$MKFS_BTRFS_PROG -fq $DEV_GOOD
> +	$MKFS_BTRFS_PROG -fq $DEV_BAD
> +	_reload_fs_module "btrfs"
> +
> +	run_check dd status=none of=$DEV_BAD if=$DEV_GOOD ibs=1 obs=1\
> +			skip=$bytenr seek=$bytenr count=4K
> +
> +	#must fail
> +	_mount `mount_opt_minus_args` $DEV_BAD $SCRATCH_MNT 2>&1 | _filter_scratch_pool
> +	#If mount didn't fail
> +	_scratch_unmount > /dev/null 2>&1
> +}
> +
> +# Test if the mount fails if the primary superblock csum is corrupted.
> +check_primary()
> +{
> +	local bytenr=65536
> +	echo -e "\\ncheck_primary\\n" | tee -a $seqres.full
> +
> +	wipe
> +	_scratch_pool_mkfs "-mraid1 -draid1"
> +	_reload_fs_module "btrfs"
> +
> +	#corrupt bytenr DEV_BAD
> +	od -j$bytenr -N1 -An -x $DEV_BAD |\
> +		dd status=none of=$DEV_BAD ibs=1 obs=1 seek=$bytenr count=1 conv=fsync
> +
> +	#must fail
> +	_mount `mount_opt_minus_args device=$DEV_GOOD` $DEV_BAD $SCRATCH_MNT 2>&1 |\
> +	      _filter_error_mount

If I read the code correctly, the purpose of mount_opt_minus_args is to
remove the device and mount point mount arguments and keep other options
if there's any, then append "-o device=<dev>" as mount options.

If so, I think you could use "_common_dev_mount_options", e.g.

	_mount `_common_dev_mount_options -o device=$DEV_GOOD` $DEV_BAD $SCRATCH_MNT ...

But do mount options really matter in this test? Could we just mount
with "-o device=<dev>"?

Thanks,
Eryu

> +
> +	#If mount didn't fail
> +	_scratch_unmount > /dev/null 2>&1
> +}
> +
> +# If copy1 is corrupted we still should be able to mount, check that.
> +check_copy1()
> +{
> +	local bytenr=67108864
> +	echo -e "\\ncheck_copy1" | tee -a $seqres.full
> +
> +	wipe
> +	_scratch_pool_mkfs "-mraid1 -draid1"
> +	_reload_fs_module "btrfs"
> +
> +	#corrupt bytenr DEV_BAD
> +	od -j$bytenr -N1 -An -x $DEV_BAD |\
> +		dd status=none of=$DEV_BAD ibs=1 obs=1 seek=$bytenr count=1 conv=fsync
> +
> +	_mount `mount_opt_minus_args device=$DEV_GOOD` $DEV_BAD $SCRATCH_MNT 2>&1 |\
> +		_filter_error_mount
> +	_scratch_unmount
> +}
> +
> +DEV_GOOD=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +DEV_BAD=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +
> +check_copy1_fsid
> +check_primary
> +check_copy1
> +
> +echo -e "\\nReverse good and bad devices"
> +# For csum verification on devid 2, reverse the good and bad disks.
> +DEV_BAD=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +DEV_GOOD=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +check_primary
> +check_copy1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
> new file mode 100644
> index 000000000000..3e7ba31929e6
> --- /dev/null
> +++ b/tests/btrfs/159.out
> @@ -0,0 +1,23 @@
> +QA output created by 159
> +
> +check_copy1_fsid
> +
> +mount: wrong fs type, bad option, bad superblock on SCRATCH_DEV,
> +       missing codepage or helper program, or other error
> +
> +       In some cases useful info is found in syslog - try
> +       dmesg | tail or so.
> +
> +check_primary
> +
> +mount: Structure needs cleaning
> +
> +check_copy1
> +
> +Reverse good and bad devices
> +
> +check_primary
> +
> +mount: Structure needs cleaning
> +
> +check_copy1
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 8007e07e9cbd..ba766f6b84f8 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -161,3 +161,4 @@
>  156 auto quick trim
>  157 auto quick raid
>  158 auto quick raid scrub
> +159 auto quick
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
