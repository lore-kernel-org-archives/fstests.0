Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33756 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbbDBMP1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Apr 2015 08:15:27 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t32CFQwT019670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 2 Apr 2015 08:15:27 -0400
Date: Thu, 2 Apr 2015 20:15:23 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 5/9] generic: test fs freeze/unfreeze and mount/umount
 race
Message-ID: <20150402121522.GJ16808@dhcp-13-216.nay.redhat.com>
References: <1426846618-23413-6-git-send-email-eguan@redhat.com>
 <1427896405-11908-1-git-send-email-eguan@redhat.com>
 <20150401175609.GE4756@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150401175609.GE4756@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 01, 2015 at 01:56:09PM -0400, Brian Foster wrote:
> On Wed, Apr 01, 2015 at 09:53:25PM +0800, Eryu Guan wrote:
> > Exercise fs freeze/unfreeze and mount/umount race, which could lead to
> > use-after-free oops.
> > 
> > This commit fixed the issue:
> > 1494583 fix get_active_super()/umount() race
> > 
> > This test case is based on a script from Monakhov Dmitriy.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> > v2:
> > - add comments to explain dmsetup is used not xfs_freeze to freeze filesystem
> > - detect failures in setup phase, so test exits not continus with errors
> > 
> >  tests/generic/080     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/080.out |   2 +
> >  tests/generic/group   |   1 +
> >  3 files changed, 105 insertions(+)
> >  create mode 100755 tests/generic/080
> >  create mode 100644 tests/generic/080.out
> > 
> > diff --git a/tests/generic/080 b/tests/generic/080
> > new file mode 100755
> > index 0000000..fd460b1
> > --- /dev/null
> > +++ b/tests/generic/080
> > @@ -0,0 +1,102 @@
> > +#! /bin/bash
> > +# FS QA Test No. 080
> > +#
> > +# Exercise fs freeze/unfreeze and mount/umount race, which could lead to
> > +# use-after-free oops.
> > +#
> > +# This commit fixed the issue:
> > +# 1494583 fix get_active_super()/umount() race
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +	cleanup_dmdev
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +_require_block_device $SCRATCH_DEV
> > +_require_command $DMSETUP_PROG
> > +_require_freeze
> > +
> > +setup_dmdev()
> > +{
> > +	table="0 $size_in_sector linear $SCRATCH_DEV 0"
> > +	$DMSETUP_PROG create $node --table "$table" >>$seqres.full 2>&1 && \
> > +	$DMSETUP_PROG mknodes >/dev/null 2>&1
> > +	return $?
> > +}
> > +
> > +cleanup_dmdev()
> > +{
> > +	# in case it's still suspended and/or mounted
> > +	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
> > +	$UMOUNT_PROG $lvdev >/dev/null 2>&1
> > +
> > +	$DMSETUP_PROG remove $node >>$seqres.full 2>&1
> > +	$DMSETUP_PROG mknodes >/dev/null 2>&1
> > +}
> > +
> > +rm -f $seqres.full
> > +echo "Silence is golden"
> > +
> > +size=$((256 * 1024 * 1024))
> > +size_in_sector=$((size / 512))
> > +_scratch_mkfs_sized $size >>$seqres.full 2>&1
> > +
> > +node=$seq-test
> > +lvdev=/dev/mapper/$node
> > +setup_dmdev || _fail "setup dm device failed"
> > +
> > +# take use of dmsetup suspend to freeze the fs.
> > +# xfs_freeze/fsfreeze cannot be used in this test, because it can possibly
> > +# freeze the root fs of the host when SCRATCH_MNT is not mounted
> > +for ((i=0; i<100; i++)); do
> > +	$DMSETUP_PROG suspend $lvdev >/dev/null 2>&1
> > +	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
> > +done &
> > +pid=$!
> > +for ((i=0; i<100; i++)); do
> > +	$MOUNT_PROG $lvdev $SCRATCH_MNT >/dev/null 2>&1
> > +	$UMOUNT_PROG $lvdev >/dev/null 2>&1
> > +done &
> > +pid="$pid $!"
> > +
> 
> Still need error checks for the suspend/resume and mount/umount
> commands. As it is, I reproduce mount errors if I add such checking to
> this test. That needs to be either addressed or documented, if
> expected..?

I don't expect these racing commands to succeed all the time, and the
results are not important either, as long as they are racing with each
other.

I think I can add some comments to state the fact.

Thanks for your review!

Eryu
> 
> My primary concern is that as written, any or all of these commands
> could fail/explode for whatever external reason and the test will just
> silently pass. :)
> 
> Brian
> 
> > +wait $pid
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/080.out b/tests/generic/080.out
> > new file mode 100644
> > index 0000000..11a4a1a
> > --- /dev/null
> > +++ b/tests/generic/080.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 080
> > +Silence is golden
> > diff --git a/tests/generic/group b/tests/generic/group
> > index ee5b642..cf7408c 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -82,6 +82,7 @@
> >  077 acl attr auto enospc
> >  078 auto quick metadata
> >  079 acl attr ioctl metadata auto quick
> > +080 auto freeze mount
> >  083 rw auto enospc stress
> >  088 perms auto quick
> >  089 metadata auto
> > -- 
> > 2.1.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
