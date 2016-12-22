Received: from imap.thunk.org ([74.207.234.97]:45224 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965333AbcLVRKC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Dec 2016 12:10:02 -0500
Date: Thu, 22 Dec 2016 12:10:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: remove dead code for gce-xfstests
 get-results
Message-ID: <20161222171000.zckuwokuoyqk5y6k@thunk.org>
References: <1482343592-135031-5-git-send-email-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482343592-135031-5-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 21, 2016 at 10:06:31AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 'gce-xfstests get-results' command was implemented in two places.
> Remove the dead version.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

				- Ted
