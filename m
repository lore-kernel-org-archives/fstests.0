Received: from mx1.redhat.com ([209.132.183.28]:33304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755246AbcI2IJd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Sep 2016 04:09:33 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42BD0769F5
        for <fstests@vger.kernel.org>; Thu, 29 Sep 2016 08:09:33 +0000 (UTC)
Date: Thu, 29 Sep 2016 16:09:30 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/349,350,351: remove from quick group
Message-ID: <20160929080930.GZ27776@eguan.usersys.redhat.com>
References: <1474893992-32630-1-git-send-email-eguan@redhat.com>
 <20160929075240.GA4771@dhcp12-143.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160929075240.GA4771@dhcp12-143.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 29, 2016 at 03:52:40PM +0800, Zorro Lang wrote:
> On Mon, Sep 26, 2016 at 08:46:32PM +0800, Eryu Guan wrote:
> > These tests are meant to test block devices, so they're not in auto
> > group. And quick group is a subset of auto group, so remove quick as
> > well.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> >  tests/generic/group | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 879b1ef..dc8e70d 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -352,9 +352,9 @@
> >  346 auto quick rw
> >  347 auto quick rw thin
> >  348 auto quick metadata
> > -349 blockdev quick rw zero
> > -350 blockdev quick rw punch
> > -351 blockdev quick rw punch collapse insert zero
> > +349 blockdev rw zero
> > +350 blockdev rw punch
> > +351 blockdev rw punch collapse insert zero
> 
> Can we use some methods to check if fallocate supports the features
> for block devices at first? Then decide to keep running or _notrun() these
> cases?
> 
> Because these cases are really 'quick', if they can be run automatically,
> maybe we can add them into auto group?

We didn't add them to 'auto' group on purpose.

http://oss.sgi.com/archives/xfs/2016-03/msg00288.html

I think removing 'quick' group is sufficient at this stage.

Thanks,
Eryu
