Received: from sandeen.net ([63.231.237.45]:36254 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824AbcE0SFS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 May 2016 14:05:18 -0400
Subject: Re: [PATCH 1/2] common/rc: add functions to check or write objects
 under /sys/fs
References: <1464362482-7704-1-git-send-email-zlang@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <07e71f2f-229e-e8bf-3b73-546bef86f98b@sandeen.net>
Date: Fri, 27 May 2016 13:05:15 -0500
MIME-Version: 1.0
In-Reply-To: <1464362482-7704-1-git-send-email-zlang@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: cem@redhat.com
List-ID: <fstests@vger.kernel.org>

On 5/27/16 10:21 AM, Zorro Lang wrote:
> XFS add more configurations in /sys/fs/xfs recently. For use
> them, this patch add some common functions for:
>   1. "require" a file/dir in /sys/fs.
>   2. write a file in /sys/fs.

More specifically, in /sys/fs/${FSTYP}

> For common use, these functions can be used by other filesystems.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  common/rc | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 51092a0..9935f08 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3556,6 +3556,87 @@ run_fsx()
>  	fi
>  }
>  
> +_require_sys_fs()
> +{
> +        local dev=$1
> +        local target=$2
> +        local dname=""
> +
> +        if [ ! -b "$dev" -o -z "$target" ];then
> +	        echo "Usage: _require_sys_fs <device> <target_need_exist>"
> +                exit 1
> +        fi
> +
> +        dname=$(basename $(readlink -f $dev))
> +        _mkfs_dev $dev > /dev/null 2>&1

we don't want to mkfs the test dev just for a _require test; that
device is supposed to age, and this could possibly take a very long
time, as well.  And in general a mkfs should not be required to test
the existence of a sysfs tunable, I think?

> +        _mount -t $FSTYP `_common_dev_mount_options` $dev $SCRATCH_MNT
> +        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
> +                umount $SCRATCH_MNT
> +                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
> +        fi
> +        umount $SCRATCH_MNT
> +}
> +
> +_require_scratch_sys_fs()
> +{
> +        local target=$1
> +        local dname=""
> +
> +        if [ ! -b "$SCRATCH_DEV" -o -z "$target" ];then
> +	        echo "Usage: _require_scratch_sys_fs <target_need_exist>"
> +		exit 1
> +	fi
> +
> +        dname=$(basename $(readlink -f $SCRATCH_DEV))
> +	_scratch_mkfs > /dev/null 2>&1
> +        _scratch_mount
> +        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
> +                _scratch_unmount
> +                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
> +        fi
> +        _scratch_unmount
> +}

This seems overly complex; do you need both of these functions?  We are only
testing one filesystem type at a time, and $TEST_DEV is always required.
What is the reason for the two differing functions?

Isn't _require_sys_fs $SCRATCH_DEV exactly the same as
_require_scratch_sys_fs ?

Also, because $SCRATCH_DEV is not required, $SCRATCH_MNT
isn't either, so I don't think you can use $SCRATCH_MNT.

Also :)  We may one day want to require sysfs files which
are not in the fs/ namespace, so it should probably
be named according to the namespace.

So maybe something like this (not tested)

+ /* Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ENTRY */
+_require_fs_sys_fs()
+{
+        local dev=$1
+        local target=$2
+        local dname=""
+        local tmp_mnt=`mktemp -d`
+
+        if [ ! -b "$dev" -o -z "$target" ];then
+	        echo "Usage: _require_fs_sys_fs <device> <sysfs_path>"
+                exit 1
+        fi
+
+        dname=$(basename $(readlink -f $dev))
+        _mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
+        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
+                umount $tmp_mnt
+                rm -f $tmp_mnt
+                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
+        fi
+        umount $SCRATCH_MNT
+        rm -f $tmp_mnt
+}

and it would work for either SCRATCH or TEST?

> +_set_sys_fs_param()
> +{
> +        local dev=$1
> +        shift
> +        local target=$1
> +        shift
> +        local content="$*"
> +
> +        if [ ! -b "$dev" -o -z "$target" -o -z "$content" ];then
> +                echo "Usage: _set_sys_fs_param <mounted_device> <target> <content>"
> +                exit 1
> +        fi
> +        local dname=$(basename $(readlink -f $dev))
> +        echo "$content" > /sys/fs/${FSTYP}/${dname}/$target
> +}

This seems fine.  Normally I'd say this could just be open coded
in the test, but the dname=$(basename $(readlink -f $dev)) is worth
encapsulating in the helper.

> +_enable_xfs_fail_at_unmount()
> +{
> +        local dev=$1
> +
> +        if [ ! -b "$dev" -o "$FSTYP" != "xfs" ];then
> +                echo "Usage: _enable_xfs_fail_at_unmount <mounted_XFS_device>"
> +                exit 1
> +        fi
> +
> +        _set_sys_fs_param $dev error/fail_at_unmount 1
> +}
> +
> +_disable_xfs_fail_at_unmount()
> +{
> +        local dev=$1
> +
> +        if [ ! -b "$dev" -o "$FSTYP" != "xfs" ];then
> +                echo "Usage: _enable_xfs_fail_at_unmount <mounted_XFS_device>"
> +                exit 1
> +        fi
> +
> +        _set_sys_fs_param $dev error/fail_at_unmount 0
> +}

I don't think this is needed; it's easy enough to just call:

_set_fs_sys_fs_param $dev error/fail_at_unmount 0
_set_fs_sys_fs_param $dev error/fail_at_unmount 1

directly from tests.  There are a lot of sysfs tunables, writing wrappers
for each one isn't really that helpful.

Thanks,
-Eric

>  init_rc

>  
>  ################################################################################
> 
