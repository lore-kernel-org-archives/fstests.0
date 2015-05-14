Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:50888 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932671AbbENKan (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 May 2015 06:30:43 -0400
Date: Thu, 14 May 2015 20:30:28 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/326: Test the permission to set file times
Message-ID: <20150514103028.GR15721@dastard>
References: <20150512234005.GC4316@dastard>
 <1431475654-23274-1-git-send-email-andreas.gruenbacher@gmail.com>
 <20150514031952.GP15721@dastard>
 <CAHpGcMKfobLMLXDzX2qQhpqvGotbwHh-n3o9+NeVEtwahUMXdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMKfobLMLXDzX2qQhpqvGotbwHh-n3o9+NeVEtwahUMXdQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

On Thu, May 14, 2015 at 09:56:50AM +0200, Andreas Grünbacher wrote:
> 2015-05-14 5:19 GMT+02:00 Dave Chinner <david@fromorbit.com>:
> > Fails on XFS.
> >
> > /me looks at fs_perms and shudders at all the system() calls.
> >
> > Looks like there is no testx.file created first.
> 
> Hmm, that file was lying around from a previous run here.
> Leaky tests are fun.
> 
> > should this actually be doing "rm -f"?
> 
> That's better, indeed.

Except it still doesn't work:

generic/087 1s ... - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_v4/generic/087.out.bad)
    --- tests/generic/087.out   2015-05-14 20:25:13.000000000 +1000
    +++ /home/dave/src/xfstests-dev/results//xfs_v4/generic/087.out.bad 2015-05-14 20:28:13.000000000 +1000
    @@ -1,7 +1,13 @@
     QA output created by 087
    +rm: cannot remove 'test.file': Permission denied
     t a 600 file owned by (99/99) as user/group(99/99)  PASS
    +rm: cannot remove 'test.file': Permission denied
     T a 600 file owned by (99/99) as user/group(99/99)  PASS
    +rm: cannot remove 'test.file': Permission denied
     t a 600 file owned by (99/99) as user/group(100/99)  PASS
.....

So there's something else that needs to be done here to allow the
test file to be removed....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
