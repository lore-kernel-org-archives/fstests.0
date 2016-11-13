Received: from bombadil.infradead.org ([198.137.202.9]:51699 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbcKMMLP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Nov 2016 07:11:15 -0500
Date: Sun, 13 Nov 2016 04:11:14 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fstests: fix error redirection in generic/256
Message-ID: <20161113121114.GA8362@infradead.org>
References: <20161112164720.GA18127@infradead.org>
 <20161112183943.GK27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161112183943.GK27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Nov 13, 2016 at 02:39:43AM +0800, Eryu Guan wrote:
> On Sat, Nov 12, 2016 at 08:47:20AM -0800, Christoph Hellwig wrote:
> > Not sure if my shell is the problem here, but I need this explicit
> > redirection to ignore the error output from mkdir and xfs_io, otherwise
> > the test fails due to the error messages from these commands.
> 
> That's weird, from bash manpage, "&>" should be equivalent to "> ... 2>&1"
> 
> There're many other tests use "&>" as well, do you see such failures
> from other tests, such as generic/347?

generic/347 works fine for me, but I'm not sure I hit an error there
which would have to be redirected.
