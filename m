Received: from verein.lst.de ([213.95.11.211]:58524 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbdISDFT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 18 Sep 2017 23:05:19 -0400
Date: Tue, 19 Sep 2017 05:05:17 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: xfs/310: relax extent count check
Message-ID: <20170919030517.GA32757@lst.de>
References: <20170903155101.GA30258@lst.de> <20170919022859.GC6533@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170919022859.GC6533@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 18, 2017 at 07:28:59PM -0700, Darrick J. Wong wrote:
> On Sun, Sep 03, 2017 at 05:51:01PM +0200, Christoph Hellwig wrote:
> > If we got over the bmbt length we'll always allocate two extents,
> > its just that so far getbmap merged them.
> > 
> > Also fix/update some comments.
> > 
> 
> Needs a s-o-b.  Otherwise,

Hmm, didn;t notice I missed that:

Signed-off-by: Christoph Hellwig <hch@lst.de>
