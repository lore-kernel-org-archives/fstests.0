Received: from mail-pg0-f65.google.com ([74.125.83.65]:35115 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932445AbdAEA3S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Jan 2017 19:29:18 -0500
Received: by mail-pg0-f65.google.com with SMTP id i5so38748465pgh.2
        for <fstests@vger.kernel.org>; Wed, 04 Jan 2017 16:29:18 -0800 (PST)
Date: Wed, 4 Jan 2017 16:29:15 -0800
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v3] xfstests-bld: correct file permissions on test
 appliance files
Message-ID: <20170105002915.GD21696@gmail.com>
References: <20161228210820.13832-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161228210820.13832-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 28, 2016 at 03:08:20PM -0600, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The xfstests-bld repository may have been cloned with a umask that
> masked out the group and/or the other bits.  When using --update-files
> in this situation or when creating a GCE image, the VM ended up in a
> state where non-root users were unable to execute anything, which made
> all tests using the fsgqa user get skipped.  Fix this by copying the r
> and x user bits to the group and other bits when creating files.tar.gz.
> Also set the owner and group to root while we're at it.
> 
> Note that git doesn't actually store file owners, groups, or any mode
> bits other than "is the file executable"?  So this patch really just
> enforces a consistent, sane default for this "unstored" metadata.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

As it turns out, update_xfstests() in kvm-xfstests/test-appliance/gen-image also
needs to be updated.  (I'm not sure why it wasn't a problem for me before.)  So
I'll send yet another version of this patch.

Eric
