Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CA6C678D5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 17:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjCGRgh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjCGRgX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 12:36:23 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691B99F20C
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 09:32:10 -0800 (PST)
Received: from [IPV6:2a02:8109:aa40:4e0:fc60:ae3e:2f1d:8bfc]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 17:32:09 +0000
Message-ID: <ed07090b-a5a7-513a-aa14-3ef32aaee55e@sdfg.com.ar>
Date:   Tue, 7 Mar 2023 18:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/11] vfs: Fix race condition on get_userns_fd()
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-4-rodrigo@sdfg.com.ar>
 <20230307164604.guofenicecdtlsxl@wittgenstein>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20230307164604.guofenicecdtlsxl@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/7/23 17:46, Christian Brauner wrote:
> On Tue, Mar 07, 2023 at 12:44:59PM +0100, Rodrigo Campos wrote:
>> Talking with Christian Brauner about a different problem, he mentioned
>> that technically this race condition exists and we should fix it.
>>
>> The race is that when we clone, we call a function that just returns
>> while at the same time we try to get the userns via /proc/pid/ns/user.
>> The thing is that, while the pid needs to be reaped, Christian said that
>> the userns file cease to exist as soon as the program finishes.
> 
> See exit_task_namespaces() in kernel/exit.c:do_exit().

Cool, thanks! Added that instead, then :)


>> So, let's make the function never return, so we always can get the
>> userns. We are already sending a SIGKILL to this pid, so nothing else
>> remaining to not leak the process.
>>
>> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
>> ---
>>   src/vfs/utils.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git src/vfs/utils.c src/vfs/utils.c
>> index ea7536c1..67779e83 100644
>> --- src/vfs/utils.c
>> +++ src/vfs/utils.c
>> @@ -58,9 +58,10 @@ pid_t do_clone(int (*fn)(void *), void *arg, int flags)
>>   #endif
>>   }
>>   
>> -static int get_userns_fd_cb(void *data)
>> +__attribute__((noreturn)) static int get_userns_fd_cb(void *data)
>>   {
>> -	return 0;
>> +	for (;;)
>> +		pause();
> 
> Should this add a _exit(0)? It's pretty odd otherwise. And do we need
> noreturn?

Agree, let's do that and remove the attribute.
