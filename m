Return-Path: <SRS0=gg96=B4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB7EC433E1
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Aug 2020 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4060720786
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Aug 2020 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="cKeeFeKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgHRPeM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHRPeB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Aug 2020 11:34:01 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D332FC061389
        for <fstests@vger.kernel.org>; Tue, 18 Aug 2020 08:34:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so15410306qtg.4
        for <fstests@vger.kernel.org>; Tue, 18 Aug 2020 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UuPmgCC+5t/0Fxo6v6dbuZXnEeuw2yq3XgKedOCqjiU=;
        b=cKeeFeKJ6G1FhWPEs4Eb/48zcRAkynhIaJeTd/qXaqs3rPPXLBCXb/x1Vaqvu0EsvV
         TlnSEGVBz9N3N2JtLjbVxKwR2PDcjoxC8iOansVWhGVDF+rHALmxs+bRKd50AwChCp+a
         SVeIWZkA8d6Cm3kplt+ZrmT5gezacVy++iYTDmQDvR+9txdxhTChdsXy/O3Ov4hYY6F7
         e9bihM0XT53ze1vomw48YpdEgZI8azTP0Ugb7gxHSvRTiYNK+yy/Jgc6mIuB/EJ4IsWE
         Lz/wk0TRI+d9gZhWOt6Yr6BhuiZ6ksLe1sHm3XSQQolHEEud43Gl6j2Q5EYBYaaPuYOB
         CMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UuPmgCC+5t/0Fxo6v6dbuZXnEeuw2yq3XgKedOCqjiU=;
        b=Wk9duZoS6gmUflmOrclYFxZABLZm/7KrmuAXadGmg/mmA4j+rcS3xarGS43jIb6FSX
         i3CwrozDff1FpWw2ngNITVAgICP6vPtv8xARb/hxLF90rEQwu2LNK5zO6JHSKWwgQx4K
         4c2+8NSyicaFDKZYsDNqenXsf30yJqO9jn2yPs9n6dno1p0ZyY+q7mPOy9/M+W1CJ+xk
         yKcuKK3a98EyH6zlwoGXweV0WAARQUeGKNm0OvUcUtqb3fWocdwEYIww5EwwPI5d6IhH
         jymUV4RD5JOxApgJm+ICKcmJAdvZjinoqcZ56+pEC2BzxSWW8aGbQq/BCj+5VH2PCDZp
         lqsQ==
X-Gm-Message-State: AOAM530GURD43Ku8V/hT+jVjtVY8/jOmWhpKUBJpndStogNd1iSvci2P
        lFf1tIBq0zCLUGcRfS3cJG4OVg==
X-Google-Smtp-Source: ABdhPJzjPx+170fTqdIUgTDiFxlcb0//NNeqFQYttrMpjUxupsfhz7fwkvmKVSwWU762d4iqqbzCTw==
X-Received: by 2002:ac8:4511:: with SMTP id q17mr18098083qtn.117.1597764840041;
        Tue, 18 Aug 2020 08:34:00 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id i75sm21726760qke.70.2020.08.18.08.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:33:59 -0700 (PDT)
Subject: Re: [PATCH] fstests: btrfs/218 check if mount opts are applied
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200804205648.11284-1-marcos@mpdesouza.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <da689149-a332-c69e-a9a7-f63074bcb64c@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:33:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804205648.11284-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 8/4/20 4:56 PM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This new test will apply different mount points and check if they were applied
> by reading /proc/self/mounts. Almost all available btrfs options are tested
> here, leaving only device=, which is tested in btrfs/125 and space_cache, tested
> in btrfs/131.
> 
> This test does not apply any workload after the fs is mounted, just checks is
> the option was set/unset correctly.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
