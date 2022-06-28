Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0EDC43334
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiF1SVC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiF1SVB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 14:21:01 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97014205D9
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 11:21:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25SIKtBD023362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656440456; bh=yb9N1MuqJKQO3Cq1ZwNmuYayxpY6tH1k7Tmg84o+idM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NXuzvXVc6flMcwpXJHM4kj0R/3Gi3jKYkbq0+vZyBpigEJbnN+i4sJyMqzgX07o1K
         sGElVTt0OHOuEVtRrZ77Yb+ovKhd/DvMyIUaNURzBzYwwGoNi0Dmzf9wp8dAZJ0vSV
         90zSQYRtL990UE3J07e/h1vNmR+C2rS4d8vQim31jv0zfQasHLwmw9WIqKN2P+6OI2
         ujW0Ki3y4UdP6olbGIHO3idWHqYF8trT96lw9UoATp+o/Gx9z+iy9gcsBr8pCdgGVI
         IU+aA8vjkuLiJDlVbA9wccneK0ifzayq7+4xtVEzLR0xwZa+Pu1l3clU6vSd3ZXNQl
         y9xUqTNyj4IPg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7700415C4311; Tue, 28 Jun 2022 14:20:55 -0400 (EDT)
Date:   Tue, 28 Jun 2022 14:20:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] ext4/044: skip test if the file system does not have
 a journal
Message-ID: <YrtGh5Zm7Ukfxx1I@mit.edu>
References: <20220625030718.1215980-1-tytso@mit.edu>
 <20220625030718.1215980-3-tytso@mit.edu>
 <20220628042817.2xxzleisfguoq7qh@zlang-mailbox>
 <20220628043229.pkluyozx4rfqqkfc@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628043229.pkluyozx4rfqqkfc@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 12:32:29PM +0800, Zorro Lang wrote:
> > 
> > Can _has_metadata_journaling help that?
> 
> Or use _require_metadata_journaling directly?

Yep, that's just what we need.  I'll fix this in the next version of
these patches.

						- Ted
