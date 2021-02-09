Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158BAC433E6
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Feb 2021 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36BF64EC2
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Feb 2021 17:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhBIRVK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232912AbhBIRVJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Feb 2021 12:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612891182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Du/0LAh9FYcka8ZiR551NwsAnsx+ZkD2c7BpFYFEShA=;
        b=c5vkLcokZpZmNNnJcR3Xzm+Bs0SVUHYkP1uXeFBdM2RTgvMnoU2FGmO9Z/M4l5hOUpIBbv
        5c3cZCjDV0grGr+eKNh9ER2uMjy7D5QrfGFnnqvcApLSPBMfOxoozICy1MlweLZBPZhvba
        CdbOsNdrifM2hqBqbWl9h92CuoG4diM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-SS70BfMxO6OnCOo3jKNm6Q-1; Tue, 09 Feb 2021 12:19:38 -0500
X-MC-Unique: SS70BfMxO6OnCOo3jKNm6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0327CAFA80;
        Tue,  9 Feb 2021 17:19:37 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7121260C04;
        Tue,  9 Feb 2021 17:19:36 +0000 (UTC)
Date:   Wed, 10 Feb 2021 01:36:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Sterba <dsterba@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] src/splice-test.c: use memalign instead of aligned_alloc
Message-ID: <20210209173656.GK14354@localhost.localdomain>
Mail-Followup-To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
References: <20210209155715.28804-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209155715.28804-1-dsterba@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 09, 2021 at 04:57:15PM +0100, David Sterba wrote:
> The build fails on SLE11 as the function aligned_alloc is not available
> there. Replace it by memalign that has the same semantics and is
> commonly used in fstests code base. aligned_alloc has additional
> requirements on the alignment and buffer size but that is ok as the
> buffer is defined in multiples of the alignment.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---

The manpage said:

  aligned_alloc(): _ISOC11_SOURCE

  The functions memalign(), valloc(), and pvalloc() have been available in all Linux libc libraries.                                                                                     
  The function aligned_alloc() was added to glibc in version 2.16.

So looks like aligned_alloc might not be supported on some old system. As the
change of this patch won't change the original testing, so it's good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/splice-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/splice-test.c b/src/splice-test.c
> index 11fb11fa8cc3..2f1ba2baaff0 100644
> --- a/src/splice-test.c
> +++ b/src/splice-test.c
> @@ -17,6 +17,7 @@
>  #include <stdbool.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <malloc.h>
>  
>  #define SECTOR_SIZE 512
>  #define BUFFER_SIZE (150 * SECTOR_SIZE)
> @@ -143,9 +144,9 @@ int main(int argc, char *argv[])
>  		   do_splice == do_splice1 ? "sequential" : "concurrent",
>  		   (open_flags & O_DIRECT) ? "with" : "without");
>  
> -	buffer = aligned_alloc(SECTOR_SIZE, BUFFER_SIZE);
> +	buffer = memalign(SECTOR_SIZE, BUFFER_SIZE);
>  	if (buffer == NULL)
> -		err(1, "aligned_alloc");
> +		err(1, "memalign");
>  
>  	fd = open(filename, open_flags, 0666);
>  	if (fd == -1)
> -- 
> 2.29.2
> 

