Received: from mx1.redhat.com ([209.132.183.28]:53942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbeLLPSw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Dec 2018 10:18:52 -0500
Date: Wed, 12 Dec 2018 10:18:44 -0500
From: Mike Snitzer <snitzer@redhat.com>
Subject: Re: xfstests generic/347 was never correct [was: Re: dm: fix
 inflight IO check]
Message-ID: <20181212151844.GA24433@redhat.com>
References: <4fec4b01-35f9-8008-22ec-2ac8af58b854@kernel.dk>
 <20181211003204.GA14673@redhat.com>
 <20181212023424.GA21119@redhat.com>
 <c4d94e2b-883b-7b6c-ec08-54b10ba4c9ca@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d94e2b-883b-7b6c-ec08-54b10ba4c9ca@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jens Axboe <axboe@kernel.dk>, sandeen@redhat.com, fstests@vger.kernel.org, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 11 2018 at  9:58pm -0500,
Eric Sandeen <sandeen@sandeen.net> wrote:

> On 12/11/18 8:34 PM, Mike Snitzer wrote:
> > On Mon, Dec 10 2018 at  7:32pm -0500,
> > Mike Snitzer <snitzer@redhat.com> wrote:
> > 
> > SO generic/347 needs to account for 2 things:
> > 1) issue $XFS_IO_PROG IO in the background with other process(es)
> > 2) in parallel, in main generic/347 shell, run _dmthin_grow but the
> > "thin" device must be suspended with dmsetup suspend --noflush
> > 
> > Eric Sandeen: can you or someone else xfstests inclined use this info to
> > fix generic/347 please?
> 
> It's not at all clear to me what is wrong with the test.  "Do a bunch of IO
> including a sync, completely filling the backing store, then grow the backing store"
> is surely a real-world scenario that dm-thinp might encounter, no?  Things
> do recover, subsequent writes succeed, and when all is said and done the filesystem
> is checked and it's still consistent.  That sounds like some version of success to me.
> 
> Even if it's emulating a dumb user/administrator, that doesn't seem invalid.
> 
> What is wrong here?

I told you in elaborate detail.

Your willingness to leave generic/347 as is makes little sense; but that
is your call.  I'll just move on...
