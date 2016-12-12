Received: from mga05.intel.com ([192.55.52.43]:6156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753388AbcLLRml (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Dec 2016 12:42:41 -0500
Date: Mon, 12 Dec 2016 10:42:40 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] generic: Check linking O_TMPFILE into namespace with
 POSIX ACLs
Message-ID: <20161212174240.GA3622@linux.intel.com>
References: <1476877814-29310-1-git-send-email-agruenba@redhat.com>
 <CAOxpaSUMJ13=o0oudfBUZXzXe6sxKRvhnBbAtmd75q_S2R57mQ@mail.gmail.com>
 <20161210053935.GP29149@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161210053935.GP29149@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Ross Zwisler <zwisler@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 10, 2016 at 01:39:35PM +0800, Eryu Guan wrote:
> On Fri, Dec 09, 2016 at 01:35:36PM -0700, Ross Zwisler wrote:
> > On Wed, Oct 19, 2016 at 5:50 AM, Andreas Gruenbacher
> > <agruenba@redhat.com> wrote:
> > >
> > > When an O_TMPFILE file is linked into a directory with a POSIX default
> > > ACL, the file should inherit the default ACL and the umask needs to be
> > > ignored.
> > >
> > > This goes together with generic/004, which tests O_TMPFILE files without
> > > POSIX ACLs.
> > >
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > 
> > I can't seem to get this test to pass.  It fails for me with PMEM and
> > BRD devices, and with XFS, ext4 and ext2.
> 
> Probably you need the latest xfsprogs, specifically this patch
> 
> commit 41c702ce4b2bbea59e49384a90e17c64e46bd3ae
> Author: Andreas Gruenbacher <agruenba@redhat.com>
> Date:   Tue Nov 1 10:38:40 2016 +1100
> 
>     xfs_io: Fix initial -m option
>     
>     Like "open -m mode", the initial -m option requires a mode argument.
>     
>     Document these options correctly as well.
>     
>     Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>     Reviewed-by: Dave Chinner <dchinner@redhat.com>
>     Signed-off-by: Dave Chinner <david@fromorbit.com>
> 

Great, thanks.  I updated my xfsprogs and e2fsprogs and now it's passing for
all 3 filesystems.
