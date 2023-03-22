Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFEBC6FD1D
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Mar 2023 02:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCVCZc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Mar 2023 22:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCVCZc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2023 22:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3065A1B0
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2023 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679451885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6oMSGUJAZpBPKFcO2fZJsIWmoX+5e2Lx0/usfbhCWE=;
        b=STWEsd16KGdmDHaQg1fwnApjm6ncZiyehx9IREYjIvcPChHRfHo2U1HqkCSV+ElirS5A2n
        Fu4KEuArXX7zYDXvN/B54tzk62EW4yH15wYNDpQx/t0nRllTtpQy0AabewMvVSnCbJ+/Ax
        WxgB5huM6KdM8Y+NRpbcUZeG+FEWw5E=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-oN2ib8Q_NSexc-0H2GUnPg-1; Tue, 21 Mar 2023 22:24:44 -0400
X-MC-Unique: oN2ib8Q_NSexc-0H2GUnPg-1
Received: by mail-pg1-f197.google.com with SMTP id g13-20020a63f40d000000b005015be7b9faso4143804pgi.15
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2023 19:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679451883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6oMSGUJAZpBPKFcO2fZJsIWmoX+5e2Lx0/usfbhCWE=;
        b=K38JifhTFK1Be7Svo1MsZiUEbLycieuBx7RCtPsMQiG2wbSmXmBfVopt0MoWNxYb/d
         tVeBYhZzmmBxeHXEsbf9NuyTcGb7IAr8O9SYr+O5bPJIJSYdP2Cn8niat5r5P84pw1Yc
         T60yTgAfMYQYXUSFCMLbm0mLW1Dn2n2aktZm8GN/BIV3EXHrdy7rojDmMIzoZYmLJ+6M
         v8ofApCSjIbuemQuHrRgvFTwEwoP0DGHMZNF4N4YCWogRtgYE5B++nF/pXUOBXc1C89z
         bpnLv3Vt5if+txjyGlllsdYkuUiJjJBRJhox7Rpq7VCMiIkTS//3GjjVeafGiTXG6ILp
         062w==
X-Gm-Message-State: AO0yUKWu3d69p3i3PFgjTtvm1077lWYKCwCO3m5zVfrtr8TKtXDw9MPt
        qZ8keOM8+BwadtLU8peX6EtKhzip6V+UiY/GRH0mefgs5NcSDUVNclu9MrsnEP1N6ib43X0WFKa
        owieq6UUfdu5rppeubg==
X-Received: by 2002:a05:6a20:b72a:b0:da:eabf:eec2 with SMTP id fg42-20020a056a20b72a00b000daeabfeec2mr2458788pzb.48.1679451883312;
        Tue, 21 Mar 2023 19:24:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set8YARSWpxNdxlY+7LJCN/GQYk3RwnttToqtb+dUv2NSZUziLQhzwSi+UsZuWzBOjJOxq2Mf2Q==
X-Received: by 2002:a05:6a20:b72a:b0:da:eabf:eec2 with SMTP id fg42-20020a056a20b72a00b000daeabfeec2mr2458776pzb.48.1679451882962;
        Tue, 21 Mar 2023 19:24:42 -0700 (PDT)
Received: from [10.72.12.98] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78e03000000b00593c1c5bd0esm5260611pfr.164.2023.03.21.19.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 19:24:42 -0700 (PDT)
Message-ID: <829cd072-271b-b22a-4ab3-74a786d41e58@redhat.com>
Date:   Wed, 22 Mar 2023 10:24:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] generic/075: no need to move the .fsxlog to the same
 directory
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
        ceph-devel@vger.kernel.org, vshankar@redhat.com
References: <20230301020730.92354-1-xiubli@redhat.com>
 <20230320143703.dv5ab4tnwrs5cnwl@zlang-mailbox>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230320143703.dv5ab4tnwrs5cnwl@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 20/03/2023 22:37, Zorro Lang wrote:
> On Wed, Mar 01, 2023 at 10:07:30AM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Actually it was trying to move the '075.$_n.fsxlog' from results
>> directory to the same results directory.
>>
>> Fixes: https://tracker.ceph.com/issues/58834
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   tests/generic/075 | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tests/generic/075 b/tests/generic/075
>> index 9f24ad41..03a394a6 100755
>> --- a/tests/generic/075
>> +++ b/tests/generic/075
>> @@ -57,7 +57,6 @@ _do_test()
>>       then
>>   	echo "    fsx ($_param) failed, $? - compare $seqres.$_n.{good,bad,fsxlog}"
>>   	mv $out/$seq.$_n $seqres.$_n.full
>> -	mv "$RESULT_DIR"/$seq.$_n.fsxlog $seqres.$_n.fsxlog
> Hmm... Thoese $seq, $seqnum, $seqres, $RESULT_DIR and $REPORT_DIR are mess for
> me too :-D
>
>  From the logic of xfstests/check:
>
>    if $OPTIONS_HAVE_SECTIONS; then
>            export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;${RESULT_BASE}/$section;"`
>            REPORT_DIR="$RESULT_BASE/$section"
>    else
>            export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;$RESULT_BASE;"`
>            REPORT_DIR="$RESULT_BASE"
>    fi
>    seqres="$REPORT_DIR/$seqnum"
>
>
> I think "$RESULT_DIR"/$seq equal to "$seqres", so this change makes sense to me.
> (Not sure if there're some special situations which I don't know :)
>
> The generic/075 is too old, lots of code in it can be removed or refactored, so
> I think it's not worth changing it bit by bit, I can refactor it totally, or if
> you'd like, you can do that.

Yeah, I can do that later, but not recently.

I may add some more tests in future and then I can improve this together.

Thanks Zorro,

- Xiubo

> Thanks,
> Zorro
>
>>   	od -xAx $seqres.$_n.full > $seqres.$_n.bad
>>   	od -xAx "$RESULT_DIR"/$seq.$_n.fsxgood > $seqres.$_n.good
>>   	rm -f "$RESULT_DIR"/$seq.$_n.fsxgood
>> -- 
>> 2.31.1
>>
-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

