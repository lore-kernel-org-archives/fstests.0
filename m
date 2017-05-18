Received: from imap.thunk.org ([74.207.234.97]:38984 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755541AbdERSog (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 May 2017 14:44:36 -0400
Date: Thu, 18 May 2017 14:44:33 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/5] kernel-configs: switch to using defconfigs
Message-ID: <20170518184433.qq2g43s4za6hrfjz@thunk.org>
References: <20170517233233.61244-1-ebiggers3@gmail.com>
 <20170517233233.61244-2-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517233233.61244-2-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 17, 2017 at 04:32:29PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Currently, the kernel configs for kvm-xfstests and gce-xfstests are
> difficult to maintain because they are so long.  Fix this by changing
> them to 'defconfig' format, so they only list the non-default settings.
> 
> As documented, there is one additional step introduced when building a
> kernel for the first time: you now must run 'make olddefconfig' after
> copying a defconfig file to .config.  However I think this is an
> acceptable tradeoff for having much more maintainable config files.
> Running 'make olddefconfig' also means that people won't have to answer
> random config questions if they're testing the latest kernel.
> 
> This change was scripted by running 'make savedefconfig' for each config
> within the appropriate source tree (stable/linux-X.X-y).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.  (This patch was 1.4MB, so it would have been
rejected by vger.kernel.org.)

						- Ted
