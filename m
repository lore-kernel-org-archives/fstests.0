Received: from mx1.redhat.com ([209.132.183.28]:53110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbcJZJr1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Oct 2016 05:47:27 -0400
Date: Wed, 26 Oct 2016 17:47:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: xfstests mount options?
Message-ID: <20161026094724.GT27776@eguan.usersys.redhat.com>
References: <20161024184611.GA83082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161024184611.GA83082@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 24, 2016 at 11:46:11AM -0700, Eric Biggers wrote:
> Hi,
> 
> When starting xfstests without $TEST_DEV mounted, it mounts it using this
> command in _test_mount, called from init_rc:
> 
>     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR

In my understanding, TEST_FS_MOUNT_OPTS is used for TEST_DEV, as
MOUNT_OPTIONS is used for SCRATCH_DEV.

Looking through the git history, TEST_FS_MOUNT_OPTS was introduced by
commit ab526a6 in 2006 without any documents. It replaced MOUNT_OPTIONS
in _test_mount(). So I think its intention is used as mount options for
TEST_DEV.

> 
> This is also used by _test_cycle_mount, which some tests use.
> 
> This is inconsistent with the later code in _check_generic_filesystem, called
> after each test, which remounts $TEST_DEV:
> 
>     _mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint

_check_generic_filesystem is used in both _check_test_fs() and
_check_scratch_fs(), I think it should use different mount options based
on which device it's checking, not use MOUNT_OPTIONS always.

And there's another inconsistency in _require_test()

	out=`_mount_or_remount_rw "$MOUNT_OPTIONS" $TEST_DEV $TEST_DIR`

We should use TEST_FS_MOUNT_OPTS here, because we know we're working on
TEST_DEV in this function.

> 
> It is possible to have mount options in $MOUNT_OPTIONS which then are *not*
> included in the options that _test_mount uses.
> 
> $TEST_FS_MOUNT_OPTS is also very strange in that it only appears to ever be set
> when testing CIFS.

Only CIFS set both TEST_FS_MOUNT_OPTS and MOUNT_OPTIONS to
CIFS_MOUNT_OPTIONS, that means for cifs it's not possible to use
different mount options for TEST_DEV and SCRATCH_DEV if you have
CIFS_MOUNT_OPTIONS set.

Thanks,
Eryu

> 
> Which version of the test device mount options is correct?  Is it documented
> anywhere what is the correct way to configure the mount options used by
> xfstests?
> 
> Thanks,
> 
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
