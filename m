Received: from imap.thunk.org ([74.207.234.97]:60632 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035668AbdDUF55 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 Apr 2017 01:57:57 -0400
Date: Fri, 21 Apr 2017 01:57:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] android-xfstests: improve 'android-xfstests shell'
 command
Message-ID: <20170421055755.zdlpgekezwklhfeb@thunk.org>
References: <20170417234918.81940-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417234918.81940-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 04:49:18PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make several improvements to 'android-xfstests shell':
> 
> 1.) Make it give a shell inside the chroot, not outside.
> 2.) Set up the xfstests partitions before entering the chroot.
> 3.) Make the shell start from /root, similar to 'kvm-xfstests shell'.
> 4.) Fix setup-fstab to use the new names for the test device variables,
>     to not give errors if the /dev/vd[b-f] symlinks already exist, and
>     to not create links to the large devices if they weren't specified
>     in the test-config.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted
