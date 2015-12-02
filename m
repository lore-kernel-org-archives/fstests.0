Received: from mx1.redhat.com ([209.132.183.28]:55931 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbbLBVlp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 2 Dec 2015 16:41:45 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] dmflakey: filter out 'dax' from mount options
References: <x49610gq180.fsf@segfault.boston.devel.redhat.com>
	<20151202200454.GR26718@dastard>
Date: Wed, 02 Dec 2015 16:41:44 -0500
In-Reply-To: <20151202200454.GR26718@dastard> (Dave Chinner's message of "Thu,
	3 Dec 2015 07:04:54 +1100")
Message-ID: <x497fkwo7dz.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> Because dm-flakey will not alow you to use DAX, there's not much
> point in running these tests if the DAX mount option is enabled.
> Hence I'd just add this to common/dm-flakey:
>
> echo $MOUNT_OPTIONS | grep -q dax
> if [ $? -ne 0 ]; then
> 	_notrun "Cannot run tests with DAX on dmflakey devices"
> fi
>
> That way we have a clear reminder that these tests do not run with
> DAX enabled and hence we are not doing crash integrity testing using
> dm-flakey on DAX devices....

Yes, that makes more sense.  Or, I guess I could add dax support to
dm-flakey.

-Jeff
