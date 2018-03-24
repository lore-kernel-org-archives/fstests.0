Received: from imap.thunk.org ([74.207.234.97]:52186 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbeCXCdb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Mar 2018 22:33:31 -0400
Date: Fri, 23 Mar 2018 22:33:28 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] test-appliance: use --auto-deconfigure when
 installing extra packages
Message-ID: <20180324023328.GA730@thunk.org>
References: <20180306013209.30082-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306013209.30082-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 05, 2018 at 05:32:09PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Trying to build the KVM or GCE test appliances with Debian packages
> built from the latest e2fsprogs git tree placed into the
> test-appliance/debs/ directory fails because of the recent renamings
> from libcomerr2 to libcom-err2 and e2fslibs to libext2fs2, e.g.:
> 
>     dpkg: regarding .../libcom-err2_1.44.0~rc2-1_amd64.deb containing libcom-err2:amd64:
>      libcom-err2 breaks libcomerr2 (<< 1.43.9-1~)
>       libcomerr2:amd64 (version 1.43.4-2) is present and installed.
> 
>     dpkg: error processing archive /run/libcom-err2_1.44.0~rc2-1_amd64.deb (--install):
>      installing libcom-err2:amd64 would break libcomerr2:amd64, and
>      deconfiguration is not permitted (--auto-deconfigure might help)
> 
> Add the --auto-deconfigure argument to make it work.  I'm not sure it's
> the best solution, but it works.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
