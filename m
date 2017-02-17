Received: from mx1.redhat.com ([209.132.183.28]:47424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752574AbdBQGwI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Feb 2017 01:52:08 -0500
Date: Fri, 17 Feb 2017 14:52:07 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v6 2/2] generic: test mmap io through DAX and non-DAX
Message-ID: <20170217065207.fr2lwf2jdobc6jsl@XZHOUW.usersys.redhat.com>
References: <20170206191717.GB12290@linux.intel.com>
 <1486527078-11173-1-git-send-email-xzhou@redhat.com>
 <1486527078-11173-3-git-send-email-xzhou@redhat.com>
 <20170217064624.GC24562@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217064624.GC24562@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiong Zhou <xzhou@redhat.com>, ross.zwisler@linux.intel.com, fstests@vger.kernel.org, linux-nvdimm@ml01.01.org, jmoyer@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 17, 2017 at 02:46:24PM +0800, Eryu Guan wrote:
> On Wed, Feb 08, 2017 at 12:11:18PM +0800, Xiong Zhou wrote:
> > Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
> > do some IO between them. In this case we use mmap
> > and dio/buffered IO read/write test programme.
> > 
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >  tests/generic/407     | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/407.out |   2 +
> >  tests/generic/group   |   1 +
> >  3 files changed, 155 insertions(+)
> >  create mode 100755 tests/generic/407
> >  create mode 100644 tests/generic/407.out
> > 
> > diff --git a/tests/generic/407 b/tests/generic/407
> > new file mode 100755
> > index 0000000..b5b2ce4
> > --- /dev/null
> > +++ b/tests/generic/407
> > @@ -0,0 +1,152 @@
> > +#! /bin/bash
> > +# FS QA Test 407
> > +#
> > +# mmap direct/buffered io between DAX and non-DAX mountpoints.
> [snip]
> > +
> > +# make fs 2Mb aligned for PMD fault testing
> > +if [[ $FSTYP =~ ext ]] ; then
> > +	_scratch_mkfs "-E stride=512,stripe_width=1" \
> > +		> /dev/null 2>&1
> > +elif [[ $FSTYP =~ xfs ]] ; then
> > +	_scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
> > +fi
> 
> If FSTYP isn't extN nor xfs, then scratch device is not mkfs'ed, I think
> you're missing a default "else" here, which calls _scratch_mkfs without
> any options.
> 
> If you're OK with this update, I can fix it at commit time.

Okay, Thank you!

> 
> Thanks,
> Eryu
