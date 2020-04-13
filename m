Return-Path: <SRS0=mI6p=55=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0341CC2BA19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Apr 2020 11:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B3C2072C
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Apr 2020 11:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5gjOkqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgDMLAd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:00:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20157 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728295AbgDMLAc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Apr 2020 07:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586775631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdWNrsdHzAAIn2lJ7TH7RKbjKtUag1Er7hXLe54R4Xs=;
        b=d5gjOkqIBIA4UgHshU7FHQpy+g+HSHnP+aYKDRnePR3d8Le7oVe9ozLoZVpNeSmZ5RPzu4
        qW8vT1p0wmCyqBt0SeNGIHDrZpIR0E8r4cCuFle/4RqNr/zgutTE+miyv6dCAdSdyA1w+i
        ijYAVBwYqO60XgHEitqhGo+n30PnZ14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-e4HUpl4UORSxyjaytE5oyg-1; Mon, 13 Apr 2020 07:00:29 -0400
X-MC-Unique: e4HUpl4UORSxyjaytE5oyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 728C518B9F80
        for <fstests@vger.kernel.org>; Mon, 13 Apr 2020 11:00:28 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D95695E001
        for <fstests@vger.kernel.org>; Mon, 13 Apr 2020 11:00:27 +0000 (UTC)
Date:   Mon, 13 Apr 2020 19:12:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: assign a few tests to additional groups
Message-ID: <20200413111238.GY14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <20200413072449.14268-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413072449.14268-1-vladimir@tuxera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 13, 2020 at 10:24:49AM +0300, Vladimir Zapolskiy wrote:
> The rationale behind the proposed changes is to correct and improve
> granularity of some generic tests, so it becomes possible to control
> lists of run tests better, if there is given additional information
> about a test environment and tested filesystems.
> 
> * generic/459 test is added to freeze group
> * generic/482 test is added to thin group
> * generic/529 test is added to acl group
> * generic/530 test is added to shutdown group
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
> ---
> Changes from v1 to v2:
> * squashed the changes into one as asked by Eryu Guan

Looks good to me.
Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> tests/generic/group | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 99d06c9ad945..718575baeef9 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -461,7 +461,7 @@
>  456 auto quick metadata collapse zero prealloc
>  457 auto log replay clone
>  458 auto quick clone collapse zero
> -459 auto thin
> +459 auto freeze thin
>  460 auto quick rw
>  461 auto shutdown stress
>  462 auto quick dax
> @@ -484,7 +484,7 @@
>  479 auto quick metadata log
>  480 auto quick metadata log
>  481 auto quick log metadata
> -482 auto metadata replay
> +482 auto metadata replay thin
>  483 auto quick log metadata
>  485 auto quick insert
>  486 auto quick attr
> @@ -530,8 +530,8 @@
>  526 auto quick log
>  527 auto quick log
>  528 auto quick
> -529 auto quick attr
> -530 auto quick unlink
> +529 auto quick acl attr
> +530 auto quick shutdown unlink
>  531 auto quick unlink
>  532 auto quick
>  533 auto quick attr
> -- 
> 2.25.1
> 

