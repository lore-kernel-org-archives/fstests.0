Received: from imap.thunk.org ([74.207.234.97]:32896 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S376726AbdD2Ql0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 29 Apr 2017 12:41:26 -0400
Date: Sat, 29 Apr 2017 12:41:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] android-xfstests: create loopback device nodes in
 standard location
Message-ID: <20170429164124.byuracv4ud3n4435@thunk.org>
References: <20170311005632.130135-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170311005632.130135-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 04:56:32PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Android creates loopback device nodes in /dev/block/, where they can't
> be found by losetup.  Create them in /dev/ too so that losetup can find
> them.  This stops tests using loopback devices, e.g. generic/361 and
> shared/298, from failing.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
