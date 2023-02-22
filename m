Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A9C61DA4
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Feb 2023 23:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjBVX7A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjBVX67 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2023 18:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54514EC52
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2023 15:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677110293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXV8Ai9JbcuZGMK5QaH8UsVqX+xW1BVGo9JkWTVbj98=;
        b=gOHsadBqzWVq30bMCfRSV35PYxfcghM68PqUJ7GoXY5LHNrurqCerts5R+59swOd/4e3BT
        UWAR0IrTvJ0NCrnLINjH0Pj5yEnm3L+ZlSp3V9K74+n8cHLtFLjTiQKEjcWYqOiUQV9ehj
        TJxVw27jBbtHdglEwDe8LqsD1TgghX8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-WWzT5NVlNK2AXydMHdRzNg-1; Wed, 22 Feb 2023 18:58:11 -0500
X-MC-Unique: WWzT5NVlNK2AXydMHdRzNg-1
Received: by mail-pl1-f199.google.com with SMTP id z1-20020a170902d54100b00198bc9ba4edso4342740plf.21
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2023 15:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXV8Ai9JbcuZGMK5QaH8UsVqX+xW1BVGo9JkWTVbj98=;
        b=PKFn0KpzSylwUmNtJG7JDLdcilqutqXBNaXQPNtjK+5Ump2TsFq5GI7Nyt7t2SrOd3
         sA2IKnr8IM/n+Y2rEBMkPncDLBUefkmqO8UIofiAsT2AlVYkyh99pFP6/b3YRTUxDwZ7
         6BxTZpmw+mpspnMtL/eTXm09EZKXklkO2X8WA0cKvZs0jNp5rrNlXWqFSILaa9gc4dSU
         +uWh7hOyRpK3Nc6f6yID88YGeiIWdiVrl9FHAHMi2aX/+hFBj4IXryK6ueiRM8XutUW2
         cxgdANbgP85rIOmmUAVFqz3lGW508sMpCg3H9waY1jSRccr6GHP7+ZjNvoeSRoMVvCr4
         8Cbg==
X-Gm-Message-State: AO0yUKWq96n9Tv3dxCF6goxh8u7tm88bVeWlH7DocGi43DJ921zazT8F
        bDQMQdY3gsZMSL/LXlOJ05k0gm7Gn1vsg3VuU+FCWGvQUN4k7nCdQHUpb+ZvyXVuT1Szm9q93e9
        ITklhaUskAcWBZ2XAog==
X-Received: by 2002:a17:90b:1988:b0:229:4dcd:ff61 with SMTP id mv8-20020a17090b198800b002294dcdff61mr11778850pjb.28.1677110290704;
        Wed, 22 Feb 2023 15:58:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8RfTAtj8z6vzJ4vIFeaKXrlhekJ1syCglrFj0SuMP2NlkemLkwmKN8Rst524azC/Cqv2zbjA==
X-Received: by 2002:a17:90b:1988:b0:229:4dcd:ff61 with SMTP id mv8-20020a17090b198800b002294dcdff61mr11778837pjb.28.1677110290353;
        Wed, 22 Feb 2023 15:58:10 -0800 (PST)
Received: from [10.72.12.152] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a294700b00234899c65e7sm5459666pjf.28.2023.02.22.15.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 15:58:09 -0800 (PST)
Message-ID: <718381b5-c36b-2398-6e22-43a6143957ae@redhat.com>
Date:   Thu, 23 Feb 2023 07:58:06 +0800
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

Sure. Thanks Zorro.

- Xiubo


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

