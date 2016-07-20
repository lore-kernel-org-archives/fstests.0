Received: from mx2.suse.de ([195.135.220.15]:58654 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbcGTIb5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jul 2016 04:31:57 -0400
Date: Wed, 20 Jul 2016 07:13:24 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] generic/235: Use CSV format for repquota output
Message-ID: <20160720051324.GB3918@quack2.suse.cz>
References: <1468843224-8940-1-git-send-email-jack@suse.cz>
 <20160719040738.GK27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160719040738.GK27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org, dchinner@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue 19-07-16 12:07:38, Eryu Guan wrote:
> On Mon, Jul 18, 2016 at 02:00:24PM +0200, Jan Kara wrote:
> > Different quota format may print additional information in repquota(8)
> > output after standard quota information is printed and this information
> > is separated by two empty lines. For quota formats that don't support
> > printing any additional information these lines are not present in the
> > output which causes false failures of the test. Switch the test to use
> > repquota(8) CSV output format which does not have these formatting
> > issues and in general should be more stable.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> This breaks tests on distributions with older version of repquota (e.g.
> RHEL6 and RHEL7) where there's no "-O" support, and test failed because
> of "invalid option -- 'O'".

Hum, support for -O option is in repquota for three years. That isn't much
for enterprise distros, I agree. I can fix the problem with output
filtering. That will be less future-proof but it will work for old
repquota. I'm not sure what's more desirable. Dave?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
