Received: from imap.thunk.org ([74.207.234.97]:36682 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdIPGeU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 16 Sep 2017 02:34:20 -0400
Date: Sat, 16 Sep 2017 02:34:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] setup-buildchroot: fix finding files in
 chroot.d
Message-ID: <20170916063418.7unlz2kwunoozu37@thunk.org>
References: <20170831201540.32597-1-ebiggers3@gmail.com>
 <20170916040008.GD6901@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170916040008.GD6901@zzz.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 15, 2017 at 09:00:08PM -0700, Eric Biggers wrote:
> On Thu, Aug 31, 2017 at 01:15:40PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > get_schroot_config() sometimes didn't find the files in
> > /etc/schroot/chroot.d/ because there was a typo in the regex: it used
> > [0-09] instead of [0-9].  Fix it, and also cat schroot.conf first so
> > that it doesn't get printed multiple times by the xargs command.
> > 
> > We also don't need to check whether schroot.conf exists, since it was
> > already checked in check_prerequisites(), and the 'cat' command would
> > fail anyway if it didn't exist.
> > 
> 
> Ted, can you apply this patch?  Thanks!

Applied, thanks.

					- Ted
