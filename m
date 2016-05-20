Received: from mx1.redhat.com ([209.132.183.28]:35758 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066AbcETOlz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 May 2016 10:41:55 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FB617DCFA
	for <fstests@vger.kernel.org>; Fri, 20 May 2016 14:41:54 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] exclude dmerror tests with mount -o dax
References: <b8729f80-6d09-6c57-1fb7-4303558fc9a3@redhat.com>
Date: Fri, 20 May 2016 10:41:53 -0400
In-Reply-To: <b8729f80-6d09-6c57-1fb7-4303558fc9a3@redhat.com> (Eric Sandeen's
	message of "Thu, 19 May 2016 16:12:22 -0500")
Message-ID: <x49mvnkzt8u.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Eric Sandeen <sandeen@redhat.com> writes:

> Same as we do for dm flakey.  dm can't do dax.
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

We'll add support eventually, but for now this makes sense.

Acked-by: Jeff Moyer <jmoyer@redhat.com>

-Jeff

> ---
>
> diff --git a/common/dmerror b/common/dmerror
> index 004530d..42c075e 100644
> --- a/common/dmerror
> +++ b/common/dmerror
> @@ -18,6 +18,11 @@
>  #
>  # common functions for setting up and tearing down a dmerror device
>  
> +echo $MOUNT_OPTIONS | grep -q dax
> +if [ $? -eq 0 ]; then
> +	_notrun "Cannot run tests with DAX on dmerror devices"
> +fi
> +
>  _dmerror_init()
>  {
>  	local dm_backing_dev=$SCRATCH_DEV
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
