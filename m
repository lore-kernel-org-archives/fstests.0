Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:37437 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753419AbcKTWfj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Nov 2016 17:35:39 -0500
Date: Mon, 21 Nov 2016 09:35:36 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 4/4] generic: test locking when setting encryption policy
Message-ID: <20161120223536.GL28177@dastard>
References: <1479412027-34416-1-git-send-email-ebiggers@google.com>
 <1479412027-34416-5-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479412027-34416-5-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 17, 2016 at 11:47:07AM -0800, Eric Biggers wrote:
> This test tries to reproduce (with a moderate chance of success on ext4)
> a race condition where a file could be created in a directory
> concurrently to an encryption policy being set on that directory,
> causing the directory to become corrupted.

Why can't this be done with shell loops rather than requiring a
helper application?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
