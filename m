Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEDDC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 02:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiGUCkt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiGUCks (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 22:40:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0401EEE3
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 19:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8A8BB8221C
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 02:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31223C341C7;
        Thu, 21 Jul 2022 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658371244;
        bh=jf3ZmRGaeGU2KNSVQkBSmutBNxXTT6bgz+/Ttii7KbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWJuocSN3OkeZx6mGArAkB9lBFm//k7L52JWYtxvYdRdS06m5Ix2/bxRgTL/+pzsB
         9ApiONJGNKEuy+A8s6GyECB1uqQdWAlGXiCJ/lI91e+tcSkg+ZgZbd4CnXlI3ABDX/
         g7LDVmtyfSltvS6BZkk/GIOhFIe2lofYqF6Q4jLdkMZCXvy7VPTxW5n61i4gkR9GWB
         SMyF0PF6fb7HkGDMXrl9qBrbFmWlV3dyikC1w6SUEJLl1SRsKtkUk9X37VqYbh8yTs
         3UrJe4qzRtlFcnr1OaQA5L5uNwpHrdME30UVuiOsjZWEGEvRvmUfuV2yJyrGxAKwMV
         AC1j4ix47bNsg==
Date:   Wed, 20 Jul 2022 19:40:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] generic/556: add a check to make sure ext4 supports
 encrypted casefolding
Message-ID: <Yti8qpzy5MRKTShk@sol.localdomain>
References: <20220720164356.4078789-1-tytso@mit.edu>
 <20220720164356.4078789-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720164356.4078789-3-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Ted,

On Wed, Jul 20, 2022 at 12:43:54PM -0400, Theodore Ts'o wrote:
> Some older kernels support ext4 file systems with encryption enabled,
> and with casefold enabled, but not file systems have both encryption
> *and* casefolding enabled.  On those kernels, generic/556 will fail.
> Fortunately, we can test if ext4 supports encrypted casefold via the
> presence of /sys/fs/ext4/features/encrypted_casefold.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Please see my previous comments on this same patch:

    * https://lore.kernel.org/fstests/YNDOdrW0cEOhC9rZ@gmail.com
    * https://lore.kernel.org/fstests/YmGcDdLRlfSwUxmZ@sol.localdomain

- Eric
