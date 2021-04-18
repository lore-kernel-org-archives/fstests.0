Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F3AC433ED
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE4B610E9
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 15:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhDRP4d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Apr 2021 11:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhDRP4d (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 18 Apr 2021 11:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50342610CD;
        Sun, 18 Apr 2021 15:56:04 +0000 (UTC)
Date:   Sun, 18 Apr 2021 17:55:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: master branch updated to 15510d3a2081
Message-ID: <20210418155559.tikeikb6ukzhfuk2@wittgenstein>
References: <607c2df0.1c69fb81.67e78.ac79@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <607c2df0.1c69fb81.67e78.ac79@mx.google.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 18, 2021 at 09:02:36PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. The idmapped mount tests from Christian Brauner are
> merged in this update, many thanks to Christian for the 10+ rounds of revision!

Thank you for your reviews and patience, Eryu! I'm happy the tests are
now in available!

Christian
