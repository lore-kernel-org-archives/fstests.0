Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:29592 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753272AbbFQVcD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2015 17:32:03 -0400
Date: Thu, 18 Jun 2015 07:32:00 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH V2] generic: add fiemap test that does prealloc
Message-ID: <20150617213159.GG10224@dastard>
References: <1434573149-4471-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434573149-4471-1-git-send-email-jbacik@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <jbacik@fb.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 17, 2015 at 01:32:29PM -0700, Josef Bacik wrote:
> I noticed that btrfs wasn't setting unwritten on prealloc test, and then
> subsequently noticed that we weren't testing fiemap on prealloc extents with the
> fiemap-tester.  This patch adds another test that does the same as generic/225
> only with prealloc enabled.  Thanks,
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
....
> +_require_xfs_io_command "fiemap"
> +_require_xfs_io_command "falloc"
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount > /dev/null 2>&1
> +
> +rm -f $seqres.full
> +fiemapfile=$SCRATCH_MNT/$seq.fiemap
> +
> +[ -x $here/src/fiemap-tester ] || _notrun "fiemap-tester not built"
> +
> +seed=`date +%s`
> +
> +echo "using seed $seed" >> $seqres.full
> +
> +echo "fiemap run with sync"
> +$here/src/fiemap-tester -q -S -s $seed -r 200 $fiemapfile 2>&1 | \
> +	tee -a $seqres.full
> +
> +if [ $? -ne 0 ]; then
> +	if grep -q "Operation not supported" $seqres.full; then
> +	      _notrun "FIEMAP not supported by this filesystem type: $FSTYP"
> +	fi
> +	status=$?
> +	exit
> +fi

No need for the FIEMAP not supported check - that is done by the
'+_require_xfs_io_command "fiemap"' line above and so any failure
of fiemap-tester is something that should fail the test.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
