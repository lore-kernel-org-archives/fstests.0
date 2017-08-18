Received: from mail-wr0-f170.google.com ([209.85.128.170]:38607 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdHRIKs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Aug 2017 04:10:48 -0400
Received: by mail-wr0-f170.google.com with SMTP id 5so39614253wrz.5
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2017 01:10:47 -0700 (PDT)
Date: Fri, 18 Aug 2017 10:10:44 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH V2] xfs: Test infinite loop while searching for a free
 inode slot
Message-ID: <20170818081044.5xedrmk6ucbzwc4e@hades.localdomain>
References: <20170817133943.10774-1-cmaiolino@redhat.com>
 <20170818054830.GW14807@eguan.usersys.redhat.com>
 <20170818073525.vegynnjxn4j2l63t@hades.localdomain>
 <20170818075510.GX14807@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818075510.GX14807@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi!

> 
> > 
> > Although, I'm not sure if you notice, but even you hit this assert, you will
> > not be able to unmount the filesystem.
> > 
> > I'm not sure now if simply disable this test on XFS_DEBUG is the best approach,
> > hitting the bug in XFS_DEBUG is less catastrophic because it will not lockup,
> > but will make the FS unmountable.
> 
> It crashed my host immediately, because I have
> /proc/sys/kernel/panic_on_oops set to 1.
> 
> Anyway, an unmountable fs is as bad as a crash, they all prevent
> subsequent tests from running. The underlying bug is fixed, we expect
> test to pass, not crash the host or block further testings.
> 

Do you have any suggestion about it? The test will purposely corrupt the FS,
which will certainly trigger this assert (it's a NO-OP without XFS_DEBUG btw),
I've already added it to dangerous group though.
> > 
> > I'd simply disable it in XFS_DEBUG, once the bug is exactly the same as with non
> > debug code, but with a different behavior. Not sure though if there are people
> > running xfstests exclusively on XFS_DEBUG.
> 
> I believe running xfstests with XFS_DEBUG is pretty common.
> 

The assert is triggered even before the fixed code can catch the corruption, so,
I think if you are not comfortable with it crashing the system, unless we remove
the assert from the code (which I believe might be done once the fix is merged),
I'de suggest not running this test with XFS_DEBUG.

cheers.

> Thanks,
> Eryu

-- 
Carlos
