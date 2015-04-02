Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44884 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbbDBLRV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Apr 2015 07:17:21 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 37EE4B6E9E
	for <fstests@vger.kernel.org>; Thu,  2 Apr 2015 11:17:21 +0000 (UTC)
Date: Thu, 2 Apr 2015 07:17:18 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2 3/9] generic: test hardlink to unlinked file
Message-ID: <20150402111718.GB3808@laptop.bfoster>
References: <1426846618-23413-4-git-send-email-eguan@redhat.com>
 <1427896120-11520-1-git-send-email-eguan@redhat.com>
 <20150401175446.GD4756@bfoster.bfoster>
 <20150402025923.GE16808@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150402025923.GE16808@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 02, 2015 at 10:59:23AM +0800, Eryu Guan wrote:
> On Wed, Apr 01, 2015 at 01:54:47PM -0400, Brian Foster wrote:
> > On Wed, Apr 01, 2015 at 09:48:40PM +0800, Eryu Guan wrote:
> > > Kernel commit
> > > 
> > > aae8a97 fs: Don't allow to create hardlink for deleted file
> > > 
> > > disabled hardlink to unlinked file.
> > > 
> > > Test the race between link and unlink, which could end up adding link
> > > count to an unlinked file and leading to fs corruption on xfs.
> > > 
> > > Test case was originally written by Eric Sandeen.
> > > 
> > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > ---
> > > v2:
> > > - create different link file in each iteration in link_unlink_storm(), which
> > >   is confirmed to be able to reproduce the original corruption
> > > - remove all newly created & tail'ed files at last, out of the loop, to avoid
> > >   tail & rm race
> > > - iterate $nr_cpu times to do the link_unlink_storm, not a fixed number
> > > - add to quick group
> > > 
> > >  tests/generic/073     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/073.out |   2 +
> > >  tests/generic/group   |   1 +
> > >  3 files changed, 105 insertions(+)
> > >  create mode 100755 tests/generic/073
> > >  create mode 100644 tests/generic/073.out
> > > 
> > > diff --git a/tests/generic/073 b/tests/generic/073
> > > new file mode 100755
> > > index 0000000..6fd8c89
> > > --- /dev/null
> > > +++ b/tests/generic/073
> > > @@ -0,0 +1,102 @@
> > > +#! /bin/bash
> > > +# FS QA Test No. 073
> > > +#
> > > +# Test hardlink to unlinked file.
> > > +#
> > > +# Regression test for commit:
> > > +# aae8a97 fs: Don't allow to create hardlink for deleted file
> > > +#
> > > +#-----------------------------------------------------------------------
> > > +# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
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
> > > +
> > > +link_unlink_storm()
> > > +{
> > > +	local src=$1
> > > +	local target=$2
> > > +	local i=0
> > > +
> > > +	while true; do
> > > +		ln -f $src $target.$i >/dev/null 2>&1
> > > +		rm -f $target.$i >/dev/null 2>&1
> > > +		let i=i+1
> > > +	done
> > > +}
> > > +
> > > +rm -f $seqres.full
> > > +nr_cpu=`$here/src/feature -o`
> > > +echo "Silence is golden"
> > > +
> > > +_scratch_mkfs >>$seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +# create, open & unlinked files so unlinked inode list is not empty
> > > +for i in `seq 1 $nr_cpu`; do
> > > +	testfile=$SCRATCH_MNT/$seq.unlinked.$i
> > > +	touch $testfile
> > > +	tail -f $testfile &
> > > +	tail_pids="$tail_pids $!"
> > > +done
> > > +rm -f $SCRATCH_MNT/$seq.unlinked.*
> > > +
> > 
> > Still fails:
> > 
> > generic/073      - output mismatch (see /root/xfstests-dev/results//generic/073.out.bad)
> >     --- tests/generic/073.out   2015-04-01 12:45:25.633900350 -0400
> >     +++ /root/xfstests-dev/results//generic/073.out.bad 2015-04-01 12:46:39.129900350 -0400
> >     @@ -1,2 +1,10 @@
> >      QA output created by 073
> >      Silence is golden
> >     +tail: cannot open '/mnt/scratch/073.unlinked.2' for reading: No such file or directory
> >     +tail: cannot open '/mnt/scratch/073.unlinked.4' for readingtail: : No such file or directory
> >     +cannot open '/mnt/scratch/073.unlinked.3' for reading: No such file or directory
> >     +tail: cannot open '/mnt/scratch/073.unlinked.1' for reading: No such file or directory
> >     +tail: no files remaining
> >     ...
> >     (Run 'diff -u tests/generic/073.out /root/xfstests-dev/results//generic/073.out.bad'  to see the entire diff)
> > 
> > We need a 'sleep 1' between the loop that runs the tail instances and
> > actually removing the files to trigger the background tasks to run and
> > open the files before they are removed.
> 
> This version passed on the host where originally I can see it fail.
> Seems it doesn't fail every time.
> 
> You mean adding 'sleep 1' before removing all the files?
> 
> 	for ; do
> 	done
> 	sleep 1
> 	rm -f $SCRATCH_MNT/$seq.unlinked.*
> 

Yes... the for loop creates a bunch of background tasks to open the
files we're about to unlink. There's no guarantee those background tasks
actually even begin execution by the time the parent gets to removing
the files. E.g., it's a race, sometimes it might work, sometimes not. A
sleep 1 is probably enough to make sure the parent can't progress until
the children have started.

> And what's your test vm setup? I want to see if I can reproduce the
> failure myself. I'm testing on a vm with 4 vcpus and 8G mem, running
> RHEL6.
> 

My basic testing vms are usually 2-4cpu with 4GB ram running various
operating systems. I'm running Fedora rawhide in this case...

Brian

> Thanks for your review!
> 
> Eryu
> > 
> > The rest looks pretty good to me.
> > 
> > Brian
> > 
> > > +# start link/unlink storm
> > > +src=$SCRATCH_MNT/$seq.target
> > > +touch $src
> > > +for i in `seq 1 $nr_cpu`; do
> > > +	target=$SCRATCH_MNT/$seq.target.link.$i
> > > +	link_unlink_storm $src $target &
> > > +	link_pids="$link_pids $!"
> > > +done
> > > +
> > > +# remove & re-create target to race with link/unlink
> > > +while true; do
> > > +	rm -f $src
> > > +	touch $src
> > > +done &
> > > +sleep 5
> > > +kill $! >/dev/null 2>&1
> > > +
> > > +kill $tail_pids $link_pids >/dev/null 2>&1
> > > +wait $tail_pids $link_pids
> > > +
> > > +# all done, no oops/hang expected, _check_filesystems checks SCRATCH_DEV after test
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/073.out b/tests/generic/073.out
> > > new file mode 100644
> > > index 0000000..d107704
> > > --- /dev/null
> > > +++ b/tests/generic/073.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 073
> > > +Silence is golden
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index c0210d2..ee5b642 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -75,6 +75,7 @@
> > >  070 attr udf auto quick stress
> > >  071 auto quick prealloc
> > >  072 auto quick quota
> > > +073 auto metadata quick
> > >  074 rw udf auto
> > >  075 rw udf auto quick
> > >  076 metadata rw udf auto quick stress
> > > -- 
> > > 2.1.0
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
