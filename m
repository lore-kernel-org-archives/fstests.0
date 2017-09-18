Received: from verein.lst.de ([213.95.11.211]:57663 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbdIRXjT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 18 Sep 2017 19:39:19 -0400
Date: Tue, 19 Sep 2017 01:39:17 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: xfs/310: relax extent count check
Message-ID: <20170918233917.GA29974@lst.de>
References: <20170903155101.GA30258@lst.de> <20170918211042.GA6533@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918211042.GA6533@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 18, 2017 at 02:10:42PM -0700, Darrick J. Wong wrote:
> > +# make sure the allocator didn't allocate more than the needed two extents
> >  echo "Check extent count"
> > -xfs_bmap -l -p -v $testdir/file1 | grep '^[[:space:]]*1:' -q && xfs_bmap -l -p -v $testdir/file1
> > +xfs_bmap -l -p -v $testdir/file1 | grep '^[[:space:]]*2:' -q && xfs_bmap -l -p -v $testdir/file1
> 
> I haven't had time to read the getbmap rework over in xfs-land yet, but
> I'm assuming from this diff that the new getbmap no longer merges adjacent
> records?

Yes.

> Also, won't this break the test on old kernels?

No - it just checks we don't have more than two extents instead of
checking we don't have more than one, so it just relaxes the check
a bit.
