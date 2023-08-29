Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC36C83F12
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Aug 2023 03:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjH2Dt0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Aug 2023 23:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjH2DtA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Aug 2023 23:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F2185
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 20:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693280894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCiQgdOssNkYuxoY15auZhF5HquGtvORRM/8VOuLoJw=;
        b=DWNn0l666bgB3XQKMGmH8Fnv4qgDmaHC2bsLUyo8cx3vRzWYjOf0bn0O2mpdktEuBs6tvQ
        r77KWQzIjj8dGARpsMlo10ndu3IkHvQy0KOSQnwkK/+G+WyWzo7+EIhh8VxXa1DjIk/TLw
        8YnR6OTk5xemWGIWJK9/7/23s59j2b8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-wQMI_5WMOk216V6VTIhwrw-1; Mon, 28 Aug 2023 23:48:11 -0400
X-MC-Unique: wQMI_5WMOk216V6VTIhwrw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a7d402fc85so4696387b6e.3
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 20:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693280891; x=1693885691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCiQgdOssNkYuxoY15auZhF5HquGtvORRM/8VOuLoJw=;
        b=DnJUka4lx2apBarcvRow5nFj4Y8JiAmjvw++Bxrpcsa+80SDqYWsw8lqw2VWOSpaUl
         WGDsfC6Ty8uQ2aEY1BRxomXPl5ciZMOk6lzDtYruIhmZKILWQHYWLSDBOVIkCVR7bbKo
         tkzDtOM0eI45MSGGuFAhNF3e6q4z+2dBaMNK7AnZmlvpe2b6Zt+E0ZxhSNvpR0XB4tlS
         1IwJz3mwv/58ji/JKMOxfgZOQY3yRefnVTdkWpmKOotz3OdYlQZtlvIPn98eeKPdN7CN
         6hO5xmrIjCwq5ydLEerzzMgZ7Y0zSglLGPUoQce3Z+vARWvR/2QgPBhL1PaxOwlY23oM
         2RnA==
X-Gm-Message-State: AOJu0Yyr2MWpZdJ4M5to7na+NmEWTAVNEpSHl73emeEcjgUoGu7NOU6u
        INvJMb0VvJ9XWqSXNBFNCGwgaSjpvId1HZ4ckh3NYTasr0ljFiBQAxSnDq+fUC3XSLSoWmaD78Y
        czjQTosJKT+fkUOSzJA==
X-Received: by 2002:a05:6808:48e:b0:3a7:2693:3293 with SMTP id z14-20020a056808048e00b003a726933293mr13668025oid.16.1693280891157;
        Mon, 28 Aug 2023 20:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnrMvYlOtyHSFyDpA9HFinp7M8I50bh00vcT/C62xyjK9gJ1h6haM25oFChKUB+IATX1XHjQ==
X-Received: by 2002:a05:6808:48e:b0:3a7:2693:3293 with SMTP id z14-20020a056808048e00b003a726933293mr13668020oid.16.1693280890916;
        Mon, 28 Aug 2023 20:48:10 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m6-20020aa78a06000000b0068a414858bdsm7434952pfa.118.2023.08.28.20.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 20:48:10 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:48:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] aio-dio-write-verify: print more info on the error
 case
Message-ID: <20230829034807.mwxmtbyvewtencvd@zlang-mailbox>
References: <cover.1692688971.git.naohiro.aota@wdc.com>
 <e4d570e6f5c0e5da4824d196810fd7d56e0cc393.1692688971.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d570e6f5c0e5da4824d196810fd7d56e0cc393.1692688971.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 22, 2023 at 04:28:51PM +0900, Naohiro Aota wrote:
> When short read or corruption happened, it is difficult to locate which IO
> event failed. Print the address to make it identifiable.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/aio-dio-regress/aio-dio-write-verify.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> index 90e41b391289..dabbfacde3f8 100644
> --- a/src/aio-dio-regress/aio-dio-write-verify.c
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -267,13 +267,14 @@ static int io_verify(int fd)
>  			perror("pread");
>  			return 1;
>  		} else if (sret != p->param->buf_size) {
> -			fprintf(stderr, "short read %zd was less than %zu\n",
> -			        sret, p->param->buf_size);
> +			fprintf(stderr, "short read %zd was less than %zu at %zu\n",
> +			        sret, p->param->buf_size, p->param->offset);
>  			return 1;
>  		}
>  		if (memcmp(p->param->buf,
>  		           p->param->cmp_buf, p->param->buf_size)) {
> -			printf("Find corruption\n");
> +			printf("Find corruption at %zu length %zu\n", p->param->offset,
> +			       p->param->buf_size);
>  			dump_buffer(p->param->buf, p->param->offset,
>  			            p->param->buf_size);
>  			corrupted++;
> -- 
> 2.41.0
> 

