Received: from bombadil.infradead.org ([65.50.211.133]:39979 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755138AbdDRKM1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Apr 2017 06:12:27 -0400
Date: Tue, 18 Apr 2017 03:12:26 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 2/4] generic: test mmap io fom DAX to non-DAX
Message-ID: <20170418101226.GA15898@infradead.org>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-3-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492413255-11146-3-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 03:14:13PM +0800, Xiong Zhou wrote:
> Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
> do mmap DIO from DAX to non-DAX.
> 
> This test is split from generic/413. Since DIO from DAX
> to non-DAX is only supported/doable when device underneath
> has memory(struct page) backend.
> 
> By ndctl looking at SCRATCH_DEV, skip this test if it is
> not in "memory mode".

DAX devices don't need to be something using NFIT, so I don't think this
method is correct.
