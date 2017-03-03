Received: from imap.thunk.org ([74.207.234.97]:39630 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbdCCWya (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Mar 2017 17:54:30 -0500
Date: Fri, 3 Mar 2017 17:53:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: add an android-xfstests command
Message-ID: <20170303225337.sbvwi6xhggbbimdl@thunk.org>
References: <20170303010238.76005-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303010238.76005-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 02, 2017 at 05:02:38PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a command android-xfstests which has an interface similar to
> kvm-xfstests and gce-xfstests, but runs xfstests on the internal storage
> of an Android device instead.  It works by setting up temporary
> partitions in space freed up by reformatting the userdata filesystem
> with a smaller size, then running the tests in a Debian chroot.  More
> information can be found in the documentation in android-xfstests.md.
> 
> Some features of kvm-xfstests and gce-xfstests, such as selecting the
> kernel to use, are not yet implemented for android-xfstests but may be
> possible to add later.
> 
> So far I have only tested android-xfstests on two devices, but it's
> intended to work on other devices too.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Very Nice!   Thanks, applied.

					- Ted
