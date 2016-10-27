Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:13005 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932702AbcJ0Aqf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Oct 2016 20:46:35 -0400
Date: Thu, 27 Oct 2016 11:46:31 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests mount options?
Message-ID: <20161027004631.GB22126@dastard>
References: <20161024184611.GA83082@google.com>
 <20161026094724.GT27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161026094724.GT27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 26, 2016 at 05:47:24PM +0800, Eryu Guan wrote:
> On Mon, Oct 24, 2016 at 11:46:11AM -0700, Eric Biggers wrote:
> > Hi,
> > 
> > When starting xfstests without $TEST_DEV mounted, it mounts it using this
> > command in _test_mount, called from init_rc:
> > 
> >     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> 
> In my understanding, TEST_FS_MOUNT_OPTS is used for TEST_DEV, as
> MOUNT_OPTIONS is used for SCRATCH_DEV.
> 
> Looking through the git history, TEST_FS_MOUNT_OPTS was introduced by
> commit ab526a6 in 2006 without any documents. It replaced MOUNT_OPTIONS
> in _test_mount(). So I think its intention is used as mount options for
> TEST_DEV.

> 
> > 
> > This is also used by _test_cycle_mount, which some tests use.
> > 
> > This is inconsistent with the later code in _check_generic_filesystem, called
> > after each test, which remounts $TEST_DEV:
> > 
> >     _mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
> 
> _check_generic_filesystem is used in both _check_test_fs() and
> _check_scratch_fs(), I think it should use different mount options based
> on which device it's checking, not use MOUNT_OPTIONS always.

Right - we have _scratch_mount_options() for returning the
configured mount options for a scratch device.  We should extract a
similar helper out of _test_mount(), and use them appropriately
where necessary.

i.e. nothing should really be using $MOUNT_OPTIONS or
$TEST_FS_MOUNT_OPTS directly - they should always get them from
the _scratch_mount_options/_test_mount_options functions...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
