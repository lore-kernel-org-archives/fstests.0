Received: from imap.thunk.org ([74.207.234.97]:50580 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933289AbdAGQnM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 7 Jan 2017 11:43:12 -0500
Date: Sat, 7 Jan 2017 11:43:07 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v4] xfstests-bld: correct file permissions on test
 appliance files
Message-ID: <20170107164307.5w7ordjrg3sjpkns@thunk.org>
References: <20170105003137.112962-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170105003137.112962-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 04, 2017 at 04:31:37PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The xfstests-bld repository may have been cloned with a umask that
> masked out the group and/or the other bits.  When using --update-files
> in this situation or when creating a GCE image, the VM ended up in a
> state where non-root users were unable to execute the binaries in
> /root/xfstests, which made all tests using the fsgqa user get skipped.
> Fix this by copying the r and x user bits to the group and other bits
> when creating files.tar.gz, creating xfstests.tar.gz, or copying files
> directly to the kvm-xfstests appliance.  Also consistently set the owner
> and group to root.
> 
> Note that git doesn't actually store file owners, groups, or any mode
> bits other than "is the file executable"?  So this patch really just
> enforces a consistent, sane default for this "unstored" metadata.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
