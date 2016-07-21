Received: from mx2.suse.de ([195.135.220.15]:40463 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbcGUH1Q (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 03:27:16 -0400
Date: Thu, 21 Jul 2016 09:27:10 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] generic/235: Use CSV format for repquota output
Message-ID: <20160721072710.GA7220@quack2.suse.cz>
References: <1468843224-8940-1-git-send-email-jack@suse.cz>
 <20160719040738.GK27776@eguan.usersys.redhat.com>
 <20160720051324.GB3918@quack2.suse.cz>
 <20160720230230.GW12670@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160720230230.GW12670@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, dchinner@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu 21-07-16 09:02:31, Dave Chinner wrote:
> On Wed, Jul 20, 2016 at 07:13:24AM +0200, Jan Kara wrote:
> > On Tue 19-07-16 12:07:38, Eryu Guan wrote:
> > > On Mon, Jul 18, 2016 at 02:00:24PM +0200, Jan Kara wrote:
> > > > Different quota format may print additional information in repquota(8)
> > > > output after standard quota information is printed and this information
> > > > is separated by two empty lines. For quota formats that don't support
> > > > printing any additional information these lines are not present in the
> > > > output which causes false failures of the test. Switch the test to use
> > > > repquota(8) CSV output format which does not have these formatting
> > > > issues and in general should be more stable.
> > > > 
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > 
> > > This breaks tests on distributions with older version of repquota (e.g.
> > > RHEL6 and RHEL7) where there's no "-O" support, and test failed because
> > > of "invalid option -- 'O'".
> > 
> > Hum, support for -O option is in repquota for three years. That isn't much
> > for enterprise distros, I agree. I can fix the problem with output
> > filtering. That will be less future-proof but it will work for old
> > repquota. I'm not sure what's more desirable. Dave?
> 
> What are the extra lines? Why can't an output filter be added to
> strip the extra lines if they are emitted?

Those extra lines can be stripped. If that's preferable I'll send a patch
doing that. I just thought using CSV output format of repquota may be less
prone to formatting changes in the future.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
