Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:55451 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751043AbcF2GWJ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2016 02:22:09 -0400
Date: Wed, 29 Jun 2016 16:15:29 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic/294: filter quotes from mknod
Message-ID: <20160629061529.GT27480@dastard>
References: <1467032008-16374-1-git-send-email-omzg@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467032008-16374-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 27, 2016 at 03:53:28PM +0300, Omer Zilberberg wrote:
> Since coreutils v8.25, mknod errors omit quotes around filenames, and
> this breaks generic/294's golden image.
> 
> Checked on Ubuntu 16.04.
> 
> See coreutils: 08e8fd7 all: avoid quoting file names when possible
> https://github.com/coreutils/coreutils/commit/08e8fd7e38f2dae7c69c54eb22d508b6517e66e5
> 
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
> 
> v2: added comment to _filter_mknod.
> ---
>  common/filter         | 7 +++++++
>  tests/generic/294     | 2 +-
>  tests/generic/294.out | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)

$ git grep -l mknod common/ tests/
common/dmflakey
common/populate
tests/btrfs/004
tests/generic/062
tests/generic/085
tests/generic/117
tests/generic/157
tests/generic/158
tests/generic/184
tests/generic/294
tests/generic/294.out
tests/generic/306
tests/overlay/003
tests/xfs/106
$

Do any of these other tests that call mknod need this filtering?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
