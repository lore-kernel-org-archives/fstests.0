Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8002CC77B7A
	for <linux-fstests@archiver.kernel.org>; Tue, 23 May 2023 04:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEWERJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 May 2023 00:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEWERI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 May 2023 00:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB8FA
        for <fstests@vger.kernel.org>; Mon, 22 May 2023 21:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684815379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1gJLQtiw13JPCRzV1z2EBz29lIc5NOp9A7BGKftGyAk=;
        b=gwOE/3MIUJ168zoXE8lWHZJFcJB7SUBuYEPJ7APXzWvulj3d0CCMcxWmiMYevKYRPrWlNh
        FLzvN5XtWB/SV8bAGNSLuNo29AI5su8pdQa08hZaCt2OUNUQCB8GPF9tjKVgQUNzmbwij5
        pqIhY0w2HkAlvVB1CrLm0AdQMiRdK08=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-Ka1leGxcMWSnuo7MNZCIwQ-1; Tue, 23 May 2023 00:16:17 -0400
X-MC-Unique: Ka1leGxcMWSnuo7MNZCIwQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2534d7abebeso3504997a91.0
        for <fstests@vger.kernel.org>; Mon, 22 May 2023 21:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684815377; x=1687407377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gJLQtiw13JPCRzV1z2EBz29lIc5NOp9A7BGKftGyAk=;
        b=QeKWX1DiKMWTOefyiXbCWtLFCbltk/7WKOIpBG33CLoSUg+PSBnf8dhh0isxKNc4Gs
         L4tn4YVCBOZ0G/iEdYE4NlORmWcELUEt9ysyzJ+lonH3HFGYVzsXmLJfb2ZWS0Oi3yZd
         wiVkQSEhqpRUNxo9oKYCaJ5KsIuwcRxXTnfTjpkmO8BRkgWbOIqqDF9re9I5Z6tgzU5G
         VpCOWCb8pqusa2H8IGacGM6F300cJ3visp6u+a1kdph4ioYGGhzUTbZ1mOLCkE8KbCPV
         1ue0apSoajW0EQxPAMp//wWXEKVIFi7TZhAGAaG+rqHDU193zNI6XWk0+DVPkeZzUd+v
         77yg==
X-Gm-Message-State: AC+VfDxiqUnWWJE78IXcgqKcB3lngnywZXrC2+xcZR9NQxeSDWYKnKMA
        EZSfzOBQCRHi5NBBomMCUBu+fH1YLihFPVyfTmCx45zR8A8qKFwgD8QR4gpLP1WVZnFz+NSrr7L
        XwrEvNVenlIfnKz111A==
X-Received: by 2002:a17:903:22cf:b0:1ae:73b8:747e with SMTP id y15-20020a17090322cf00b001ae73b8747emr16565372plg.31.1684815376778;
        Mon, 22 May 2023 21:16:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YCzK1nzHELaHuUdc4abexL3uXbgmxzVDxRGPplSWScntAArizPHl7+igEHuLc893qI2+/Bw==
X-Received: by 2002:a17:903:22cf:b0:1ae:73b8:747e with SMTP id y15-20020a17090322cf00b001ae73b8747emr16565364plg.31.1684815376403;
        Mon, 22 May 2023 21:16:16 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ik1-20020a170902ab0100b001ac741dfd29sm5657133plb.295.2023.05.22.21.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 21:16:16 -0700 (PDT)
Date:   Tue, 23 May 2023 12:16:12 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fuzzy: skip online scrub and health checks if not
 supported
Message-ID: <20230523041612.cp7z3lzyxgnbsyac@zlang-mailbox>
References: <20230522212712.97846-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522212712.97846-1-ailiop@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 22, 2023 at 11:27:12PM +0200, Anthony Iliopoulos wrote:
> Commit a27e6e6f4c18 introduced xfs health checking on no-repair fuzz,
> which in turn requires scrub to be run before that. The health checks
> are done only if scrub returns with an error (which is expected as an
> indication that fuzzed metadata errors were picked up), but the code
> does not discern between xfs_scrub returning an error because of
> uncorrected metadata vs failing because the kernel does not support
> scrub at all.
> 
> This causes all tests that do fuzzing with no-repair strategy to fail on
> kernels compiled without online scrub support (CONFIG_XFS_ONLINE_SCRUB).

Great, thanks for fixing this issue!

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Skip scrub and health checks altogether, if the kernel does not support
> it, since the tests are still valuable.
> 
> Fixes: a27e6e6f4c18 ("common: check xfs health after doing an online scrub")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  common/fuzzy | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/fuzzy b/common/fuzzy
> index 4365e7343e92..a78a354142df 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -422,6 +422,12 @@ __scratch_xfs_fuzz_field_norepair() {
>  		return 1
>  	fi
>  
> +	# Skip scrub and health check if scrub is not supported
> +	if ! _supports_xfs_scrub $SCRATCH_MNT $SCRATCH_DEV; then
> +		__scratch_xfs_fuzz_unmount
> +		return 0
> +	fi
> +
>  	# Make sure online scrub will catch whatever we fuzzed
>  	__fuzz_notify "++ Detect fuzzed field (online)"
>  	_scratch_scrub -n -a 1 -e continue 2>&1
> -- 
> 2.40.0
> 

