Received: from mx1.redhat.com ([209.132.183.28]:59378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754504AbdBQKOC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Feb 2017 05:14:02 -0500
Date: Fri, 17 Feb 2017 18:14:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 4/8] overlay: permission check with cached acls in
 tmpfs
Message-ID: <20170217101401.GE24562@eguan.usersys.redhat.com>
References: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
 <1487306188-2097-4-git-send-email-xzhou@redhat.com>
 <CAOQ4uxie4S-YVu61foCqERq_z41p89zwCv43Kn+its1HPJvqGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxie4S-YVu61foCqERq_z41p89zwCv43Kn+its1HPJvqGg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 17, 2017 at 09:29:18AM +0200, Amir Goldstein wrote:
> On Fri, Feb 17, 2017 at 6:36 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> > tmpfs does not implement ->get_acl method, overlayfs
> > need to get its cached acls in permission check when
> > lower or upper fs is tmpfs.
> >
> > CC: Miklos Szeredi <mszeredi@redhat.com>
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >  tests/overlay/025     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/overlay/025.out |  2 ++
> >  tests/overlay/group   |  1 +
> >  3 files changed, 88 insertions(+)
> >  create mode 100755 tests/overlay/025
> >  create mode 100644 tests/overlay/025.out
> >
> > diff --git a/tests/overlay/025 b/tests/overlay/025
> > new file mode 100755
> > index 0000000..ad3ebe1
> > --- /dev/null
> > +++ b/tests/overlay/025
> > @@ -0,0 +1,85 @@
> > +#! /bin/bash
> > +# FS QA Test 025
> > +#
> > +# Overlayfs failed to get posix acls if lower or upper
> > +# fs is tmpfs.
> > +# Kernel commit below fixed it.
> > +# 5201dc449e4b ovl: use cached acl on underlying layer
> > +#
> > +# This reproducer was originally written by
> > +#     Miklos Szeredi <mszeredi@redhat.com>
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
> > +status=1       # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +       cd /
> > +       $UMOUNT_PROG $tmp/tmpfs/mnt
> > +       $UMOUNT_PROG $tmp/tmpfs
> > +       rm -rf $tmp/tmpfs
> 
> rm -rf $tmp

Yes, otherwise test leaves $tmp dir after test.

> 
> > +       rm -f $tmp.*
> 
> I am not so sure you need that anymore since your test is not creating
> $tmp.* files.

Seems not, but it's fine to me to remove $tmp.* explicitly even test
doesn't create any $tmp.* files, I even like it :)

It's in new test template and consistent across tests (all right, most
of the tests), and makes people don't have to worry about if they should
add "rm -f $tmp.*" in _cleanup when updating tests, just use $tmp.xxx
freely, and fstests has been this way for a long time and people are
familar with this style.

Anyway, it's not a big issue, as long as all tmp files are cleaned up
properly.

> I think Eryu cleaned up the common functions that create $tmp.* files?

Yes, patch still sits in the list waiting for review.

Thanks,
Eryu
