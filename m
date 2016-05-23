Received: from bombadil.infradead.org ([198.137.202.9]:52499 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbcEWOzF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 23 May 2016 10:55:05 -0400
Date: Mon, 23 May 2016 07:55:03 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFD] fstests needs a new maintainer
Message-ID: <20160523145503.GA32314@infradead.org>
References: <20160523045350.GF26977@dastard>
 <20160523064138.GA5051@zlang.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160523064138.GA5051@zlang.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 23, 2016 at 02:41:38PM +0800, Zorro Lang wrote:
> Thanks for what you did for us. I'm just thinking maybe you can
> separate fstests maintenance jobs to several different maintainers?
> Due to fstests project become bigger and bigger, it maybe hard for
> someone review & merge & verify all kinds of patches.
> 
> As I know LTP have "not only one" maintainers. I think we still
> need someone like you can make important decision for fstests.
> But for some daily jobs, you can distribute them to others.

FYI, back when we team-maintained the xfstests-dev repo together with
all the other xfs -dev repos it worked out fine.  But even with that
we need someone to volunteer for doing the day to day grunt work.

While I'd be happy to help out I fear I don't have time to do the
majority of the work at the moment either.
