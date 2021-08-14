Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F9C4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 08:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DFA60F36
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 08:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbhHNInG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 14 Aug 2021 04:43:06 -0400
Received: from verein.lst.de ([213.95.11.211]:49577 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237532AbhHNInE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Aug 2021 04:43:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77FDC67373; Sat, 14 Aug 2021 10:42:34 +0200 (CEST)
Date:   Sat, 14 Aug 2021 10:42:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 2/8] idmapped-mounts: switch to getopt_long_only()
Message-ID: <20210814084234.GB22637@lst.de>
References: <20210812160140.990229-1-brauner@kernel.org> <20210812160140.990229-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812160140.990229-3-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> -	while ((ret = getopt_long(argc, argv, "", longopts, &index)) != -1) {
> +	while ((ret = getopt_long_only(argc, argv, "d:f:m:sh", longopts, &index)) != -1) {

Hmm.  From the manpage:

"(If the program accepts only long options, then optstring should be specified
as an  empty  string (""),  not  NULL.)"

So I think the empty opstring should remain.

Also later in the man page:

" getopt_long_only() is like getopt_long(), but '-' as well as "--" can
indicate a long option."

So maybe my advise to switch to getopt_long_only wasn't needed or is
even not that helpful.  Sorry, it's been a while since I wrote programs
with non-trivial option parsing.
