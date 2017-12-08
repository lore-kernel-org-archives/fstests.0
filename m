Received: from zeniv.linux.org.uk ([195.92.253.2]:40204 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbdLHANJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Dec 2017 19:13:09 -0500
Date: Fri, 8 Dec 2017 00:13:02 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: False lockdep completion splats with loop device
Message-ID: <20171208001302.GK21978@ZenIV.linux.org.uk>
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
 <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org>
 <20171205210956.GZ5858@dastard>
 <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com>
 <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <20171207235922.GJ5858@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207235922.GJ5858@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Byungchul Park <byungchul.park@lge.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 08, 2017 at 10:59:22AM +1100, Dave Chinner wrote:

> > 3. if multi nested looped fs is important (not really) then loop/nbd will
> >     need to know if its file is on a looped fs and propagate nesting level
> >     to ext4
> 
> This functionality is definitely used and needs to be supported by
> the annotations.

FWIW, in addition to loop, there's md.  So should loop need to know if its
backing file lives on a filesystem that does, for example, have an extrnal
journal sitting on RAID1 with one of the components hosted in a file on
some other fs, brought into the array via another loop device?

Oh, and to make life even more fun, backing file can be flipped under
configured /dev/loop.  IOW, those nesting depths are not static at all.
