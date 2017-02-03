Received: from verein.lst.de ([213.95.11.211]:47285 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752122AbdBCKeU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 05:34:20 -0500
Date: Fri, 3 Feb 2017 11:34:18 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] generic/407: check that destination timestamps are
        updated on clone
Message-ID: <20170203103418.GA29484@lst.de>
References: <20170202162755.21101-1-hch@lst.de> <CAOQ4uxiPdAvGe7LT9OtvGJrXozxtTxQi_iDU--y_9aPUTsSkaA@mail.gmail.com> <20170203095606.GA28569@lst.de> <CAOQ4uxh4Wp8YtX283=X0Kp=8BXZCdeoPamBAwimpq2RmZkxkKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh4Wp8YtX283=X0Kp=8BXZCdeoPamBAwimpq2RmZkxkKg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 03, 2017 at 12:32:21PM +0200, Amir Goldstein wrote:
> Yes, I saw that, generic/215 which was copied from generic/080 I guess
> someone should clean up those 2 some time.
> 
> And while we are busy saving more angels lives, do 407 and 408 really need
> to be separate tests?
> How about consolidating them into a single test that works with 2 sets of files?
> Sorry again for nit picking on those lost seconds.

We can't do that as there are file systems that support clone but not
dedup (e.g. NFS).
