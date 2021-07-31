Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092C7C4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 31 Jul 2021 17:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC26660725
	for <linux-fstests@archiver.kernel.org>; Sat, 31 Jul 2021 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGaRGj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGaRGj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 31 Jul 2021 13:06:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19CDA60EB7;
        Sat, 31 Jul 2021 17:06:31 +0000 (UTC)
Date:   Sat, 31 Jul 2021 19:06:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/6] Extend idmapped mount testsuite
Message-ID: <20210731170629.6ddk4to7euwqdyas@wittgenstein>
References: <20210731165834.479633-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210731165834.479633-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jul 31, 2021 at 06:58:28PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey,
> 
> This adds two new tests:
> - a regression test for vfs capabilities
> - a new test with nested idmapping layouts
> 
> In addition, I've added a new test for btrfs which is on-track to
> support idmapped mounts in v5.15. I leave it to Eryu whether he wants to
> merge the btrfs test already or not. I think there's no harm in doing so
> but I'm also happy to wait.

The last patch hasn't showed up on the list. We had this problem before
and the cause is likely that the patch is too large. The whole series
including the 6th patch can be pulled from:

git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/xfstests-dev fs.idmapped.nested_userns
git@gitlab.com:brauner/xfstests.git fs.idmapped.nested_userns
git@github.com:brauner/xfstests.git fs.idmapped.nested_userns

Thanks!
Christian
