Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888AbbC0MKF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Mar 2015 08:10:05 -0400
Date: Fri, 27 Mar 2015 08:10:02 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 5/9 RESEND] generic: test fs freeze/unfreeze and
 mount/umount race
Message-ID: <20150327121002.GA3254@laptop.bfoster>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
 <1426846618-23413-6-git-send-email-eguan@redhat.com>
 <20150325194429.GE3436@laptop.bfoster>
 <20150327084651.GD4810@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150327084651.GD4810@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Monakhov Dmitriy <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 27, 2015 at 04:46:51PM +0800, Eryu Guan wrote:
> On Wed, Mar 25, 2015 at 03:44:29PM -0400, Brian Foster wrote:
> > On Fri, Mar 20, 2015 at 06:16:54PM +0800, Eryu Guan wrote:
> > > Exercise fs freeze/unfreeze and mount/umount race, which could lead to
> > > use-after-free oops.
> > > 
> > > This commit fixed the issue:
> > > 1494583 fix get_active_super()/umount() race
> > > 
> > > This test case is based on a script from Monakhov Dmitriy.
> > > 
> > > Cc: Monakhov Dmitriy <dmonakhov@openvz.org>
> > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > ---
> > >  tests/generic/080     | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/080.out |  2 ++
> > >  tests/generic/group   |  1 +
> > >  3 files changed, 101 insertions(+)
> > >  create mode 100755 tests/generic/080
> > >  create mode 100644 tests/generic/080.out
> > > 
> > > diff --git a/tests/generic/080 b/tests/generic/080
> > > new file mode 100755
> > > index 0000000..7d9fa5c
> > > --- /dev/null
> > > +++ b/tests/generic/080
> > > @@ -0,0 +1,98 @@
> > > +#! /bin/bash
> > > +# FS QA Test No. 080
> > > +#
> > > +# Exercise fs freeze/unfreeze and mount/umount race, which could lead to
> > > +# use-after-free oops.
> > > +#
> > > +# This commit fixed the issue:
> > > +# 1494583 fix get_active_super()/umount() race
> > > +#
> > > +#-----------------------------------------------------------------------
> > > +# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
> > > +#
> > > +# This program is free software; you can redistribute it and/or
> > > +# modify it under the terms of the GNU General Public License as
> > > +# published by the Free Software Foundation.
> > > +#
> > > +# This program is distributed in the hope that it would be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > +# GNU General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU General Public License
> > > +# along with this program; if not, write the Free Software Foundation,
> > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > +#-----------------------------------------------------------------------
> > > +#
> > > +
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +	cleanup_dmdev
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_scratch
> > > +_require_block_device $SCRATCH_DEV
> > > +_require_command $DMSETUP_PROG
> > > +_require_freeze
> > > +
> > > +setup_dmdev()
> > > +{
> > > +	table="0 $size_in_sector linear $SCRATCH_DEV 0"
> > > +	$DMSETUP_PROG create $node --table "$table" >>$seqres.full 2>&1
> > > +	$DMSETUP_PROG mknodes >/dev/null 2>&1
> > > +}
> > > +
> > > +cleanup_dmdev()
> > > +{
> > > +	# in case it's still suspended and/or mounted
> > > +	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
> > > +	$UMOUNT_PROG $lvdev >/dev/null 2>&1
> > > +
> > > +	$DMSETUP_PROG remove $node >>$seqres.full 2>&1
> > > +	$DMSETUP_PROG mknodes >/dev/null 2>&1
> > > +}
> > > +
> > > +rm -f $seqres.full
> > > +echo "Silence is golden"
> > > +
> > > +size=$((256 * 1024 * 1024))
> > > +size_in_sector=$((size / 512))
> > > +_scratch_mkfs_sized $size >>$seqres.full 2>&1
> > > +
> > > +node=$seq-test
> > > +lvdev=/dev/mapper/$node
> > > +setup_dmdev
> > > +
> > > +for ((i=0; i<100; i++)); do
> > > +	$DMSETUP_PROG suspend $lvdev >/dev/null 2>&1
> > > +	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
> > > +done &
> > 
> > Any reason we can't use xfs_freeze/fsfreeze for this test? That seems
> > more simple (avoids the dm stuff), but I don't know enough about the
> > original problem to know if that still reproduces it.
> 
> Yes, fsfreeze/unfreeze can reproduce the problem too, and that was
> how Monakhov Dmitriy reproduced it at first, running fstests with
> xfs_freeze -f/xfs_freeze -u loop in background.
> 
> The problem is it's racing with umount so it's possible SCRATCH_DEV is
> not mounted at SCRATCH_MNT when xfs_freeze tries to freeze it, then the
> root fs is freezed instead, then the host just hangs there.
> 
> Using dmsetup is safer, just freezes the device we want to test.
> 

Ah, I see. Sounds reasonable. Could you add some comments to explain why
the test is implemented this way?

I'd also recommend some error checking for this test (e.g., the various
setup commands, the suspend/resume commands, etc.).

Brian

> Thanks,
> Eryu
> > 
> > Brian
> > 
> > > +pid=$!
> > > +for ((i=0; i<100; i++)); do
> > > +	$MOUNT_PROG $lvdev $SCRATCH_MNT >/dev/null 2>&1
> > > +	$UMOUNT_PROG $lvdev >/dev/null 2>&1
> > > +done &
> > > +pid="$pid $!"
> > > +
> > > +wait $pid
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/080.out b/tests/generic/080.out
> > > new file mode 100644
> > > index 0000000..11a4a1a
> > > --- /dev/null
> > > +++ b/tests/generic/080.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 080
> > > +Silence is golden
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index ee5b642..cf7408c 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -82,6 +82,7 @@
> > >  077 acl attr auto enospc
> > >  078 auto quick metadata
> > >  079 acl attr ioctl metadata auto quick
> > > +080 auto freeze mount
> > >  083 rw auto enospc stress
> > >  088 perms auto quick
> > >  089 metadata auto
> > > -- 
> > > 2.1.0
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
