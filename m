Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD1CC61DA4
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 16:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCMQVh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCMQVg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 12:21:36 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159836F49A
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 09:21:34 -0700 (PDT)
Received: from [192.168.221.177]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Mon, 13 Mar 2023 16:21:30 +0000
Message-ID: <a78d5516-e191-db6f-ecb5-2793c230b584@sdfg.com.ar>
Date:   Mon, 13 Mar 2023 17:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 9/9] vfs: Add tmpfs tests for idmap mounts
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
 <20230308111343.510970-10-rodrigo@sdfg.com.ar>
 <20230313105018.n4nxsemdnp2mvbwk@wittgenstein>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20230313105018.n4nxsemdnp2mvbwk@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/13/23 11:50, Christian Brauner wrote:
> On Wed, Mar 08, 2023 at 12:13:43PM +0100, Rodrigo Campos wrote:
>> +	/* create separate mount namespace */
>> +	if (unshare(CLONE_NEWNS)) {
>> +		log_stderr("failure: create new mount namespace");
>> +		goto out_no_rm;
>> +	}
> 
> I think you might want to turn off mount propagation here so that the
> tmpfs mount doesn't propagate into the parent mount namespace:
> 
> 	mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0)

Right, great catch!


>> +	// Create a new info to use for test we will call.
>> +	struct vfstest_info nested_test_info = *info;
> 
> nit: We usually don't mix declarations and code in C code so I would
> move that struct vfstest_info to the top of the function.

Heh, I prefer C99 declarations, but sorry I forgot we are not using that 
style in these files. I'll fix it :)

> 
>> +	nested_test_info.t_mountpoint = strdup(path);
>> +	if (nested_test_info.t_mountpoint == NULL) {
> 
> nit: more idiomatic
> if (!nested_test_info.t_mountpoint)

Thanks!

>> +	if(rm_r(info->t_mnt_fd, DIR0)) >
> nit: missing space between "if" and "("

Ouch, probably my scripts for the spacing patch mixed this up... Fixed!
