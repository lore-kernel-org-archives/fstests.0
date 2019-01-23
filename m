Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:18426 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726968AbfAWEMu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jan 2019 23:12:50 -0500
Date: Wed, 23 Jan 2019 15:12:46 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] xfs/068: new fsstress operation breaks xfsrestore
 output
Message-ID: <20190123041246.GO6173@dastard>
References: <20190119024258.6864-1-zlang@redhat.com>
 <20190119024258.6864-2-zlang@redhat.com>
 <20190121224412.GE4205@dastard>
 <CAOQ4uxjjGuNKWXmNKGq_7+ckkYm9ERF+Mne-jdvJY8r-4YzkZQ@mail.gmail.com>
 <20190122045854.GE2255@dhcp-12-149.nay.redhat.com>
 <20190122222216.GN6173@dastard>
 <20190123034406.GF2255@dhcp-12-149.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123034406.GF2255@dhcp-12-149.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 23, 2019 at 11:44:06AM +0800, Zorro Lang wrote:
> On Wed, Jan 23, 2019 at 09:22:16AM +1100, Dave Chinner wrote:
> > On Tue, Jan 22, 2019 at 12:58:54PM +0800, Zorro Lang wrote:
> > > > This is not the case with the newly added SPLICE operation and
> > > > updating the golden output rather than blacklisting the new operation
> > > > is what was decided and done two times in recent history (also patches
> > > > by Zorro).
> > > 
> > > Yes, I saw that FSSTRESS_AVOID in common/dump. But I thought (if I'm wrong
> > > please feel free to correct me):
> > > 1) dedupe/clone/copyrange might not be compiled in fsstress, they depend
> > >    on "#ifndef ... #endif". That will make different xfsdump/restore output
> > >    when a fs with or without these operations. Then there's not a fixed 068.out.
> > >    So they must be avoided.
> > 
> > > 2) splice syscall is an old common function, which is first appeared in Linux
> > >    2.6.17. So I think it's safe to be added.
> > 
> > What makes you think it worked in 2.6.17? I mean:
> > 
> > commit 0ff28d9f4674d781e492bcff6f32f0fe48cf0fed
> > Author: Christophe Leroy <christophe.leroy@c-s.fr>
> > Date:   Wed May 6 17:26:47 2015 +0200
> > 
> >     splice: sendfile() at once fails for big files
> >     
> >     Using sendfile with below small program to get MD5 sums of some files,
> >     it appear that big files (over 64kbytes with 4k pages system) get a
> >     wrong MD5 sum while small files get the correct sum.
> >     This program uses sendfile() to send a file to an AF_ALG socket
> >     for hashing.
> > .....
> > 
> > i.e. using sendfile to copy large files resulted in corrupt copies
> > up until 2015.
> > 
> > Basically, sendfile is a legacy interface that has spend a very
> > large amount of it's time broken, full of deadlocks (i.e. unusable)
> > and not used by anyone. It's not something we really want to enable
> > in xfstests because it will cause all sorts of failures on older
> > distros...
> 
> Sorry I didn't learn about that. I just checked "man 2 splice", it said:
> "The splice() system call first appeared in Linux 2.6.17; library support was
> added to glibc in version 2.5."

splice() != sendfile().

sendfile has been around since the 2.2 days, originally implemented
to allow web servers to do zero-copy of file data to the network.
The ability to do file-to-file copies was in the original 2.2/2.4
implementation, but it was removed in the 2.5 series.  Back around
2.6.32 it got converted to use the splice(2) kernel infrastructure
and started supporting files as the destination again, and that's
where it all went off the rails....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
