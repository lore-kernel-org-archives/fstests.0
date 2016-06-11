Received: from mx1.redhat.com ([209.132.183.28]:59473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbcFKOSS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 11 Jun 2016 10:18:18 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA83B7D0DB
	for <fstests@vger.kernel.org>; Sat, 11 Jun 2016 14:18:17 +0000 (UTC)
Date: Sat, 11 Jun 2016 22:18:15 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3 1/2] common/rc: add functions to check or write
 objects under /sys/fs/$FSTYP
Message-ID: <20160611141815.GU5140@eguan.usersys.redhat.com>
References: <1464496121-6380-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464496121-6380-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Sun, May 29, 2016 at 12:28:40PM +0800, Zorro Lang wrote:
> XFS add more configurations in /sys/fs/xfs recently. For use
> them, this patch add some common functions for:
>   1. "require" a file/dir in /sys/fs/${FSTYP}.
>   2. write a file in /sys/fs/${FSTYP}.
> 
> For common use, these functions can be used by other filesystems.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> V3 revert dname=$(basename $(readlink -f $dev)) line.
> 
> I think we don't need to check if /sys/fs/${FSTYP}/${dname}/$target
> is exist in _set_fs_sys_fs_param(). Because if no this file,
> *echo* will report error, and it will disturb golden file.
> 
> Thanks,
> Zorro
> 
>  common/rc | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 51092a0..759ec30 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3556,6 +3556,46 @@ run_fsx()
>  	fi
>  }
>  
> +_require_fs_sys_fs()

_require_fs_sysfs seems better to me :)

And a comment about the purpose of this helper would be fine, e.g. the
comment Eric wrote in his review:

"Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ENTRY"

> +{
> +	local dev=$1
> +	local target=$2
> +	local tmp_mnt=`mktemp -d`
> +
> +	if [ ! -b "$dev" -o -z "$target" ];then
> +		_fail "Usage: _require_fs_sys_fs <device> <sysfs_path>"
> +        fi
> +
> +	local dname=$(basename $(readlink -f $dev))

We do have a helper "_short_dev" to do this, e.g.

	local dname=`_short_dev $dev`

> +	_mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
> +	if [ $? -ne 0 ];then
> +		rm -f $tmp_mnt
> +		_fail "could not mount; mkfs first in your test?"

Having function name as prefix in error message makes debugging easier,
I think.

> +	elif [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
> +		umount $tmp_mnt

Use $UMOUNT_PROG here, and in all other umount calls.

> +		rm -f $tmp_mnt
> +		_notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
> +	fi
> +	umount $tmp_mnt
> +	rm -rf $tmp_mnt
> +}
> +
> +_set_fs_sys_fs_param()

_set_fs_sysfs_param :) And a comment about its purpose.

Thanks,
Eryu

> +{
> +	local dev=$1
> +	shift
> +	local target=$1
> +	shift
> +	local content="$*"
> +
> +	if [ ! -b "$dev" -o -z "$target" -o -z "$content" ];then
> +		_fail "Usage: _set_sys_fs_param <mounted_device> <target> <content>"
> +	fi
> +
> +	local dname=$(basename $(readlink -f $dev))
> +	echo "$content" > /sys/fs/${FSTYP}/${dname}/$target
> +}
> +
>  init_rc
>  
>  ################################################################################
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
