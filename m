Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49E1C77B61
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Apr 2023 04:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDQE5h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Apr 2023 00:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjDQE5g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2023 00:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93E7F4
        for <fstests@vger.kernel.org>; Sun, 16 Apr 2023 21:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681707408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3BnFojWZL/bG/zPigloJEN3ndYrUcDTrtcXiM6ketw=;
        b=Tfkour2C0+F3rHH69b1aCjVz6sNkCG7GUQtd8rwk/Z14EqjYLCFv0Hee79bf9IoYZiz2rK
        zWQH1SRZwRkD0mbVvlA/V4hGbSIFfyXtdnvPAIMOJB+V+vmVGxO7hs5XcP96IwWaeuEDO7
        Yv7DVePAgL2/JngpqhdzhWwHauV5eGY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-RfoIiu3iNGmA8TYOh53HUw-1; Mon, 17 Apr 2023 00:56:47 -0400
X-MC-Unique: RfoIiu3iNGmA8TYOh53HUw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1a6a1b6a1d9so3135095ad.3
        for <fstests@vger.kernel.org>; Sun, 16 Apr 2023 21:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681707405; x=1684299405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3BnFojWZL/bG/zPigloJEN3ndYrUcDTrtcXiM6ketw=;
        b=CwysKR7By1cGq4ubi4noaYVN7BjybFph1HgqZ7tzrMEWcSuCLFvfGtP8j0TYTYIrWg
         21zopl1sVWkWUy8EYdyIgfOV2IXuOIvRnEhQjXl5nX/enVK7HTkoSVCPcAZoMuaGMbMY
         RVRn4TVJ4wAsWgPHZ6ReV0vwklXYDCFc6wf0oe7LisweR+ElpQoria5ET4Ay10EvQDsz
         R78pDzm4jWHfdS0CVuToobkNN60YqW2fDq/91uK2lNjxvwMRW9cA3qdpABLniz66KpYC
         jQ/tD8zBYjxc9plQyYAfqhvnFS1Q1eha65Zxy4OJbkG63WlYdsZ1UpPhNrtWzO2oJYSF
         OOhQ==
X-Gm-Message-State: AAQBX9d2vRrGzGN0bTOJ+5fc8wZnyBfegqm6txoS509zxkudaw4n8edc
        VN1Uv8VNPwp9j+XfnRKMtM5S7urhzNIezlfd/Izc3+zFkm00o7meuxDOgNWVwyAtUNMG1JdNQB0
        qm8lrT5TIX7+pQFehmQ==
X-Received: by 2002:a05:6a00:17a9:b0:63b:8b47:453c with SMTP id s41-20020a056a0017a900b0063b8b47453cmr4698275pfg.1.1681707405382;
        Sun, 16 Apr 2023 21:56:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZWVIyQhNc125Br02ERP6RgBnPbaIr0QiV5VeUubxkxkvksUIPHl2cGfx/uI1APHkaRJSGbXA==
X-Received: by 2002:a05:6a00:17a9:b0:63b:8b47:453c with SMTP id s41-20020a056a0017a900b0063b8b47453cmr4698266pfg.1.1681707405127;
        Sun, 16 Apr 2023 21:56:45 -0700 (PDT)
Received: from [10.72.12.181] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b00638b13ee6a7sm6648061pfn.25.2023.04.16.21.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 21:56:44 -0700 (PDT)
Message-ID: <34ad8dc4-6bf9-15b4-3c04-c43165ecb229@redhat.com>
Date:   Mon, 17 Apr 2023 12:56:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] common/rc: skip ceph when atime is required
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
References: <20230417024134.30560-1-xiubli@redhat.com>
 <20230417041752.lryihlt7atnljfzo@zlang-mailbox>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230417041752.lryihlt7atnljfzo@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 4/17/23 12:17, Zorro Lang wrote:
> On Mon, Apr 17, 2023 at 10:41:34AM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Ceph won't maintain the atime, so just skip the tests when the atime
>> is required.
>>
>> URL: https://tracker.ceph.com/issues/53844
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   common/rc | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 90749343..3238842e 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3999,6 +3999,9 @@ _require_atime()
>>   	nfs|cifs|virtiofs)
>>   		_notrun "atime related mount options have no effect on $FSTYP"
>>   		;;
>> +	ceph)
>> +                _notrun "atime not maintained by $FSTYP"
> Make sense to me. I'll change this line a bit when I merge it, to keep the line
> aligned (with above).
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Sure, thanks Zorro.

- Xiubo


> Thanks,
> Zorro
>
>> +		;;
>>   	esac
>>   
>>   }
>> -- 
>> 2.39.1
>>

