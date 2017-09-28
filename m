Received: from mx1.redhat.com ([209.132.183.28]:34388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752993AbdI1M2f (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Sep 2017 08:28:35 -0400
Date: Thu, 28 Sep 2017 20:28:32 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v6 2/4] gitignore: sort src/ binaries name
Message-ID: <20170928122832.yowvdelvhihn67xg@XZHOUW.usersys.redhat.com>
References: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
 <1506584500-867-1-git-send-email-xzhou@redhat.com>
 <1506584500-867-3-git-send-email-xzhou@redhat.com>
 <20170928111008.GA15067@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928111008.GA15067@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 28, 2017 at 09:10:08PM +1000, Dave Chinner wrote:
> On Thu, Sep 28, 2017 at 03:41:38PM +0800, Xiong Zhou wrote:
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> 
> Why? you're not fixing any problem here, and it's completely
> unrelated to fixing the issue the series is about....

Yes. It's not related and a little weird. Because I'm too lazy
to split them. This is a "by the way" patch.

If you strongly recommend, I could resend these into 2 series:
one with the fix of fake failures, the other is the write_ro
case with the name/group fixes.

Thanks,
Xiong

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
