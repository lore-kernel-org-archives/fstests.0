Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:51403 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987AbaLOWJK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 17:09:10 -0500
Date: Tue, 16 Dec 2014 09:07:04 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/038: require fallocate support and test for trim
 support
Message-ID: <20141215220704.GA2152@dastard>
References: <alpine.LNX.2.00.1412152322070.21847@reiser4.gekom>
 <20141215204914.GS24183@dastard>
 <20141215214510.GL17575@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215214510.GL17575@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dushan Tcholich <dusanc@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 15, 2014 at 04:45:10PM -0500, Theodore Ts'o wrote:
> On Tue, Dec 16, 2014 at 07:49:15AM +1100, Dave Chinner wrote:
> > On Mon, Dec 15, 2014 at 11:26:35PM +0100, Dushan Tcholich wrote:
> > > Add tests for allocate support and test if TRIM really works on tested 
> > > partition.
> > > 
> > > Signed-off-by: Dushan Tcholich <dusanc@gmail.com>
> > > 
> > > --- xfstests.orig/tests/generic/038	2014-12-14 15:18:00.000000000 +0100
> > > +++ xfstests/tests/generic/038	2014-12-15 23:21:11.000000000 +0100
> > > @@ -70,6 +70,10 @@
> > >  _supported_os Linux
> > >  _require_scratch
> > >  _require_fstrim
> > > +_require_xfs_io_command "falloc"
> > > +_require_xfs_io_command "truncate"
> > 
> > No need to test for the truncate command as it's supported in all
> > versions of xfs_io people use. falloc, OTOH, isn't supported on oler
> > distros that people still need to run QA on, and hence that check is
> > required....
> 
> I've also been using '_require_xfs_io_command "falloc"' to test
> whether the file system supports fallocate(2).  So for example, in the
> patch that I sent out today, I'm checking not just whether xfs_io
> supports "falloc", but whether the file system under test (at least
> with a specific configuration, such as ext4 in ext3 compatibility
> mode) supports fallocate(2).  Do you consider that a valid thing to
> do?

Yes, that's it's intent. From the 2009 patch that introduced
checks for fallocate support:

+# check that xfs_io, glibc, kernel, and filesystem all (!) support
+# fallocate
+#
+_require_xfs_io_falloc()

i.e. the one function checks the entire stack for fallocate support.
That's not going to change.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
