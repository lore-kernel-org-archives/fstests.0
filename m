Received: from mail.kernel.org ([198.145.29.136]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbcKREik (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 17 Nov 2016 23:38:40 -0500
Date: Thu, 17 Nov 2016 20:38:35 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] xfstests-bld: add f2fs support
Message-ID: <20161118043835.GA22707@jaegeuk>
References: <1479412353-35154-1-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479412353-35154-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Hi Eric,

On Thu, Nov 17, 2016 at 11:52:33AM -0800, Eric Biggers wrote:
> Add basic f2fs support to xfstests-bld.  I am using this to verify that
> the encryption tests I am adding to xfstests pass on both ext4 and f2fs.
> It may be useful to f2fs developers too.  For now, only one
> configuration, "f2fs/default", is offered.
> 
> For the f2fs tests to work, it's required to build a kernel with f2fs
> support and build a rootfs with f2fs-tools installed.  For testing
> encryption, f2fs-tools must be v1.5.0 or later.
> 
> It was necessary to remove the /etc/fstab lines for /dev/vd[b-f] because
> they interfered with non-ext4 fsck.  They are not needed for the tests.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  kvm-xfstests/test-appliance/files/etc/fstab        |  5 --
>  .../test-appliance/files/root/fs/f2fs/cfg/all.list |  1 +
>  .../test-appliance/files/root/fs/f2fs/cfg/default  |  4 ++
>  .../test-appliance/files/root/fs/f2fs/config       | 62 ++++++++++++++++++++++
>  kvm-xfstests/util/parse_cli                        |  2 +-
>  5 files changed, 68 insertions(+), 6 deletions(-)
>  create mode 100644 kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
>  create mode 100644 kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/default
>  create mode 100644 kvm-xfstests/test-appliance/files/root/fs/f2fs/config
> 
> diff --git a/kvm-xfstests/test-appliance/files/etc/fstab b/kvm-xfstests/test-appliance/files/etc/fstab
> index 864478b..27fb1df 100644
> --- a/kvm-xfstests/test-appliance/files/etc/fstab
> +++ b/kvm-xfstests/test-appliance/files/etc/fstab
> @@ -5,9 +5,4 @@ proc            /proc           proc    defaults        0       0
>  tmpfs		/tmp		tmpfs	mode=1777	0	0
>  debugfs		/sys/kernel/debug debugfs defaults	0	0
>  /dev/rootfs	/	ext4    noatime 0 1
> -/dev/vdb	/vdb	ext4	defaults,noauto	0	0
> -/dev/vdc	/vdc ext4	defaults,noauto	0	0
> -/dev/vdd	/vdd ext4	defaults,noauto	0	0
> -/dev/vde	/vde ext4	defaults,noauto 0	0
> -/dev/vdf	/vdf ext4	defaults,noauto 0	0
>  /dev/vdg	/results ext4	defaults 0 2
> diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
> new file mode 100644
> index 0000000..4ad96d5
> --- /dev/null
> +++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
> @@ -0,0 +1 @@
> +default
> diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/default b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/default
> new file mode 100644
> index 0000000..616a070
> --- /dev/null
> +++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/default
> @@ -0,0 +1,4 @@
> +SIZE=small
> +export MKFS_OPTIONS=""
> +export F2FS_MOUNT_OPTIONS=""
> +TESTNAME="f2fs"
> diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
> new file mode 100644
> index 0000000..3cab963
> --- /dev/null
> +++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
> @@ -0,0 +1,62 @@
> +#
> +# Configuration file for f2fs
> +#
> +
> +DEFAULT_MKFS_OPTIONS=""
> +
> +function check_filesystem()
> +{
> +    local dev="$1"
> +    local ret
> +
> +    /sbin/fsck.f2fs -f "$dev"

Could you change to call fsck.f2fs instead of /sbin/xx?
I'm almost finished to import f2fs-tools in xfstests-bld for kvm-xfstests.
Given f2fs-tools from git, it seems /sbin/xx doesn't work.

> +    ret="$?"
> +    echo fsck.f2fs exited with status "$ret"
> +    return "$ret"
> +}
> +
> +function format_filesystem()
> +{
> +    local dev="$1"
> +    local opts="$2"
> +
> +    /sbin/mkfs.f2fs -q $opts "$dev"

Ditto, mkfs.f2fs.

Thanks,

> +    return $?
> +}
> +
> +function setup_mount_opts()
> +{
> +    if test -n "$MNTOPTS" ; then
> +	if test -n "$F2FS_MOUNT_OPTIONS" ; then
> +	    F2FS_MOUNT_OPTIONS="$F2FS_MOUNT_OPTIONS,$MNTOPTS"
> +	else
> +	    F2FS_MOUNT_OPTIONS="-o $MNTOPTS"
> +	fi
> +    fi
> +}
> +
> +function get_mkfs_opts()
> +{
> +    echo "$MKFS_OPTIONS"
> +}
> +
> +function show_mkfs_opts()
> +{
> +    echo MKFS_OPTIONS: "$MKFS_OPTIONS"
> +}
> +
> +function show_mount_opts()
> +{
> +    echo F2FS_MOUNT_OPTIONS: "$F2FS_MOUNT_OPTIONS"
> +}
> +
> +function test_name_alias()
> +{
> +    echo "$1"
> +}
> +
> +function reset_vars()
> +{
> +    unset F2FS_MOUNT_OPTIONS
> +    unset MKFS_OPTIONS
> +}
> diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
> index ea747be..b42c8ba 100644
> --- a/kvm-xfstests/util/parse_cli
> +++ b/kvm-xfstests/util/parse_cli
> @@ -59,7 +59,7 @@ print_help ()
>  validate_test_name()
>  {
>      case "$1" in
> -	btrfs*|cifs*|ext4*|generic*|shared*|udf*|xfs*|overlay*) ;;
> +	btrfs*|cifs*|ext4*|f2fs*|generic*|shared*|udf*|xfs*|overlay*) ;;
>  	*)
>  	    echo -e "Invalid test name: $1\n"
>  	    print_help
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
