Received: from mx1.redhat.com ([209.132.183.28]:38578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbdHBJEJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Aug 2017 05:04:09 -0400
Date: Wed, 2 Aug 2017 17:04:07 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] common/config: add acl and user_xattr support for
 TEST_DEV
Message-ID: <20170802090407.GV9167@eguan.usersys.redhat.com>
References: <20170731085518.GI9167@eguan.usersys.redhat.com>
 <1501493816-29678-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501493816-29678-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 31, 2017 at 05:36:56PM +0800, Xiao Yang wrote:
> On RHEL6.9GA, generic/097 fails for ext4 because _test_cycle_mount()
> remount ext4 without the user_xattr option, so extended attributes
> are not supported by ext4.
> 
> On some old kernels, ext4 filesystem can not be mounted with acl and
> user_xattr options by default.  The following patch has enabled these
> options by default:
> 'ea6633369458("ext4: enable acls and user_xattr by default")'
> 
> We add acl and user_xattr support in _test_mount_opts(), and it works
> normally on all kernels.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks for the patch! But it exposes some bugs in config section
handling, a section for xfs test could inherit TEST_FS_MOUNT_OPTS (and
other variables like MOUNT_OPTIONS) from previous ext4 section, and xfs
doesn't support acl mount option which results in a mount failure for
TEST_DEV.

I'll look into the config section bug first, and apply this patch after
fixing that bug. This patch fixes a minor bug that only shows up on
older kernels and only affects one test, so I think it's not urgent to
fix. OTOH, I think config section is more widely used and affects more
people.

Thanks,
Eryu

> ---
>  common/config | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/common/config b/common/config
> index 80598d0..4f7fba8 100644
> --- a/common/config
> +++ b/common/config
> @@ -335,6 +335,10 @@ _test_mount_opts()
>  	glusterfs)
>  		export TEST_FS_MOUNT_OPTS=$GLUSTERFS_MOUNT_OPTIONS
>  		;;
> +	ext2|ext3|ext4|ext4dev)
> +		# acls & xattrs aren't turned on by default on older ext$FOO
> +		export TEST_FS_MOUNT_OPTS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> +		;;
>  	*)
>  		;;
>  	esac
> -- 
> 1.8.3.1
> 
> 
> 
