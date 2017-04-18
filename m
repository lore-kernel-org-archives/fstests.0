Received: from mga01.intel.com ([192.55.52.88]:54497 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbdDRQcS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Apr 2017 12:32:18 -0400
Date: Tue, 18 Apr 2017 10:31:33 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 1/4] DAX-DIO: make dax_to_non_dax dio test solo
Message-ID: <20170418163133.GA25618@linux.intel.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-2-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492413255-11146-2-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 03:14:12PM +0800, Xiong Zhou wrote:
> Split it from old testsets in generic/413 and xfs/260, since this
> test need pmem device underneath has memory(struct page) backend.
> We will _notrun the solo if the device is not compatible for the
> test, preveting its confusing failure.
> 
> The other dax/nondax dio tests don't have this limitation.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

Sure, this seems like a good solution to me.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
