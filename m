Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:62955 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750817AbdI1VqC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Sep 2017 17:46:02 -0400
Date: Fri, 29 Sep 2017 07:43:40 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v6 2/4] gitignore: sort src/ binaries name
Message-ID: <20170928214340.GB15067@dastard>
References: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
 <1506584500-867-1-git-send-email-xzhou@redhat.com>
 <1506584500-867-3-git-send-email-xzhou@redhat.com>
 <20170928111008.GA15067@dastard>
 <20170928122832.yowvdelvhihn67xg@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928122832.yowvdelvhihn67xg@XZHOUW.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 28, 2017 at 08:28:32PM +0800, Xiong Zhou wrote:
> On Thu, Sep 28, 2017 at 09:10:08PM +1000, Dave Chinner wrote:
> > On Thu, Sep 28, 2017 at 03:41:38PM +0800, Xiong Zhou wrote:
> > > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > 
> > Why? you're not fixing any problem here, and it's completely
> > unrelated to fixing the issue the series is about....
> 
> Yes. It's not related and a little weird. Because I'm too lazy
> to split them. This is a "by the way" patch.
> 
> If you strongly recommend, I could resend these into 2 series:
> one with the fix of fake failures, the other is the write_ro
> case with the name/group fixes.

Yes, please send them in a separate series - patch series are
supposed to contain related patches. i.e. random changes should
not be added to a set of fixes for a specific problem. Thanks!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
