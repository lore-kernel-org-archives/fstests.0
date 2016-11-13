Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:63231 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935048AbcKMXOV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Nov 2016 18:14:21 -0500
Date: Mon, 14 Nov 2016 10:14:18 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: fix $tmp path in tests
Message-ID: <20161113231418.GL28922@dastard>
References: <1478976041-2006-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478976041-2006-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Nov 13, 2016 at 02:40:41AM +0800, Eryu Guan wrote:
> Some tests use "tmp/$$" as $tmp, and this would result in ENOENT
> failure if $tmp is referenced in helpers or tests, because we have
> no "tmp" dir in pwd.
> 
> Fix them to use "/tmp/$$" as all other tests do.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
