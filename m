Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3B5C433ED
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Apr 2021 06:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD45610CC
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Apr 2021 06:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhDTG0l (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Apr 2021 02:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhDTG0l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Apr 2021 02:26:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78323C06174A
        for <fstests@vger.kernel.org>; Mon, 19 Apr 2021 23:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=prG0MnkZ4zGkj3HyleA4McL9ytztPbg+VcbFOzmv77E=; b=MAgOoB/YXCITktVoYK61VcPnr+
        F+Sf/8wL27ns/SXd0Y/07rlhzU2eujVgT+isIgnYZLxdkCX3n8sKSoGluLkAWKR8ZzkEowSyfE9wS
        kns4yWsT2dMlH9dFPvbfpCsPS5qSvzzuksPUkYwTpjIAMwH+j5olFs8dkfcCn4IcC4DfISm2yItlE
        SNq/JFWPVvGALxeRQx+pAe0Jk0BIuqxckBtn+J4STOmzY6RnJmK+wlRkJ56oVLTWDAHq7XAeMljMa
        NiaFxOauOp+XY68UGvYKAMaAWxfbxvyw2BsvZ81x56AEPVk95T3M99t2zH4UHlaH4VkVOKPlAPJqO
        oqzXlKKQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYjpV-00EnuI-7P; Tue, 20 Apr 2021 06:25:56 +0000
Date:   Tue, 20 Apr 2021 07:25:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com
Subject: Re: [PATCH] common/rc: teach _require_scratch_swapfile() that swap
 does not work with DAX
Message-ID: <20210420062549.GB3525612@infradead.org>
References: <20210418161925.240995-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418161925.240995-1-tytso@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 18, 2021 at 12:19:25PM -0400, Theodore Ts'o wrote:
> The statement, "ext* and xfs have supported all variants of swap files
> since their introduction, so swapon should not fail," is not quite
> completely true.  In particular, swapon does not work if the DAX is
> active on a swapfile, and that would be true if the file system is
> mounted with -o dax.
> 
> So if swapon fails, check to see if the swapfile has the
> STATX_ATTR_DAX attribute set, and if so, issue a _notrun instead of a
> _fail.

Isn't the fact that swapon doesn't work on DAX files a back?  The
swap I/O path couldn't care less if the file is marked as DAX or not.
