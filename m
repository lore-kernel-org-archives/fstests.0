Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42918 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044AbaJPKiI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 16 Oct 2014 06:38:08 -0400
Date: Thu, 16 Oct 2014 12:38:06 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] xfs/195: Use XFSDUMP_PROG instead of xfsdump directly
Message-ID: <20141016103806.GB6085@quack.suse.cz>
References: <1412177239-27241-1-git-send-email-jack@suse.cz>
 <20141014115808.GF17506@dastard>
 <20141014121204.GG17506@dastard>
 <20141014121527.GH17506@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141014121527.GH17506@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue 14-10-14 23:15:27, Dave Chinner wrote:
> On Tue, Oct 14, 2014 at 11:12:04PM +1100, Dave Chinner wrote:
> > On Tue, Oct 14, 2014 at 10:58:08PM +1100, Dave Chinner wrote:
> > > On Wed, Oct 01, 2014 at 05:27:18PM +0200, Jan Kara wrote:
> > > > Use appropriate environment variable (XFSDUMP_PROG) instead of hardcoding
> > > > 'xfsdump' name. This also makes the test fail graciously when xfsdump
> > > > isn't installed.
> > > > 
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  tests/xfs/195 |    3 ++-
> > > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/tests/xfs/195 b/tests/xfs/195
> > > > index c7bc7b8..b86aedb 100755
> > > > --- a/tests/xfs/195
> > > > +++ b/tests/xfs/195
> > > > @@ -48,7 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > > >  #
> > > >  _do_dump()
> > > >  {
> > > > -	xfsdump -l 0 -s d -F  \
> > > > +	$XFSDUMP_PROG -l 0 -s d -F  \
> > > >  		-L prova -M prova \
> > > >  		-f $TEST_DIR/dumpfile -e -v excluded_files=debug $TEST_DIR \
> > > >  		| grep "ino $inum" \
> > > > @@ -58,6 +58,7 @@ _do_dump()
> > > >  # get standard environment, filters and checks
> > > >  . ./common/rc
> > > >  . ./common/filter
> > > > +. ./common/dump
> > > 
> > > This causes the test to fail, because _do_dump() is defined in
> > > common/dump as well. I'll fix the conflict...
> > 
> > Actually, this has problems with duplicate _cleanup functions too,
> > so It' would just be better to check for xfsdump being defined
> > directly rather than including common/dump....
> 
> I've dropped this for now. Can you rework it, Jan? Maybe best to use
> _require_command or something like that as common/dump implies
> certain specific usage patterns and functions are used, which this
> test doesn't follow...
  OK, I'll try to fix it differently. I just wonder why things work for me
here...
								Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
