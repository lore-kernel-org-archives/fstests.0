Received: from imap.thunk.org ([74.207.234.97]:60602 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035546AbdDUFvd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 Apr 2017 01:51:33 -0400
Date: Fri, 21 Apr 2017 01:51:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] test-appliance: remove gce-run
Message-ID: <20170421055131.rjkrhv4aekfvlwcu@thunk.org>
References: <20170417195911.75159-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417195911.75159-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 12:59:11PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 'gce-run' command is obsolete now that we have 'gce-xfstests shell'.
> It also didn't respect the settings in ~/.config/gce-xfstests.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

				- Ted
