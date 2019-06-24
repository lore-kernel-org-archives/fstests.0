Received: from bombadil.infradead.org ([198.137.202.133]:51740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfFXHQP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jun 2019 03:16:15 -0400
Date: Mon, 24 Jun 2019 00:16:10 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Removing the shared class of tests
Message-ID: <20190624071610.GA10195@infradead.org>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
 <20190620175035.GA5380@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620175035.GA5380@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, Gabriel Krisman Bertazi <krisman@collabora.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 20, 2019 at 10:50:35AM -0700, Darrick J. Wong wrote:
> > I'm not sure why shared/011 is only run on ext4 and btrfs.  Does
> > cgroup-aware writeback not work on other file systems?
> 
> IIRC it doesn't work on xfs because the author never quite answered
> Dave's question about whether or not it would cause ... io priority
> inversions or something?  There was some unanswered question (iirc) so
> nobody RVB'd the patch and it never went upstream.

I've got a new and tested patch to support cgroup writeback on xfs that
I'll send out today.  But even with that lots of file systems don't
support cgroup writeback and there is no easy way to autodetect the
support.  As far as I an tell ext2 and f2fs also support cgroup
writeback, so they should be added a well.


As for the higher level question?  The shared tests always confused the
heck out of me.  generic with the right feature checks seem like a much
better idea.
