Received: from mx2.suse.de ([195.135.220.15]:40892 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbcGUHfN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 03:35:13 -0400
Date: Thu, 21 Jul 2016 09:35:07 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] generic/130: Improve xfs_io filter
Message-ID: <20160721073507.GB7220@quack2.suse.cz>
References: <1469081856-6424-1-git-send-email-jack@suse.cz>
 <1469081856-6424-2-git-send-email-jack@suse.cz>
 <20160721065526.GB27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160721065526.GB27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu 21-07-16 14:55:26, Eryu Guan wrote:
> On Thu, Jul 21, 2016 at 08:17:36AM +0200, Jan Kara wrote:
> > On my test setup xfs_io reports 'nan' in bytes/s and ops/s fields when
> > the operation takes zero time. Account for that in _filter_xfs_io.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  common/filter | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/filter b/common/filter
> > index b229a97dfa0e..37f07c8ca1ac 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -221,7 +221,7 @@ common_line_filter()
> >  
> >  _filter_xfs_io()
> >  {
> > -    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([inf0-9/.]* [EPGMKiBbytes]*\/sec and [inf0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
> > +    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infnan0-9/.]* [EPGMKiBbytes]*\/sec and [infnan0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
> 
> Seems adding only 'a' to the char set is sufficient, 'n' is already in
> the set, i.e.
> 
> - ...([inf0-9/.]* ...
> + ...([infa0-9/.]* ...

Yeah. I've added 'nan' to document what the letters are there for. But
probably I should have added just 'a' and added a comment. I'll respin the
patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
