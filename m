Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A395BC43461
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 14:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E5D61027
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 14:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhDZOaz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233752AbhDZOay (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Apr 2021 10:30:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E52146101B;
        Mon, 26 Apr 2021 14:30:11 +0000 (UTC)
Date:   Mon, 26 Apr 2021 16:30:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/3] src/*: Fix an error for the loop initialization
 declaration
Message-ID: <20210426143007.zuy7y4ez57cwexiy@wittgenstein>
References: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 26, 2021 at 02:23:05PM +0800, Yang Xu wrote:
> When compile them on old gcc, get the following error
> mount-idmapped.c: In function 'parse_map':
> mount-idmapped.c:154:2: error: 'for' loop initial declarations are only allowed in C99 mode
>   for (int i = 0; i < 2; i++) {
> 
> Fix them by declaring them at the beginning instead of in loop.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

2021 and we still can't use for-loop initial declarations, _sigh_.
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
