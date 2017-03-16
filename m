Received: from mx1.redhat.com ([209.132.183.28]:60138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbdCPGEe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Mar 2017 02:04:34 -0400
Date: Thu, 16 Mar 2017 14:04:32 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] fstests: add GlusterFS support
Message-ID: <20170316060432.GI21915@dhcp12-143.nay.redhat.com>
References: <1489642099-9019-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489642099-9019-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: gluster-devel@gluster.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 16, 2017 at 01:28:19PM +0800, Zorro Lang wrote:
> Add basic GlusterFS support. Neither new GlusterFS specific tests
> nor related patches are included. Only support FSTYP=glusterfs or
> check -glusterfs XXX.
> 
> To test on glusterfs, two gluster volumes and two mountpoint
> directories are needed.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi glusterfs developers,
> 
> Recently some people cares about testing kernel FUSE by running
> xfstests. We can't test FUSE independently, we must depend upon
> someone real FS base on FUSE, e.g. GlusterFS.
> 
> This patch only want to run xfstests on glusterfs, but I haven't
> made sure if there's no case bugs for glusterfs. I think that's
> another problem which I will fix in later patches.
> 
> At first I prepare two gluster volumes and two directories, then
> set into xfstests/local.config.
> 
> [root@ibm-x3650m4-10 xfstests-dev]# cat local.config
> TEST_DIR=/mnt/gluster/test
> TEST_DEV=ibm-xxxx-xx.redhat.com:testvol
> SCRATCH_MNT=/mnt/gluster/scratch
> SCRATCH_DEV=ibm-xxxx-xx.redhat.com:scratchvol
> 
> (feel free to set MOUNT_OPTIONS, or GLUSTERFS_MOUNT_OPTIONS)
> 
> Then I ran some generic cases, e.g. g/001 and g/117, one test on
> TEST_DEV, and the other run on SCRATCH_DEV:
> 
> [root@ibm-x3650m4-10 xfstests-dev]# ./check -glusterfs generic/001
> FSTYP         -- glusterfs
> PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 3.10.0-581.el7.x86_64
> MKFS_OPTIONS  -- ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol
> MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol /mnt/gluster/scratch
> 
> generic/001 9s ... 8s
> Ran: generic/001
> Passed all 1 tests
> 
> [root@ibm-x3650m4-10 xfstests-dev]# ./check -glusterfs generic/117
> FSTYP         -- glusterfs
> PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 3.10.0-581.el7.x86_64
> MKFS_OPTIONS  -- ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol
> MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol /mnt/gluster/scratch
> 
> generic/117 24s ... 24s
> Ran: generic/117
> Passed all 1 tests
> 
> The results look good. But there're some cases fails on glusterfs,
> I think that's case problem or glusterfs problems. I'll look into
> them in the future.
> 
> I only know how to use "mount -t glusterfs XXXX:vol /mnt", if you
> have any other requirements or suggestions, please tell me.
> Welcome send more patches to fstests@ mail list:)
> 
> Thanks,
> Zorro
> 
>  README.config-sections |  7 +++++++
>  check                  |  2 ++
>  common/config          |  6 ++++++
>  common/rc              | 34 ++++++++++++++++++++++++++++++++--
>  4 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/README.config-sections b/README.config-sections
> index df7c929..9133997 100644
> --- a/README.config-sections
> +++ b/README.config-sections
> @@ -121,3 +121,10 @@ TEST_DIR=/mnt/test
>  TEST_DEV=192.168.14.1:6789:/
>  TEST_FS_MOUNT_OPTS="-o name=admin,secret=AQDuEBtYKEYRINGSECRETriSC8YJGDZsQHcr7g=="
>  FSTYP="ceph"
> +
> +[glusterfs]
> +FSTYP=glusterfs
> +TEST_DIR=/mnt/gluster/test
> +TEST_DEV=192.168.1.1:testvol
> +SCRATCH_DIR=/mnt/gluster/scratch

Sorry, there's a mistake, SCRATCH_DIR should be SCRATCH_MNT. I'll
fix it if glusterfs team has more suggestions after review.

Thanks,
Zorro

> +SCRATCH_DEV=192.168.1.1:scratchvol
> diff --git a/check b/check
> index c2c22e2..2fcf385 100755
> --- a/check
> +++ b/check
> @@ -65,6 +65,7 @@ usage()
>  
>  check options
>      -nfs                test NFS
> +    -glusterfs                test GlusterFS
>      -cifs               test CIFS
>      -overlay		test overlay
>      -tmpfs              test TMPFS
> @@ -260,6 +261,7 @@ while [ $# -gt 0 ]; do
>  	-\? | -h | --help) usage ;;
>  
>  	-nfs)		FSTYP=nfs ;;
> +	-glusterfs)	FSTYP=glusterfs ;;
>  	-cifs)		FSTYP=cifs ;;
>  	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
>  	-tmpfs)		FSTYP=tmpfs ;;
> diff --git a/common/config b/common/config
> index 0c7335a..1ee16f7 100644
> --- a/common/config
> +++ b/common/config
> @@ -301,6 +301,9 @@ _mount_opts()
>  	ceph)
>  		export MOUNT_OPTIONS=$CEPHFS_MOUNT_OPTIONS
>  		;;
> +	glusterfs)
> +		export MOUNT_OPTIONS=$GLUSTERFS_MOUNT_OPTIONS
> +		;;
>  	overlay)
>  		export MOUNT_OPTIONS=$OVERLAY_MOUNT_OPTIONS
>  		;;
> @@ -341,6 +344,9 @@ _test_mount_opts()
>  	ceph)
>  		export TEST_FS_MOUNT_OPTS=$CEPHFS_MOUNT_OPTIONS
>  		;;
> +	glusterfs)
> +		export TEST_FS_MOUNT_OPTS=$GLUSTERFS_MOUNT_OPTIONS
> +		;;
>  	*)
>  		;;
>  	esac
> diff --git a/common/rc b/common/rc
> index d53f679..7185c3f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -167,6 +167,8 @@ case "$FSTYP" in
>  	 ;;
>      ceph)
>  	 ;;
> +    glusterfs)
> +	 ;;
>      overlay)
>  	 ;;
>      reiser4)
> @@ -706,6 +708,9 @@ _test_mkfs()
>      ceph)
>  	# do nothing for ceph
>  	;;
> +    glusterfs)
> +	# do nothing for glusterfs
> +	;;
>      overlay)
>  	# do nothing for overlay
>  	;;
> @@ -788,7 +793,7 @@ _scratch_mkfs()
>  	local mkfs_status
>  
>  	case $FSTYP in
> -	nfs*|cifs|ceph|overlay)
> +	nfs*|cifs|ceph|overlay|glusterfs)
>  		# unable to re-create this fstyp, just remove all files in
>  		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>  		# created in previous runs
> @@ -1307,7 +1312,8 @@ _fs_type()
>      # Fix the filesystem type up here so that the callers don't
>      # have to bother with this quirk.
>      #
> -    _df_device $1 | $AWK_PROG '{ print $2 }' | sed -e 's/nfs4/nfs/'
> +    _df_device $1 | $AWK_PROG '{ print $2 }' | \
> +        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/'
>  }
>  
>  # return the FS mount options of a mounted device
> @@ -1489,6 +1495,15 @@ _check_mounted_on()
>  _require_scratch_nocheck()
>  {
>      case "$FSTYP" in
> +	glusterfs)
> +		echo $SCRATCH_DEV | grep -q "\w:\w" > /dev/null 2>&1
> +		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_DEV"
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;
>  	nfs*|ceph)
>  		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> @@ -1568,6 +1583,15 @@ _require_scratch()
>  _require_test()
>  {
>      case "$FSTYP" in
> +	glusterfs)
> +		echo $TEST_DEV | grep -q "\w:\w" > /dev/null 2>&1
> +		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ]; then
> +			_notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;
>  	nfs*|ceph)
>  		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
>  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> @@ -2421,6 +2445,9 @@ _check_test_fs()
>      ceph)
>  	# no way to check consistency for CephFS
>  	;;
> +    glusterfs)
> +	# no way to check consistency for GlusterFS
> +	;;
>      overlay)
>  	# no way to check consistency for overlay
>  	;;
> @@ -2468,6 +2495,9 @@ _check_scratch_fs()
>      ceph)
>  	# no way to check consistency for CephFS
>  	;;
> +    glusterfs)
> +	# no way to check consistency for GlusterFS
> +	;;
>      overlay)
>  	# no way to check consistency for overlay
>  	;;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
