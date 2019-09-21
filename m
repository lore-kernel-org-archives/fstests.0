Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55626 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393509AbfIUONQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Sep 2019 10:13:16 -0400
Date: Sat, 21 Sep 2019 10:13:12 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH][xfstests-bld] build-all: fix acl tools build
Message-ID: <20190921141312.GA26913@mit.edu>
References: <20190920184846.18251-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920184846.18251-1-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 20, 2019 at 09:48:46PM +0300, Amir Goldstein wrote:
> On a clean do-all buster image getfacl is dynamically
> linked with libacl.so.1, but the built library is not installed.
> The installed libacl.so.1 in the image is incompatible with the
> version of acl tools that we build:

So I did a clean build of a4df7d7b3112: "Update the default version of
quota and xfsprogs" in buster, and the resulting getfacl executable
does not depend on libacl.so.1:

<tytso@stretch-amd64-CHROOT.lambda> {/tmp/xfstests-bld}
1002% ldd xfstests/bin/getfacl 
	linux-vdso.so.1 (0x00007ffeafbc4000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fd8cf9a0000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fd8cff47000)

Is there something in your config.custom which is influencing the
reseult?  I'm also not seeing any file in the acl directory, after the
build, which contains NO_SOLIB:

<tytso@stretch-amd64-CHROOT.lambda> {/tmp/xfstests-bld/acl}
1004% find . -type f -print | xargs grep NO_SOLIB

The git repository for keyutils does respect NO_SOLIB, but that's
because it's hard-coded into keyutils's Makefile.  So it doesn't
appear to me how your change would make any difference to how the acl
library is built.

Can you take a closer look?

					- Ted
