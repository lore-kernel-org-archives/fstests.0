Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0759DC433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FCA61139
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 14:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhDZOdR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233603AbhDZOdP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Apr 2021 10:33:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CA0961004;
        Mon, 26 Apr 2021 14:32:32 +0000 (UTC)
Date:   Mon, 26 Apr 2021 16:32:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/3] idmapped-mounts.c: Use renameat instead of
 renameat2
Message-ID: <20210426143228.6nnoedfawpiibchr@wittgenstein>
References: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1619418187-19951-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619418187-19951-2-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 26, 2021 at 02:23:06PM +0800, Yang Xu wrote:
> We don't add fallback for renameat2, so it build failed on old kernel.
> Also, renameat2() man-pages said as below:
> "renameat2() has an additional flags argument.  A renameat2() call with
> a zero flags argument is equivalent to renameat()."
> 
> In this src file, it uses zero flag for all renameat2 call. So we can use
> renameat directly.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Looks ok. You made sure that this passes after this change, right?
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
