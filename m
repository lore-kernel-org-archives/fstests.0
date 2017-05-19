Received: from mail-pg0-f67.google.com ([74.125.83.67]:34131 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdESHjO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 May 2017 03:39:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id u187so8853807pgb.1
        for <fstests@vger.kernel.org>; Fri, 19 May 2017 00:39:14 -0700 (PDT)
Date: Fri, 19 May 2017 00:39:11 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH 1/5] kernel-configs: switch to using defconfigs
Message-ID: <20170519073911.GA28321@zzz>
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
Cc: Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Hi Amir,

On Fri, May 19, 2017 at 10:05:35AM +0300, Amir Goldstein wrote:
> On Thu, May 18, 2017 at 9:44 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > On Wed, May 17, 2017 at 04:32:29PM -0700, Eric Biggers wrote:
> >> From: Eric Biggers <ebiggers@google.com>
> >>
> >> Currently, the kernel configs for kvm-xfstests and gce-xfstests are
> >> difficult to maintain because they are so long.  Fix this by changing
> >> them to 'defconfig' format, so they only list the non-default settings.
> >>
> >> As documented, there is one additional step introduced when building a
> >> kernel for the first time: you now must run 'make olddefconfig' after
> >> copying a defconfig file to .config.  However I think this is an
> >> acceptable tradeoff for having much more maintainable config files.
> >> Running 'make olddefconfig' also means that people won't have to answer
> >> random config questions if they're testing the latest kernel.
> >>
> >> This change was scripted by running 'make savedefconfig' for each config
> >> within the appropriate source tree (stable/linux-X.X-y).
> >>
> >> Signed-off-by: Eric Biggers <ebiggers@google.com>
> >
> > Thanks, applied.  (This patch was 1.4MB, so it would have been
> > rejected by vger.kernel.org.)
> >
> 
> Ted,
> 
> Applied where? github is 2 weeks behind. kernel.org is 2 weeks behind.
> 
> BTW, I am curious to know why the kernel-configs in this repository have
> no obvious debug config options.
> 
> Aren't you guys testing regularly with lockdep etc? does everyone carry
> their own home brewed debug configs like I do [1]?
> 
> What do you say about including -debug variants to the maintained
> kernel-configs in this repo? or turn on the obvious debugging features
> by default?
> 

There are already a number of debugging options turned on in the 4.9 x86_64
config, including lockdep, various other CONFIG_DEBUG_* options, and the crypto
self-tests.  It definitely should still be improved, though.  I've been planning
to go through it again and see if there are any other debug options that should
be turned on, as well as unused features which should be disabled.  Also the
older configs tend to be outdated and should be synced up with the latest (to
the extent that this is worthwhile; in simple cases, at least, it's pretty
easily scriptable).

We probably shouldn't enable the most expensive debug options like KASAN by
default, though.  Lockdep is fine.

Eric
