Received: from mx2.suse.de ([195.135.220.15]:41322 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbcGUMVb (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 08:21:31 -0400
Date: Thu, 21 Jul 2016 14:21:28 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] generic/235: Fix false failures for some quota formats
Message-ID: <20160721122128.GC7901@quack2.suse.cz>
References: <1469091306-8559-1-git-send-email-jack@suse.cz>
 <20160721104513.GE27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160721104513.GE27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu 21-07-16 18:45:13, Eryu Guan wrote:
> On Thu, Jul 21, 2016 at 10:55:06AM +0200, Jan Kara wrote:
> > Different quota format may print additional information in repquota(8)
> > output after standard quota information is printed. If format does
> > support this additional printouts, repquota(8) will separate possible
> > output by two empty lines even if format handler doesn't actually
> > printout anything (which is currently always the case for queries test
> > generic/235 does). If format doesn't support additional printouts, these
> > two empty lines are not present in the output. This inconsistency causes
> > false failures for some quota formats.
> > 
> > Fix the problem by filtering out empty lines out of repquota(8) output.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  tests/generic/235     | 9 +++++++--
> >  tests/generic/235.out | 8 --------
> >  2 files changed, 7 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tests/generic/235 b/tests/generic/235
> > index 59456b67c092..d42054efee91 100755
> > --- a/tests/generic/235
> > +++ b/tests/generic/235
> > @@ -46,6 +46,11 @@ _require_scratch
> >  _require_quota
> >  _require_user
> >  
> > +_repquota()
> > +{
> > +	repquota -u -g $SCRATCH_MNT  | grep -v -E '^root|^$' | _filter_scratch
> > +}
> 
> Usually we name local functions without the leading "_", which is for
> common helpers from common/rc etc. Do you mind if I rename it to
> "do_repquota"?

I don't mind so go ahead.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
