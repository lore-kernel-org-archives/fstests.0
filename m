Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE61C6FD1C
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Mar 2023 15:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCNPIU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Mar 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCNPIT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2023 11:08:19 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB6233E1
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 08:08:15 -0700 (PDT)
Received: from [IPV6:2a02:8109:aa40:4e0:fc60:ae3e:2f1d:8bfc]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 14 Mar 2023 15:08:07 +0000
Message-ID: <1c330f94-bc1e-dd3a-a033-81e04f52df71@sdfg.com.ar>
Date:   Tue, 14 Mar 2023 16:08:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 9/9] vfs: Add tmpfs tests for idmap mounts
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20230314114511.128207-1-rodrigo@sdfg.com.ar>
 <20230314114511.128207-10-rodrigo@sdfg.com.ar>
 <20230314144703.uq7wpw2g2qlmerz5@zlang-mailbox>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20230314144703.uq7wpw2g2qlmerz5@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/14/23 15:47, Zorro Lang wrote:
> On Tue, Mar 14, 2023 at 12:45:11PM +0100, Rodrigo Campos wrote:
>> This patch calls all tests in the suite s_idmapped_mounts, but with a
>> tmpfs directory mounted inside a userns. This directory is setup as the
>> mount point for the test that runs nested.
>>
>> This excercises that tmpfs mounted inside a userns works as expected
>> regarding idmap mounts.
>>
>> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
>> ---
> 
> This verion looks good to me, so ...
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks!

> Just curious, did you use "--no-prefix" option or use some similar configuration
> to generate this patchset. I have to use "-p0" to merge this patchset :)

Oh, yes, sorry, I used no prefix. I'll remove it from my config for this 
repo.



Thanks again,
Rodrigo
