Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5EBC433FE
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Nov 2022 06:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKDGwg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Nov 2022 02:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKDGwf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Nov 2022 02:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00465CF
        for <fstests@vger.kernel.org>; Thu,  3 Nov 2022 23:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39C7B620DB
        for <fstests@vger.kernel.org>; Fri,  4 Nov 2022 06:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8704CC433C1;
        Fri,  4 Nov 2022 06:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667544753;
        bh=uORKq/S7IMi5Xh0rH7T172DRCJFk6ipsBWCA0fojPUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/wtoWucRiIYSzjUCDq8kEqdE9UHPAwoEKabc84eTDglC3ALgHJ02cIUrGsNLt5/H
         4WLg6zSykEWlv75tJPmjXf5vQk4B79EJo7S0hjREZidNTgU/EJC2uKiTV6dLZ5gd+w
         95+v0f0USdJnq4DjFlW+/EeZ4DL7kmO1cGXey+UV5W45FDlDoi853POCTT+kJvOnSK
         yOsWL5FgnNslL468MvLD/HEc2VEywdoy9w2B913kx7QZmLP14jLBYnhcFCHod2hJh3
         llfbqJTP3eYEgNGHL+/no11x9jzd8QLHt895/lU2vLDp1wQXlij+FdayXd0q9xufkv
         XOmfWrpC99bDg==
Date:   Thu, 3 Nov 2022 23:52:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 0/2] generic/577: fix hash check and add metadata
 cleaning
Message-ID: <Y2S2r2hStHK47xdR@sol.localdomain>
References: <20221103191420.390048-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103191420.390048-1-aalbersh@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 03, 2022 at 08:14:18PM +0100, Andrey Albershteyn wrote:
> Hi all,
> 
> This patchset has two fixes for generic/577. The first one is fix of
> common helper _fsv_have_hash_algorithm which didn't work correctly in
> generic/577 as that test requires signing. The second patch fixes issue
> which is uncovered when first patch is applied. The test fails to write to file
> with already enabled verity.
> 
> v1 -> v2:
> - add first patch as proper fix
> 
> Andrey Albershteyn (2):
>   common/verity: disable signature verification on hash alg check
>   generic/577: add missing fsverity metadata cleaning
> 
>  common/verity     | 3 +++
>  tests/generic/577 | 1 +
>  2 files changed, 4 insertions(+)
> 

Thanks Andrey!  One thing that you overlooked is that _fsv_have_hash_algorithm()
needs to restore the previous value of fs.verity.require_signatures, not the
value that existed at the beginning of the test.

Also, I found that some of the newer tests don't work properly on systems where
fs.verity.require_signatures=1.  I'd like to fix that too.

Can you take a look at the patchset
https://lore.kernel.org/fstests/20221104064742.167326-1-ebiggers@kernel.org/T/#u
I just sent out?  It should take care of everything...

- Eric
