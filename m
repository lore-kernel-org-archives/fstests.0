Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5591C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Mar 2022 20:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiCBUhh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiCBUhf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Mar 2022 15:37:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA12C116F
        for <fstests@vger.kernel.org>; Wed,  2 Mar 2022 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uuH561z1YykPEfXoqFS0ypeJGWl19c5ve6Sb74aOwJc=; b=QbFxwmks57zAtkdRjDvz7I6BD/
        +y/BW62XlbYWuJGwFgRYz2wwnz35FVw1FNOeiq8Z7tCLVth8p+eMp4DKFrO+D2r8RzHNDSF+HhpI6
        GZijsMzl8BVDJBCi3/UhzBhOKL2NLMeg6gdBtc1OHRSIj0zVH+Dv3srYNvQWxI+jTwQWGIZa4O/Xv
        5oisa0vaJB5ojiDsPj92FnGmhajAzpztq0azUOemfWbmSuZl/OGe7tcy0sCQbzt+BM5/+mFWqZtHP
        BPl2FvQ5HSXgwPxHRgcZnXZgSalxSuRUU8OIaLI0ucylXLEogBn2rKrIy8toeWGFRKoIXDClO0Id3
        nLvd90uQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPViN-0046n9-B8; Wed, 02 Mar 2022 20:36:51 +0000
Date:   Wed, 2 Mar 2022 12:36:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com,
        p.raghav@samsung.com, joshi.k@samsung.com, arnav.dawn@samsung.com
Subject: Re: [PATCH] xfs/205,432,516: read sysfs for mkfs block size instead
 of hardcoded values
Message-ID: <Yh/VY8DSIUhHfRu6@bombadil.infradead.org>
References: <CGME20220301213529epcas5p2974c84878339d5661336533696d3938f@epcas5p2.samsung.com>
 <20220301213022.28999-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301213022.28999-1-nj.shetty@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 02, 2022 at 03:00:22AM +0530, Nitesh Shetty wrote:
> At present block size of 1024 is hardcoded for mkfs. This creates
> problem when device block size is more than 1024. So we use sysfs values
> of SCRATCH_DEV, if not found then default to 1024.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
