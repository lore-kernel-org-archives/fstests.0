Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D9CC636D6
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Feb 2023 00:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBRA1v (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Feb 2023 19:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBRA1u (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2023 19:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670C68ADC
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 16:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676680018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TVOvyAkMinBR6Y3/er05/0qs6PJZeW5sD0yVjgNqbU=;
        b=Vw8GoesVKrvXTh6qmmAj2u1AskaqVeDZ4VftRQnXFLk2n+abFNro0wCI11B83MmInZS4PU
        1ZRilEYiBdnNZIOQK0fkJFhnvdLSzagOSC921rA0Pw4hpzMaYqYihDEsrQO6nrfZi/ZkjE
        or8vJ76Qapi5xApjYck/m8FCQKs40dw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-UENuAPgwN663RR3pSrk3bg-1; Fri, 17 Feb 2023 19:26:57 -0500
X-MC-Unique: UENuAPgwN663RR3pSrk3bg-1
Received: by mail-pl1-f200.google.com with SMTP id jd12-20020a170903260c00b001963da9cc71so1586415plb.11
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 16:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TVOvyAkMinBR6Y3/er05/0qs6PJZeW5sD0yVjgNqbU=;
        b=RJLUh88wdcOv0b021i3ttLbnq68fq7AM3X0vUq8Aep3hTNo0otWynNi+OtF24Wvz4B
         AZ2RQAd/BQsggrJksgSt2SPfAjwS/4EF5VttZHS6bnrtWKyXhPwBAYD41uiAWOfiDzdw
         hFrtdElF2tSASc9A8Cn/96QeLgi8uQhJudpF5AzedAypMVOJfnftC6z2RgrLUEVHOPjp
         gLduheEV2D3gw6LbADHQDci+Hmx7HPw8QwjhQglHNq1fP+jUXnMOA+IvKSHnDqgXxsLF
         owddldEM9xRRGWIh1Aj6Hin55aeEyqm8gA2QtuEIGLqG3M/Oq/cKiNAHPXYjryRGWH50
         SQEw==
X-Gm-Message-State: AO0yUKXu1JzyeI27fFQFoRbTE2bt8dnd4E7/e3wR+WAOPUwIFbWJLP7k
        wVbxK+3I8MFb4FFnqKoiD3EEqrkecLHqewu0cTXMuqfdT2H8SUcjzPkjbp0/fL321XqIXFX2KYT
        LkmkR3rx/OH7dH/Ghurff0vp+n15j
X-Received: by 2002:a17:902:ec8c:b0:196:7bfb:f0d1 with SMTP id x12-20020a170902ec8c00b001967bfbf0d1mr2116121plg.34.1676680016116;
        Fri, 17 Feb 2023 16:26:56 -0800 (PST)
X-Google-Smtp-Source: AK7set/pTQPbTBejLC3ZlGmTrp0zRFUymVN4NfxARLQed13IM33bE8WinIA3xyIncb7RXbmXQLDfSQ==
X-Received: by 2002:a17:902:ec8c:b0:196:7bfb:f0d1 with SMTP id x12-20020a170902ec8c00b001967bfbf0d1mr2116099plg.34.1676680015714;
        Fri, 17 Feb 2023 16:26:55 -0800 (PST)
Received: from [10.72.12.155] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bi12-20020a170902bf0c00b00194c1281ca9sm3654407plb.166.2023.02.17.16.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 16:26:55 -0800 (PST)
Message-ID: <3b1ea8e1-c6b0-1c5e-9db2-542861d12269@redhat.com>
Date:   Sat, 18 Feb 2023 08:26:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] generic/020: fix really long attr test failure for ceph
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, david@fromorbit.com,
        ceph-devel@vger.kernel.org, vshankar@redhat.com, zlang@redhat.com
References: <20230217124558.555027-1-xiubli@redhat.com>
 <Y++0t8qxK8et8fTg@magnolia>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <Y++0t8qxK8et8fTg@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 18/02/2023 01:09, Darrick J. Wong wrote:
> On Fri, Feb 17, 2023 at 08:45:58PM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> If the CONFIG_CEPH_FS_SECURITY_LABEL is enabled the kernel ceph
>> itself will set the security.selinux extended attribute to MDS.
>> And it will also eat some space of the total size.
>>
>> Fixes: https://tracker.ceph.com/issues/58742
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   tests/generic/020 | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/generic/020 b/tests/generic/020
>> index be5cecad..594535b5 100755
>> --- a/tests/generic/020
>> +++ b/tests/generic/020
>> @@ -150,9 +150,11 @@ _attr_get_maxval_size()
>>   		# it imposes a maximum size for the full set of xattrs
>>   		# names+values, which by default is 64K.  Compute the maximum
>>   		# taking into account the already existing attributes
>> -		max_attrval_size=$(getfattr --dump -e hex $filename 2>/dev/null | \
>> +		size=$(getfattr --dump -e hex $filename 2>/dev/null | \
>>   			awk -F "=0x" '/^user/ {len += length($1) + length($2) / 2} END {print len}')
>> -		max_attrval_size=$((65536 - $max_attrval_size - $max_attrval_namelen))
>> +		selinux_size=$(getfattr -n 'security.selinux' --dump -e hex $filename 2>/dev/null | \
>> +			awk -F "=0x" '/^security/ {len += length($1) + length($2) / 2} END {print len}')
>> +		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
> If this is a ceph bug, then why is the change being applied to the
> section for FSTYP=ext* ?  Why not create a case statement for ceph?

Hi Darrick,

The above change is already in the "ceph)" section:

143         nfs)
144                 # NFS doesn't provide a way to find out the 
max_attrval_size for
145                 # the underlying filesystem, so just use the lowest 
value above.
146                 max_attrval_size=1024
147                 ;;
148         ceph)
149                 # CephFS does not have a maximum value for 
attributes.  Instead,
150                 # it imposes a maximum size for the full set of xattrs
151                 # names+values, which by default is 64K. Compute the 
maximum
152                 # taking into account the already existing attributes
153                 size=$(getfattr --dump -e hex $filename 2>/dev/null | \
154                         awk -F "=0x" '/^user/ {len += length($1) + 
length($2) / 2} END {print len}')
155                 selinux_size=$(getfattr -n 'security.selinux' --dump 
-e hex $filename 2>/dev/null | \
156                         awk -F "=0x" '/^security/ {len += length($1) 
+ length($2) / 2} END {print len}')
157                 max_attrval_size=$((65536 - $size - $selinux_size - 
$max_attrval_namelen))
158                 ;;
159         *)
160                 # Assume max ~1 block of attrs
161                 BLOCK_SIZE=`_get_block_size $TEST_DIR`
162                 # leave a little overhead
163                 let max_attrval_size=$BLOCK_SIZE-256

I didn't find the ext* section in _attr_get_maxval_size(). Did I miss 
something here ?

I have double checked it again by pulling the latest source code, no any 
change about this since my last pull yesterday.

Thanks

- Xiubo


> --D
>
>>   		;;
>>   	*)
>>   		# Assume max ~1 block of attrs
>> -- 
>> 2.31.1
>>
-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

