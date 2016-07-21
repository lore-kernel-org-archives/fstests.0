Received: from mx2.suse.de ([195.135.220.15]:44200 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbcGUIOZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 04:14:25 -0400
Date: Thu, 21 Jul 2016 10:14:22 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] generic/130: Improve xfs_io filter
Message-ID: <20160721081422.GA7901@quack2.suse.cz>
References: <1469081856-6424-1-git-send-email-jack@suse.cz>
 <1469081856-6424-2-git-send-email-jack@suse.cz>
 <20160721065526.GB27776@eguan.usersys.redhat.com>
 <20160721073507.GB7220@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20160721073507.GB7220@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 21-07-16 09:35:07, Jan Kara wrote:
> On Thu 21-07-16 14:55:26, Eryu Guan wrote:
> > On Thu, Jul 21, 2016 at 08:17:36AM +0200, Jan Kara wrote:
> > > On my test setup xfs_io reports 'nan' in bytes/s and ops/s fields when
> > > the operation takes zero time. Account for that in _filter_xfs_io.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  common/filter | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/common/filter b/common/filter
> > > index b229a97dfa0e..37f07c8ca1ac 100644
> > > --- a/common/filter
> > > +++ b/common/filter
> > > @@ -221,7 +221,7 @@ common_line_filter()
> > >  
> > >  _filter_xfs_io()
> > >  {
> > > -    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([inf0-9/.]* [EPGMKiBbytes]*\/sec and [inf0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
> > > +    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infnan0-9/.]* [EPGMKiBbytes]*\/sec and [infnan0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
> > 
> > Seems adding only 'a' to the char set is sufficient, 'n' is already in
> > the set, i.e.
> > 
> > - ...([inf0-9/.]* ...
> > + ...([infa0-9/.]* ...
> 
> Yeah. I've added 'nan' to document what the letters are there for. But
> probably I should have added just 'a' and added a comment. I'll respin the
> patch.

Attached is a revised patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-generic-130-Improve-xfs_io-filter.patch"

>From 8d86c6fe36040e21db3475292a2dd05a280f158f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 21 Jul 2016 08:15:19 +0200
Subject: [PATCH] generic/130: Improve xfs_io filter

On my test setup xfs_io reports 'nan' in bytes/s and ops/s fields when
the operation takes zero time. Account for that in _filter_xfs_io.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/filter | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index b229a97dfa0e..f80cd562af71 100644
--- a/common/filter
+++ b/common/filter
@@ -221,7 +221,9 @@ common_line_filter()
 
 _filter_xfs_io()
 {
-    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([inf0-9/.]* [EPGMKiBbytes]*\/sec and [inf0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
+    # Apart from standard numeric values, we also filter out 'inf' and 'nan'
+    # which can result from division in some cases
+    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.]* [EPGMKiBbytes]*\/sec and [infa0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
 }
 
 _filter_xfs_io_unique()
-- 
2.6.6


--LZvS9be/3tNcYl/X--
