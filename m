Received: from imap.thunk.org ([74.207.234.97]:35492 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbeJKWXf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Oct 2018 18:23:35 -0400
Date: Thu, 11 Oct 2018 10:56:02 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH resend] android-xfstests: fix finding FS_TYPE when
 userdata is on dm device
Message-ID: <20181011145601.GA14520@thunk.org>
References: <20180905190700.66123-1-ebiggers@kernel.org>
 <20180915193657.GC9979@thunk.org>
 <20181003233717.GA58226@gmail.com>
 <20181004023502.GA646@thunk.org>
 <CAOQ4uxibDWQPh_Vno9s2RUXkrkSR0kStd2r3UXpaK_XV681oVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxibDWQPh_Vno9s2RUXkrkSR0kStd2r3UXpaK_XV681oVg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: ebiggers@kernel.org, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 11, 2018 at 03:01:36PM +0300, Amir Goldstein wrote:
> 
> FYI, this is pushed to github, but not kernel.org tree.
> Intentional?

Nope, just another oversight; fixed now.

> FYI2, I started trying to build a kvm-xfstests image with Debian buster.
> First thing I ran into with setup-buildchroot is that golang-1.8-go
> package is not available.
> I suppose golang is for syzbot? Their wiki recommends to use
> golang-go for debian based releases, which does work for buster.

At the time syzbot required golang 1.8.  I just checked, and according
to their docs[1] syzbot now requires golang 1.9.  I haven't been
bothering quite as much with syzkaller lately because there are now C
reproducers, and the syzkaller reproducers are not stable --- that is,
if you don't use *precisely* the same version of syzkaller, down to
the commit id, the syzkaller repro might not work at all.  I've tried
talking to Dmitry about providing at least *backwards* compatibility
(e.g., that a newer syzkaller can use a repro produced by an older
syzbot), but he's not willing to provide even that level of
compatibility.

[1] https://github.com/google/syzkaller/blob/master/docs/linux/setup.md

So building syzkaller is currently optional, and the only time I would
recommend it is that there apparently some cases where there is a
syzkaller reproducer, but no C reproducer, which is very said given
the complete lack of backwards compatibility.

I suppose we could include git, the syzkaller git tree and the go
compiler into the test VM, and build the appropriate version syzkaller
for each repro --- but it would really bloat the kvm-xfstests, and
that information isn't even encoded into the syzkaller repro file.  :-(

So it's all rather a mess at this point.  Maybe this is something we
could do just for the gce-xfstests test appliance.  Patches
appreciated.  :-)

On your other note, I haven't bothered using setup-buildchroot since
my laptop environment is buster.  Making setup-buildchroot install the
newest possible version of go available for buster or stretch sounds
like the best approach for now.


> Now I hit an error in ./gen-image:
> W: Couldn't download package openssl (ver 1.1.0f-3+deb9u1 arch amd64) at
> http://mirrors.kernel.org/debian/pool/main/o/openssl/openssl_1.1.0f-3+deb9u1_amd64.deb
> I see that this pkg doesn't exist in the mirror, but this pkg does
> exists (deb9u2):
> http://mirrors.edge.kernel.org/debian/pool/main/o/openssl/openssl_1.1.0f-3+deb9u2_amd64.deb
> 
> Do you know what that is about?

That's generally due to the mirror not being fully synced up so the
Debian distro metadata files weren't synced up with the debian package
files.  If you try again in 30 minutes or so, it should resolve
itself.

						- Ted
