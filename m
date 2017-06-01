Received: from mail-pf0-f177.google.com ([209.85.192.177]:34334 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdFAD3H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 May 2017 23:29:07 -0400
Received: by mail-pf0-f177.google.com with SMTP id 9so25001294pfj.1
        for <fstests@vger.kernel.org>; Wed, 31 May 2017 20:29:07 -0700 (PDT)
Date: Wed, 31 May 2017 20:29:04 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH 0/6] xfstests: remove most IRIX-specific code
Message-ID: <20170601032904.GA1083@zzz>
References: <20170531223655.130613-1-ebiggers3@gmail.com>
 <20170601031235.GV23805@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170601031235.GV23805@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 01, 2017 at 11:12:35AM +0800, Eryu Guan wrote:
> On Wed, May 31, 2017 at 03:36:49PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > For some time xfstests has de facto not supported IRIX anymore.  The
> > final release of IRIX was over 10 years ago and it seems no one has
> > been running the latest xfstests releases on any IRIX system, as at
> > the very least xfstests now assumes the existence of some util-linux
> > binaries.  There are probably other examples of this bitrot too.
> > 
> > Therefore, this patchset simplifies things removing IRIX support from
> > the xfstests tests, build system, and documentation.
> > 
> > It focuses on making larger, more obvious cleanups.  Of course,
> > there's more to do if people want to spend more time going through
> > some of the more intricate details, especially XFS-specific details.
> > But this should be a good start.
> 
> Thanks a lot for doing this!! I didn't see patch #2 and #3 hit the list
> (too big for the list?). Do you have a public git repo that I can pull
> from?
> 

Ick, I guess the size limit must be 100K.  I've pushed the series out to
repository https://github.com/ebiggers/xfstests, branch "remove_irix_support".

Note that the two biggest patches can be more easily reviewed with
'git diff -D', since that abbreviates the file deletions.

Eric
