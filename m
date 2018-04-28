Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeD1WrF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 28 Apr 2018 18:47:05 -0400
Message-ID: <43ef94e9a53422797638438102ac7bac4ea20831.camel@kernel.org>
Subject: Re: [PATCH][RESEND] generic/441: whitelist gfs2 for full test
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 28 Apr 2018 18:47:02 -0400
In-Reply-To: <20180428033254.GS11384@desktop>
References: <20180427163327.20442-1-jlayton@kernel.org>
         <20180428033254.GS11384@desktop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, 2018-04-28 at 11:32 +0800, Eryu Guan wrote:
> Hi Jeff,
> 
> On Fri, Apr 27, 2018 at 12:33:27PM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > gfs2 passes the full-scale generic/441 test with the patch that
> > converts it to use errseq_t reporting for fsync.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> 
> Sorry for letting you resend the same patch again and again, but I
> didn't get any feedback on my previous replies to the patch.
> 
> Please see
> https://patchwork.kernel.org/patch/9868465/
> https://patchwork.kernel.org/patch/9952475/
> 
> > ---
> >  tests/generic/441 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/441 b/tests/generic/441
> > index 5fbfececadc0..be903fbf94f8 100755
> > --- a/tests/generic/441
> > +++ b/tests/generic/441
> > @@ -58,7 +58,7 @@ case $FSTYP in
> >  	btrfs)
> >  		_notrun "btrfs has a specialized test for this"
> >  		;;
> > -	ext3|ext4|xfs)
> > +	ext3|ext4|gfs2|xfs)
> >  		# Do the more thorough test if we have a logdev
> >  		_has_logdev && sflag=''
> 
> So my concern remains, _scratch_mkfs doesn't create gfs2 with external
> log device even if we set SCRATCH_LOGDEV and USE_EXTERNAL=yes, i.e.
> _has_logdev returns true. So with this modification, gfs2 still runs
> with internal log (and test still *fails* with v4.16 kernel, I hit the
> same failure as in the second link above).
> 
> If running gfs2 test with internal log is expected, I think we can run
> the test in full-scale mode unconditionally for gfs2, as suggested in
> above two replies. i.e. something like
> 
> 	ext3|ext4|xfs)
> 		# Do the more thorough test if we have a logdev
> 		_has_logdev && sflag=''
> 		;;
> 	gfs2)
> 		# <comments here>
> 		sflag=''
> 		;;
> 	*)
> 		;;
> 
> If gfs2 really requires external log to run in full-scale test, I think
> we should also add external log device support to _scratch_mkfs().
> 
> Any comments?

My apologies. I somehow missed your earlier replies and I think I made
a mistake in testing gfs2 that resulted in the error not occurring when
it normally would.

Please just disregard this patch. Sorry for the noise.

-- 
Jeff Layton <jlayton@kernel.org>
