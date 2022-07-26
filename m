Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3145C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Jul 2022 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbiGZJtk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Jul 2022 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiGZJti (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Jul 2022 05:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FB6D32040
        for <fstests@vger.kernel.org>; Tue, 26 Jul 2022 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658828976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njmXR/tl6Yv4H7DqdHRc9Thiis+e3nUQsXGdK+eV/4k=;
        b=jPbx39x/0ZyALp/Dm3+d1UDn66/cBDYIsnk4plxtQy8T12knyIaon7Ze7A6PtU/DBlGcRe
        QQDrc3HASZH17+pXPX1sJdBAja4Aiv1YJZJkQ5U62Y+y/etZhUXiknXTQXjWmktro7YjWU
        Hb9Dn7qESIzTm1+i2B7Ye6uPFmvv98w=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-G-i1_csMPJiMZvZYfdD9zQ-1; Tue, 26 Jul 2022 05:49:34 -0400
X-MC-Unique: G-i1_csMPJiMZvZYfdD9zQ-1
Received: by mail-ot1-f72.google.com with SMTP id a13-20020a05683012cd00b0061c9b55da16so6982754otq.9
        for <fstests@vger.kernel.org>; Tue, 26 Jul 2022 02:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=njmXR/tl6Yv4H7DqdHRc9Thiis+e3nUQsXGdK+eV/4k=;
        b=lVSNh1+JFgkDdY6w3liBUINwr8LVoF+0gg0r7wrLrvjXPXmAPwluSsnWz+owruu//d
         LBRnrGGO5Hxg7dURllm7qybhfXNk3OVWXoo94Mkhj/OdQBt24BUdEqK2m1eKZjmLnnIv
         Y4SzD7/78sAy5tlShoCDqA3JBZm4s2hohQs2LmR8b91VQ58jhENFxOqXS5OHg29rJ6Y0
         UbPOMV1+pquq6Ws2iDZ1pD/h/8u51nyfvv1n3H5wA5Ac6jUMB7yRR5ZOL4M6n3Xmwa0D
         bU4slvrsCAJT+ny85/Z+UWOwkft+mLXSegjEmSbc4+5NMWlPNO5WZHaB92AlpcIkRx8s
         Ij0A==
X-Gm-Message-State: AJIora9pWqMW+155elUMfFsslxw4PzxzvABUWmjGUKPSSPvhiXVPt4li
        XYHmM2m+YpQ396sJpWs4JiTU5jUaEld6qPmFpNxaIWGw+pLK02pqHMn60HG7x1vvI8Rx5yE6uTj
        N27xL3QUZsN9kIpqDWQ==
X-Received: by 2002:a05:6830:3101:b0:61c:bd29:3043 with SMTP id b1-20020a056830310100b0061cbd293043mr6253372ots.125.1658828973775;
        Tue, 26 Jul 2022 02:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vpXJ9KmpFv0EvnoDdSi9zeklf33OQ9+NZAMX9Mk653AjqKPJ7c00t/uGd671E5+e08bQCp0w==
X-Received: by 2002:a05:6830:3101:b0:61c:bd29:3043 with SMTP id b1-20020a056830310100b0061cbd293043mr6253365ots.125.1658828973519;
        Tue, 26 Jul 2022 02:49:33 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x81-20020a4a4154000000b00425ce891cd8sm5794802ooa.34.2022.07.26.02.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 02:49:33 -0700 (PDT)
Date:   Tue, 26 Jul 2022 17:49:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/253: skip on zoned mode as we cannot change the
 chunk size
Message-ID: <20220726094928.ovz42mjoanhtinbe@zlang-mailbox>
References: <20220726075759.3155494-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726075759.3155494-1-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 26, 2022 at 04:57:59PM +0900, Naohiro Aota wrote:
> On zoned mode, we have a fixed chunk size which is equal to the zone size.
> So, we cannot change the chunk size, and running this test results in a
> failure with below.
> 
>     --- tests/btrfs/253.out     2021-12-10 04:33:53.000000000 +0000
>     +++ /host/results/btrfs/253.out.bad 2022-07-26 05:58:10.000000000 +0000
>     @@ -2,9 +2,16 @@
>      Capture default chunk sizes.
>      First allocation.
>      Second allocation.
>     +./common/rc: line 4670: echo: write error: Invalid argument
>     +./common/rc: line 4670: echo: write error: Invalid argument
>      Calculate request size so last memory allocation cannot be completely fullfilled.
>      Third allocation.
>     ...
> 
> It is no use to test this feature on zoned mode. So, just skip it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Make sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/253 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/btrfs/253 b/tests/btrfs/253
> index fbbb81fae754..c746f41e9264 100755
> --- a/tests/btrfs/253
> +++ b/tests/btrfs/253
> @@ -81,6 +81,8 @@ alloc_size() {
>  _supported_fs btrfs
>  _require_test
>  _require_scratch
> +# The chunk size on zoned mode is fixed to the zone size
> +_require_non_zoned_device "$SCRATCH_DEV"
>  
>  # Delete log file if it exists.
>  rm -f "${seqres}.full"
> -- 
> 2.35.1
> 

