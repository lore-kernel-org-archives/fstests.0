Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:51620 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013AbaLAFIt (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 1 Dec 2014 00:08:49 -0500
Date: Mon, 1 Dec 2014 16:08:22 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Support overlayfs testing.
Message-ID: <20141201050822.GI16151@dastard>
References: <CAK9uKkcDnJzNyJBxb9jaONUHDwn9Z35c=ixa96pX=tc=ws93LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9uKkcDnJzNyJBxb9jaONUHDwn9Z35c=ixa96pX=tc=ws93LA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Li Mengyang <li.mengyang@stonybrook.edu>
Cc: xfs@oss.sgi.com, Erez Zadok <ezk@fsl.cs.sunysb.edu>, miklos@szeredi.hu, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[cc fstests@vger.kernel.org]

On Sat, Nov 15, 2014 at 03:41:39PM -0500, Li Mengyang wrote:
> Hi,
>  Recently people are proposing overlayfs for inclusion into the mainline, I
> found it could be helpful if xfstests supports overlayfs testing. Here is
> the patch and example configuration file for that. Thank you.

Sorry, I missed this in all the other stuff going paston the xfs
list. In future, can you send patches to xfstests to
fstests@vger.kernel.org?

> diff --git a/common/rc b/common/rc
> index d5e3aff..efa0fac 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1133,6 +1133,24 @@ _require_test()
>  		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
>  		fi
>  		;;
> +	overlayfs)
> +		if [ -z "$OVLFS_LOWERDIR" -o ! -d "$OVLFS_LOWERDIR" ];
> +		then
> +		    _notrun "this test requires a valid \$OVLFS_LOWERDIR"
> +		fi
> +		if [ -z "$OVLFS_UPPERDIR" -o ! -d "$OVLFS_UPPERDIR" ];
> +		then
> +		    _notrun "this test requires a valid \$OVLFS_UPPERDIR"
> +		fi
> +		if [ -z "$OVLFS_WORKDIR" -o ! -d "$OVLFS_WORKDIR" ];
> +		then
> +		    _notrun "this test requires a valid \$OVLFS_WORKDIR"
> +		fi

Why do these varibles need to be declared and checked by the test
harness? They are purely mount option fields, and so if they don't
exist mount will fail, right?

Indeed, if you're going to start validating such variables, then
you'd need to check they don't point at the same directory, etc.
i.e. I don't think this actually belongs here....

> +		if [ -z "$TEST_DIR" -o ! -d "$TEST_DIR" ];
> +		then
> +		    _notrun "this test requires a valid \$TEST_DIR"
> +		fi

Why would you not test for $TEST_DEV, too?

> +		;;
>  	*)
>  		 if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
>  		 then
> @@ -1947,6 +1965,9 @@ _check_test_fs()
>      tmpfs)
>  	# no way to check consistency for tmpfs
>  	;;
> +    overlayfs)
> +	# no way to check consistency for overlayfs
> +	;;
>      *)
>  	_check_generic_filesystem $TEST_DEV
>  	;;
> diff --git a/configs/overlayfs.config b/configs/overlayfs.config
> new file mode 100644
> index 0000000..42ef975
> --- /dev/null
> +++ b/configs/overlayfs.config
> @@ -0,0 +1,16 @@
> +# Example config for overlayfs
> +# source me before run ./check
> +
> +export OVLFS_LOWERDIR=/mnt/ovllower
> +export OVLFS_UPPERDIR=/mnt/ovlupper
> +export OVLFS_WORKDIR=/mnt/workdir
> +
> +export TEST_DIR=/mnt/merged
> +export TEST_DEV=/dev/loop0

Slightly confused.  I'm trying to understand what the TEST_DEV has
to do with the overlayfs mount. Understand that I know *nothing*
about how overlayfs should be set up, and neither will most people
who want to add a FSTYP=overlayfs to their config section to test
that overlayfs works on the filesystem they develop/maintain.

I think that the "How to set up overlayfs" needs to be documented in
the README file, not left as an exercise for the reader to reverse
engineer what a template is supposed to do.  i.e. if I want to test
overlayfs on XFS and I already have /dev/vda as an XFS filesystem,
exactly what do I do need to do to make xfstests work?

> +export TEST_FS_MOUNT_OPTS=-olowerdir=$OVLFS_LOWERDIR,\
> +upperdir=$OVLFS_UPPERDIR,workdir=$OVLFS_WORKDIR
> +
> +unset SCRATCH_DEV
> +unset SCRATCH_MNT

No need to unset variables you don't need, nor is there any need to
export them - the test harness will export them as appropriate

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
