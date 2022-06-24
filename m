Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84820C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 03:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiFXDtP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 23:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiFXDtO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 23:49:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364B54EF47
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 20:49:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25O3mxVd019431
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 23:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656042541; bh=EFzyHJ/z8/A0aqvjIaBI2rPQh6d89Q1nUlqrMSDDXqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HbPn9w7S4PPgJN9q4azjWb8j77QtxNKF3FdzbXsyDRZOQUC7klnPEe62enpy9FSb1
         1G7JkTMNmdrMGSLWxDfeEs6E4qM747DpCEsTbmuWlrCOQWGAvW4QHfs1CLaiay4Nyb
         /ETdX+XZlimQk/4JZc16tUwl4xk8/Z7tdMV86KvkW+TLLVGrNGw5p1vpMlZ8u+Lhux
         orY6Ryt1LFsuXTy7VqbKRMSa34wRPO6e+LfpyPnl/MSqJOUkRZ0x3MzCHJhmeqhcQm
         8zKbIvdAhmK1kAAG5gWqQtS9luX4qqjJIgZ9C1a+wOlCAzI96CuoCNPQqn8VjeCB3o
         FcH5o/Bnc8+Nw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C8E5615C42F6; Thu, 23 Jun 2022 23:48:59 -0400 (EDT)
Date:   Thu, 23 Jun 2022 23:48:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [xfstests-bld PATCH] {kvm,gce}-xfstests: fix the
 --update-xfstests-tar option
Message-ID: <YrU0KytLUZH72X4h@mit.edu>
References: <20220623182131.210809-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623182131.210809-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 23, 2022 at 11:21:31AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make --update-xfstests-tar work with the new directory organization.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted
