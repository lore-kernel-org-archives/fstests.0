Received: from imap.thunk.org ([74.207.234.97]:38484 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbdEBElq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 May 2017 00:41:46 -0400
Date: Tue, 2 May 2017 00:41:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] kvm-xfstests: fix running tests with non-primary
 filesystem type
Message-ID: <20170502044143.k7cfqjho3btxsru5@thunk.org>
References: <20170501170358.94330-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501170358.94330-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, May 01, 2017 at 10:03:58AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> With kvm-xfstests, the 'setup-fstab' script would add entries for the
> test devices to /etc/fstab, using $PRIMARY_FSTYPE (default "ext4").
> This was apparently intended only as a convenience to allow manually
> running commands like 'mount /vdb'.  However, it was actually always
> executed because the appliance is configured to automatically start
> interactive login shells for 'root' on the extra serial ports.  This
> broke running tests with filesystem types other than the "primary",
> since the wrong fsck program would run.
> 
> To fix this, instead use static fstab entries with fstype 'auto'.  This
> makes fsck and mount auto-detect the filesystem type, so both the tests
> and interactive mounts will work regardless of filesystem type.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
