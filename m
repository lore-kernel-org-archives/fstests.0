Received: from mx1.redhat.com ([209.132.183.28]:47320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbdDROt5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Apr 2017 10:49:57 -0400
Date: Tue, 18 Apr 2017 22:49:53 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v4 2/4] generic: test mmap io fom DAX to non-DAX
Message-ID: <20170418144953.4zblejq7blq5622p@XZHOUW.usersys.redhat.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-3-git-send-email-xzhou@redhat.com>
 <20170418101226.GA15898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418101226.GA15898@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 18, 2017 at 03:12:26AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 17, 2017 at 03:14:13PM +0800, Xiong Zhou wrote:
> > Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
> > do mmap DIO from DAX to non-DAX.
> > 
> > This test is split from generic/413. Since DIO from DAX
> > to non-DAX is only supported/doable when device underneath
> > has memory(struct page) backend.
> > 
> > By ndctl looking at SCRATCH_DEV, skip this test if it is
> > not in "memory mode".
> 
> DAX devices don't need to be something using NFIT, so I don't think this
> method is correct.

Ya. This commit message needs update. I'm trying another method, not being
that nvdimm specific.
