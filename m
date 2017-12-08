Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:42783 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753773AbdLHW6u (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Dec 2017 17:58:50 -0500
Date: Sat, 9 Dec 2017 09:57:57 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: False lockdep completion splats with loop device
Message-ID: <20171208225757.GP4094@dastard>
References: <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org>
 <20171205210956.GZ5858@dastard>
 <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com>
 <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <20171207235922.GJ5858@dastard>
 <20171208001302.GK21978@ZenIV.linux.org.uk>
 <CAOQ4uxj=amYQBnOrcYTLCs4_8gN_+ZkiRu8u45tOEd+v9mHvtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj=amYQBnOrcYTLCs4_8gN_+ZkiRu8u45tOEd+v9mHvtw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Byungchul Park <byungchul.park@lge.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 08, 2017 at 10:15:07AM +0200, Amir Goldstein wrote:
> On Fri, Dec 8, 2017 at 2:13 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Fri, Dec 08, 2017 at 10:59:22AM +1100, Dave Chinner wrote:
> >
> >> > 3. if multi nested looped fs is important (not really) then loop/nbd will
> >> >     need to know if its file is on a looped fs and propagate nesting level
> >> >     to ext4
> >>
> >> This functionality is definitely used and needs to be supported by
> >> the annotations.
> >
> > FWIW, in addition to loop, there's md.
> 
> Do you mean md can sit on a file directly without loop/nbd?
> I am referring to loop/nbd, because those are the only ones I know
> of that can be used to nest (non stackable) fs over fs.

The problem is one of stacked completions, not loop/nbd devices. The
loop and nbd devices are just the simplest way to stack completions.
MD can sit on MD and other devices in complex stacks, so if there's
completion in MD, we have the same completion layering problem.

i.e. this is *not specifically a filesystem problem*. This is a
completion stacking problem, and lots of different layers in the
storage stack use completions and can be layered in arbitrary
orders. MD and DM are jsut two more virtual block devices that can
stack in random orders.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
