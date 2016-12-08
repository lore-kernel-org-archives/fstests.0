Received: from imap.thunk.org ([74.207.234.97]:60356 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753615AbcLHDS7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Dec 2016 22:18:59 -0500
Date: Wed, 7 Dec 2016 22:18:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: correct file permissions in xfstests.tar.gz
Message-ID: <20161208031856.cqaggdktoas5ughs@thunk.org>
References: <1479504350-123472-1-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479504350-123472-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 18, 2016 at 01:25:50PM -0800, Eric Biggers wrote:
> The bug with --update-files also affected --update-xfstests-tar.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
