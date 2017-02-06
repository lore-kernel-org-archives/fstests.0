Received: from mga03.intel.com ([134.134.136.65]:45318 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbdBFTNU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 6 Feb 2017 14:13:20 -0500
Date: Mon, 6 Feb 2017 12:13:18 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v5 1/2] xfs: test per-inode DAX flag by IO
Message-ID: <20170206191318.GA12290@linux.intel.com>
References: <1486221472-1007-1-git-send-email-ross.zwisler@linux.intel.com>
 <1486275704-18917-1-git-send-email-xzhou@redhat.com>
 <1486275704-18917-2-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486275704-18917-2-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: ross.zwisler@linux.intel.com, fstests@vger.kernel.org, linux-nvdimm@ml01.01.org, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Sun, Feb 05, 2017 at 02:21:43PM +0800, Xiong Zhou wrote:
> In a DAX mountpoint, do IO betwen files with and
> without DAX per-inode flag. We do mmap, both
> O_DIRECT and buffered read/write IO in this case.
> Then test again in the same device without dax
> mountoption.
> 
> Add help _require_scratch_dax to make sure we can
> test DAX feature on SCRATCH_DEV.
> 
> Add mmap dio test programme to test read/write
> between a mmap area of one file and another file
> directly or buffered, with different size.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Yep, this fine. :)

> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

These changes all look good.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
