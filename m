Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF70C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Mar 2021 19:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5134864F9F
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Mar 2021 19:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhCJTFV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:05:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60020 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbhCJTFN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Mar 2021 14:05:13 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lK48u-0003cw-Eo; Wed, 10 Mar 2021 19:05:12 +0000
Date:   Wed, 10 Mar 2021 20:05:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] generic/626: add test for detached mount propagation
Message-ID: <20210310190511.k7jn3xsxtg44fdap@wittgenstein>
References: <20210309121041.753359-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309121041.753359-1-christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 09, 2021 at 01:10:41PM +0100, Christian Brauner wrote:
> Regression test to verify that creating a series of detached mounts,
> attaching them to the filesystem, and unmounting them does not trigger an
> integer overflow in ns->mounts causing the kernel to block any new mounts in
> count_mounts() and returning ENOSPC because it falsely assumes that the
> maximum number of mounts in the mount namespace has been reached, i.e. it
> thinks it can't fit the new mounts into the mount namespace anymore.
> 
> The test is written in a way that it will leave the host's mount
> namespace intact so we are sure to never make the host's mount namespace
> unuseable!
> 
> The fix is in [1].
> 
> [1]: https://git.kernel.org/brauner/c/ee2e3f50629f17b0752b55b2566c15ce8dafb557

The fix is now in mainline so this should be good to pick up/review if
people think it's useful to have!

Thanks!
Christian
