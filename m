Received: from bombadil.infradead.org ([198.137.202.9]:38756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdAJG2h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2017 01:28:37 -0500
Date: Mon, 9 Jan 2017 22:28:36 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fstests: fix error redirection in generic/256
Message-ID: <20170110062836.GA17367@infradead.org>
References: <20161112164720.GA18127@infradead.org>
 <20161112183943.GK27776@eguan.usersys.redhat.com>
 <20170109134008.GC19577@infradead.org>
 <20170110042701.GJ1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170110042701.GJ1859@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 10, 2017 at 12:27:01PM +0800, Eryu Guan wrote:
> BTW, are you using Debian, or your default shell is not bash? If so, I
> guess you may hit this

Yes, this is debian with dash.

> 
> https://www.spinics.net/lists/fstests/msg00686.html
> 
> Changing the default shell to bash for fsgqa user should do the work for
> you, I guess.

I don't think that's a good idea.  But option 2) from Ted's list to
use a specific shell for executions is a good idea.  I'll look into
that.
