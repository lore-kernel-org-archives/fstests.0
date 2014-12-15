Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:57718 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbaLOVpM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 16:45:12 -0500
Date: Mon, 15 Dec 2014 16:45:10 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] generic/038: require fallocate support and test for trim
 support
Message-ID: <20141215214510.GL17575@thunk.org>
References: <alpine.LNX.2.00.1412152322070.21847@reiser4.gekom>
 <20141215204914.GS24183@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215204914.GS24183@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Dushan Tcholich <dusanc@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 16, 2014 at 07:49:15AM +1100, Dave Chinner wrote:
> On Mon, Dec 15, 2014 at 11:26:35PM +0100, Dushan Tcholich wrote:
> > Add tests for allocate support and test if TRIM really works on tested 
> > partition.
> > 
> > Signed-off-by: Dushan Tcholich <dusanc@gmail.com>
> > 
> > --- xfstests.orig/tests/generic/038	2014-12-14 15:18:00.000000000 +0100
> > +++ xfstests/tests/generic/038	2014-12-15 23:21:11.000000000 +0100
> > @@ -70,6 +70,10 @@
> >  _supported_os Linux
> >  _require_scratch
> >  _require_fstrim
> > +_require_xfs_io_command "falloc"
> > +_require_xfs_io_command "truncate"
> 
> No need to test for the truncate command as it's supported in all
> versions of xfs_io people use. falloc, OTOH, isn't supported on oler
> distros that people still need to run QA on, and hence that check is
> required....

I've also been using '_require_xfs_io_command "falloc"' to test
whether the file system supports fallocate(2).  So for example, in the
patch that I sent out today, I'm checking not just whether xfs_io
supports "falloc", but whether the file system under test (at least
with a specific configuration, such as ext4 in ext3 compatibility
mode) supports fallocate(2).  Do you consider that a valid thing to
do?

I could propose creating a separate _require_fallocate macro, but it
would basically be doing the equivalent thing to
_require_xfs_io_command "falloc", and in the tests that I was looking
at, we were using xfs_io and falloc anyway.  So the point is somewhat
moot, but if and when we stop suppotring RHEL 3, or whatever
enterprise distro was driving this check, it would be nice if we could
keep those checks around.

       	  	   	      	    	 - Ted
