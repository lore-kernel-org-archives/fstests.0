Received: from mx1.redhat.com ([209.132.183.28]:45890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdG1Ozf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Jul 2017 10:55:35 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v4 2/4] generic: test mmap io fom DAX to non-DAX
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
        <1492413255-11146-1-git-send-email-xzhou@redhat.com>
        <1492413255-11146-3-git-send-email-xzhou@redhat.com>
        <20170418101226.GA15898@infradead.org>
Date: Fri, 28 Jul 2017 10:55:33 -0400
In-Reply-To: <20170418101226.GA15898@infradead.org> (Christoph Hellwig's
        message of "Tue, 18 Apr 2017 03:12:26 -0700")
Message-ID: <x49k22sy5ju.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, Apr 17, 2017 at 03:14:13PM +0800, Xiong Zhou wrote:
>> Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
>> do mmap DIO from DAX to non-DAX.
>> 
>> This test is split from generic/413. Since DIO from DAX
>> to non-DAX is only supported/doable when device underneath
>> has memory(struct page) backend.
>> 
>> By ndctl looking at SCRATCH_DEV, skip this test if it is
>> not in "memory mode".
>
> DAX devices don't need to be something using NFIT, so I don't think this
> method is correct.

Memory mode does not depend on an NFIT.  There's a superblock stored in
the persistent memory that tracks its mode when labels are not present.

-Jeff
