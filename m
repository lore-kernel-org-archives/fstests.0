Received: from mail-wr0-f169.google.com ([209.85.128.169]:34262 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdHRIfL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Aug 2017 04:35:11 -0400
Received: by mail-wr0-f169.google.com with SMTP id y96so61370243wrc.1
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2017 01:35:10 -0700 (PDT)
Date: Fri, 18 Aug 2017 10:35:07 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH V2] xfs: Test infinite loop while searching for a free
 inode slot
Message-ID: <20170818083507.5eypbon5kra7util@hades.localdomain>
References: <20170817133943.10774-1-cmaiolino@redhat.com>
 <20170818054830.GW14807@eguan.usersys.redhat.com>
 <20170818073525.vegynnjxn4j2l63t@hades.localdomain>
 <20170818075510.GX14807@eguan.usersys.redhat.com>
 <20170818081044.5xedrmk6ucbzwc4e@hades.localdomain>
 <20170818082600.GY14807@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818082600.GY14807@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

> 
> I think adding a _require_no_xfs_debug helper in common/xfs and calling
> it in the new test should work (please rename if you have a better
> name), e.g.
> 
> _require_no_xfs_debug()
> {
> 	if grep -q "debug 1" /proc/fs/xfs/stat; then
> 		_notrun "Require XFS built without CONFIG_XFS_DEBUG"
> 	fi
> }
> 

sounds a pretty decent name for me.
> > > > 
> > > > I'd simply disable it in XFS_DEBUG, once the bug is exactly the same as with non
> > > > debug code, but with a different behavior. Not sure though if there are people
> > > > running xfstests exclusively on XFS_DEBUG.
> > > 
> > > I believe running xfstests with XFS_DEBUG is pretty common.
> > > 
> > 
> > The assert is triggered even before the fixed code can catch the corruption, so,
> > I think if you are not comfortable with it crashing the system, unless we remove
> > the assert from the code (which I believe might be done once the fix is merged),
> > I'de suggest not running this test with XFS_DEBUG.
> 
> Yeah, _notrun if XFS_DEBUG is on :)

Sure, I'll add the above helper as a patch before my test, thanks
> 
> Thanks,
> Eryu

-- 
Carlos
