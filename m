Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3339EC4338F
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 00:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FDE60EFE
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 00:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHTAgw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTAgw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 20:36:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9988DC061575;
        Thu, 19 Aug 2021 17:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pzxpQh5zqJKvlwrJQYa0xInKOUIVZwMWfGQigSQjPFk=; b=MDBsGEyRDhQ0agwIXUKeotmDRb
        Ekjnhumtu9phJ7PHhtyWeFYrtK3A/4/05mVMKxTGfmS44QtwTUtm/6AnoUueMtTwa2ecHVXf0IwW3
        eY1Qec6HBXYhUef57iIQtz05PfiR23FVvUONygJOHB24CJ/1gquxo8sJ/RFclbmkIfmm1a5+jrOHs
        Nt08o/txva8bc3ZPBb957xLEXzRSMUw6zBAaEomtERawmt9566Y1+LCjYiFm7m9ZM7jn1b8zf2H/B
        MJiTS/0vNv6lsyrv7K3FGGE5z76QswbEM7/VAuCH4oGcmV/DCEGvHejTfCLRPy3wYI4CRl09+jsok
        AXoiHswQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGsW7-009oSk-5Y; Fri, 20 Aug 2021 00:36:15 +0000
Date:   Thu, 19 Aug 2021 17:36:15 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] fstests: add patient module remover
Message-ID: <YR74/+OC9u+6NOQx@bombadil.infradead.org>
References: <20210820000234.2333125-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820000234.2333125-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 19, 2021 at 05:02:32PM -0700, Luis Chamberlain wrote:
> Changes in v4:
> 
>   - Just adds a new comment to clarify why we use a string check
>     for max_tries as requested by Eryu Guan.

Apologies, I had not seen another reply to one patch. I'll post
soon v5 addressing those changes.

  Luis
