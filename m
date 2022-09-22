Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D4EC54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 15:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiIVPFL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVPFK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 11:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A772EF8
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663859108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2EWYN8RCmBpx6YpDTfr+NPjJSsxw5E/QLxOXveMvTU=;
        b=W3Vfi4lIU0F5rOkPZbsr/CX6qQtN4tttM7mk2goSeXvF42yshtxQIvndDt25/rEUar486N
        bOmn5fwjDbOFF21I99o8ECRe96VtebePHCNTEqg5IeGbiEJ43jjsyZ32j6YDNUUcrAVNX1
        Vs3MKbMtPHoi9cIef5+pURaeiD/rqV4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-145-FHqlFufmMO6JceIzoNexgw-1; Thu, 22 Sep 2022 11:05:07 -0400
X-MC-Unique: FHqlFufmMO6JceIzoNexgw-1
Received: by mail-qk1-f200.google.com with SMTP id br14-20020a05620a460e00b006cec4af5a2fso6785824qkb.2
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 08:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S2EWYN8RCmBpx6YpDTfr+NPjJSsxw5E/QLxOXveMvTU=;
        b=2RaMSIqN4hpfMmN1RdTG7q1d9qN299HosZkj5zFG4+ohJCf4xiW7y9tNpdBKukRc4z
         on2nZEfc5i27nPJvGP0t5FjnCDTEi+u5UKYt5/cp4NyBbxL+R6Eekl3/8BcQ+6gy775M
         Q7wStS5yodAwdb2hb/7/iKFCMTKXPFfvmQjynY+9INgFiNGMaVR6/5DfhRwhJYd0q7sy
         /U54AAS+oJPNxHoNqYyQvzI5vx4T3IctCLzXbyeANA3YxpJcLw+bWE+AM7O09WKtc8yF
         HijWI4/EmNYBapQNn4X6kwh0KZpuGZWqET/Qafz0Dt5UznKmuVhE6uOwikSzIKC1L9pI
         OTdw==
X-Gm-Message-State: ACrzQf1ldF1xeq3c5b4xS3whj4iRXEwVbUMsqsViXouaEjA3557SOAXU
        4HjMYKPjvs1AljddXKtke45VDC4Q5JwGEZWoP9ZeqxOZbRcjHomxSIOAHia8C7eNUlM+9BSMqyh
        AQdPCNU9nh+KTKZwjKw==
X-Received: by 2002:a05:6214:29e8:b0:4ad:8cb6:9d39 with SMTP id jv8-20020a05621429e800b004ad8cb69d39mr991047qvb.20.1663859095448;
        Thu, 22 Sep 2022 08:04:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7g3TlHmTM7vnEqoekai3YBBILK3wk7Mv/N0voF4NoUqo56lYKVV060+Np/2Kb8RH8dzd2CAQ==
X-Received: by 2002:a05:6214:29e8:b0:4ad:8cb6:9d39 with SMTP id jv8-20020a05621429e800b004ad8cb69d39mr991024qvb.20.1663859095207;
        Thu, 22 Sep 2022 08:04:55 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v19-20020a05620a441300b006b945519488sm3917451qkp.88.2022.09.22.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:04:54 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:04:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] g/394: clean up test files
Message-ID: <20220922150450.t7k5gvtornayjqvy@zlang-mailbox>
References: <20220922134822.1020119-1-preichl@redhat.com>
 <20220922134822.1020119-4-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922134822.1020119-4-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 03:48:22PM +0200, Pavel Reichl wrote:
> Clean up test files taking space.
> 
> -rwxr-xr-x. 1 root root 1.0G Sep 22 14:58 394.1183899
> -rwxr-xr-x. 1 root root 1.0G Sep 22 14:58 394.1183899-1
> -rwxr-xr-x. 1 root root    0 sep 22 14:58 394.1183899+1
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/generic/394 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/394 b/tests/generic/394
> index fc03e2f3..cbc2ce13 100755
> --- a/tests/generic/394
> +++ b/tests/generic/394
> @@ -14,7 +14,7 @@ _cleanup()
>  {
>  	cd /
>  	ulimit -f unlimited
> -	rm -f $tmp.*
> +	rm -f $tmp.* $TEST_DIR/$seq.*

I think you can combine this patch with patch 1/4, due to they're for same
purpose, all due to some fs (e.g. exfat) doesn't support sparse file, so
we need to remove those large files created by truncate. If you find same
issue on other places, better to fix them in same patch.

>  }
>  
>  # Import common functions.
> -- 
> 2.37.3
> 

