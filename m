Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00297C678D4
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 17:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCGRiF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjCGRhb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 12:37:31 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9EF8C5B1
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 09:33:35 -0800 (PST)
Received: from [IPV6:2a02:8109:aa40:4e0:fc60:ae3e:2f1d:8bfc]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 17:33:31 +0000
Message-ID: <408cb118-4613-c1d6-14f5-9d4f0e249912@sdfg.com.ar>
Date:   Tue, 7 Mar 2023 18:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/11] vfs: Add DIR0 constant
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-10-rodrigo@sdfg.com.ar>
 <20230307165306.2mvrdu4qlor7n56w@wittgenstein>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20230307165306.2mvrdu4qlor7n56w@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/7/23 17:53, Christian Brauner wrote:
> On Tue, Mar 07, 2023 at 12:45:05PM +0100, Rodrigo Campos wrote:
>> This will be used by tests that call other tests within themselves.
>>
>> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
>> ---
>>   src/vfs/utils.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git src/vfs/utils.h src/vfs/utils.h
>> index 4c796559..c52a0738 100644
>> --- src/vfs/utils.h
>> +++ src/vfs/utils.h
>> @@ -45,6 +45,8 @@
>>   #define DIR2 "dir2"
>>   #define DIR3 "dir3"
>>   #define DIR1_RENAME "dir1_rename"
>> +// This directory may be used by tests that call another test.
>> +#define DIR0 "dir0"
> 
> I think you can fold that into whatever patch is using this, same for
> the addition of t->in_user_ns thing...

Will do both, thanks!
