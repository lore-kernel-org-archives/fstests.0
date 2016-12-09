Received: from mail-pg0-f67.google.com ([74.125.83.67]:33149 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbcLIVVH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Dec 2016 16:21:07 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so3373326pgd.0
        for <fstests@vger.kernel.org>; Fri, 09 Dec 2016 13:21:06 -0800 (PST)
Date: Fri, 9 Dec 2016 13:21:03 -0800
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] kvm-xfstests, gce-xfstests: correct file permissions
 with --update-files
Message-ID: <20161209212103.GA64048@google.com>
References: <1479260456-6723-1-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479260456-6723-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 15, 2016 at 05:40:56PM -0800, Eric Biggers wrote:
> The xfstests-bld repository may have been cloned with a umask that
> masked out the other bits.  When using --update-files in this situation,
> the VM ended up in a state where non-root users were unable to execute
> anything, which made all tests using the fsgqa user get skipped.  Fix
> this by copying the r and x group bits to the other bits when creating
> files.tar.gz.  Also set the owner and group to root while we're at it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Hi Ted, are you planning to apply this patch?  I see you applied the patch to
fix --update-xfstests-tar but not this one, to fix --update-files.

Thanks!

Eric
