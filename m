Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BAFC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Oct 2022 15:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiJKPQL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJKPPf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Oct 2022 11:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A19E682
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665500694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ePp4QT4G9gQUrjdNORLtU1PN9AMtQvSC2n8c+ZT37g=;
        b=BZUdiSvTykbyVcsCB8twO3bVyfPSWV1Zv8HPYOj4gSJ+HwKAQDK/2npHcwN2PrX42G1wCN
        Q/WleUozCGSdMonDLWuhXalEUfveuOn5cSRcX/gpJiTsvI+rL8ubljeTYJ0mYdt5tyDT+l
        Qlgnfuo1IuMqJIsM0yjt/6BLU2s0pqc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-uHXh5IbiO46rhlxV4ZDTXg-1; Tue, 11 Oct 2022 11:04:52 -0400
X-MC-Unique: uHXh5IbiO46rhlxV4ZDTXg-1
Received: by mail-qv1-f70.google.com with SMTP id f10-20020ad443ea000000b004aca9fabe98so8069934qvu.18
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 08:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ePp4QT4G9gQUrjdNORLtU1PN9AMtQvSC2n8c+ZT37g=;
        b=ICAMSvUks0lCMANXGGViFbj9Cc+r7x7s57iY3SjqpRbhXqWDa3Pf264rSB9+8E1BkL
         3U2mYDxms259HaWmh/D6C0C6BEXEpYN/Dnlat+tIJATEUMAoULMiR/j9TxxVxcvkV63K
         ZJONv+PCEGLzLifCCse01HqcuUojMSpohFHEr31QYBXrCfiNRE0b7pclc2GWh/Y1pWB8
         bI6/L+n26ecryZbIgOS3jxWUseSsB9xaaUvpD/0/QQfzgvcdWxCfQ0VWlFrH3+kBg6df
         3H1YsRBbyq3qlTNv2gqgVHfnpJtn2IR3AXQeKOf5nbcSNnQARQWinEbC6DTq4gEGbiB4
         Qy9Q==
X-Gm-Message-State: ACrzQf11aKS5XfocrcDY8pAdhoR1ZynL0Lvs6Hj+BUE3ZQI/GwG5Rk+2
        Lt2d3scc2oMFa3nT0FrePnAn58GD9Ffm3JYog6UzqpvGYeDUpszMpJG3MC+wrg1GXqSuaPMGmya
        zqNIKOVl+cEkqgDpN6Q==
X-Received: by 2002:a05:622a:10e:b0:398:d464:eefa with SMTP id u14-20020a05622a010e00b00398d464eefamr11995433qtw.172.1665500691622;
        Tue, 11 Oct 2022 08:04:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6xcjgX5N2+t1Jtu8FKD5SvEwloX+NXBUdz/5whmXPCe6xtLdf8/U9NC7tjtG2s5x1mc2QB3A==
X-Received: by 2002:a05:622a:10e:b0:398:d464:eefa with SMTP id u14-20020a05622a010e00b00398d464eefamr11995403qtw.172.1665500691333;
        Tue, 11 Oct 2022 08:04:51 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x14-20020ac87a8e000000b003988b3d5280sm7001314qtr.70.2022.10.11.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:04:50 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:04:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] lsqa.pl: fix --header output
Message-ID: <20221011150447.hafluwfduvwobkxd@zlang-mailbox>
References: <20221011092340.24857-1-ddiss@suse.de>
 <20221011092340.24857-2-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011092340.24857-2-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 11, 2022 at 11:23:39AM +0200, David Disseldorp wrote:
> 7e98d41a ("fstests: move test group info to test files") replaces the
> post-header "seq" assignment with "./common/preamble\n_begin_fstest ..."
> Update lsqa.pl to recognise the "./common/preamble" line as a header
> divider.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  lsqa.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lsqa.pl b/lsqa.pl
> index 8ca1167f..63bee582 100755
> --- a/lsqa.pl
> +++ b/lsqa.pl
> @@ -99,7 +99,7 @@ sub get_qa_header($) {
>  	m/^# SPDX/i		and next; # SPDX tags
>  	m/^# Copyright/i	and next; # Copyright tags
>  	m/^#\s*\-{10}/		and last; # dashed lines
> -	m/^seq/i		and last; # test start
> +	m/^\. \.\/common\/preamble/ and last; # test start

I think that makes sense, I don't have better idea, so ..

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  	s/^# *//;
>  
> -- 
> 2.35.3
> 

