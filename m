Received: from mx1.redhat.com ([209.132.183.28]:53162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbdGaIzU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 31 Jul 2017 04:55:20 -0400
Date: Mon, 31 Jul 2017 16:55:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/rc: add variable MOUNT_OPTIONS into _test_mount
Message-ID: <20170731085518.GI9167@eguan.usersys.redhat.com>
References: <1501488393-25924-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501488393-25924-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 31, 2017 at 04:06:33PM +0800, Xiao Yang wrote:
> On RHEL6.9GA, generic/097 fails for ext4 because _test_cycle_mount()
> remount ext4 without the user_xattr option, so extended attributes
> are not supported by ext4.
> 
> On some old kernels, ext4 filesystem can not be mounted with acl and
> user_xattr options by default.  The following patch has enabled these
> options by default:
> 'ea6633369458("ext4: enable acls and user_xattr by default")'
> 
> We add variable MOUNT_OPTIONS into _test_mount, and it works normally
> on all kernels.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

MOUNT_OPTIONS is for SCRATCH_DEV, TEST_FS_MOUNT_OPTS is for TEST_DEV, I
think what you should update is _test_mount_opts in common/config, add
something similar to _test_opts for ext series, to add acl and
user_xattr support. Could you please verify if that works?

Thanks,
Eryu

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index c752979..c478eeb 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -519,7 +519,7 @@ _test_mount()
>          return $?
>      fi
>      _test_options mount
> -    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> +    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS `_common_dev_mount_options $*` $TEST_DEV $TEST_DIR
>  }
>  
>  _test_unmount()
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
