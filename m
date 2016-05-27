Received: from sandeen.net ([63.231.237.45]:37159 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243AbcE0S16 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 May 2016 14:27:58 -0400
Subject: Re: [PATCH 1/2] common/rc: add functions to check or write objects
 under /sys/fs
References: <1464362482-7704-1-git-send-email-zlang@redhat.com>
 <07e71f2f-229e-e8bf-3b73-546bef86f98b@sandeen.net>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <8311236a-820b-473d-7aab-2afa8c24a4af@sandeen.net>
Date: Fri, 27 May 2016 13:27:56 -0500
MIME-Version: 1.0
In-Reply-To: <07e71f2f-229e-e8bf-3b73-546bef86f98b@sandeen.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: cem@redhat.com
List-ID: <fstests@vger.kernel.org>

On 5/27/16 1:05 PM, Eric Sandeen wrote:

> So maybe something like this (not tested)
> 
> + /* Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ENTRY */
> +_require_fs_sys_fs()
> +{
> +        local dev=$1
> +        local target=$2
> +        local dname=""
> +        local tmp_mnt=`mktemp -d`
> +
> +        if [ ! -b "$dev" -o -z "$target" ];then
> +	        echo "Usage: _require_fs_sys_fs <device> <sysfs_path>"
> +                exit 1
> +        fi
> +
> +        dname=$(basename $(readlink -f $dev))
> +        _mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
> +        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
> +                umount $tmp_mnt
> +                rm -f $tmp_mnt
> +                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
> +        fi
> +        umount $SCRATCH_MNT
> +        rm -f $tmp_mnt
> +}
> 
> and it would work for either SCRATCH or TEST?

I guess nothing guarantees that the device is already mkfs'd, at least
for scratch, so maybe it also needs to catch a mount failure,
with a message about "could not mount; mkfs first in your test?"
or something like that.

-Eric
