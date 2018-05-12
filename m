Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750879AbeELNS1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 12 May 2018 09:18:27 -0400
Date: Sat, 12 May 2018 21:18:24 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] xfs: test inode allocation state missmatch corruption
Message-ID: <20180512131824.GH1963@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180511161127.15158-1-zlang@redhat.com>
 <20180511233239.GZ23861@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511233239.GZ23861@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, May 12, 2018 at 09:32:39AM +1000, Dave Chinner wrote:
> On Sat, May 12, 2018 at 12:11:27AM +0800, Zorro Lang wrote:
> > There's a situation where the directory structure and the inobt
> > thinks the inode is free, but the inode on disk thinks it is still
> > in use. XFS should detect it and prevent the kernel from oopsing
> > on lookup.
> 
> Isn't this testing the same thing that I recently posted "xfs: test
> inobt/on disk free state mismatches" for?

Hmm... I think so.

This case is written to test your patch:
https://marc.info/?l=linux-xfs&m=152161877728015&w=2

Sorry I sent this case about 2 month ago, but I just got free time
to send V2 patch yesterday :P

As you're the original author of that bug fix, I think your case
will be better than mine. Please keep your case reviewing, ignore
this one.

Thanks,
Zorro

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
