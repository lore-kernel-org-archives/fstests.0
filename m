Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9597C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E6E6127A
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 14:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhDZOdr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233869AbhDZOdq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Apr 2021 10:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35A6B6101B;
        Mon, 26 Apr 2021 14:33:02 +0000 (UTC)
Date:   Mon, 26 Apr 2021 16:32:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/3] src/idmapped-mounts: Remove useless header file
Message-ID: <20210426143259.mx625byxevru6sep@wittgenstein>
References: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1619418187-19951-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619418187-19951-3-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 26, 2021 at 02:23:07PM +0800, Yang Xu wrote:
> When compile xfstest on old kernel, mount-idmapped.c will fail because of
> missing linux/bpf.h. But this src file doesn't use bpf realted functions or macros.
> 
> So remove these useless header files in idmapped-mounts.c and mount-idmapped.c.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Seems fine,
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
