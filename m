Received: from mx1.redhat.com ([209.132.183.28]:45358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbdHRI0E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Aug 2017 04:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C6CD5D687
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2017 08:26:04 +0000 (UTC)
Date: Fri, 18 Aug 2017 16:26:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH V2] xfs: Test infinite loop while searching for a free
 inode slot
Message-ID: <20170818082600.GY14807@eguan.usersys.redhat.com>
References: <20170817133943.10774-1-cmaiolino@redhat.com>
 <20170818054830.GW14807@eguan.usersys.redhat.com>
 <20170818073525.vegynnjxn4j2l63t@hades.localdomain>
 <20170818075510.GX14807@eguan.usersys.redhat.com>
 <20170818081044.5xedrmk6ucbzwc4e@hades.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818081044.5xedrmk6ucbzwc4e@hades.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Carlos Maiolino <cmaiolino@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 18, 2017 at 10:10:44AM +0200, Carlos Maiolino wrote:
> Hi!
> 
> > 
> > > 
> > > Although, I'm not sure if you notice, but even you hit this assert, you will
> > > not be able to unmount the filesystem.
> > > 
> > > I'm not sure now if simply disable this test on XFS_DEBUG is the best approach,
> > > hitting the bug in XFS_DEBUG is less catastrophic because it will not lockup,
> > > but will make the FS unmountable.
> > 
> > It crashed my host immediately, because I have
> > /proc/sys/kernel/panic_on_oops set to 1.
> > 
> > Anyway, an unmountable fs is as bad as a crash, they all prevent
> > subsequent tests from running. The underlying bug is fixed, we expect
> > test to pass, not crash the host or block further testings.
> > 
> 
> Do you have any suggestion about it? The test will purposely corrupt the FS,
> which will certainly trigger this assert (it's a NO-OP without XFS_DEBUG btw),
> I've already added it to dangerous group though.

I think adding a _require_no_xfs_debug helper in common/xfs and calling
it in the new test should work (please rename if you have a better
name), e.g.

_require_no_xfs_debug()
{
	if grep -q "debug 1" /proc/fs/xfs/stat; then
		_notrun "Require XFS built without CONFIG_XFS_DEBUG"
	fi
}

> > > 
> > > I'd simply disable it in XFS_DEBUG, once the bug is exactly the same as with non
> > > debug code, but with a different behavior. Not sure though if there are people
> > > running xfstests exclusively on XFS_DEBUG.
> > 
> > I believe running xfstests with XFS_DEBUG is pretty common.
> > 
> 
> The assert is triggered even before the fixed code can catch the corruption, so,
> I think if you are not comfortable with it crashing the system, unless we remove
> the assert from the code (which I believe might be done once the fix is merged),
> I'de suggest not running this test with XFS_DEBUG.

Yeah, _notrun if XFS_DEBUG is on :)

Thanks,
Eryu
