Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:34914 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932073AbaJNMP3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 14 Oct 2014 08:15:29 -0400
Date: Tue, 14 Oct 2014 23:15:27 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/195: Use XFSDUMP_PROG instead of xfsdump directly
Message-ID: <20141014121527.GH17506@dastard>
References: <1412177239-27241-1-git-send-email-jack@suse.cz>
 <20141014115808.GF17506@dastard>
 <20141014121204.GG17506@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141014121204.GG17506@dastard>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 14, 2014 at 11:12:04PM +1100, Dave Chinner wrote:
> On Tue, Oct 14, 2014 at 10:58:08PM +1100, Dave Chinner wrote:
> > On Wed, Oct 01, 2014 at 05:27:18PM +0200, Jan Kara wrote:
> > > Use appropriate environment variable (XFSDUMP_PROG) instead of hardcoding
> > > 'xfsdump' name. This also makes the test fail graciously when xfsdump
> > > isn't installed.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  tests/xfs/195 |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/tests/xfs/195 b/tests/xfs/195
> > > index c7bc7b8..b86aedb 100755
> > > --- a/tests/xfs/195
> > > +++ b/tests/xfs/195
> > > @@ -48,7 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  #
> > >  _do_dump()
> > >  {
> > > -	xfsdump -l 0 -s d -F  \
> > > +	$XFSDUMP_PROG -l 0 -s d -F  \
> > >  		-L prova -M prova \
> > >  		-f $TEST_DIR/dumpfile -e -v excluded_files=debug $TEST_DIR \
> > >  		| grep "ino $inum" \
> > > @@ -58,6 +58,7 @@ _do_dump()
> > >  # get standard environment, filters and checks
> > >  . ./common/rc
> > >  . ./common/filter
> > > +. ./common/dump
> > 
> > This causes the test to fail, because _do_dump() is defined in
> > common/dump as well. I'll fix the conflict...
> 
> Actually, this has problems with duplicate _cleanup functions too,
> so It' would just be better to check for xfsdump being defined
> directly rather than including common/dump....

I've dropped this for now. Can you rework it, Jan? Maybe best to use
_require_command or something like that as common/dump implies
certain specific usage patterns and functions are used, which this
test doesn't follow...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
