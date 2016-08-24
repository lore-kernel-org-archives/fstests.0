Received: from mx1.redhat.com ([209.132.183.28]:39030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753928AbcHXKSC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Aug 2016 06:18:02 -0400
Date: Wed, 24 Aug 2016 17:56:04 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/375: Check clearing of SGID in chmod and
 acl_set_file
Message-ID: <20160824095604.GT27776@eguan.usersys.redhat.com>
References: <1471989099-19099-1-git-send-email-agruenba@redhat.com>
 <20160824092801.GR27776@eguan.usersys.redhat.com>
 <CAHc6FU76M4SsbM=VacbBOtPcOQy9w0sv4TUDiK9i4TfBD6t9ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU76M4SsbM=VacbBOtPcOQy9w0sv4TUDiK9i4TfBD6t9ug@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 24, 2016 at 11:48:51AM +0200, Andreas Gruenbacher wrote:
> Eryu,
> 
> On Wed, Aug 24, 2016 at 11:28 AM, Eryu Guan <eguan@redhat.com> wrote:
> > On Tue, Aug 23, 2016 at 11:51:39PM +0200, Andreas Gruenbacher wrote:
> >> Check if SGID is cleared upon chmod / setfacl when the owner is not in
> >> the owning group.  As of today, the kernel fails to clear SGID in
> >> setxattr (which is what acl_set_file is implemented on top of) in that
> >> case; see this patch:
> >>   https://patchwork.kernel.org/patch/9290507/
> >>
> >> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> >> Cc: Jan Kara <jack@suse.cz>
> >> ---
> >>  tests/generic/375     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/generic/375.out |  9 ++++++
> >>  tests/generic/group   |  1 +
> >>  3 files changed, 90 insertions(+)
> >>  create mode 100755 tests/generic/375
> >>  create mode 100644 tests/generic/375.out
> >>
> >> diff --git a/tests/generic/375 b/tests/generic/375
> >> new file mode 100755
> >> index 0000000..9976c3d
> >> --- /dev/null
> >> +++ b/tests/generic/375
> >> @@ -0,0 +1,80 @@
> >> +#! /bin/bash
> >> +# FS QA Test 375
> >> +#
> >> +# Check if SGID is cleared upon chmod / setfacl when the owner is not in the
> >> +# owning group.
> >> +#
> >> +#-----------------------------------------------------------------------
> >> +# Copyright (c) 2016 Red Hat.  All Rights Reserved.
> >> +#
> >> +# Author: Andreas gruenbacher <agruenba@redhat.com>
> >> +#
> >> +# This program is free software; you can redistribute it and/or
> >> +# modify it under the terms of the GNU General Public License as
> >> +# published by the Free Software Foundation.
> >> +#
> >> +# This program is distributed in the hope that it would be useful,
> >> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> +# GNU General Public License for more details.
> >> +#
> >> +# You should have received a copy of the GNU General Public License
> >> +# along with this program; if not, write the Free Software Foundation,
> >> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >> +#-----------------------------------------------------------------------
> >> +#
> >> +
> >> +seq=`basename $0`
> >> +seqres=$RESULT_DIR/$seq
> >> +echo "QA output created by $seq"
> >> +
> >> +here=`pwd`
> >> +tmp=/tmp/$$
> >> +status=1     # failure is the default!
> >> +trap "_cleanup; exit \$status" 0 1 2 3 15
> >> +
> >> +_cleanup()
> >> +{
> >> +     cd /
> >> +     rm -f $tmp.*
> >> +}
> >> +
> >> +# get standard environment, filters and checks
> >> +. ./common/rc
> >> +. ./common/filter
> >> +
> >> +# real QA test starts here
> >> +
> >> +# Modify as appropriate.
> >> +_supported_fs generic
> >> +_supported_os Linux
> >> +_require_test
> >> +_require_runas
> >
> > Need a "_require_acls", and need to source common/attr first to use
> > _require_acls.
> >
> >> +
> >> +cd $TEST_DIR
> >> +rm -f testfile
> >
> > I'd be better to name "testfile" with a test-specific prefix or suffix,
> > e.g. testfile.$seq, so we can know it's from test $seq.
> >
> > I can fix these two nitpicks at commit time, if there's no new review
> > comments from others.
> 
> Okay, thanks.
> 
> >> +
> >> +touch testfile
> >> +chown 100:100 testfile
> >> +
> >> +echo '*** SGID should remain set (twice)'
> >> +chmod 2755 testfile
> >> +_runas -u 100 -g 100 -- chmod 2777 testfile
> >> +stat -c %A testfile
> >> +chmod 2755 testfile
> >> +_runas -u 100 -g 100 -- setfacl -m u::rwx,g::rwx,o::rwx testfile
> >> +stat -c %A testfile
> >
> > I noticed that NFSv4 cleared sgid bit on setfacl above, where the sgid
> > bit should stay, maybe an NFS bug?
> 
> No, that's a setfacl bug:
> 
> http://git.savannah.gnu.org/cgit/acl.git/commit/?id=38f32ea1865bcc44185f4118fde469cb962cff68

Thanks for the info!

Eryu
