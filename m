Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C83DC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 14:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiLMOwN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 09:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiLMOwK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 09:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FFC112A
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 06:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670943090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82JNWwEXxjDHRL26eKZ38HmQD+TF9FG6D/30GitU+L8=;
        b=K0CgIqm+tHVYIEZv1Q7BC8dzYh3pVrqxBJyUqYkEt4RCiLMf4xgeITXZAtI8Azz0dN/RRj
        QSC3uz/ZgSGHliP2IMF5igoyCUN0Kj2pDvCxRz/680PkouC7hR7PMo/5U36i9pR4t4J5cu
        2s3LRSlooFzNyousZ5QM1nDzIHQle2Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-axRtGJQkPGKU4G1IQa3pdQ-1; Tue, 13 Dec 2022 09:51:28 -0500
X-MC-Unique: axRtGJQkPGKU4G1IQa3pdQ-1
Received: by mail-pg1-f200.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so9703907pgl.8
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 06:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82JNWwEXxjDHRL26eKZ38HmQD+TF9FG6D/30GitU+L8=;
        b=4sNRu3t4RHrZNCsOGVctY7VZuEyEo3VCNLVLV9pf37l+U9nBQCVukZ26rSfV2pcDDz
         W+IhDZJ/SbPw0GF7lYUuCrZcoh8uF0EG2VBQZeQOvUVXyzRMZAckqPO9kD9fwZIIaH8+
         T55Qme8DaxXtPBoRrILLcMBGCOLc1Ep/oWqHfofJzCWuliSGQXBZnHz8PXvVCbZqNF5V
         hmHg4GNRfFZ3ujYLvm/d7xX3SXtRtUVRB6iGlPE9i/Z1FiBSVBaZLv0oYNNgz2SJcCVl
         7MgNPAIqbfkQfiU2ZwXw2tNzWwUwgpYhpAkKe3nXkUayVyDGw8LZW2mpQa63tGYaKtFQ
         lbKw==
X-Gm-Message-State: ANoB5pnhc1LoQuMSqQKI2yx3SBGrEzjsFWQT6GrCWFCDR1M9tzOgHvly
        3bhwT9YBvsIO/LV9O7YmYYxOCcfjJz5trgRiPkFbox2CC2lyqBojDs6nVFsVxzRW1qThOih9+Qi
        2xJUmQZNUNbF1GE2A2w==
X-Received: by 2002:a17:90b:35d2:b0:21a:146:13c9 with SMTP id nb18-20020a17090b35d200b0021a014613c9mr21035035pjb.36.1670943087694;
        Tue, 13 Dec 2022 06:51:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5zS1ZunffQb3viIZps6a5PcV2KmSBIZMnEYnTSQG1ghYQFrGfrHQJSYNyLEVPddPWmqbKo5g==
X-Received: by 2002:a17:90b:35d2:b0:21a:146:13c9 with SMTP id nb18-20020a17090b35d200b0021a014613c9mr21035018pjb.36.1670943087405;
        Tue, 13 Dec 2022 06:51:27 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b0021900ba8eeesm7527837pjb.2.2022.12.13.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:51:26 -0800 (PST)
Date:   Tue, 13 Dec 2022 22:51:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] check: ensure sect_stop is initialized if interrupted
Message-ID: <20221213145123.zbhzh6tvwmi22ib5@zlang-mailbox>
References: <20221212230820.3466-1-ddiss@suse.de>
 <20221212230820.3466-3-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212230820.3466-3-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 13, 2022 at 12:08:20AM +0100, David Disseldorp wrote:
> sect_stop is normally set immediately prior to calling _wrapup() via
> run_section(). However, when called via a trap signal handler,
> sect_stop may be uninitialized, leading to a negative section time
> (sect_stop - sect_start) in the xunit report. E.g.
>   Interrupted!
>   Passed all 1 tests
>   Xunit report: /home/david/xfstests/results//result.xml
>   rapido1:/# head /home/david/xfstests/results//result.xml
>   <?xml version="1.0" encoding="UTF-8"?>
>   <testsuite name="xfstests" failures="0" skipped="0" tests="1"
>    time="-1670885797" ... >
> 
> This commit uses the existing $interrupt flag to determine when
> sect_stop needs to be initialised.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---

I don't use Xunit report generally, but this change makes sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  check | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/check b/check
> index d2e51296..cb3ea155 100755
> --- a/check
> +++ b/check
> @@ -433,6 +433,7 @@ _wrapup()
>  {
>  	seq="check"
>  	check="$RESULT_BASE/check"
> +	$interrupt && sect_stop=`_wallclock`
>  
>  	if $showme && $needwrap; then
>  		if $do_report; then
> -- 
> 2.35.3
> 

