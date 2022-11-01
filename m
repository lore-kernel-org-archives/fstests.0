Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E4FA3741
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Nov 2022 01:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKABxB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKABxA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Oct 2022 21:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B42E17428
        for <fstests@vger.kernel.org>; Mon, 31 Oct 2022 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667267515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDvrHJlZsUaGU5+nTFM97pKPF/nM910J0rVo2TRHYhk=;
        b=CiaGgfjbi47thPKydY0UtMa2Y72nGy02DzrZX6i6IG6+p9nd75OkunVTO23yIXQUy/KwS4
        ogj4Cw50QF3TRU625Wcjnd9hX5P4nYiiao8VAgTpvFZphuJDFYZzmCf/hWIXIx2RlSDj6c
        PmN1VZVQVqQbLVNb/PT+Bv8ndMSPD9M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-6bNnYrcXPuGxfJwrVTdkJQ-1; Mon, 31 Oct 2022 21:51:52 -0400
X-MC-Unique: 6bNnYrcXPuGxfJwrVTdkJQ-1
Received: by mail-pj1-f69.google.com with SMTP id q93-20020a17090a1b6600b0021311ab9082so6330872pjq.7
        for <fstests@vger.kernel.org>; Mon, 31 Oct 2022 18:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDvrHJlZsUaGU5+nTFM97pKPF/nM910J0rVo2TRHYhk=;
        b=Onr26Umt/eN/siF/MV9IKbzbaji5arvgeuYS3Gfpy/BA7sClsVQghLxSFoonrAlUFw
         1ljCiPlxgCkGh12ZmjlTNh61Rx5+CvlfRC8hncCYoHPNt5+ti7BII7TFY2k0HqfIrLg0
         fbvhB596VUCEp0DAxySi7bI6PFpNqL5P3V2EMUVJDFddu+kc3VoYQnNhKZ/dDs3lSB63
         3Hh6ituUQUBfkKvBuc6sYh4CJIDBhyzdm/aDHTNLwlM1+qmFsnc2WtZvXyC4MGeO0P94
         8aNOLxE8z1NUQkiF+7HgP24BuBl9Dd+eNCSKB/Irw0511FYh2DQTU8JzX4+XJTQsVCrI
         Vohw==
X-Gm-Message-State: ACrzQf3sY0Peds8PI/eXKHRJcbi7p73QRiXBdrathq28fXEvLiwcB3GK
        kn44FR1/kQYhXzcf3Jnoit17lIcZkXJpc/6z8bGslxOiDlxuPBpE82QSr9X/BKdTNDJwcqHkPJf
        APTr7WmnHl46X17DME1HPjs5YThYHhBMYM92Enx/MTCv9qFU926BmZwZI4TuJ6LyfDkY=
X-Received: by 2002:a63:d149:0:b0:46f:d4b7:5120 with SMTP id c9-20020a63d149000000b0046fd4b75120mr4438776pgj.579.1667267511480;
        Mon, 31 Oct 2022 18:51:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7uYIHL9K1Bt1MDlgr/iebe/o+PHGBz4NRCUfpvC8iEW0qpcnlNnikgmdt8JjTCx/eBSg6PoA==
X-Received: by 2002:a63:d149:0:b0:46f:d4b7:5120 with SMTP id c9-20020a63d149000000b0046fd4b75120mr4438762pgj.579.1667267511122;
        Mon, 31 Oct 2022 18:51:51 -0700 (PDT)
Received: from [10.72.13.65] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g13-20020a63200d000000b0043954df3162sm4712829pgg.10.2022.10.31.18.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 18:51:50 -0700 (PDT)
Subject: Re: [PATCH v3] encrypt: add ceph support
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20221031083819.573521-1-xiubli@redhat.com>
 <20221031150404.etbrz45c7bkgcgdb@zlang-mailbox>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <79584e5e-fd3d-9870-e421-289958dc5f8e@redhat.com>
Date:   Tue, 1 Nov 2022 09:51:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221031150404.etbrz45c7bkgcgdb@zlang-mailbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 31/10/2022 23:04, Zorro Lang wrote:
> On Mon, Oct 31, 2022 at 04:38:19PM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This will enable ceph could run the fscrypt test cases, but not all.
>> Some of them will be skipped because of not supporting features.
>>
>> Here will just skip ceph in _scratch_mkfs_encrypted() and in
>> _require_scratch_encryption() it will try to check "set_encpolicy"
>> to make sure whether kernel ceph support the encryption or not.
>>
>> Reviewed-by: Zorro Lang <zlang@redhat.com>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>
>> V3:
>> - Add more commit comments.
> V2 patch has been merged and pushed.

Ah Okay.

Sorry, I pulled it and didn't see that yesterday.

I may missed that.

Thanks Zorro!


> Thanks,
> Zorro
>
>>
>>   common/encrypt | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/common/encrypt b/common/encrypt
>> index 45ce0954..1a77e23b 100644
>> --- a/common/encrypt
>> +++ b/common/encrypt
>> @@ -153,6 +153,9 @@ _scratch_mkfs_encrypted()
>>   		# erase the UBI volume; reformated automatically on next mount
>>   		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
>>   		;;
>> +	ceph)
>> +		_scratch_cleanup_files
>> +		;;
>>   	*)
>>   		_notrun "No encryption support for $FSTYP"
>>   		;;
>> -- 
>> 2.31.1
>>

