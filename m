Received: from mx1.redhat.com ([209.132.183.28]:39134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162825AbdAJE1C (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Jan 2017 23:27:02 -0500
Date: Tue, 10 Jan 2017 12:27:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: fix error redirection in generic/256
Message-ID: <20170110042701.GJ1859@eguan.usersys.redhat.com>
References: <20161112164720.GA18127@infradead.org>
 <20161112183943.GK27776@eguan.usersys.redhat.com>
 <20170109134008.GC19577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170109134008.GC19577@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 09, 2017 at 05:40:08AM -0800, Christoph Hellwig wrote:
> On Sun, Nov 13, 2016 at 02:39:43AM +0800, Eryu Guan wrote:
> > On Sat, Nov 12, 2016 at 08:47:20AM -0800, Christoph Hellwig wrote:
> > > Not sure if my shell is the problem here, but I need this explicit
> > > redirection to ignore the error output from mkdir and xfs_io, otherwise
> > > the test fails due to the error messages from these commands.
> > 
> > That's weird, from bash manpage, "&>" should be equivalent to "> ... 2>&1"
> > 
> > There're many other tests use "&>" as well, do you see such failures
> > from other tests, such as generic/347?
> 
> No.  But 256 keeps on failing for me without this.  Given that it's
> just a slightly more verbose syntax is there any reason not to just
> apply this patch for now?

BTW, are you using Debian, or your default shell is not bash? If so, I
guess you may hit this

https://www.spinics.net/lists/fstests/msg00686.html

Changing the default shell to bash for fsgqa user should do the work for
you, I guess.

Thanks,
Eryu
