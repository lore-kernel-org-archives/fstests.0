Received: from mx1.redhat.com ([209.132.183.28]:44692 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbcDUNPg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Apr 2016 09:15:36 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E804B7D0F0
	for <fstests@vger.kernel.org>; Thu, 21 Apr 2016 13:15:35 +0000 (UTC)
Date: Thu, 21 Apr 2016 21:15:34 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] overlay: test basic whiteout
Message-ID: <20160421131534.GA3450@dhcp12-144.nay.redhat.com>
References: <1461241438-24238-1-git-send-email-xzhou@redhat.com>
 <20160421125732.GF4675@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160421125732.GF4675@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 21, 2016 at 08:57:32PM +0800, Eryu Guan wrote:
> On Thu, Apr 21, 2016 at 08:23:58PM +0800, Xiong Zhou wrote:
> > Overlayfs whiteout can be visible if underlying xfs was created
> > with ftype=0. Kernel commit
> > 	45aebea (ovl: Ensure upper filesystem supports d_type)
> > prevents mounting overlayfs like this since v4.6-rc1. No harm to
> > keep this test as a sanity check.
> 
> It turns out that the test harness won't even start if underlying XFS
> has no d_type support :)

Yes, so do other overlay test cases. Maybe we should check underlying
fs d_type support situation before running overlay cases, mark as
not run if need.

> 
> mount: wrong fs type, bad option, bad superblock on /mnt/ovl/test,
>        missing codepage or helper program, or other error
> 
>        In some cases useful info is found in syslog - try
>        dmesg | tail or so.
> common/rc: retrying test device mount with external set
> 
> But I still think it's good to have a whiteout sanity test.
> 
> > 
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >  tests/overlay/003     | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/overlay/003.out |  2 ++
> >  tests/overlay/group   |  1 +
> >  3 files changed, 81 insertions(+)
> >  create mode 100755 tests/overlay/003
> >  create mode 100644 tests/overlay/003.out
> > 
> > diff --git a/tests/overlay/003 b/tests/overlay/003
> > new file mode 100755
> > index 0000000..2401075
> > --- /dev/null
> > +++ b/tests/overlay/003
> > @@ -0,0 +1,78 @@
> > +#! /bin/bash
> > +# FS QA Test 003
> > +#
> > +# Test overlayfs whiteout.
> > +#
> > +# Overlayfs whiteout can be visible if underlying xfs was created
> > +# with ftype=0. Kernel commit
> > +#	45aebea (ovl: Ensure upper filesystem supports d_type)
> > +# prevents mounting overlayfs like this since v4.6-rc1. No harm to
> > +# keep this test as a sanity check.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2016 Red Hat Inc. All Rights Reserved.
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
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs overlay
> > +_supported_os Linux
> > +_require_scratch
> > +
> > +# Remove all files from previous tests
> > +_scratch_mkfs
> > +
> > +# Create test file in lower dir
> > +lowerdir=${SCRATCH_DEV}/${OVERLAY_LOWER_DIR}
> > +mkdir -p $lowerdir
> > +touch ${lowerdir}/test_file
> 
> I think as a whiteout sanity test, more file types can be tested here,
> not only regular file, things like dir, hardlink, symlink, chardev,
> blkdev and named pipe should be tested as well.

Yes! I missed this. Great catch!

> 
> > +
> > +_scratch_mount
> > +
> > +# whiteout file in overlay mount
> > +rm -f ${SCRATCH_MNT}/test_file
> 
> Then all files can be removed here
> rm -rf ${SCRATCH_MNT}/*
> 
> > +# it should not be listed
> > +ls -l ${SCRATCH_MNT}/test_file 2>&1 | awk -F: '{print $NF}'
> 
> And no output expected here from ls
> ls ${SCRATCH_MNT}/
> 
> > +
> > +_scratch_unmount
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/overlay/003.out b/tests/overlay/003.out
> > new file mode 100644
> > index 0000000..83bafee
> > --- /dev/null
> > +++ b/tests/overlay/003.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 003
> > + No such file or directory
> 
> And probably we can change this to a simple "Silence is golden" and
> print it from the test.

en.. yes, this looks better.

> 
> > diff --git a/tests/overlay/group b/tests/overlay/group
> > index 84d164e..f671c67 100644
> > --- a/tests/overlay/group
> > +++ b/tests/overlay/group
> > @@ -5,3 +5,4 @@
> >  #
> >  001 auto quick copyup
> >  002 auto quick metadata
> > +003 auto quick
> 
> Add a new "whiteout" group?

Good idea.  Thanks very much for reviewing!

--
Xiong

> 
> Thanks,
> Eryu
