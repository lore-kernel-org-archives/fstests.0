Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D0DC7EE29
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jun 2023 01:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjFEBmY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Jun 2023 21:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjFEBmX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Jun 2023 21:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF86A1
        for <fstests@vger.kernel.org>; Sun,  4 Jun 2023 18:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685929299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dPxMNgp9Z5Jx7/cmyNMr458SLsz8+Wt5P0SKLMfTOM=;
        b=Oki/j2cu/fXZsnLiHLud7aMFF/x7HYe6zRmqi6Nh8H/I20IDc6p5cnLlPNcZKLZv13/rfT
        AgYvH+IJasdB4mmI4TIyVKVR5GJlM5rVjV9ZpEpARpdC8DkjKtnNZg01Qfw8l8dlASqLIr
        RKc3W56attBQLlwUW/OX1OURjrfmBso=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-Lcahb4ghOWmnKnG2IfOqzw-1; Sun, 04 Jun 2023 21:41:38 -0400
X-MC-Unique: Lcahb4ghOWmnKnG2IfOqzw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b1622d8923so907520a34.2
        for <fstests@vger.kernel.org>; Sun, 04 Jun 2023 18:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685929297; x=1688521297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9dPxMNgp9Z5Jx7/cmyNMr458SLsz8+Wt5P0SKLMfTOM=;
        b=Mx7+AgIuYwdO7RONCnvenZh4Ap/lsOsw2vR41Vm8kZA/LFQaj350WvF93MWt5R5RUY
         7M2e7O7w3iNGEz6hXVUm/uNoHn5M9mi4rUGZcAwhBmPu/U+7Hi4rGwhaJl2h/gwLenta
         MOwn6Ya/wxurs/hijkBXRh9f2piXX7LjSRDDaUmoGQHx4GE3VcrTn9bRBMUGMXT5XHJ+
         EK4cDy/4nGcInlmmiEZXC691urjZdLapclvk5N3Ym1ZCvRtuKzexTDberAzUfXlELu1Z
         k89tFfvqBQc6hsXqI1qKIjN4efm9JJKkP6GFa9qHN6tiutkuTv3z1rtfEg8KJfjiKsed
         u9Wg==
X-Gm-Message-State: AC+VfDxqg44N8c5a7CjuLghv3ufu7nT+DtXJNhAouYX19FzxVuk8amVb
        5e8etfZ87tfU4RD5tt9pcAJ4ZLRmlDXNebLft5fmgfh46fg/7QMitNKN0au6nM9u1IkSyrSrlbH
        q2Cg6Z7plWr+sa6SBWq2aF+9I4UuZ
X-Received: by 2002:a05:6830:169a:b0:6ab:1c78:d5e with SMTP id k26-20020a056830169a00b006ab1c780d5emr8957181otr.5.1685929297711;
        Sun, 04 Jun 2023 18:41:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+LD1A+zZFKBZya0yVPWFykITUF4pkHOOWCKXLjzSZzoZEuP2I7Fbrq+7zT8OGTW7freccug==
X-Received: by 2002:a05:6830:169a:b0:6ab:1c78:d5e with SMTP id k26-20020a056830169a00b006ab1c780d5emr8957166otr.5.1685929297480;
        Sun, 04 Jun 2023 18:41:37 -0700 (PDT)
Received: from [10.72.12.216] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q16-20020a62e110000000b0063d29df1589sm4089971pfh.136.2023.06.04.18.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 18:41:36 -0700 (PDT)
Message-ID: <a90b085c-8744-cdbc-9f4f-3221723a7bd3@redhat.com>
Date:   Mon, 5 Jun 2023 09:41:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] generic/020: add ceph-fuse support
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
References: <20230530071552.766424-1-xiubli@redhat.com>
 <20230602105038.tz2azxiaxzcrdu3l@zlang-mailbox>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230602105038.tz2azxiaxzcrdu3l@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 6/2/23 18:50, Zorro Lang wrote:
> On Tue, May 30, 2023 at 03:15:52PM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> For ceph fuse client the fs type will be "ceph-fuse".
>>
>> Fixes: https://tracker.ceph.com/issues/61496
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   tests/generic/020 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/020 b/tests/generic/020
>> index e00365a9..da258aa5 100755
>> --- a/tests/generic/020
>> +++ b/tests/generic/020
>> @@ -56,7 +56,7 @@ _attr_get_max()
> Hmm... generic/020 is a very old test case, I think this _attr_get_max might
> can be a common helper in common/attr.
Yeah, sounds reasonable.
>>   {
>>   	# set maximum total attr space based on fs type
>>   	case "$FSTYP" in
>> -	xfs|udf|pvfs2|9p|ceph|fuse|nfs)
>> +	xfs|udf|pvfs2|9p|ceph|fuse|nfs|ceph-fuse)
> Anyway, that's another story, for the purpose of this patch:
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>
Thanks

- Xiubo

>>   		max_attrs=1000
>>   		;;
>>   	ext2|ext3|ext4)
>> -- 
>> 2.40.1
>>

