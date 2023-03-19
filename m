Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F3AC6FD1F
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Mar 2023 06:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCSGcO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCSGcM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Mar 2023 02:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8426F1E5FC
        for <fstests@vger.kernel.org>; Sat, 18 Mar 2023 23:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679207489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgNqSeAnkD8xehBPecL0biGOWA/e3DxTPtpv2Ygur/Y=;
        b=ODR8HxASIgqD4X8x78BKftCr1PnSDDsjg+m3XEnjEyppAoLaXvp20z+OeZBJF3QDedvfQW
        rBdDW77SI6K2QNk+7RoTd11aG/RtA+JYx203myoLnGvMrmg8AadaY4sEl5y6CC7xGOjKMM
        HvH2Xkh9bJ0u16lVUyY3FwNNR4E2csU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-gfVBZO_fMrWCMycH0_q7Sw-1; Sun, 19 Mar 2023 02:31:28 -0400
X-MC-Unique: gfVBZO_fMrWCMycH0_q7Sw-1
Received: by mail-pf1-f198.google.com with SMTP id 16-20020a056a00073000b006260bbaa3a4so3829087pfm.16
        for <fstests@vger.kernel.org>; Sat, 18 Mar 2023 23:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgNqSeAnkD8xehBPecL0biGOWA/e3DxTPtpv2Ygur/Y=;
        b=6LEUbdXgvuIgtjgNh0YQGWiqaIGIxJEmhRsAkngIu9bmijdRkKW8LWtsVjdudHld9s
         0l+rxiI/AJPpB94q4lzD/jzuURDS6g3Lnvq5470Zj9hHeRGrCT4+BodUBWUvYOnCPR3q
         wAPh1s2vSPUMDmX8fbRFkJ79Z40wBTYkypoN81d0P+fJfQIXosrPa87aOXcPWtB5mkse
         As0akrlbpuGcXUUOH8BG5VZS+6bryS67mpr6dM3RT5iRrcfiXvoQe+c4/aTT6NYtL9t5
         tKrH94tPs+Kgzz5/Sc4mgvUtDFUuSeAC7bHkNwbXii6GBCh/63J78izNWOTwpJ496OCQ
         D7RQ==
X-Gm-Message-State: AO0yUKVjhA/26TnzFGGQiMO29ee4MZlLestDq7IlSa+4ttG3JRZFk/fy
        6SxNCFDWUuk0sPHQjqwXfpl8utaIMCVBnZKtdh1rbh0ElXrwT6KWK8oWDdRk13kJup9rvlpPOIl
        ufghEyybsZhIXY6XtDGKk2rdKt+pC++SeDYT00mGkI/MIWNYRtWSYAvFLdpxebCa6dZeX/+AvjD
        CgAQ==
X-Received: by 2002:a17:90b:4f8f:b0:23d:3264:16bf with SMTP id qe15-20020a17090b4f8f00b0023d326416bfmr8913358pjb.0.1679207486326;
        Sat, 18 Mar 2023 23:31:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set94uc4iv61YoA1d4TWU2d7GFhycEo2ecSc2LC2X95ErJvVMSDZOiBFni0EyDMGzcYYBhOWCbA==
X-Received: by 2002:a17:90b:4f8f:b0:23d:3264:16bf with SMTP id qe15-20020a17090b4f8f00b0023d326416bfmr8913341pjb.0.1679207485956;
        Sat, 18 Mar 2023 23:31:25 -0700 (PDT)
Received: from [10.72.12.59] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090ac68400b0023d1b9e17e2sm3819968pjt.31.2023.03.18.23.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 23:31:25 -0700 (PDT)
Message-ID: <c16a822c-1237-118b-ec3d-adf64289a7a5@redhat.com>
Date:   Sun, 19 Mar 2023 14:31:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] generic/075: no need to move the .fsxlog to the same
 directory
Content-Language: en-US
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, djwong@kernel.org, ceph-devel@vger.kernel.org,
        vshankar@redhat.com, zlang@redhat.com
References: <20230301020730.92354-1-xiubli@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230301020730.92354-1-xiubli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ping.

What's the status of this patch ?

Thanks

- Xiubo


On 01/03/2023 10:07, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> Actually it was trying to move the '075.$_n.fsxlog' from results
> directory to the same results directory.
>
> Fixes: https://tracker.ceph.com/issues/58834
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>   tests/generic/075 | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/tests/generic/075 b/tests/generic/075
> index 9f24ad41..03a394a6 100755
> --- a/tests/generic/075
> +++ b/tests/generic/075
> @@ -57,7 +57,6 @@ _do_test()
>       then
>   	echo "    fsx ($_param) failed, $? - compare $seqres.$_n.{good,bad,fsxlog}"
>   	mv $out/$seq.$_n $seqres.$_n.full
> -	mv "$RESULT_DIR"/$seq.$_n.fsxlog $seqres.$_n.fsxlog
>   	od -xAx $seqres.$_n.full > $seqres.$_n.bad
>   	od -xAx "$RESULT_DIR"/$seq.$_n.fsxgood > $seqres.$_n.good
>   	rm -f "$RESULT_DIR"/$seq.$_n.fsxgood

-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

