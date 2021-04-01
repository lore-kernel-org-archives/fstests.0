Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533D2C43470
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Apr 2021 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FF1610E5
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Apr 2021 09:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDAJrs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Apr 2021 05:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbhDAJrj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Apr 2021 05:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617270459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qbka1MuHTUaUBgISMmgp3LVors4VvjsFFwC/IHLayjY=;
        b=dllPIBq22Dha1cGF5Zbd31mXh4P4/klRojqdtXLDClp7zQjb3oyHhVOgeG15WGTMOC0TRW
        KdwnKiOU8+hSE6OU4LY9WYq7npfdz6OsVcZ5NnLJXh4op9QCBwIKjddSO7H4xDAzDnDq7x
        Ki3W6RwvrshuC9/+uPq5seu8L7GTiP0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-MQu5a5ykMGuslX-qztPSbA-1; Thu, 01 Apr 2021 05:47:37 -0400
X-MC-Unique: MQu5a5ykMGuslX-qztPSbA-1
Received: by mail-wm1-f69.google.com with SMTP id w185so757985wmg.4
        for <fstests@vger.kernel.org>; Thu, 01 Apr 2021 02:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbka1MuHTUaUBgISMmgp3LVors4VvjsFFwC/IHLayjY=;
        b=HCQgjX9blkhLIdtfsSlEBiiKzToWDiKFAGXRYXq4WcJskB8fU/IDEQ7vyhfvKmyobF
         YrOJNDyzHguFO9/qDKha7QZ0fx089QFj/XFZYGhjcr+eKFU84S1nN7CM0VJ0/w+gKqMp
         GEH9CwU6ioPEYt/Vab+glmtntvX4LT0DdTodqG5if1Yc8Kk33wPJ1BHLwqbR3gltfzK1
         zpbOsc0Fy79oWiDF4HWk43EwQN9q/l4UAGKJp25ckg085AQwjszCbJjDKVm71vYLnr4S
         DOGFy1u2C0CdSTOkk7vjyU8MesdgILUQQfSS1N80snwBMrX11brZ/qF/SCywtmwo85Ww
         hzYg==
X-Gm-Message-State: AOAM531V4ViFcHUxHLmQghfXZBnvte0TLlV6klAgqwGdi5L1QeqKKgPM
        JEYZNA/GiAZddhqU6i5wj5M36DrIkx/mUgTYgPu/38KRlWwMXqbmwWlhriKuKE16NUs0eB5al2G
        ni+GqOcJD4UhdjUvHkA==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr8621328wru.368.1617270456555;
        Thu, 01 Apr 2021 02:47:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLdTcLa/yMKMzBOLQqnhNFcVyHcOh0mHxzzLh2KmFbHvjVjW/VoFZxRd7SNr80xOWkn9VcFQ==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr8621309wru.368.1617270456352;
        Thu, 01 Apr 2021 02:47:36 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id c131sm7934300wma.37.2021.04.01.02.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:47:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] common/rc: Add _require_{chown,chmod,symlink}()
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, guan@eryu.me,
        Eric Sandeen <sandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-2-preichl@redhat.com>
 <20210401033853.GO95214@e18g06458.et15sqa>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <9f6d45ca-7f96-1cfa-5e66-a355ad4e0c7a@redhat.com>
Date:   Thu, 1 Apr 2021 11:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401033853.GO95214@e18g06458.et15sqa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 4/1/21 5:38 AM, Eryu Guan wrote:
> On Wed, Mar 31, 2021 at 12:00:02AM +0200, Pavel Reichl wrote:
>> Add helper functions that ensure that test is only executed on file
>> systems that implement chown, chmod and symbolic links.
>>
>> Fixed test are: generic/{87,88,125,126,128,193,314,317,355,597,598}
>>
>> Signed-off-by: Pavel Reichl <preichl@redhat.com>
>> ---
>>  common/rc         | 27 +++++++++++++++++++++++++++
>>  tests/generic/087 |  1 +
>>  tests/generic/088 |  1 +
>>  tests/generic/125 |  1 +
>>  tests/generic/126 |  1 +
>>  tests/generic/128 |  1 +
>>  tests/generic/193 |  1 +
>>  tests/generic/314 |  1 +
>>  tests/generic/317 |  1 +
>>  tests/generic/355 |  1 +
>>  tests/generic/597 |  1 +
>>  tests/generic/598 |  1 +
>>  12 files changed, 38 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 0ce3cb0d..9cdfe21c 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2129,6 +2129,33 @@ _require_user()
>>      [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
>>  }
>>  
>> +# check for a chown support
>> +#
>> +_require_chown()
>> +{
>> +	if [ "$FSTYP" = "exfat" ]; then
>> +		_notrun "chown is not supported on $FSTYP"
>> +	fi
>> +}
>> +
>> +# check for a chmod support
>> +#
>> +_require_chmod()
>> +{
>> +	if [ "$FSTYP" = "exfat" ]; then
>> +		_notrun "chmod is not supported on $FSTYP"
>> +	fi
>> +}
>> +
> 
> Does chown/chmod fail on exfat? Like the existing _require_symlink()
> implementation and many other _require rules, we try to actually do the
> action on $TEST_DIR, and check if command succeeds to see if the action
> is supported by current $FSTYP. Is it possible for exfat to do the same
> check?
> 
> We only use whitelist if it's impossible to do such check.
> 
> Thanks,
> Eryu
> 

Hi, 

it does fail. It was actually my original intention to write the _require*() so it would check if the command succeeds as you are suggesting.

However, Eric and Dave were worried that adding more _require*() through the tests would lead to further slowing test execution. This worry actually makes sense to me.

Is there a significant benefit of testing the support vs. maintaining check based on FSTYP variable? I guess doing the check saves us from the need to update the code when new file-system is added, however actually doing the check increases time of test execution (but I haven't done any measurements yet - it's just my guess).

I really don't mind doing it either way and I'm happy to change the code - I'm just trying to explain :-)

Thanks for the comment.

Have a nice day.

