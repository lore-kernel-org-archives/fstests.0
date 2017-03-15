Received: from mail-pf0-f195.google.com ([209.85.192.195]:35706 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdCOR7v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Mar 2017 13:59:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id x63so2794889pfx.2
        for <fstests@vger.kernel.org>; Wed, 15 Mar 2017 10:59:50 -0700 (PDT)
Date: Wed, 15 Mar 2017 10:59:47 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] generic/397: test renaming encrypted files without key
Message-ID: <20170315175947.GB85449@gmail.com>
References: <20170314212358.46169-1-ebiggers3@gmail.com>
 <20170315093942.GN14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315093942.GN14226@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 15, 2017 at 05:39:42PM +0800, Eryu Guan wrote:
> On Tue, Mar 14, 2017 at 02:23:58PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Update generic/397 to test another behavior when accessing encrypted
> > files without the key: renames should be forbidden, even though they may
> > be possible cryptographically.  Test both a regular rename and a cross
> > rename.  (It happens that generic/398 also covers the cross rename case,
> > but it's primarily for a different reason.)
> > 
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > Cc: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> We usually don't add new tests to existing tests, expecially targeted
> regression tests, this could make test start failing and make people
> think it's a new regression.
> 
> Would you mind writing a new case for it?
> 
> Thanks,
> Eryu

I felt that this fit well into the existing test, but yes I'll add a new one if
that's preferable.  Thanks!

- Eric
