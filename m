Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81335C0015E
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Jul 2023 01:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjG0BNr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Jul 2023 21:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjG0BNr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Jul 2023 21:13:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455F8270E
        for <fstests@vger.kernel.org>; Wed, 26 Jul 2023 18:13:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-115-64.bstnma.fios.verizon.net [173.48.115.64])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36R1DUd0031713
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 21:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690420412; bh=iWeW6TPN/pQMA4jyT8Qe3Y4WNnef1gSl84ghHaywJBo=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=J/vhEch5R1H98GHk42HK8REv28eqDR0mQOOd5/vwu6AO18rIT3oPPkQk0iWirGkAr
         r23eqoCoW+JPX8hM8kft4boJJTIJ4UDnyhd1T4MA1+WrYDE7+QomcmRNak/VCINEpt
         1+XiTiBF8a4RIhKZwrTWim2VCjpmUTbbkf6xgmZ9gBTTiJHpQOq97BZQBBrWGbrNQ9
         2GT/wXcbu4VUhPqAq32VOW9zjZHgXuIeXQf93mrZf54gmEfLIyJc7zB0k8Ti1Lc1CQ
         hTbto1PPuenynritnt5a5clznFKGDpbs6NRzpC/ZL6YJXC6kdz/ALnATBn7967IOQ6
         inHNRZGMRJuig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 33FC915C04DF; Wed, 26 Jul 2023 21:13:30 -0400 (EDT)
Date:   Wed, 26 Jul 2023 21:13:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] fstests: add helper to canonicalize devices used to
 enable persistent disks
Message-ID: <20230727011330.GE30264@mit.edu>
References: <20230720061727.2363548-1-mcgrof@kernel.org>
 <20230725081307.xydlwjdl4lq3ts3m@zlang-mailbox>
 <20230725155439.GF11340@frogsfrogsfrogs>
 <20230726044132.GA30264@mit.edu>
 <ZMFJp5OZN3vnT/yI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMFJp5OZN3vnT/yI@bombadil.infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 26, 2023 at 09:28:23AM -0700, Luis Chamberlain wrote:
> > I'm a little confused.  Where are these "sanity checks" enforced?
> > I've been using
> > 
> > SCRATCH_DEV=/dev/mapper/xt-vdc
> > 
> > where /dev/mapper/xt-vdc is a symlink to /dev/dm-4 (or some such)
> > without any problems.  So I don't quite understand why we need to
> > canonicalize devices?
> 
> That might work, but try using /dev/disk/by-id/ stuff, that'll bust. So
> to keep existing expecations by fstests, it's needed.

What goes wrong, and why?  /dev/disk/by-id/<disk-id> is a symlink,
just like /dev/mapper/<vg>-<lv> is a symlink.

What am I missing?

Thanks,

						- Ted

