Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF3FC433DB
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Jan 2021 09:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63D264E27
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Jan 2021 09:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhA3JGj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233742AbhA3Eqn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Jan 2021 23:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611981917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAbl87lClFQvcy6ibxl+KvHSxTXARzf6ymMThUe1Fjg=;
        b=BA8g1SDmpY/P2KFZFWtS/FNr5IDPouuELI8wotUL1kzYHd/DQ9mLXetWc7MYS0vX2j9uaM
        LgKF8Io9Rkqivjdg5+IoVsyrB4JUPuFrLwrW+IXPqht0ifcp/AGJTn4KboFmDR519XDGk6
        ICyimIB7PbcbLsrl+ERgkUuGYgcsd8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-WLm7LBSLMEuQElSDZAIHZQ-1; Fri, 29 Jan 2021 23:41:21 -0500
X-MC-Unique: WLm7LBSLMEuQElSDZAIHZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98AE4802B44;
        Sat, 30 Jan 2021 04:41:20 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BBED60BE2;
        Sat, 30 Jan 2021 04:41:19 +0000 (UTC)
Date:   Sat, 30 Jan 2021 12:58:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] src/swapon.c: initiate p to NULL
Message-ID: <20210130045817.GV14354@localhost.localdomain>
Mail-Followup-To: Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org
References: <20210128065010.218830-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128065010.218830-1-sunke32@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 28, 2021 at 02:50:10PM +0800, Sun Ke wrote:
> when run make, show:
> swapon.c:135:3: warning: 'p' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>    memcpy(p, buf, BUF_SIZE);
>       ^~~~~~~~~~~~~~~~~~~~~~~~
> fix it.

If you don't have a situation to prove this's a real bug, I guess the gcc might
think the 'p' can be used uninitialized at here when verb is TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:

        case TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:
                memcpy(p, buf, BUF_SIZE);
                break;

But from the code logic, if verb is TEST_MWRITE_BEFORE_AND_MWRITE_AFTER, the 'p'
will be initialized by:

        switch (verb) {
        case TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:
        case TEST_MWRITE_BEFORE:
                p = mmap(NULL, BUF_SIZE, PROT_WRITE | PROT_READ, MAP_SHARED,


So I think this's a fake uninitialized warning (Maybe I'm wrong. But if I'm right,
better to specify that in commit log).

Anyway, I personally don't object to initialize a pointer to NULL at beginning,
and make a build warning disappear. Leave the decision to maintainer :)


Thanks,
Zorro

> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  src/swapon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/swapon.c b/src/swapon.c
> index afaed405..fe8949a3 100644
> --- a/src/swapon.c
> +++ b/src/swapon.c
> @@ -41,7 +41,7 @@ int main(int argc, char **argv)
>  		.sa_handler	= handle_signal,
>  	};
>  	enum verbs verb = TEST_SWAPON;
> -	void *p;
> +	void *p = NULL;
>  	ssize_t sz;
>  	int fd = -1;
>  	int ret, c;
> -- 
> 2.13.6
> 

