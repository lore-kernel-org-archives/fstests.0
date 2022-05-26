Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62E7C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiEZSGY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 May 2022 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiEZSGX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 May 2022 14:06:23 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5359136E3D
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 11:06:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24QI6CJl022138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 14:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653588374; bh=/6ud0pdo0AuuDsJX3JJTKi5pLakBIWe9mvWkbOXThTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TFCxmIgrwKDL4RUZCpTsmFDGyjfeViZdHr4XZttSnZ/fK51btaN83hyEXBo5pR/Ne
         NMTBkq0m5fUhDvZLshmL0A8T7sF7qsx+h+OnGDOVHUe/nQw4W7Apf/Rc2qvFcLqRmt
         27EpG8cNqTIz1kW5nJF0/rNx1cvEv6ZgQKLdG3Uy3Bt21f7BKTYLvRP5QbdFAhgn9B
         o3LeUpAnkibK0aFM+6ycoVef5fowxtkiW7FYYS6U0qMpTZZHprwVj89INOKvqj+vkj
         VESbXyomCmx2tpDIVW7RYh6MeSSi1afeiA1x/aWANfeiotEmFox7Ikzvn94mGsyzAJ
         jxL8Hblqj1gKg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 887D415C3399; Thu, 26 May 2022 14:06:12 -0400 (EDT)
Date:   Thu, 26 May 2022 14:06:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, enwlinux@gmail.com,
        leah.rumancik@gmail.com, harshadshirwadkar@gmail.com
Subject: Re: Directory reorganization in xfstests-bld pushed out
Message-ID: <Yo/BlHww40A9YTS+@mit.edu>
References: <YozjGjNv9dEW/m0L@mit.edu>
 <Yo0xg6BofOdo6dGu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo0xg6BofOdo6dGu@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 07:26:59PM +0000, Eric Biggers wrote:
> Thanks Ted!  It looks like some of the documentation still needs to be updated;
> can you consider the following patch?

Thanks for doing the documentation sweep!  I've applied your patch.

Cheers,

						- Ted
