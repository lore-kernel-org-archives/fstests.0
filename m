Received: from mail-pg1-f193.google.com ([209.85.215.193]:35455 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPRe4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Aug 2019 13:34:56 -0400
Date: Fri, 16 Aug 2019 17:34:53 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [ANN] oscheck: wrapper for fstests check.sh - tracking and
 working with baselines
Message-ID: <20190816173453.GM16384@42.do-not-panic.com>
References: <CAB=NE6UjcBgQhoQvZoWKXnPWoHVNMbeYdyGfYsHdgeA=L1M4wQ@mail.gmail.com>
 <20180713205154.GA8782@bombadil.infradead.org>
 <20180713205931.GC3620@garbanzo.do-not-panic.com>
 <20180714222115.GA13230@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714222115.GA13230@bombadil.infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>, fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Sasha Levin <Alexander.Levin@microsoft.com>, Sasha Levin <levinsasha928@gmail.com>, Valentin Rothberg <valentinrothberg@gmail.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Kent Overstreet <kent.overstreet@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Jul 14, 2018 at 03:21:15PM -0700, Matthew Wilcox wrote:
> On Fri, Jul 13, 2018 at 01:59:31PM -0700, Luis R. Chamberlain wrote:
> > > It's still ridiculously hard
> > > to set up a DAX test environment though. 
> 
> > > The best I've been able to
> > > do is now merged into Kent's ktest -- but you're not based on that,
> > > so I'll try and get your ostest set up to work with DAX.  Or maybe Ross
> > > can do it since he's actually been able to get 2MB pages working and I
> > > still haven't :-(
> > 
> > Patches and new sections to cover more ground indeed are appreciated!
> 
> I feel like we need to merge ktest and oscheck.

In the end I disagreed.

> oscheck assumes that you
> know how to set up qemu, and ktest takes care of setting up qemu for you.

I really disliked all the stupid hacks we had both mine and Kent's
solution. So I wrote a proper modern devops environment for Linux kernel
development which is agnostic to from an architectural pespective to
your OS, and virtualization environment, whether that be local or cloud.

Addressing cloud and local virtual environment proved more diffcult and
took a bit of time. But with a bit of patience, I found something
suitable, and better than just hacks put together.

It relies on ansible, vagrant and terraform. The later two unfortunately
rely on Ruby...  Let me be clear though, I have my own reservations
about relying on solutions which rely on Ruby... but I find that
startups *should* do a better job than a few kernel developers writing
shell hacks for their own prefferred virtual environment. With a bit of
proper ... nudging...  I think we can steer things in the right
direction. vagrant / terraform are at least perhaps more usable and
popular then a few shell hacks.

oscheck now embraces this solution, and you don't need to know much
about setting up qemu, and even supports running on OS X. I've announced
the effort through lkml as it turns out the nuts and bolts about the
generic setup is actually a more common goal than for filesystems. The
results:

https://people.kernel.org/mcgrof/kdevops-a-devops-framework-for-linux-kernel-development

  Luis
