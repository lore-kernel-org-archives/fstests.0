Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:27991 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755529AbbIUBTy (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 20 Sep 2015 21:19:54 -0400
Date: Mon, 21 Sep 2015 11:19:50 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: Add test of rename
Message-ID: <20150921011950.GK26895@dastard>
References: <1440495730-14093-1-git-send-email-jack@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440495730-14093-1-git-send-email-jack@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 25, 2015 at 11:42:10AM +0200, Jan Kara wrote:
> Test renaming of various entry types in directories of various sizes.
> Check that filesystem didn't get corrupted.
> 
> Signed-off-by: Jan Kara <jack@suse.com>
> ---
>  tests/generic/326   | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/group |  1 +
>  2 files changed, 94 insertions(+)
>  create mode 100755 tests/generic/326

Missing an output file. I'll fix it on commit.

> +if _check_scratch_fs; then
> +	_echofull "Scratch fs is fine after renames"
> +	status=0
> +fi

This happens automatically now as a result of _require_scratch being
called, so I'll remove it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
