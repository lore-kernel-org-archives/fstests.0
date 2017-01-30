Received: from imap.thunk.org ([74.207.234.97]:43270 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752578AbdA3Wml (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Jan 2017 17:42:41 -0500
Date: Mon, 30 Jan 2017 17:42:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] xfstests-bld: populate keyring with default key for
 test_dummy_encryption
Message-ID: <20170130224238.3ez7gcx2wh32xh6o@thunk.org>
References: <20170130213647.14843-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170130213647.14843-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 30, 2017 at 01:36:47PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> We can improve test coverage and simplify the test_dummy_encryption
> kernel logic by requiring userspace to add a default master key to the
> keyring.  Update xfstests-bld to do this.  This allows xfstests-bld to
> test kernels with the corresponding kernel patch applied ("fscrypt: make
> test_dummy_encryption require a keyring key").  It can still test older
> kernels too; the key just doesn't get used in that case.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

This is upstream already.  (commit: ce7ef24b3ef1940)

					- Ted
