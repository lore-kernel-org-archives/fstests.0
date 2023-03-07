Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC52C6FA99
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 23:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCGXf4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 18:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCGXfk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 18:35:40 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3CA9DF5
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 15:35:01 -0800 (PST)
Received: from [IPV6:2a02:8109:aa40:4e0:fc60:ae3e:2f1d:8bfc]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 23:34:50 +0000
Message-ID: <f8aaae1e-9ac2-d7e9-7c56-158c9b64b5f9@sdfg.com.ar>
Date:   Wed, 8 Mar 2023 00:34:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/11] vfs: Prepare tests in &s_idmapped_mounts to be
 reused inside a userns
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-7-rodrigo@sdfg.com.ar>
 <20230307165024.p72x3irzn36kt6bm@wittgenstein>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20230307165024.p72x3irzn36kt6bm@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/7/23 17:50, Christian Brauner wrote:
> On Tue, Mar 07, 2023 at 12:45:02PM +0100, Rodrigo Campos wrote:
>> Future patches will call these tests within a userns. So, let's skip
>> operations not allowed inside a userns.
>>
>> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
>> ---
> 
> On newer kernels you can always do:
> 
> mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(0, 0)))
> 
> but you'd still need the t_inside_userns then anyway so sure,

Actually, no, changing the makedev to that does the trick and it works 
inside a userns (at least in kernels where tmpfs supports idmap mounts).

So I will just do that instead, thanks!

