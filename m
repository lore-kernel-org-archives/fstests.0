Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40647C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Nov 2022 16:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKUQvr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Nov 2022 11:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKUQvq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Nov 2022 11:51:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39424CFA57
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 08:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C887A61315
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 16:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F65C433D6;
        Mon, 21 Nov 2022 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669049504;
        bh=xUNzm4bwRVUmQH7IFNkn/gc3EOvVwuMLwn0BYxbVAx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B61UQBpHBjOuV/D5pcqLpVnHCV5nuLd7lPomnCL4NMKi5V7K0TMdWnNx7MDQerAjS
         zX7mmgqNRf8LA/eZf02OWwg0PqO5rjAGm81ST28obFHPQjkz2Okgg+hW0Cg6yerGtx
         E1CCZPbmU6QoJAql/KPqcwZNGp5TXChYAF9MKvZDDB+ok7Og3V/raO5vyGyf1FGtj5
         eN5AKTOJCO0Y58vm8eKOfQsU8sItvmaNOaim6WiwFMVAuXeYH9a5Wrio2NnwfQ0ttB
         GjWRodLZiR3uFR6eUqnrXOMdAcNXb9YiqQedYfqHEKM7LPKQQ+GTLwqiNakWZJqm0R
         hBxdrvbqwKYVA==
Date:   Mon, 21 Nov 2022 08:51:43 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: Test generic/614
Message-ID: <Y3usnwK3MFba2kEw@magnolia>
References: <20221121123636.ltwwxgoom5bd4eyd@quack3>
 <CAL3q7H5fCW9ViD3R8pX9ekLrtF-NpaqaEX+SjmVH09jRsT53dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5fCW9ViD3R8pX9ekLrtF-NpaqaEX+SjmVH09jRsT53dQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 21, 2022 at 01:32:22PM +0000, Filipe Manana wrote:
> On Mon, Nov 21, 2022 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello Filipe!
> 
> Hi Jan!
> 
> >
> > I have noticed test generic/614 is failing on ext2. The test creates sparse
> > file, maps it, and writes data to it through mmap. Then it checks i_blocks
> > has increased. However for ext2 (and other trivial filesystems supporting
> > sparse files but not implementing delayed allocation) this is bound to fail
> > because i_block gets incremented only during page writeback.
> >
> > So would your btrfs test make sense even if we called fsync(2) before
> > checking stat(2) results?
> 
> Calling fsync before calling stat would defeat the purpose of the test.
> I.e. the test would pass both with and without the btrfs fix.
> 
> So maybe adding the following to the test:
> 
> _supported_fs ^ext2
> 
> And listing all other filesystems not supporting delayed allocation?
> 
> Or adding a _require_delayed_allocation() helper to make it _notrun().

_require_scratch_delalloc() ?

--D

> Thanks.
> 
> 
> 
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
