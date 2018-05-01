Received: from imap.thunk.org ([74.207.234.97]:47876 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbeEACRu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Apr 2018 22:17:50 -0400
Date: Mon, 30 Apr 2018 22:17:46 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH 1/2] test-appliance: fix specifying f2fs
 mount options in config file
Message-ID: <20180501021746.GG20585@thunk.org>
References: <20180419205020.16868-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419205020.16868-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 19, 2018 at 01:50:19PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> setup_mount_opts() is supposed to prepend "-o " to the mount options,
> but it failed to do so in the case where mount options are specified in
> a config file rather than on the command line.  Fix it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
