Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F15BC4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Aug 2021 08:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8D61073
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Aug 2021 08:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhHJIQP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:16:15 -0400
Received: from verein.lst.de ([213.95.11.211]:35087 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhHJIQP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Aug 2021 04:16:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7DBDA67373; Tue, 10 Aug 2021 10:15:49 +0200 (CEST)
Date:   Tue, 10 Aug 2021 10:15:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 1/6] idmapped-mounts: prepare for additional tests
Message-ID: <20210810081549.GA20012@lst.de>
References: <20210731165834.479633-1-brauner@kernel.org> <20210731165834.479633-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731165834.479633-2-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jul 31, 2021 at 06:58:29PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> - Use sequential option numbering for option parsing since we're only
>   using longopts anyway and to easier correlate test parsing in the
>   switch with the options specified in longopts.

These sequential options are rally weird.  Why not use getopt_long_only?

>
> - Introduce an explicit command line switch to runs the basic test
>   suite. This prepares for the introduction of additional command line
>   switches to run tests.
> - Update help output.
> - Use die() when logging test failure.

Each of these changes really should be a separate patch.
