Received: from mx1.redhat.com ([209.132.183.28]:56572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966641AbcKLSjq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 12 Nov 2016 13:39:46 -0500
Date: Sun, 13 Nov 2016 02:39:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: fix error redirection in generic/256
Message-ID: <20161112183943.GK27776@eguan.usersys.redhat.com>
References: <20161112164720.GA18127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161112164720.GA18127@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Nov 12, 2016 at 08:47:20AM -0800, Christoph Hellwig wrote:
> Not sure if my shell is the problem here, but I need this explicit
> redirection to ignore the error output from mkdir and xfs_io, otherwise
> the test fails due to the error messages from these commands.

That's weird, from bash manpage, "&>" should be equivalent to "> ... 2>&1"

There're many other tests use "&>" as well, do you see such failures
from other tests, such as generic/347?

Thanks,
Eryu
