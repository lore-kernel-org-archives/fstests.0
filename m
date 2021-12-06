Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E15C4332F
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Dec 2021 17:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbhLFRJK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:09:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46808 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350049AbhLFRGC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Dec 2021 12:06:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0858B81163
        for <fstests@vger.kernel.org>; Mon,  6 Dec 2021 17:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B000C341C2;
        Mon,  6 Dec 2021 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638810151;
        bh=xADlavXw00s2jcel26FkUjpAX00KBnLRsm3aDtC56A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S99Pj0svqGUZglI6R/hVfdU6aUxbng75bhfmb0/kxOQqUQslP9hwbxxg/q0bFQF2p
         mB8SOBeVlmbxW974KT8d90itzPMss8g6vCvlHYgePqsSCnuctAbXFpskvcr7P18vKp
         23NJfnbl/gaTnS7Gc1VlJjsy2I2PTOSqt+scDJNf1hijejTUfTWMSYJprkzLUnEAsk
         GRmQpBn+zP4Rj2jzCEuckcqwadMK/2ylDcnqNC08DllmLw1XkKz5xTU0DHn3v2WzRq
         tN78r4Tc3N8M/sVXHD9t00OCNvAIJFmjFUBEQiWYDPpaSb2wQDrZH+HeOxJEU1f4Aj
         8RG3/h9K71Qzg==
Date:   Mon, 6 Dec 2021 09:02:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Subject: Re: [PATCH v2 00/16] generic: add some mmap CoW tests
Message-ID: <20211206170230.GB8442@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211203073053.1421823-1-ruansy.fnst@fujitsu.com>
 <YazTSVgkmfnhkR9j@desktop>
 <b1aacb7f-719d-0624-2186-dfb9755d74a0@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1aacb7f-719d-0624-2186-dfb9755d74a0@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 06, 2021 at 09:18:16AM +0800, Shiyang Ruan wrote:
> 
> 在 2021/12/5 22:57, Eryu Guan 写道:
> > On Fri, Dec 03, 2021 at 03:30:53PM +0800, Shiyang Ruan wrote:
> > > Ping
> > 
> > The patchset is in my to-review queue, but just didn't get enough time
> > to review them.. Will try to find some time to review them next week.
> 
> OK, Thanks~

Same here, I didn't have any time to look at this set last week, too
many other regressions going on. :(

--D

> 
> --
> Ruan
> 
> > 
> > Thanks,
> > Eryu
> > 
> > > 
> > > > This series is to add missing mmap CoW tests in some sets of testcases:
> > > > Set 1. CoW on shared blocks which are interleaving reflinked by two files.
> > > >    - P1:            add mmap test
> > > > Set 2. CoW a range covers shared blocks and multiple kind of unshared blocks of
> > > >     the destination file.
> > > >    - P2 ~ P6:       add mmap test
> > > > Set 3. CoW a range covers shared blocks and multiple kind of unshared blocks of
> > > >     the source file.
> > > >    - P11, P12:      add missing buffered-io and direct-io test for mixed blocks
> > > >    - P7 ~ P10, P13: add mmap test
> > > > Set 4. races tests
> > > >    - P14: race between reflink and mmap reading
> > > >    - P15: race between mmap writing to and reflink source file
> > > >    - P16: race between mmap writing to and reflink target file
> > > 
> 
> 
