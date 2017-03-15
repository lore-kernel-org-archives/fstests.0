Received: from mx1.redhat.com ([209.132.183.28]:34328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751885AbdCOJjy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Mar 2017 05:39:54 -0400
Date: Wed, 15 Mar 2017 17:39:42 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/397: test renaming encrypted files without key
Message-ID: <20170315093942.GN14226@eguan.usersys.redhat.com>
References: <20170314212358.46169-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314212358.46169-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 14, 2017 at 02:23:58PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Update generic/397 to test another behavior when accessing encrypted
> files without the key: renames should be forbidden, even though they may
> be possible cryptographically.  Test both a regular rename and a cross
> rename.  (It happens that generic/398 also covers the cross rename case,
> but it's primarily for a different reason.)
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Richard Weinberger <richard@nod.at>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

We usually don't add new tests to existing tests, expecially targeted
regression tests, this could make test start failing and make people
think it's a new regression.

Would you mind writing a new case for it?

Thanks,
Eryu
