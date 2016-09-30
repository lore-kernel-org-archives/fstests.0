Received: from imap.thunk.org ([74.207.234.97]:50786 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbcJABOM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Sep 2016 21:14:12 -0400
Date: Fri, 30 Sep 2016 18:21:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] [xfstests-bld] kvm-xfstests: forbid conflicting
 specifications of FSTESTCFG
Message-ID: <20160930222158.hlqvupjhdibjhiht@thunk.org>
References: <1474664172-84173-1-git-send-email-ebiggers@google.com>
 <1474664172-84173-3-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474664172-84173-3-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 23, 2016 at 01:56:12PM -0700, Eric Biggers wrote:
> It was possible to run kvm-xfstests with arguments like '-c encrypt
> smoke', in which case FSTESTCFG ended up set to "4k" because 'smoke'
> implies '-c 4k' and the second config specification overrode the first.
> If the user tries something like this, fail with a helpful error message
> rather than proceeding with a configuration that likely wasn't intended.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applie,d thanks.

					- Ted
