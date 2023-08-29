Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D07C83F12
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Aug 2023 03:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjH2DxR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Aug 2023 23:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjH2Dw7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Aug 2023 23:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7605D132
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 20:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693281132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzOfmiVagjEJSH2y8vqznJ5vm8As375Kt17rqGJ3tKw=;
        b=Vx2zfFN87zlOlY/Nx8mrMhsX4meG0v3xuEm1exV2OvRE155+Au/lZKehJ+wMpST87LmNl8
        0g4MaZMtCyjFs0WdH8TWrzhi6n/4NI38dfVDOMvTO2AJHrLLBLZPWukPirSxZW85XoXACQ
        QGbwH4P3taSfs0joRor8DHfvnysjDXw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-A4txemmDOtiw_lsUdFOuqQ-1; Mon, 28 Aug 2023 23:52:11 -0400
X-MC-Unique: A4txemmDOtiw_lsUdFOuqQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f3fce5b45so4602323a91.3
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 20:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693281129; x=1693885929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzOfmiVagjEJSH2y8vqznJ5vm8As375Kt17rqGJ3tKw=;
        b=Et+S2ojwDlT++Yjlu39jEYIwNG6R0/qC/41rB6dQyr2rcHt7lUgas7S1pJrP2Mc6SM
         WXvq4NODPZOKlm8mWJACadIsCKh9ax6VtM6YgQmd5jJBCQHK4Pqe8toAzpTSUkFfiWVf
         uJwGfglWMSWjUkIYGdSe7r3CmygZlnVImXu+Z6z662UbOn266aeOWcML7WOgqjHTGm5g
         lg262LXRm05LGzp8+GYgpaNH4Ls9694EUeg9jvKZYl9WdCCElRtWsLO3cjfaVze+Hnjl
         bWde5byuGAJXLBCf7zH7ICgd4EDU4PwxhuvQ1H4ohDdfBo/wVF9U54PI+2SyAk0rx7P/
         rqyg==
X-Gm-Message-State: AOJu0YwyMTWNY8/FxOrqVpALFYYGl5hw5dQ+d3qFgUcE4DX4FBy0Tl/5
        q3wxGCtu99h7GVjWA50uRWvXUjlEiIRUuucKF0kyuwmPB4RkGHzxbXTb9C2FBkQa6U1kgTq3Aq8
        oKx6UIpcnDP/8dAgW3RMMzuRVcNY2
X-Received: by 2002:a17:90b:381:b0:268:a5f6:2a97 with SMTP id ga1-20020a17090b038100b00268a5f62a97mr26084051pjb.1.1693281129567;
        Mon, 28 Aug 2023 20:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE31CfeWlr8efjsWpWQt/Z5XH0aTse1CmTYmOFC5RADCTVgBzJ73UMKbn/5Je9nSo5GLq4B/w==
X-Received: by 2002:a17:90b:381:b0:268:a5f6:2a97 with SMTP id ga1-20020a17090b038100b00268a5f62a97mr26084046pjb.1.1693281129293;
        Mon, 28 Aug 2023 20:52:09 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a74c900b0026b420ae167sm9563242pjl.17.2023.08.28.20.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 20:52:08 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:52:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] generic/551: bail out test if aio-dio-write-verify
 failed
Message-ID: <20230829035206.f4bh5rma7tjpsbba@zlang-mailbox>
References: <cover.1692688971.git.naohiro.aota@wdc.com>
 <5054cad7e003bfc51bcc3ecd7ba39e389375a6f5.1692688971.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5054cad7e003bfc51bcc3ecd7ba39e389375a6f5.1692688971.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 22, 2023 at 04:28:52PM +0900, Naohiro Aota wrote:
> When the AIO program failed, it is better to bail out the test to keep the
> failed state intact.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/551 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/551 b/tests/generic/551
> index 2689270aa3dd..58c7f9a516c7 100755
> --- a/tests/generic/551
> +++ b/tests/generic/551
> @@ -56,16 +56,18 @@ do_test()
>  	truncsize=$(((RANDOM * diosize + RANDOM % diosize) % max_io_size_b))
>  
>  	$AIO_TEST -t $truncsize $oper_list $localfile
> -	if [ $? -ne 0 ];then
> +	ret=$?
> +	if [ $ret -ne 0 ];then
>  		echo "$AIO_TEST -t $truncsize $oper_list $localfile"
>  		echo "==========^^ Fail ^^=========="
>  	fi
> +	return $ret
>  }
>  
>  testimes=$((LOAD_FACTOR * 100))
>  while [ $testimes -gt 0 ]; do
>  	echo > $localfile
> -	do_test
> +	do_test || break
>  	((testimes--))
>  done
>  
> -- 
> 2.41.0
> 

