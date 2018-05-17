Received: from mx2.suse.de ([195.135.220.15]:42406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeEQJSi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 17 May 2018 05:18:38 -0400
Date: Thu, 17 May 2018 11:18:36 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/3] generic/382: Fix test when report uses /etc/passwd
Message-ID: <20180517091836.ep4pydgqpg6cihgy@quack2.suse.cz>
References: <20180514170351.13737-1-jack@suse.cz>
 <20180514170351.13737-3-jack@suse.cz>
 <20180517024250.GD29080@desktop.hz.ali.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517024250.GD29080@desktop.hz.ali.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu 17-05-18 10:42:50, Eryu Guan wrote:
> On Mon, May 14, 2018 at 07:03:50PM +0200, Jan Kara wrote:
> > On older kernels xfs_quota uses /etc/passwd to report quota entries. In
> > such case all-zero lines disturb its output and the test fails. Fix the
> > problem by ignoring all-zero lines in quota report.
> 
> I notice that generic/381 does quota report in a similar way as in
> generic/382, is 381 affected by the same problem? If only generic/382 is
> affected, we could move the filter from common/filter to the test
> itself.

Yes, that test is affected as well. I just didn't notice because on my
system I don't have user 123456-fsgqa (SLE/openSUSE don't allow you to
create user with such name and I didn't bother to force-create it by
manually editting passwd). I'll send a patch to update that test to use the
filter as well if you're otherwise fine with this approach.

> BTW, I'm curious what kernel behaves in this way, what distribution are
> you using that reproduces this failure? I want to try it myself too.

I was doing regression testing for SLE12 SP3 kernel which is 4.4 based
after backporting some fixes. Generally any kernel prior commit 926132c025
"quota: add new quotactl Q_GETNEXTQUOTA" which landed in v4.6 will have
this issue.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
