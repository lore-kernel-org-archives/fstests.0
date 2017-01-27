Received: from imap.thunk.org ([74.207.234.97]:57824 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753898AbdA0DqA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Jan 2017 22:46:00 -0500
Date: Thu, 26 Jan 2017 22:45:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: xfstest and chromeos
Message-ID: <20170127034557.l6kzxxjh2md2rfgs@thunk.org>
References: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: fstests@vger.kernel.org, Mike Frysinger <vapier@chromium.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 23, 2017 at 09:57:15AM -0800, Gwendal Grignou wrote:
> https://chromium-review.googlesource.com/#/c/424191
> - Chromeos needs libtool to (cross-)compile packages and put them at
> the right place. I needed to move archived aclocal.m4 to acinclude.m4.
> Does it make sense to require aclocal to run to compile xfstests?

I'm kind of curious why you need libtool to be able to cross-compile
packages.

I've been cross-compiling xfstests to armhf, ppcle, and arm64 without
any issues.   

See:   https://git.kernel.org/cgit/fs/ext2/xfstests-bld.git/tree/build-all

Are you trying to build with shared libraries, or some such?

							- Ted
