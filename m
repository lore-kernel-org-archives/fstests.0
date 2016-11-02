Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:44993 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932778AbcKBWR7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Nov 2016 18:17:59 -0400
Date: Thu, 3 Nov 2016 09:17:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: add CephFS support
Message-ID: <20161102221755.GH14023@dastard>
References: <20161102090054.6394-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102090054.6394-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, Joao Eduardo Luis <joao@suse.de>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 02, 2016 at 10:00:54AM +0100, David Disseldorp wrote:
> From: Joao Eduardo Luis <joao@suse.de>
> 
> Add basic CephFS support. No new CephFS specific tests are included,
> just basic enablement, with ./check now accepting a -ceph parameter.

We don't add command line parameters to specify the filesystem
anymore if we can avoid it (they are legacy options, really).
Specifying FSTYP=ceph in the environment or config file should be
sufficient to do they right thing - does this work for ceph?

> @@ -1499,6 +1508,15 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> +        ceph)
> +		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
> +		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_DEV"
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;

This is the same check as for nfs*). Can you make those common?

>  	cifs)
>  		echo $SCRATCH_DEV | grep -q "//" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> @@ -1584,6 +1602,15 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	ceph)
> +		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
> +		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ]; then
> +		     _notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;

Same.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
