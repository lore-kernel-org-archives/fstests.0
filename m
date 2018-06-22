Received: from mail-pf0-f194.google.com ([209.85.192.194]:33053 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeFVC2o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jun 2018 22:28:44 -0400
Date: Fri, 22 Jun 2018 10:28:38 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [fstests PATCH 1/2] src/: fix up mmap() error checking
Message-ID: <20180622022838.GM2780@desktop>
References: <20180620225147.12151-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620225147.12151-1-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org, Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 20, 2018 at 04:51:46PM -0600, Ross Zwisler wrote:
> I noticed that in some of my C tests in src/ I was incorrectly checking for
> mmap() failure by looking for NULL instead of MAP_FAILED.  Fix those and
> clean up some places where we were testing against -1 (the actual value of
> MAP_FAILED) which was manually being cast to a pointer.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

BTW, I've applied this patch, no need to resend it in v2.

Thanks,
Eryu
