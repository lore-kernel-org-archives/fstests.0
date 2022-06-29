Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED497C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 12:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiF2M25 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiF2M2w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 08:28:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E014101DF
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 05:28:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25TCSfSu015724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 08:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656505722; bh=nNJ9/GZG1rrfRG1zUJUFFChp8oQgcm6w+MqSg5s76xU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=m8LqmlK+sEJ9+ZZsF1kBYvHpD3chZEOxIBEeoVYTyaFHwK0++Qs/YahSqWwOn2cjr
         gNN7gLeVqkxI65dGgyleUQkCuU3NAmHiUt/8lBcbQTjqMBldooT0O5tqO+l9XEprT2
         eEuDtIa1kVkCOm0vPvdSDDHiifdKTDOOoe2aa2QiHGRoPO3OGupexsAgt9Vf2cR6eM
         BadWycmIJGiQBn9CqZXdrvYRQg6nQ2RwCl2a0tm04YoK+ulq51NgJ/PjATPQGKhp0c
         lezIWvc1xNMMt2bjusyxLCCu/0oflqSNFfewAOJi/hbxQpc9NVBHQqcyic0uoB081a
         Sx0azCyiU6o/A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2413615C3E94; Wed, 29 Jun 2022 08:28:41 -0400 (EDT)
Date:   Wed, 29 Jun 2022 08:28:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 6/6] ext4: create file systems with the enrypt feature if
 necessary
Message-ID: <YrxFeS2hKjedV9R0@mit.edu>
References: <20220628182545.1834145-1-tytso@mit.edu>
 <20220628182545.1834145-7-tytso@mit.edu>
 <YrvgMkrXh8iUItVv@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrvgMkrXh8iUItVv@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 10:16:34PM -0700, Eric Biggers wrote:
> 
> Thanks, I didn't notice these.  The general approach looks good.  A few nits:
> 
> - The hunk in tests/ext4/035 doesn't apply; it seems you have a local change?

Yeah, sorry, I had forgotten about that out of tree patch.  I'll pull
that into this patch series, and I should really try to pay down some
of that tech debt.

> - "enrypt" in the subject should be "encrypt"

Thanks, fixed.

						- Ted
