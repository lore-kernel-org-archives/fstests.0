Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE73C07E96
	for <linux-fstests@archiver.kernel.org>; Tue,  6 Jul 2021 17:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2536261C65
	for <linux-fstests@archiver.kernel.org>; Tue,  6 Jul 2021 17:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGFRvQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhGFRvQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Jul 2021 13:51:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 563C361C5F;
        Tue,  6 Jul 2021 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625593717;
        bh=+MEcM2+RWJV401XoUhDxsr/E35nHOENOu7Ei0eSrNwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+Lsyyy1GETsS4Xkt3A7kzwv0vl3cqwsSNRgSdNIZp3hKMdXOVH7XpDEvHJZU2Oyh
         wGbfnNUvMMDkC+Vg25AUenH6hKhnxXjydlybSn6+HdOTD/rWWOF61fYSya09JwQsBd
         gqrbY4x8NY0FW0Gh3fwpoopz3cLYvX5DivsVfurpqkFkEnI0OvKKkSdB2hb2jfIFUJ
         fFXnJuCNkEkDhYAz91sgWc9n28VQD7R3s1B6hBGe+YHdeFDBPjOyNwdK4hso31QcUs
         o6Mzhi6SSEKOrEtzgHKjI5MAxvhVGXdpLWZ0mBSjshybIODLQOSnBGEJud1FUnQelK
         dU1TUAEe48wXQ==
Date:   Tue, 6 Jul 2021 10:48:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 0/2] skip tests that don't work with an external log
Message-ID: <20210706174837.GA11571@locust>
References: <20210705040307.3322709-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705040307.3322709-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 05, 2021 at 12:03:05AM -0400, Theodore Ts'o wrote:
> I recently tried running xfstests with an external log device, and
> found a number of failures caused by the fact that we use dmflakey and
> dmerror to take down a disk to simulate a power failure or a complete
> hard disk failure.  But with an external log device, the tests don't
> correctly simulate these scenarios, so skip them.

Counter-proposal: If I sent out my series to fix all that[1], would you
review them?

--D

[1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=dmerror-on-rt-devices

> 
> With these patches, testing with ext4 using an external log is passing
> almost all of the auto group tests, with the exception of ext4/028
> (which appears to be a genuine ext4 fsmap bug not handling external
> log devices correctly).
> 
> Theodore Ts'o (2):
>   dmflakey: don't run dmflakey tests with an external log device
>   generic/475: skip test when using an external log device
> 
>  common/dmflakey   | 4 ++++
>  tests/generic/475 | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> -- 
> 2.31.0
> 
