Received: from verein.lst.de ([213.95.11.211]:52738 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753811AbdBDKCr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 4 Feb 2017 05:02:47 -0500
Date: Sat, 4 Feb 2017 11:02:45 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] generic/407: check that destination timestamps are
        updated on clone
Message-ID: <20170204100245.GB18697@lst.de>
References: <20170203095839.8007-1-hch@lst.de> <20170203095839.8007-2-hch@lst.de> <20170204041526.GF1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170204041526.GF1859@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Feb 04, 2017 at 12:15:26PM +0800, Eryu Guan wrote:
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. common/reflink
> 
> For consistency, ". ./common/reflink" looks better.

Sure, this was fat fingered anyway :)

> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +
> > +_require_test
> > +_require_test_reflink
> > +_require_cp_reflink
> 
> This seems not necessary, cp is not used and xfs_io reflink command is
> checked in _require_test_reflink.

Yeah - the first version used cp, but I changed it later so this an be
safely dropped.

> Otherwise looks good to me. I can fix them at commit time.

Please do, thanks a lot!
