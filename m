Return-Path: <SRS0=NoLx=A4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BBCC433DF
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 06:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B5B206BE
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 06:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUowpkbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgGQGJd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:09:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60407 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbgGQGJc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jul 2020 02:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594966171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ua8nI+UpEeuCpNik6ej6UlT+WbLn9w4y0bu2Z1jMlo4=;
        b=ZUowpkbpA3mduEfqM41EmAa7MTBzLA4AfMhZfXd3zfk/yiuH0KUXfngOIYe489+RRFNYf0
        gyZAgzX4CI/ModzvhLNSryORLS1a/k71oqTsHakAZeIhOGgPe/KHgJG+2VvvExa4qz+oms
        ZfC0t03jE8bEjZ4CKTE0Rqf9t40WXSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-nAdnQKJMPbyXnHCbnDBjZw-1; Fri, 17 Jul 2020 02:09:29 -0400
X-MC-Unique: nAdnQKJMPbyXnHCbnDBjZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46757800597
        for <fstests@vger.kernel.org>; Fri, 17 Jul 2020 06:09:28 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6BFD5D9E7;
        Fri, 17 Jul 2020 06:09:27 +0000 (UTC)
Date:   Fri, 17 Jul 2020 14:22:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: clear WARN_ONCE state before each test
Message-ID: <20200717062222.GC1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        fstests@vger.kernel.org
References: <20200715114219.18353-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715114219.18353-1-lczerner@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 15, 2020 at 01:42:19PM +0200, Lukas Czerner wrote:
> clear WARN_ONCE state before each test to allow a potential problem
> to be reported for each test
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  check | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/check b/check
> index 2e148e57..6ba64d5d 100755
> --- a/check
> +++ b/check
> @@ -756,6 +756,11 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  			touch ${RESULT_DIR}/check_dmesg
>  		fi
>  		_try_wipe_scratch_devs > /dev/null 2>&1
> +
> +		# clear the WARN_ONCE state to allow a potential problem
> +		# to be reported for each test
> +		(echo 1 > /sys/kernel/debug/clear_warn_once) > /dev/null 2>&1

Good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
>  		if [ "$DUMP_OUTPUT" = true ]; then
>  			_run_seq 2>&1 | tee $tmp.out
>  			# Because $? would get tee's return code
> -- 
> 2.21.3
> 

