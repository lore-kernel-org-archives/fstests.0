Received: from mail.kernel.org ([198.145.29.99]:56772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758975AbeD0RU0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Apr 2018 13:20:26 -0400
Message-ID: <1524849624.4206.7.camel@kernel.org>
Subject: Re: [PATCH] generic: test for seeing unseen fsync errors on newly
 open files
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 27 Apr 2018 13:20:24 -0400
In-Reply-To: <20180427165830.xekrvdv2my6nxjsr@alap3.anarazel.de>
References: <20180427163833.21882-1-jlayton@kernel.org>
         <20180427165830.xekrvdv2my6nxjsr@alap3.anarazel.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Andres Freund <andres@anarazel.de>
Cc: fstests@vger.kernel.org, eguan@redhat.com, willy@infradead.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Fri, 2018-04-27 at 09:58 -0700, Andres Freund wrote:
> Hi,
> 
> On 2018-04-27 12:38:33 -0400, Jeff Layton wrote:
> > This is motivated by some rather odd behavior done by the PostgreSQL
> > project. The main database writers will offload the fsync calls to a
> > separate process, which can open files after a writeback error has
> > already occurred.
> 
> ;)
> 
> 
> > +	ret = pwrite(fd1, buf, bufsize, 0);
> > +	if (ret < 0) {
> > +		printf("Second write on fd1 failed: %m\n");
> > +		return 1;
> > +	}
> > +
> > +	/* Ensure writeback occurs, but don't scrape the error */
> > +	sync();
> 
> It might be a good idea to also add a second version of this that
> additionally evicts inodes after the sync? I think that should be
> simulatable with "echo 2 > /proc/sys/vm/drop_caches" or such? That'd
> obviously fail for now...
> 

We could. In this test, I'm explicitly holding the fd1 open it while we
open fd2 after the sync to ensure that it sticks around in the cache.

TBH: I'm a little leery of keeping inodes with errors on them in the
cache as it seems like an open-ended commitment. We may not be able to
keep them forever and may eventually have to eliminate some in order to
make forward progress.

If we do go that route, we may very well need drop_caches to purge
those inodes as well, to give admins a way to clear such inodes
globally without having to explicitly open+fsync them.

In any case, I'd prefer to wait until we at least have a proposed patch
for that piece before we go adding tests for it.

> Thanks for the test,
> 
> Andres Freund
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
