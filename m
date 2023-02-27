Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49C6C64ED6
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Feb 2023 04:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjB0EP4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Feb 2023 23:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0EPz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Feb 2023 23:15:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36BD525
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2023 20:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677471307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSf5j9Y3PjSJ8lU7S071w3b+DcCDtAoCeM+2R/NisMk=;
        b=hrICIdB+W31ltyVcvY1U+fp9pezioXj28S73UbcP46TGhMpch89/60auUHgvLWqy0J0aIn
        0ozsV41hWLTqyLfIgTf1DDySVbZFrLwcl3rZBN0Duy4sft7v1B4Wj8uaPOqBKtTck7QRVu
        eiSk6ny+YKFxQ9lFHyizYe1CUvQv+O4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-3rP917jhNpCaHp7HFVwvcQ-1; Sun, 26 Feb 2023 23:15:05 -0500
X-MC-Unique: 3rP917jhNpCaHp7HFVwvcQ-1
Received: by mail-pl1-f198.google.com with SMTP id x9-20020a1709028ec900b0019cad25ecf5so2960113plo.10
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2023 20:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSf5j9Y3PjSJ8lU7S071w3b+DcCDtAoCeM+2R/NisMk=;
        b=lxmLvar+d36D+8QL0E8PNXL0JKebf5bZPkVDESfXWu3uIQHMgdkK08I2Ceo8uJDL2K
         NRAOQSQw4BZnPH+sJ8uKWQmOpM84HDwNsYYYOOIldOgzZt2dDCli2npv8POEKWw0qqMh
         Amg0twNE+HmpYsakhgcoj4x5mvVhuAs20UEjui6/1OZudP02vlgLqknTONMo86GJ3rXi
         mQicz1t7A6oueuZFyIf0vSnHbzvXfoRIEP3TJgnHjIOs1lIFNzk/4/pAChA1bu7ao2Kg
         ZQ+24TbNz92/Er4X8fz14uPJ4ng2Tbd2hZ3rqpWxUHdD2GB6c0ZWOQX/d/4d5f3r7QmF
         Vdlw==
X-Gm-Message-State: AO0yUKWsoGvPbWDEyG+q5TJobsL/EhuS/oo3gYGC+yON6oirDVRL/4m+
        +iXeuu/c2gzmDcRCQJzDlkZUdoBpj0Ubg0CJx/BwzOJo55QnREkxm139skHqwuLcv/AWSGCcfJo
        sWcu2dOO7l7TgHbq1Xg==
X-Received: by 2002:aa7:998a:0:b0:5ec:702c:5880 with SMTP id k10-20020aa7998a000000b005ec702c5880mr5211779pfh.32.1677471304449;
        Sun, 26 Feb 2023 20:15:04 -0800 (PST)
X-Google-Smtp-Source: AK7set+4QuvKwBayk4195aFBdutaJz+3j2nlLMK3y45QtlQYBCThJXqScNorBMlg4jtuc0aKtlKFpg==
X-Received: by 2002:aa7:998a:0:b0:5ec:702c:5880 with SMTP id k10-20020aa7998a000000b005ec702c5880mr5211762pfh.32.1677471304117;
        Sun, 26 Feb 2023 20:15:04 -0800 (PST)
Received: from [10.72.12.143] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c15-20020aa78e0f000000b005e5b11335b3sm3184189pfr.57.2023.02.26.20.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 20:15:03 -0800 (PST)
Message-ID: <687ceb4c-68ba-7b7b-d05f-93d082054a7f@redhat.com>
Date:   Mon, 27 Feb 2023 12:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] generic/020: fix really long attr test failure for ceph
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
References: <20230217124558.555027-1-xiubli@redhat.com>
 <Y++0t8qxK8et8fTg@magnolia> <20230218060436.534bnbs5znio5pd7@zlang-mailbox>
 <Y/UZ2mwahyPzYSMj@magnolia> <20230222141526.hgrewr3ezkohukk4@zlang-mailbox>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230222141526.hgrewr3ezkohukk4@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 22/02/2023 22:15, Zorro Lang wrote:
> On Tue, Feb 21, 2023 at 11:22:02AM -0800, Darrick J. Wong wrote:
>> On Sat, Feb 18, 2023 at 02:04:36PM +0800, Zorro Lang wrote:
>>> On Fri, Feb 17, 2023 at 09:09:11AM -0800, Darrick J. Wong wrote:
>>>> On Fri, Feb 17, 2023 at 08:45:58PM +0800, xiubli@redhat.com wrote:
>>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>>
>>>>> If the CONFIG_CEPH_FS_SECURITY_LABEL is enabled the kernel ceph
>>>>> itself will set the security.selinux extended attribute to MDS.
>>>>> And it will also eat some space of the total size.
>>>>>
>>>>> Fixes: https://tracker.ceph.com/issues/58742
>>>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>>>> ---
>>>>>   tests/generic/020 | 6 ++++--
>>>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tests/generic/020 b/tests/generic/020
>>>>> index be5cecad..594535b5 100755
>>>>> --- a/tests/generic/020
>>>>> +++ b/tests/generic/020
>>>>> @@ -150,9 +150,11 @@ _attr_get_maxval_size()
>>>>>   		# it imposes a maximum size for the full set of xattrs
>>>>>   		# names+values, which by default is 64K.  Compute the maximum
>>>>>   		# taking into account the already existing attributes
>>>>> -		max_attrval_size=$(getfattr --dump -e hex $filename 2>/dev/null | \
>>>>> +		size=$(getfattr --dump -e hex $filename 2>/dev/null | \
>>>>>   			awk -F "=0x" '/^user/ {len += length($1) + length($2) / 2} END {print len}')
>>>>> -		max_attrval_size=$((65536 - $max_attrval_size - $max_attrval_namelen))
>>>>> +		selinux_size=$(getfattr -n 'security.selinux' --dump -e hex $filename 2>/dev/null | \
>>>>> +			awk -F "=0x" '/^security/ {len += length($1) + length($2) / 2} END {print len}')
>>>>> +		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
> The max_attrval_size isn't a local variable, due to we need it to be global.
> But the "size" and "selinux_size" look like not global variable, so better
> to be *local*.
>
Sorry I missed this.

And now fixed it and sent out the V2.

Thanks

- Xiubo


>>>> If this is a ceph bug, then why is the change being applied to the
>>>> section for FSTYP=ext* ?  Why not create a case statement for ceph?
>>> Hi Darrick,
>>>
>>> Looks like this change is in ceph section [1], did you hit any errors when
>>> you merge it?
>> ahahaa, diff tried to merge that hunk into _attr_get_max and not
>> _attr_get_maxval_size, and I didn't notice.  Question withdrawn
>> with apologies. :/
> Never mind. If there's not objection from you or ceph list, I'll merge this
> patch after it changes as above :)
>
> Thanks,
> Zorro
>
>> --D
>>
>>> Thanks,
>>> Zorro
>>>
>>> [1]
>>> _attr_get_maxval_size()
>>> {
>>>          local max_attrval_namelen="$1"
>>>          local filename="$2"
>>>
>>>          # Set max attr value size in bytes based on fs type
>>>          case "$FSTYP" in
>>>          ...
>>>          ...
>>>          ceph)
>>>                  # CephFS does not have a maximum value for attributes.  Instead,
>>>                  # it imposes a maximum size for the full set of xattrs
>>>                  # names+values, which by default is 64K.  Compute the maximum
>>>                  # taking into account the already existing attributes
>>> ====>           max_attrval_size=$(getfattr --dump -e hex $filename 2>/dev/null | \
>>>                          awk -F "=0x" '/^user/ {len += length($1) + length($2) / 2} END {print len}')
>>> ====>           max_attrval_size=$((65536 - $max_attrval_size - $max_attrval_namelen))
>>>
>>>
>>>
>>>> --D
>>>>
>>>>>   		;;
>>>>>   	*)
>>>>>   		# Assume max ~1 block of attrs
>>>>> -- 
>>>>> 2.31.1
>>>>>
-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

