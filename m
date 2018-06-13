Received: from mga11.intel.com ([192.55.52.93]:24425 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935256AbeFMWdY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 13 Jun 2018 18:33:24 -0400
Date: Wed, 13 Jun 2018 16:33:23 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [fstests PATCH] generic/223: skip when using DAX
Message-ID: <20180613223323.GA11638@linux.intel.com>
References: <20180613210742.28148-1-ross.zwisler@linux.intel.com>
 <20180613222558.GA9432@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613222558.GA9432@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, linux-nvdimm@lists.01.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 13, 2018 at 03:25:58PM -0700, Darrick J. Wong wrote:
> On Wed, Jun 13, 2018 at 03:07:42PM -0600, Ross Zwisler wrote:
> > As of these upstream kernel commits:
> > 
> > commit 6e2608dfd934 ("xfs, dax: introduce xfs_dax_aops")
> > commit 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
> > 
> > generic/223 fails on XFS and ext4 because filesystems mounted with DAX no
> > longer support bmap.  This is desired behavior and will not be fixed,
> > according to:
> > 
> > https://lists.01.org/pipermail/linux-nvdimm/2018-April/015383.html
> > 
> > So, just skip over generic/223 when using DAX so we don't throw false
> > positive test failures.
> 
> Just because we decided not to support FIBMAP on XFSDAX doesn't mean we
> should let this test bitrot. :)
> 
> Just out of curiosity, does the following patch fix g/223 for you?

Yep!  This makes generic/223 pass in my setup for both DAX and non-DAX, with
both XFS and ext4.
