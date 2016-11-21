Received: from mail-pg0-f42.google.com ([74.125.83.42]:34003 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753739AbcKUTZW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Nov 2016 14:25:22 -0500
Received: by mail-pg0-f42.google.com with SMTP id x23so130602429pgx.1
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2016 11:25:22 -0800 (PST)
Date: Mon, 21 Nov 2016 11:25:19 -0800
From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 4/4] generic: test locking when setting encryption policy
Message-ID: <20161121192519.GE30672@google.com>
References: <1479412027-34416-1-git-send-email-ebiggers@google.com>
 <1479412027-34416-5-git-send-email-ebiggers@google.com>
 <20161120223536.GL28177@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161120223536.GL28177@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 21, 2016 at 09:35:36AM +1100, Dave Chinner wrote:
> On Thu, Nov 17, 2016 at 11:47:07AM -0800, Eric Biggers wrote:
> > This test tries to reproduce (with a moderate chance of success on ext4)
> > a race condition where a file could be created in a directory
> > concurrently to an encryption policy being set on that directory,
> > causing the directory to become corrupted.
> 
> Why can't this be done with shell loops rather than requiring a
> helper application?
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

That's what I tried originally, but the race was too difficult to hit with the
overhead of execing a program for every mkdir and ioctl syscall.

Eric
