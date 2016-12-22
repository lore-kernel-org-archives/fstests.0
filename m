Received: from imap.thunk.org ([74.207.234.97]:45144 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755550AbcLVRI3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Dec 2016 12:08:29 -0500
Date: Thu, 22 Dec 2016 12:08:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: include xz-utils in kvm-xfstests appliance
Message-ID: <20161222170827.a3glqsxkzhcwqqlo@thunk.org>
References: <1482343592-135031-4-git-send-email-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482343592-135031-4-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 21, 2016 at 10:06:30AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> xz will be needed by one of the new encryption tests.  It was already
> included in the gce-xfstests appliance, but it was missing from the
> kvm-xfstests appliance.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
