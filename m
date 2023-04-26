Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD0AC77B78
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbjDZOzQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbjDZOzP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB896E9A
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC1A632D2
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 14:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4A4C433EF;
        Wed, 26 Apr 2023 14:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682520891;
        bh=YSNjqlHdmmJ5l/UpN+eMPc3qTvl26nuTAfY34VNul7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7TToIjfN4GyErRQn7JEOng1rPTVzO9V8RLsWlZn4vXE7dMU9j0nTT3EUiLe57Zv+
         EiO1c5iQYB17deRZdxyUtU/wmD3aYkHfzBXbSq4KqVpPa6khFYZFutTP1BJ1qdm34G
         gFyeRmYOxZQc5jctiHM/oaIYE5wc+lwJigem612qHey4CyGfEuAcUTb2e4oX6IWSr8
         QE9N9GkpXsC4T9Uggo8wgJbouEPq6ShyHVTXRwAC6sAkzrjFHokMiK2CGBbmpVwSi2
         2bxZ5hknn0MxRjYapL8owCQsT8P1VKjRPjjBn3SsydlKi9Wu+8PJshojcGGPPXl3yK
         eow053yqUP0cQ==
Date:   Wed, 26 Apr 2023 07:54:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, fstests@vger.kernel.org,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 5/6] generic/531: Check for O_TMPFILE
Message-ID: <20230426145450.GA59209@frogsfrogsfrogs>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-6-dhowells@redhat.com>
 <20230426144931.uxapfrnh6adcwevd@zlang-mailbox>
 <20230426145149.mjsuugpgusqr6oj2@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426145149.mjsuugpgusqr6oj2@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 26, 2023 at 10:51:49PM +0800, Zorro Lang wrote:
> On Wed, Apr 26, 2023 at 10:49:31PM +0800, Zorro Lang wrote:
> > On Mon, Apr 24, 2023 at 03:10:41PM +0100, David Howells wrote:
> > > Make generic/531 check that the filesystem under test supports O_TMPFILE
> > > before attempting to test it.
> > > 
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > cc: linux-afs@lists.infradead.org
> > > ---
> > >  tests/generic/531 | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tests/generic/531 b/tests/generic/531
> > > index 5e84ca97..e5f3dddd 100755
> > > --- a/tests/generic/531
> > > +++ b/tests/generic/531
> > > @@ -20,6 +20,7 @@ testfile=$TEST_DIR/$seq.txt
> > >  # real QA test starts here
> > >  _supported_fs generic
> > >  _require_scratch
> > > +_require_xfs_io_command "-T"
> > 
> > Make sense,
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Oh, generic/530 is similar with 531, why only 531 need this one?

AFS doesn't support shutdown, presumably.

(But yes, both tests should be _require-ing this.)

--D

> > 
> > >  _require_test_program "t_open_tmpfiles"
> > >  
> > >  _scratch_mkfs >> $seqres.full 2>&1
> > > 
> 
