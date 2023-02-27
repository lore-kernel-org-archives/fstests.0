Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785B2C64ED6
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Feb 2023 04:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjB0ER2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Feb 2023 23:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0ER1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Feb 2023 23:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6370113C6
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2023 20:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677471400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iH5lhD99crTciZ/1cWavxMhs6gi2mCL6wUGS4DiNbR0=;
        b=NRFzQvkrBt9RxeJ79tukhY6CRiGr4RoSIa82NgID+C7Cmcqsyt/6PG+HbZWNcgxs7mTbSk
        kaNMw2ayXM6yL6zHtuyU6soibTaHuE/VkZiKRUVIWzXs4hanGfL4seeFW3binvi8o25+c5
        vP54gD/UX//mj2FC9P084y3UnPiCVd8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-465-Q1ZPsq6IM1OAKH1lyp5k9A-1; Sun, 26 Feb 2023 23:16:38 -0500
X-MC-Unique: Q1ZPsq6IM1OAKH1lyp5k9A-1
Received: by mail-pj1-f69.google.com with SMTP id gm13-20020a17090b100d00b0023704a72ca5so1037775pjb.4
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2023 20:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iH5lhD99crTciZ/1cWavxMhs6gi2mCL6wUGS4DiNbR0=;
        b=3OyoS1bV/wY3buX4h6n1hlbzHxvs6oDJ3Zx5ZW58ubmdlS6GC6uLQJernlXA1MZnSH
         tGmXj6j36Fmeei2Xm55DnfgrnFgFDRcMZNA2FWFcAsz0f7R9JchkCIRXwG/rge2YrMQ1
         E5g7+tyw3m2J0iWG6yXqLoAH70hV50i+aGTp3N9YkfWvv3roiQy581Mz/I28d6r92UJ6
         SGA3wHrtqg1nfL8BMQxXLn5e+NHXzKxj9XVeDEnNeo8Li02nmJIrPYlFmW2zZB+BdVy0
         1Y2ieaKqKfBzcUgdQe4vtzWXo6e1EhJPlfXd/Mq/i3VmAx/9Bb8pzTA37g3MNVRR0tTg
         tofw==
X-Gm-Message-State: AO0yUKWWjqG9TLvv/Mv6J7m0WQMnvt/8f+RrCP2H7IzuNIVz5gWq5uSZ
        QvHt3uTdIlbpEEFyTVCcr+ulPJ1mgySj6avh/lH+piupUVp9678k5kaaUvcdV1l/+clG4kSpKol
        6/dtmqTFTDYBl8ozWHc4dKEM2/GmOG+CdqyLVgFlpd3Na7FwoF+FYX0iQZcCH4Mn6wKg9L/Za
X-Received: by 2002:a17:90b:4d8e:b0:237:b121:670b with SMTP id oj14-20020a17090b4d8e00b00237b121670bmr8805354pjb.7.1677471396582;
        Sun, 26 Feb 2023 20:16:36 -0800 (PST)
X-Google-Smtp-Source: AK7set8eodbzBVrU0yaJ49ulecqX0z7SpaZHkSXpZ8j86xsPTUYZGr+baty4w4Cytcj0/KnnxbJ+Ow==
X-Received: by 2002:a17:90b:4d8e:b0:237:b121:670b with SMTP id oj14-20020a17090b4d8e00b00237b121670bmr8805337pjb.7.1677471396225;
        Sun, 26 Feb 2023 20:16:36 -0800 (PST)
Received: from [10.72.12.143] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090a660c00b002343e59709asm5041396pjj.46.2023.02.26.20.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 20:16:35 -0800 (PST)
Message-ID: <3607fd4c-cc4d-ae97-ed58-ecbecc55d838@redhat.com>
Date:   Mon, 27 Feb 2023 12:16:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] generic/020: fix really long attr test failure for
 ceph
Content-Language: en-US
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, djwong@kernel.org, ceph-devel@vger.kernel.org,
        vshankar@redhat.com, zlang@redhat.com
References: <20230227041358.350309-1-xiubli@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230227041358.350309-1-xiubli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test results of this:

[root@lxbceph1 xfstests-dev]# ./check generic/020
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 lxbceph1 6.2.0-rc7-00074-gd9ba97321a89 
#211 SMP PREEMPT_DYNAMIC Wed Feb 22 14:28:15 CST 2023
MKFS_OPTIONS  -- 10.72.47.117:40602:/testB
MOUNT_OPTIONS -- -o 
test_dummy_encryption,name=admin,nowsync,copyfrom,rasize=4096 -o 
context=system_u:object_r:root_t:s0 10.72.47.117:40602:/testB /mnt/kcephfs.B

generic/020 32s ...  34s
Ran: generic/020
Passed all 1 tests

On 27/02/2023 12:13, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> If the CONFIG_CEPH_FS_SECURITY_LABEL is enabled the kernel ceph
> itself will set the security.selinux extended attribute to MDS.
> And it will also eat some space of the total size.
>
> Fixes: https://tracker.ceph.com/issues/58742
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>
> V2:
> - make the 'size' and the 'selinux_size' to be local
>
>   tests/generic/020 | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/generic/020 b/tests/generic/020
> index be5cecad..538a24c6 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -150,9 +150,11 @@ _attr_get_maxval_size()
>   		# it imposes a maximum size for the full set of xattrs
>   		# names+values, which by default is 64K.  Compute the maximum
>   		# taking into account the already existing attributes
> -		max_attrval_size=$(getfattr --dump -e hex $filename 2>/dev/null | \
> +		local size=$(getfattr --dump -e hex $filename 2>/dev/null | \
>   			awk -F "=0x" '/^user/ {len += length($1) + length($2) / 2} END {print len}')
> -		max_attrval_size=$((65536 - $max_attrval_size - $max_attrval_namelen))
> +		local selinux_size=$(getfattr -n 'security.selinux' --dump -e hex $filename 2>/dev/null | \
> +			awk -F "=0x" '/^security/ {len += length($1) + length($2) / 2} END {print len}')
> +		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
>   		;;
>   	*)
>   		# Assume max ~1 block of attrs

-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

