Received: from mx1.redhat.com ([209.132.183.28]:45828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752258AbeAXD7B (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jan 2018 22:59:01 -0500
Date: Wed, 24 Jan 2018 11:58:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 4/8] metaperf: Include linux/param.h explicitly for HZ
 macro
Message-ID: <20180124035859.GA30514@eguan.usersys.redhat.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-5-git-send-email-rostislav@tuxera.com>
 <20180122202406.GD16776@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122202406.GD16776@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Rostislav Skudnov <rostislav@tuxera.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 12:24:06PM -0800, Christoph Hellwig wrote:
> On Mon, Jan 22, 2018 at 03:57:15PM +0000, Rostislav Skudnov wrote:
> > Glibc includes linux/param.h when we include sys/param.h, whereas musl
> > libc does not do that. HZ is a Linux-specific macro, therefore include
> > the header file that defines it explicitly.
> > 
> > Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
> 
> Using HZ in userspace doesn't make any sense at all.  The kernel HZ
> (as in the granulairy for jiffies) can vary between architectures
> and even configurations.  I guess it wants a hard coded 100 here, but
> someone will have to do a detailed analysis.

No one is using metaperf now, all the old benchmark infrastructure was
removed by commit b020416d51ff ("xfstests: remove bench infrastructure")

I think we can remove src/metaperf.c too.

Thanks,
Eryu
