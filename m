Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0688C6FD1D
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 17:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCGRPy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCGRPe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 12:15:34 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D309964C
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 09:10:55 -0800 (PST)
Received: from [IPV6:2a02:8109:aa40:4e0:fc60:ae3e:2f1d:8bfc]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 17:10:46 +0000
Message-ID: <2f6faf38-633e-2371-bc19-c365dddce4aa@sdfg.com.ar>
Date:   Tue, 7 Mar 2023 18:10:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/11] vfs: Use tabs to indent, not spaces
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-12-rodrigo@sdfg.com.ar>
 <20230307165508.77ptsmv2zdotw6xg@wittgenstein>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20230307165508.77ptsmv2zdotw6xg@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/7/23 17:55, Christian Brauner wrote:
> On Tue, Mar 07, 2023 at 12:45:07PM +0100, Rodrigo Campos wrote:
>> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
>> ---
> 
> I think I explicitly used spaces but I don't know why anymore tbh. So
> I'll live that to Zorro whether he wants to take this patch or not. I
> have no strong opinion. :)

Right, it seems my patch also changed spacing after sprintf, for the 
printed text.

I'll remove that and just keep this in the diff:

>> diff --git src/vfs/vfstest.c src/vfs/vfstest.c
>> index 3d75b1e3..dea344cc 100644
>> --- src/vfs/vfstest.c
>> +++ src/vfs/vfstest.c
>> @@ -107,7 +107,7 @@ static int hardlink_crossing_mounts(const struct vfstest_info *info)
>>   	int fret = -1;
>>   	int file1_fd = -EBADF, open_tree_fd = -EBADF;
>>   
>> -        if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
>> +	if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
>>   		log_stderr("failure: chown_r");
>>   		goto out;
>>   	}
