Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33FC433E0
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Jan 2021 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE29B64E02
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Jan 2021 07:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhA2HzD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232019AbhA2HzC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Jan 2021 02:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611906901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TXtl7+Gx/FUltUB8wYldP6g/qEvn96DIrjm1Pchp/BE=;
        b=jV1GpNALohrJ4wPdR3nyTAEVHovmrOxCLtMurwcCu6Hh1oX6YEkgYL/ZCzeYijFoo8XBde
        fyMke9ld8+k7pWXRxOiFLDtnoK72htm0yCwT92rwL5Xx7F32u+3RxH6EBhYj/u0VC8iFgz
        2aPTt9FeE+dPL9zYuQJ2aPzl1i88Cwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-AmInS0sYPfGHejSnr0X5_g-1; Fri, 29 Jan 2021 02:53:51 -0500
X-MC-Unique: AmInS0sYPfGHejSnr0X5_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE07A1005504
        for <fstests@vger.kernel.org>; Fri, 29 Jan 2021 07:53:50 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F7296A8FC;
        Fri, 29 Jan 2021 07:53:47 +0000 (UTC)
Date:   Fri, 29 Jan 2021 16:10:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ltp/fsstress: don't fail on io_uring ENOSYS
Message-ID: <20210129081043.GT14354@localhost.localdomain>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>,
        fstests@vger.kernel.org
References: <7a7b7128-ba62-59e1-552b-3b1fd6b1eb50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a7b7128-ba62-59e1-552b-3b1fd6b1eb50@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 28, 2021 at 03:31:40PM -0600, Eric Sandeen wrote:
> We might have URING #defined at build time, but be running on a kernel
> which does not support it.
> 
> For that reason, we should not exit with an error if 
> io_uring_queue_init() fails with ENOSYS. We can just note the lack of
> support and skip all future io_uring operations.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 22df5e38..73751935 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -35,6 +35,7 @@ io_context_t	io_ctx;
>  #include <liburing.h>
>  #define URING_ENTRIES	1
>  struct io_uring	ring;
> +bool have_io_uring;			/* to indicate runtime availability */
>  #endif
>  #include <sys/syscall.h>
>  #include <sys/xattr.h>
> @@ -706,9 +707,15 @@ int main(int argc, char **argv)
>  			}
>  #endif
>  #ifdef URING
> +			have_io_uring = true;
> +			/* If ENOSYS, just ignore uring, other errors are fatal. */

Yes, I thought about if we should do this since rhel8 kernel removed io_uring
support from kernel, but left userspace liburing. But if we do this for io_uring,
should we do the same check the others which can be disabled from kernel? Likes: AIO?

Thanks,
Zorro

>  			if (io_uring_queue_init(URING_ENTRIES, &ring, 0)) {
> -				fprintf(stderr, "io_uring_queue_init failed\n");
> -				exit(1);
> +				if (errno == ENOSYS) {
> +					have_io_uring = false;
> +				} else {
> +					fprintf(stderr, "io_uring_queue_init failed\n");
> +					exit(1);
> +				}
>  			}
>  #endif
>  			for (i = 0; !loops || (i < loops); i++)
> @@ -720,7 +727,8 @@ int main(int argc, char **argv)
>  			}
>  #endif
>  #ifdef URING
> -			io_uring_queue_exit(&ring);
> +			if (have_io_uring)
> +				io_uring_queue_exit(&ring);
>  #endif
>  			cleanup_flist();
>  			free(freq_table);
> @@ -2208,6 +2216,9 @@ do_uring_rw(int opno, long r, int flags)
>  	struct iovec	iovec;
>  	int		iswrite = (flags & (O_WRONLY | O_RDWR)) ? 1 : 0;
>  
> +	if (!have_io_uring)
> +		return;
> +
>  	init_pathname(&f);
>  	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
>  		if (v)
> 

