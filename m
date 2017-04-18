Received: from mga09.intel.com ([134.134.136.24]:38884 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752202AbdDRQhK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Apr 2017 12:37:10 -0400
Date: Tue, 18 Apr 2017 10:36:45 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 3/4] xfs: test per-inode DAX flag DAX to non-DAX
Message-ID: <20170418163645.GC25618@linux.intel.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-4-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492413255-11146-4-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 03:14:14PM +0800, Xiong Zhou wrote:
> This test is split from xfs/260, only do IO from DAX
> to non-DAX.
> 
> Since DIO from DAX to non-DAX is only supported/doable
> when device underneath has memory(struct page) backend.
> 
> By ndctl looking at SCRATCH_DEV, skip this test if it is
> not in "memory mode".
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

Looks good.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
