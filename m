Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5458C678D5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 17:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCGRQS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCGRPz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 12:15:55 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C799AA2E
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 09:11:38 -0800 (PST)
Received: from [IPV6:2a02:8109:aa40:4e0:fc60:ae3e:2f1d:8bfc]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 17:11:37 +0000
Message-ID: <56aac132-85c6-34d6-c11a-1cad4a43b68a@sdfg.com.ar>
Date:   Tue, 7 Mar 2023 18:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/11] vfs: Export test_setup() and test_cleanup()
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-9-rodrigo@sdfg.com.ar>
 <20230307165148.ogfe5xmgxpqmv54n@wittgenstein>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20230307165148.ogfe5xmgxpqmv54n@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/7/23 17:51, Christian Brauner wrote:
> On Tue, Mar 07, 2023 at 12:45:04PM +0100, Rodrigo Campos wrote:
>> +#endif /* __IDMAPPED_MOUNTS_H */
> 
> 
> s/__IDMAPPED_MOUNTS_H/__VFSTEST_H/ ?

Ouch, yes, thanks!

