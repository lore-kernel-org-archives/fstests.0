Received: from imap.thunk.org ([74.207.234.97]:42842 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751472AbdESOnN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 19 May 2017 10:43:13 -0400
Date: Fri, 19 May 2017 10:43:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/5] kernel-configs: switch to using defconfigs
Message-ID: <20170519144310.h52nam76bkxback2@thunk.org>
References: <20170517233233.61244-1-ebiggers3@gmail.com>
 <20170517233233.61244-2-ebiggers3@gmail.com>
 <20170518184433.qq2g43s4za6hrfjz@thunk.org>
 <CAOQ4uxiygvNT07ZWLss8nnNRe4VVNuhAF5WRLSpRP7vYffibyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiygvNT07ZWLss8nnNRe4VVNuhAF5WRLSpRP7vYffibyA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers3@gmail.com>, fstests <fstests@vger.kernel.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, May 19, 2017 at 10:05:35AM +0300, Amir Goldstein wrote:
> 
> Applied where? github is 2 weeks behind. kernel.org is 2 weeks behind.

Pushed out now.  There can be a day or two lag between when I accept
patches and when they get pushed out.  That's normally because I do a
test verification in a batch process, and if there are substantive
changes, I do like to at least do a smoke test before pushing stuff
out.  In this case, where it's just Documentation and kernel-configs
changes, I do push something out first.

> BTW, I am curious to know why the kernel-configs in this repository have
> no obvious debug config options.
> 
> Aren't you guys testing regularly with lockdep etc? does everyone carry
> their own home brewed debug configs like I do [1]?

We do actually have LOCKDEP enabled in the x86_64 4.9 config.  The
current set of configs were always maintained informally, and were
originally intended to help people who were getting started to be able
to build a kernel that would actually work using KVM or GCE.  So they
were made by copying my current development configs to kernel-config
directory.  That's why there is a certain amount of inconsistency over
which debugging options were turned on.

In particular, I never bothered to turn on LOCKDEP debugging for the
stable kernel verification effort that I did a year or so ago.  (I've
been too busy to run the full set of regression tests on 3.18.x,
et. al; I suspect if I did we would discover some additional number of
bug fixes that need to be hand cherry picked back to ancient kernels.
This also reflects that I'm no longer directly involved with trying to
build Android kernels; which is why I started running the regression
tests on LTS kernel releases, out of sheer self-defense, and so I
could point out to various folks --- well, if your BSP kernel had
_bothered_ to keep up with the stable kernels, you'd find the bug fix
in 3.18.y....)  I probably should have turned on LOCKDEP debugging,
but at the time, finding bugs in the 3.10 kernel was easy enough
without turning on LOCKDEP.  :-)

> What do you say about including -debug variants to the maintained
> kernel-configs in this repo? or turn on the obvious debugging features
> by default?
> 
> [1] https://github.com/amir73il/xfstests-bld/commit/af76cac689ea726cb8f5b222010b7818a689809b

No objections to me, in general, so long as it doesn't trash
performance _too_ much.  I will note that test diversity can be a good
thing, since it could be that certain timing related bugs can be
suppressed if various debugging options are turned on....

	      	      			    - Ted
