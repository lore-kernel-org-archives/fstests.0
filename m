Received: from mail-pg0-f66.google.com ([74.125.83.66]:34577 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbeARCQN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jan 2018 21:16:13 -0500
Received: by mail-pg0-f66.google.com with SMTP id r19so6934969pgn.1
        for <fstests@vger.kernel.org>; Wed, 17 Jan 2018 18:16:13 -0800 (PST)
Date: Wed, 17 Jan 2018 18:16:10 -0800
From: Omar Sandoval <osandov@osandov.com>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118021610.GA10877@vader>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118012831.GF6948@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 17, 2018 at 08:28:31PM -0500, Theodore Ts'o wrote:
> On Wed, Jan 17, 2018 at 05:09:36PM -0800, Omar Sandoval wrote:
> > Hello,
> > 
> > If I run xfstests on ext4 with a kernel with CONFIG_QFMT_V2=n, the following
> > tests fail:
> > 
> > generic/082
> > generic/219
> > generic/230
> > generic/231
> > generic/232
> > generic/233
> > generic/234
> > generic/235
> > generic/244
> > generic/270
> > generic/382
> > 
> > Would it be possible to handle this case and skip the test instead?
> 
> I'd like to ask a different question, which is there a reason to
> support CONFIG_QFMT_V1 && !CONFIG_QFMT_V2?  Maybe we should just
> always enable CONFIG_QFMT_V2, and simplify the test matrix?

FWIW,

# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set

on this kernel.
