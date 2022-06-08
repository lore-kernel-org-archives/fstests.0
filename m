Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFFFCCA47B
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jun 2022 09:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiFHJ02 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiFHJZs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Jun 2022 05:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A00665F4F
        for <fstests@vger.kernel.org>; Wed,  8 Jun 2022 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654678267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dym9EftdGoVl7OEi571aoVb6AKAy7646sBQwCzRA1Q=;
        b=HHZMObVMSSBq6XEQGE7X/mG3itJgd/AaDNJRrGsMwFp0N3N6idqsvnV8p6hxB88HhlpUeZ
        q2TAUcOcdc8UvSGZKNOxuw9hLhxPLl2EKQRsVNAVP2SVSJW8POroPY7gC8FGpPz4bs0fO1
        +L/Jm7+9Bj2il/8OiDz9VlRSL0Rk8Yw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-FtyD-vU6O0yZwxB_Y-Yrbg-1; Wed, 08 Jun 2022 04:51:06 -0400
X-MC-Unique: FtyD-vU6O0yZwxB_Y-Yrbg-1
Received: by mail-pf1-f199.google.com with SMTP id x11-20020aa79acb000000b0051b9d3136fdso10627544pfp.1
        for <fstests@vger.kernel.org>; Wed, 08 Jun 2022 01:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8dym9EftdGoVl7OEi571aoVb6AKAy7646sBQwCzRA1Q=;
        b=nH5ADaKh/MPDkSUW1vLMVvXcl3v2NiP5+T+sX494c4c+7PNB2gmAZ1TEulqtG07V5b
         HIJmo72c1mDO1mTM0ZINR+8Bnqi1Uxo0oqwKAagrkq1E2JVkY53GCRyPp7ZAIPJ+j+1R
         95O/CHJoplhLMHIzy15aEn1lBSiue3fwn3z0ScAnREsg0DCf8SlarV9qQj00uXGb+7fE
         8jedzt2pbIq4DDNRTEbY43gOTH2cA1+yR4QgSJIvvs6MQAjBPCJsRy4yIp11UHkLJguw
         UL1hMgDJAzdEQv3xT7opzJb9o/Q0AZVaUQfMTN+q86NwOzU9mzbVXJORQwzunHseBqn7
         TcZg==
X-Gm-Message-State: AOAM5311ld2Cscel+1N8or+tU/ZFNoNPFxkI9IYla7/DBHQWjWquYpXB
        vBpAUYZH3q63yQ5y2aoY1Nv1IIoAQhe3RIi7/nGasssQecKZITx7TTfF+eBEHpp/cu/YnnisV7U
        FrQNColK8VB/+9VHEvQ==
X-Received: by 2002:a17:902:7884:b0:167:4d5b:7a2f with SMTP id q4-20020a170902788400b001674d5b7a2fmr25777658pll.18.1654678265416;
        Wed, 08 Jun 2022 01:51:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo4c1UCwpEO/e8Etgde4xDUTc27MdW+5+/TzajzYSjrZdrUco1wv6ysIEUSUwQLl1eOpuRmg==
X-Received: by 2002:a17:902:7884:b0:167:4d5b:7a2f with SMTP id q4-20020a170902788400b001674d5b7a2fmr25777640pll.18.1654678265160;
        Wed, 08 Jun 2022 01:51:05 -0700 (PDT)
Received: from [10.72.12.54] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b0016363b15acasm14193827plb.112.2022.06.08.01.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:51:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] src/attr_replace_test: dynamically adjust the max
 xattr size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        fstests@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
References: <20220607151513.26347-1-lhenriques@suse.de>
 <20220607151513.26347-3-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <eff21787-0981-f779-fce8-925c26105c96@redhat.com>
Date:   Wed, 8 Jun 2022 16:50:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220607151513.26347-3-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 6/7/22 11:15 PM, Luís Henriques wrote:
> CephFS doesn't had a maximum xattr size.  Instead, it imposes a maximum
> size for the full set of an inode's xattrs names+values, which by default
> is 64K but it can be changed by a cluster admin.
>
> Test generic/486 started to fail after fixing a ceph bug where this limit
> wasn't being imposed.  Adjust dynamically the size of the xattr being set
> if the error returned is -ENOSPC.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   src/attr_replace_test.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index cca8dcf8ff60..de18e643f469 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -62,7 +62,10 @@ int main(int argc, char *argv[])
>   
>   	/* Then, replace it with bigger one, forcing short form to leaf conversion. */
>   	memset(value, '1', size);
> -	ret = fsetxattr(fd, name, value, size, XATTR_REPLACE);
> +	do {
> +		ret = fsetxattr(fd, name, value, size, XATTR_REPLACE);
> +		size -= 256;
> +	} while ((ret < 0) && (errno == ENOSPC) && (size > 0));
>   	if (ret < 0) die();
>   	close(fd);
>   

And also here, we shouldn't worry about users will change the default 
value, and we can just assume that users should test it with default value.

I am afraid this won't test real bug of the related code then.

Or as I mentioned in another thread, add one ioctl cmd to get the value ?

