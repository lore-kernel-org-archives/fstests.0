Received: from mx1.redhat.com ([209.132.183.28]:53994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbdBVGxt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Feb 2017 01:53:49 -0500
Date: Wed, 22 Feb 2017 14:53:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] shared/005,7: fix making sure debugfs sets negative
 i_size && add strict check for dd
Message-ID: <20170222065347.GW24562@eguan.usersys.redhat.com>
References: <20170220023646.GG24562@eguan.usersys.redhat.com>
 <1487566979-6147-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170222042041.GT24562@eguan.usersys.redhat.com>
 <58AD1A16.10109@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58AD1A16.10109@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 22, 2017 at 12:56:54PM +0800, Xiao Yang wrote:
> On 2017/02/22 12:20, Eryu Guan wrote:
> > On Mon, Feb 20, 2017 at 01:02:59PM +0800, Xiao Yang wrote:
> > > 1) If the kernel bug has been fixed, stat command fails to get i_size
> > >     and reports "Structure needs cleaning".  So we use debugfs -R "stat"
> > >     instead of stat command to make sure debugfs sets negative i_size.
> > >     These cases have been broken by commit 0e13e40b247a1 ("shared/005,7:
> > >     make sure debugfs sets negative i_size").
> > > 
> > > 2) shared/007 passes unexpectedly on RHEL6.8GA and RHEL6.9Beta
> > >     because of invalid argument. When debugfs fails to set i_size
> > >     to -512, dd with direct flag fails and reports "invalid argument".
> > >     So we can add strict check.
> > But you've already added the check for i_size and _notrun if debugfs
> > failed to set i_size to -512, there's no chance for dd to hit EINVAL.
> > And I think any error dd is hitting is acceptable, as long as test runs
> > (which means i_size was set to -1/-512 successfully). So I don't think
> > we need the check on dd's output. Did I miss anything?
> Hi Eryu
> 
> Thanks for your comments.
> 
> xfs/134 passed unexpectedly on RHEL7.3GA because dd hits ENOSPC.  So I think

Hmm, xfs/134 hits ENOSPC even on 4.9 kernel (where xfs/133 triggers
kernel BUG_ON), so I think the buffer I/O tests are targeded regression
tests and the dio tests are nice-to-have tests.

> all of these cases should fail instead of pass when hitting  unexpected
> error.
> Do you think whether we only check on dd's output of xfs/133,4 or remove
> all? :-)

IMO, what we're going to test is to make sure kernel doesn't hang or
crash when dealing with negative i_size, any error is acceptable as long
as kernel could detect this corruption without crashing or hanging.

Thanks,
Eryu
